package com.ss.app.model;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.ss.app.entity.RewardTransaction;

public interface RewardTransactionRepository extends CrudRepository<RewardTransaction, Long> {
	
	List<RewardTransaction> findByMemberid(String memberId);

	List<RewardTransaction> findByRewardedMember(String rewardedMember);
	
	@Query(value="select * from t_reward_transaction where rewarded_member =:rewardedMember and rewarded_on between current_date-10 and current_timestamp", nativeQuery=true)
	List<RewardTransaction> findByRewardedMemberWithLimit(String rewardedMember);
}

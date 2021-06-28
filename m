Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63E3B5DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhF1Mbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhF1Mbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:31:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 448B561279;
        Mon, 28 Jun 2021 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624883360;
        bh=gx2gt4WCFHjSKLRbEACPz27TgRUQ0itZUqh6D5eqQv4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RtEGHDXkG8J1aMOhh0Bz0X2xGE6abouh9srxFDnbRoSvzXyRfjHk87gq5QP3O+tI4
         QoQLXGa93RJp0wrxvHYFScLwb4aws1QdmDQWQEnt7ujywVb+VRsOglmMZqvmczmER/
         Fwc6gHmLSwVGLM8eYrw9vK8ErOJ0whs6hNucvV6VFYwsMHe4UgwkANL/O/oLXdomuv
         odVyC0/vYbV95MAiMqm+0HDjvTuhsh9YtLcbmFO3OInt7W8Vjh/wyighI/8Aks3qif
         OKF5ByXs5DbKzs9u2jvMb0qd0ZAR/HrkPZ0qt9E5qhi9ctwYhplRItT+LfhV2YAd3z
         7mUnCmAbehDfw==
Subject: Re: [PATCH] f2fs: avoid attaching SB_ACTIVE flag during mount/remount
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>
References: <20210525113909.113486-1-yuchao0@huawei.com>
 <YNLsKSSxS5xLJcnB@google.com>
 <bd548ff5-4143-31f9-0d84-abc8a53b597d@kernel.org>
 <YNNYEUumK506fxPK@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1ae0bb19-4773-57e1-41e3-2bedc9c850d0@kernel.org>
Date:   Mon, 28 Jun 2021 20:29:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNNYEUumK506fxPK@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/23 23:49, Jaegeuk Kim wrote:
> On 06/23, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2021/6/23 16:09, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> I'll remove this patch, since it breaks checkpoint=disable and recovery
>>> flow that check SB_ACTIVE.
>>
>> Oh, sorry, is it due to changes in f2fs_disable_checkpoint()?
>>
>> So how about testing with changes f2fs_recover_orphan_inodes() and
>> f2fs_recover_fsync_data()?
> 
> I'm now nervous whether the test can miss corner cases. So, I don't think
> we need to pour our time for this nice-to-have patch.

Well, could you please consider to check the fixed patch in 5.15 version?
SB_ACTIVE in recovery flow is necessary for checkpoint disabling, it should
not be enabled only under CONFIG_QUOTA, right?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>> On 05/25, Chao Yu wrote:
>>>> Quoted from [1]
>>>>
>>>> "I do remember that I've added this code back then because otherwise
>>>> orphan cleanup was losing updates to quota files. But you're right
>>>> that now I don't see how that could be happening and it would be nice
>>>> if we could get rid of this hack"
>>>>
>>>> [1] https://lore.kernel.org/linux-ext4/99cce8ca-e4a0-7301-840f-2ace67c551f3@huawei.com/T/#m04990cfbc4f44592421736b504afcc346b2a7c00
>>>>
>>>> Related fix in ext4 by
>>>> commit 72ffb49a7b62 ("ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()").
>>>>
>>>> f2fs has the same hack implementation in
>>>> - f2fs_recover_orphan_inodes()
>>>> - f2fs_recover_fsync_data()
>>>> - f2fs_disable_checkpoint()
>>>>
>>>> Let's get rid of this hack as well in f2fs.
>>>>
>>>> Cc: Zhang Yi <yi.zhang@huawei.com>
>>>> Cc: Jan Kara <jack@suse.cz>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>    fs/f2fs/checkpoint.c |  3 ---
>>>>    fs/f2fs/recovery.c   |  8 ++------
>>>>    fs/f2fs/super.c      | 11 ++++-------
>>>>    3 files changed, 6 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 6c208108d69c..a578c7d13d81 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -691,9 +691,6 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>    	}
>>>>    #ifdef CONFIG_QUOTA
>>>> -	/* Needed for iput() to work correctly and not trash data */
>>>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>>> -
>>>>    	/*
>>>>    	 * Turn on quotas which were not enabled for read-only mounts if
>>>>    	 * filesystem has quota feature, so that they are updated correctly.
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index 4b2f7d1d5bf4..4cfe36fa41be 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -782,8 +782,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>>>    	}
>>>>    #ifdef CONFIG_QUOTA
>>>> -	/* Needed for iput() to work correctly and not trash data */
>>>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>>>    	/* Turn on quotas so that they are updated correctly */
>>>>    	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
>>>>    #endif
>>>> @@ -811,10 +809,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>>>    	err = recover_data(sbi, &inode_list, &tmp_inode_list, &dir_list);
>>>>    	if (!err)
>>>>    		f2fs_bug_on(sbi, !list_empty(&inode_list));
>>>> -	else {
>>>> -		/* restore s_flags to let iput() trash data */
>>>> -		sbi->sb->s_flags = s_flags;
>>>> -	}
>>>> +	else
>>>> +		f2fs_bug_on(sbi, sbi->sb->s_flags & SB_ACTIVE);
>>>>    skip:
>>>>    	fix_curseg_write_pointer = !check_only || list_empty(&inode_list);
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 0a77808ebb8f..e7bd983fbddc 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1881,17 +1881,15 @@ static int f2fs_enable_quotas(struct super_block *sb);
>>>>    static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>>>    {
>>>> -	unsigned int s_flags = sbi->sb->s_flags;
>>>>    	struct cp_control cpc;
>>>>    	int err = 0;
>>>>    	int ret;
>>>>    	block_t unusable;
>>>> -	if (s_flags & SB_RDONLY) {
>>>> +	if (sbi->sb->s_flags & SB_RDONLY) {
>>>>    		f2fs_err(sbi, "checkpoint=disable on readonly fs");
>>>>    		return -EINVAL;
>>>>    	}
>>>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>>>    	f2fs_update_time(sbi, DISABLE_TIME);
>>>> @@ -1909,13 +1907,13 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>>>    	ret = sync_filesystem(sbi->sb);
>>>>    	if (ret || err) {
>>>>    		err = ret ? ret : err;
>>>> -		goto restore_flag;
>>>> +		goto out;
>>>>    	}
>>>>    	unusable = f2fs_get_unusable_blocks(sbi);
>>>>    	if (f2fs_disable_cp_again(sbi, unusable)) {
>>>>    		err = -EAGAIN;
>>>> -		goto restore_flag;
>>>> +		goto out;
>>>>    	}
>>>>    	down_write(&sbi->gc_lock);
>>>> @@ -1931,8 +1929,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>>>    out_unlock:
>>>>    	up_write(&sbi->gc_lock);
>>>> -restore_flag:
>>>> -	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
>>>> +out:
>>>>    	return err;
>>>>    }
>>>> -- 
>>>> 2.29.2

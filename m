Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7938C3B1CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFWOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhFWOxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:53:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A401760041;
        Wed, 23 Jun 2021 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624459875;
        bh=zBYCKKDbr10iJdR/b1jsT+0zVXVgoahBYCpbcA1PBww=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IlguuzAtWGIi8QmfWLKRMZo0he0J/TU0/g8lDXyW/Yb9XmjgHjO36YVJSG5C2ofru
         VYBvQpc0cxT+01zNuTfug/5NqkJIflquw0+49aXpfcJctUaAoR3YUUTDmx0fOD9V9q
         ZBp0Qaj3bscAeuE9cOF9Ma7PWdPusw18B62eYLvYqRDMes642UZXBsn5L3APMWeP5c
         2TZB4L7TryRuZi+HRU428opoeuMvJahAbZMFvg3PwZ3LWzmWx2qYPnFPTpFV3XoFZk
         4c0aEaiVptUEyrNiu4bmV02cX5cm/cl/qtG3a+e24tOmrKowQ55agVd/Apd7TJ7k2i
         RR9PyGzZa0KMg==
Subject: Re: [PATCH] f2fs: avoid attaching SB_ACTIVE flag during mount/remount
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>
References: <20210525113909.113486-1-yuchao0@huawei.com>
 <YNLsKSSxS5xLJcnB@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <bd548ff5-4143-31f9-0d84-abc8a53b597d@kernel.org>
Date:   Wed, 23 Jun 2021 22:51:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNLsKSSxS5xLJcnB@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2021/6/23 16:09, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I'll remove this patch, since it breaks checkpoint=disable and recovery
> flow that check SB_ACTIVE.

Oh, sorry, is it due to changes in f2fs_disable_checkpoint()?

So how about testing with changes f2fs_recover_orphan_inodes() and
f2fs_recover_fsync_data()?

Thanks,

> 
> Thanks,
> 
> On 05/25, Chao Yu wrote:
>> Quoted from [1]
>>
>> "I do remember that I've added this code back then because otherwise
>> orphan cleanup was losing updates to quota files. But you're right
>> that now I don't see how that could be happening and it would be nice
>> if we could get rid of this hack"
>>
>> [1] https://lore.kernel.org/linux-ext4/99cce8ca-e4a0-7301-840f-2ace67c551f3@huawei.com/T/#m04990cfbc4f44592421736b504afcc346b2a7c00
>>
>> Related fix in ext4 by
>> commit 72ffb49a7b62 ("ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()").
>>
>> f2fs has the same hack implementation in
>> - f2fs_recover_orphan_inodes()
>> - f2fs_recover_fsync_data()
>> - f2fs_disable_checkpoint()
>>
>> Let's get rid of this hack as well in f2fs.
>>
>> Cc: Zhang Yi <yi.zhang@huawei.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/checkpoint.c |  3 ---
>>   fs/f2fs/recovery.c   |  8 ++------
>>   fs/f2fs/super.c      | 11 ++++-------
>>   3 files changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 6c208108d69c..a578c7d13d81 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -691,9 +691,6 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>   	}
>>   
>>   #ifdef CONFIG_QUOTA
>> -	/* Needed for iput() to work correctly and not trash data */
>> -	sbi->sb->s_flags |= SB_ACTIVE;
>> -
>>   	/*
>>   	 * Turn on quotas which were not enabled for read-only mounts if
>>   	 * filesystem has quota feature, so that they are updated correctly.
>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>> index 4b2f7d1d5bf4..4cfe36fa41be 100644
>> --- a/fs/f2fs/recovery.c
>> +++ b/fs/f2fs/recovery.c
>> @@ -782,8 +782,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>   	}
>>   
>>   #ifdef CONFIG_QUOTA
>> -	/* Needed for iput() to work correctly and not trash data */
>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>   	/* Turn on quotas so that they are updated correctly */
>>   	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
>>   #endif
>> @@ -811,10 +809,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>   	err = recover_data(sbi, &inode_list, &tmp_inode_list, &dir_list);
>>   	if (!err)
>>   		f2fs_bug_on(sbi, !list_empty(&inode_list));
>> -	else {
>> -		/* restore s_flags to let iput() trash data */
>> -		sbi->sb->s_flags = s_flags;
>> -	}
>> +	else
>> +		f2fs_bug_on(sbi, sbi->sb->s_flags & SB_ACTIVE);
>>   skip:
>>   	fix_curseg_write_pointer = !check_only || list_empty(&inode_list);
>>   
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 0a77808ebb8f..e7bd983fbddc 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1881,17 +1881,15 @@ static int f2fs_enable_quotas(struct super_block *sb);
>>   
>>   static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>   {
>> -	unsigned int s_flags = sbi->sb->s_flags;
>>   	struct cp_control cpc;
>>   	int err = 0;
>>   	int ret;
>>   	block_t unusable;
>>   
>> -	if (s_flags & SB_RDONLY) {
>> +	if (sbi->sb->s_flags & SB_RDONLY) {
>>   		f2fs_err(sbi, "checkpoint=disable on readonly fs");
>>   		return -EINVAL;
>>   	}
>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>   
>>   	f2fs_update_time(sbi, DISABLE_TIME);
>>   
>> @@ -1909,13 +1907,13 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>   	ret = sync_filesystem(sbi->sb);
>>   	if (ret || err) {
>>   		err = ret ? ret : err;
>> -		goto restore_flag;
>> +		goto out;
>>   	}
>>   
>>   	unusable = f2fs_get_unusable_blocks(sbi);
>>   	if (f2fs_disable_cp_again(sbi, unusable)) {
>>   		err = -EAGAIN;
>> -		goto restore_flag;
>> +		goto out;
>>   	}
>>   
>>   	down_write(&sbi->gc_lock);
>> @@ -1931,8 +1929,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>>   
>>   out_unlock:
>>   	up_write(&sbi->gc_lock);
>> -restore_flag:
>> -	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
>> +out:
>>   	return err;
>>   }
>>   
>> -- 
>> 2.29.2

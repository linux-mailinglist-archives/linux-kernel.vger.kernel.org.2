Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10119400968
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 05:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhIDDHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 23:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhIDDH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 23:07:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86B75600EF;
        Sat,  4 Sep 2021 03:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630724788;
        bh=bf45uTGNybJZynZ0RzcJn0qt6WIrwA62SQcCpztjVco=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BBA14g3K8DT6djOS+Ljvnzu8d3eBEEg7azMEbvGJbLqOBe8VKUrYJdkg4hcVh5Nwy
         Syj992eOSgQR7CsHeDl1v1sU1w0DffD32pmM+8TiiakuuDPvKv9POFHnYUi3i+U7gb
         cFzihK0RTgKAm4EQDeSoDQCtFhDiBgvrwBBHNmIpQPvwYEG5YlS2VVU4tR+0P7ptue
         HHZ1K2vx+RbA1DT7auTYvzMMaHQ0BrusSlR7RWVzTKB2zX1w99fZnJOWahzxE0Ox7S
         jzxtZPpMaeCXOsRvRHAVAnd0xhSCHNLgr3tgT6+4S57yXgxCdH1ODKigHEkb1f4Ioz
         Kx7/mmDi+IPBA==
Subject: Re: [PATCH v2] f2fs: avoid attaching SB_ACTIVE flag during mount
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>
References: <20210901080621.110319-1-chao@kernel.org>
 <YTK7JDnpc6+LNqsl@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8756a722-3363-9033-4a5f-047e28af645c@kernel.org>
Date:   Sat, 4 Sep 2021 11:06:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTK7JDnpc6+LNqsl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/4 8:17, Jaegeuk Kim wrote:
> I remember this gave a regression before?

I have removed changes which bothers checkpoint disabling path, how
about testing this in dev-test branch for a while?

BTW, any plan to porting checkpoint disabling testcases from android
into xfstest suit?

Thanks,

> 
> On 09/01, Chao Yu wrote:
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
>>
>> Let's get rid of this hack as well in f2fs.
>>
>> Cc: Zhang Yi <yi.zhang@huawei.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Acked-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - don't bother checkpoint disabling path
>>   fs/f2fs/checkpoint.c | 3 ---
>>   fs/f2fs/recovery.c   | 8 ++------
>>   2 files changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 83e9bc0f91ff..7d8803a4cbc2 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -705,9 +705,6 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
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
>> index 04655511d7f5..706ddb3c95c0 100644
>> --- a/fs/f2fs/recovery.c
>> +++ b/fs/f2fs/recovery.c
>> @@ -787,8 +787,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>   	}
>>   
>>   #ifdef CONFIG_QUOTA
>> -	/* Needed for iput() to work correctly and not trash data */
>> -	sbi->sb->s_flags |= SB_ACTIVE;
>>   	/* Turn on quotas so that they are updated correctly */
>>   	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
>>   #endif
>> @@ -816,10 +814,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
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
>> -- 
>> 2.32.0

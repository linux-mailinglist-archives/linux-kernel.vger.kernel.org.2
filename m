Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE1346F20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhCXB5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:57:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14133 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCXB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:57:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4rt72MRJz19Hj0;
        Wed, 24 Mar 2021 09:55:43 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Mar
 2021 09:57:39 +0800
Subject: Re: [PATCH] Revert "f2fs: give a warning only for readonly partition"
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210323064155.12582-1-yuchao0@huawei.com>
 <YFo16ADpWJ7OUAvK@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <107e671d-68ea-1a74-521e-ab2b6fe36416@huawei.com>
Date:   Wed, 24 Mar 2021 09:57:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YFo16ADpWJ7OUAvK@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 2:39, Jaegeuk Kim wrote:
> On 03/23, Chao Yu wrote:
>> This reverts commit 938a184265d75ea474f1c6fe1da96a5196163789.
>>
>> Because that commit fails generic/050 testcase which expect failure
>> during mount a recoverable readonly partition.
> 
> I think we need to change generic/050, since f2fs can recover this partition,

Well, not sure we can change that testcase, since it restricts all generic
filesystems behavior. At least, ext4's behavior makes sense to me:

	journal_dev_ro = bdev_read_only(journal->j_dev);
	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;

	if (journal_dev_ro && !sb_rdonly(sb)) {
		ext4_msg(sb, KERN_ERR,
			 "journal device read-only, try mounting with '-o ro'");
		err = -EROFS;
		goto err_out;
	}

	if (ext4_has_feature_journal_needs_recovery(sb)) {
		if (sb_rdonly(sb)) {
			ext4_msg(sb, KERN_INFO, "INFO: recovery "
					"required on readonly filesystem");
			if (really_read_only) {
				ext4_msg(sb, KERN_ERR, "write access "
					"unavailable, cannot proceed "
					"(try mounting with noload)");
				err = -EROFS;
				goto err_out;
			}
			ext4_msg(sb, KERN_INFO, "write access will "
			       "be enabled during recovery");
		}
	}

> even though using it as readonly. And, valid checkpoint can allow for user to
> read all the data without problem.

 >>   		if (f2fs_hw_is_readonly(sbi)) {

Since device is readonly now, all write to the device will fail, checkpoint can
not persist recovered data, after page cache is expired, user can see stale data.

Am I missing something?

Thanks,

> 
>>
>> Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/super.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b48281642e98..2b78ee11f093 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -3952,10 +3952,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   		 * previous checkpoint was not done by clean system shutdown.
>>   		 */
>>   		if (f2fs_hw_is_readonly(sbi)) {
>> -			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
>> +			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
>> +				err = -EROFS;
>>   				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
>> -			else
>> -				f2fs_info(sbi, "write access unavailable, skipping recovery");
>> +				goto free_meta;
>> +			}
>> +			f2fs_info(sbi, "write access unavailable, skipping recovery");
>>   			goto reset_checkpoint;
>>   		}
>>   
>> -- 
>> 2.29.2
> .
> 

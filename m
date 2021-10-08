Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB97426279
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhJHCkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:40:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27963 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHCk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:40:29 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQXM42gKtzbn1L;
        Fri,  8 Oct 2021 10:34:08 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:38:31 +0800
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz> <615FA55B.5070404@huawei.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <615FAF27.8070000@huawei.com>
Date:   Fri, 8 Oct 2021 10:38:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <615FA55B.5070404@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/8 9:56, yebin wrote:
>
>
> On 2021/10/7 20:31, Jan Kara wrote:
>> On Sat 11-09-21 17:00:55, Ye Bin wrote:
>>> kmmpd:
>>> ...
>>>      diff = jiffies - last_update_time;
>>>      if (diff > mmp_check_interval * HZ) {
>>> ...
>>> As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
>>> than 'mmp_update_interval', so there will never trigger detection.
>>> Introduce last_check_time record previous check time.
>>>
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> I think the check is there only for the case where write_mmp_block() +
>> sleep took longer than mmp_check_interval. I agree that should rarely
>> happen but on a really busy system it is possible and in that case we 
>> would
>> miss updating mmp block for too long and so another node could have 
>> started
>> using the filesystem. I actually don't see a reason why kmmpd should be
>> checking the block each mmp_check_interval as you do - 
>> mmp_check_interval
>> is just for ext4_multi_mount_protect() to know how long it should wait
>> before considering mmp block stale... Am I missing something?
>>
>>                                 Honza
> I'm sorry, I didn't understand the detection mechanism here before. 
> Now I understand
> the detection mechanism here.
> As you said, it's just an abnormal protection. There's really no problem.
>
Yeah, i did test as following steps
hostA                        hostB
    mount
      ext4_multi_mount_protect  -> seq == EXT4_MMP_SEQ_CLEAN
         delay 5s after label "skip" so hostB will see seq is 
EXT4_MMP_SEQ_CLEAN
                        mount
                        ext4_multi_mount_protect -> seq == 
EXT4_MMP_SEQ_CLEAN
                                run  kmmpd
     run kmmpd

Actually，in this  situation kmmpd will not detect  confliction.
In  ext4_multi_mount_protect  function we write mmp data fisrt and wait 
'wait_time * HZ'  seconds,
read mmp data do check.Most of the time, If 'wait_time' is zero, it can 
pass check.
>>> ---
>>>   fs/ext4/mmp.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>>> index 12af6dc8457b..c781b09a78c9 100644
>>> --- a/fs/ext4/mmp.c
>>> +++ b/fs/ext4/mmp.c
>>> @@ -152,6 +152,7 @@ static int kmmpd(void *data)
>>>       int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>>>       unsigned mmp_check_interval;
>>>       unsigned long last_update_time;
>>> +    unsigned long last_check_time;
>>>       unsigned long diff;
>>>       int retval = 0;
>>>   @@ -170,6 +171,7 @@ static int kmmpd(void *data)
>>>         memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>>>              sizeof(mmp->mmp_nodename));
>>> +    last_check_time = jiffies;
>>>         while (!kthread_should_stop() && !sb_rdonly(sb)) {
>>>           if (!ext4_has_feature_mmp(sb)) {
>>> @@ -198,17 +200,18 @@ static int kmmpd(void *data)
>>>           }
>>>             diff = jiffies - last_update_time;
>>> -        if (diff < mmp_update_interval * HZ)
>>> +        if (diff < mmp_update_interval * HZ) {
>>> schedule_timeout_interruptible(mmp_update_interval *
>>>                                  HZ - diff);
>>> +            diff = jiffies - last_update_time;
>>> +        }
>>>             /*
>>>            * We need to make sure that more than mmp_check_interval
>>> -         * seconds have not passed since writing. If that has happened
>>> -         * we need to check if the MMP block is as we left it.
>>> +         * seconds have not passed since check. If that has happened
>>> +         * we need to check if the MMP block is as we write it.
>>>            */
>>> -        diff = jiffies - last_update_time;
>>> -        if (diff > mmp_check_interval * HZ) {
>>> +        if (jiffies - last_check_time > mmp_check_interval * HZ) {
>>>               struct buffer_head *bh_check = NULL;
>>>               struct mmp_struct *mmp_check;
>>>   @@ -234,6 +237,7 @@ static int kmmpd(void *data)
>>>                   goto wait_to_exit;
>>>               }
>>>               put_bh(bh_check);
>>> +            last_check_time = jiffies;
>>>           }
>>>              /*
>>> -- 
>>> 2.31.1
>>>
>


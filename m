Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2746333AD17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCOIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:10:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13953 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhCOIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:10:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzTZV0fG8zrWmn;
        Mon, 15 Mar 2021 16:08:34 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 15 Mar
 2021 16:10:23 +0800
Subject: Re: [PATCH] f2fs: fix the discard thread sleep timeout under high
 utilization
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1615784186-2693-1-git-send-email-stummala@codeaurora.org>
 <49be0c70-4fe4-6acd-b508-08621f0623c0@huawei.com>
 <20210315074645.GA8562@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0c7220d7-416e-32b7-96cb-effd3f84d6e2@huawei.com>
Date:   Mon, 15 Mar 2021 16:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210315074645.GA8562@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2021/3/15 15:46, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Mon, Mar 15, 2021 at 02:12:44PM +0800, Chao Yu wrote:
>> Sahitya,
>>
>> On 2021/3/15 12:56, Sahitya Tummala wrote:
>>> When f2fs is heavily utilized over 80%, the current discard policy
>>> sets the max sleep timeout of discard thread as 50ms
>>> (DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
>>> no pending discard commands to be issued. This results into
>>> unnecessary frequent and periodic wake ups of the discard thread.
>>> This patch adds check for pending  discard commands in addition
>>> to heavy utilization condition to prevent those wake ups.
>>
>> Could this commit fix your issue?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=43f8c47ea7d59c7b2270835f1d7c4618a1ea27b6
>>
> I don't think it will help because we are changing the max timeout of the
> dpolicy itself in __init_discard_policy() when util > 80% as below -
> 
> dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> 
> And issue_discard_thread() uses this value as wait_ms, when there
> are no more pending discard commands to be issued.
> <snip>
>                  } else {
>                          wait_ms = dpolicy.max_interval;
>                  }
> <snip>
> 
> The new patch posted above is not changing anything related to the  max_interval.
> Hence, I think it won't help the uncessary wakeup problem I am trying to solve
> for this condition - util > 80% and when there are no pending discards.
> 
> Please let me know if i am missing something.

Copied, thanks for the explanation.

But there is another case which can cause this issue in the case of
disk util < 80%.

wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;

do {
	wait_event_interruptible_timeout(, wait_ms);

	...

	if (!atomic_read(&dcc->discard_cmd_cnt))
[1] new statement
		continue;

} while();

Then the loop will wakeup whenever 50ms timeout.

So, to avoid this case, shouldn't we reset wait_ms to dpolicy.max_interval
at [1]?

Meanwhile, how about relocating discard_cmd_cnt check after
__init_discard_policy(DPOLICY_FORCE)? and olny set .max_interval to
DEF_MAX_DISCARD_ISSUE_TIME if there is no discard command, and keep
.granularity to 1?

Thanks,

> 
> Thanks,
> Sahitya.
> 
>> Thanks,
>>
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>   fs/f2fs/segment.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index dced46c..df30220 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1112,6 +1112,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>>>   				struct discard_policy *dpolicy,
>>>   				int discard_type, unsigned int granularity)
>>>   {
>>> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>> +
>>>   	/* common policy */
>>>   	dpolicy->type = discard_type;
>>>   	dpolicy->sync = true;
>>> @@ -1129,7 +1131,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>>>   		dpolicy->io_aware = true;
>>>   		dpolicy->sync = false;
>>>   		dpolicy->ordered = true;
>>> -		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
>>> +		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL &&
>>> +				atomic_read(&dcc->discard_cmd_cnt)) {
>>>   			dpolicy->granularity = 1;
>>>   			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
>>>   		}
>>>
> 

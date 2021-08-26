Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E33F84E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhHZJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:56:37 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50636 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240937AbhHZJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:56:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Um47hnD_1629971747;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Um47hnD_1629971747)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Aug 2021 17:55:48 +0800
Subject: Re: [PATCH] ocfs2: ocfs2_downconvert_lock failure results in deadlock
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826061038.22295-1-ghe@suse.com>
 <b3f498eb-7de5-8a7f-0f52-01c1e2caa5d8@linux.alibaba.com>
 <7795ed72-8b77-14ea-cf18-78870e58f429@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <0a8db668-b6f4-4b33-086a-2b522b343cf1@linux.alibaba.com>
Date:   Thu, 26 Aug 2021 17:55:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7795ed72-8b77-14ea-cf18-78870e58f429@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/21 4:45 PM, Gang He wrote:
> Hi Joseph,
> 
> On 2021/8/26 16:23, Joseph Qi wrote:
>>
>>
>> On 8/26/21 2:10 PM, Gang He wrote:
>>> Usually, ocfs2_downconvert_lock() function always downconverts
>>> dlm lock to the expected level for satisfy dlm bast requests
>>
>> s/for/to
>>
>>> from the other nodes.
>>> But there is a rare situation. When dlm lock conversion is being
>>> canceled, ocfs2_downconvert_lock() function will return -EBUSY.
>>> You need to be aware that ocfs2_cancel_convert() function is
>>> asynchronous in fsdlm implementation.
>>> If we does not requeue this lockres entry, ocfs2 downconvert
>>> thread no longer handles this dlm lock bast request. Then, the
>>> other nodes will not get the dlm lock again, the current node's
>>> process will be blocked when acquire this dlm lock again.
>>>
>>> Signed-off-by: Gang He <ghe@suse.com>
>>> ---
>>>   fs/ocfs2/dlmglue.c | 13 +++++++++----
>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>>> index 48fd369c29a4..c454c218fbfe 100644
>>> --- a/fs/ocfs2/dlmglue.c
>>> +++ b/fs/ocfs2/dlmglue.c
>>> @@ -3671,13 +3671,11 @@ static int ocfs2_downconvert_lock(struct ocfs2_super *osb,
>>>                    OCFS2_LOCK_ID_MAX_LEN - 1);
>>>       lockres_clear_pending(lockres, generation, osb);
>>>       if (ret) {
>>> -        ocfs2_log_dlm_error("ocfs2_dlm_lock", ret, lockres);
>>> +        if (ret != -EBUSY)
>>> +            ocfs2_log_dlm_error("ocfs2_dlm_lock", ret, lockres);
>>
>> Do we have to treat EBUSY as a normal case?
> Yes, this return code is expected when call dlm_lock() to convert a dlm lock to another level, but this dlm lock is being cancelled.
> As I said in another mail, for fsdlm implementation,ocfs2_cancel_convert
> will return immediately, but the related dlm lock will(is) be cancelled in background. For o2dlm implementation,ocfs2_cancel_convert will return after the dlm lock is cancelled and it's ast is invoked, that is why o2cb based ocfs2 does not encounter -EBUSY return code in my test script, of course, this kind of implementation will block other lockres entries to be handled for a little time in down-convert thread.

Better to leave this log for later issue tracking.
I'm worrying about if there are other cases here.

> 
>>
>>>           ocfs2_recover_from_dlm_error(lockres, 1);
>>> -        goto bail;
>>>       }
>>>   -    ret = 0;
>>> -bail:
>>>       return ret;
>>>   }
>>>   @@ -3912,6 +3910,13 @@ static int ocfs2_unblock_lock(struct ocfs2_super *osb,
>>>       spin_unlock_irqrestore(&lockres->l_lock, flags);
>>>       ret = ocfs2_downconvert_lock(osb, lockres, new_level, set_lvb,
>>>                        gen);
>>> +    /* ocfs2_cancel_convert() is in progress, try again later */
>>> +    if (ret == -EBUSY) {
>>> +        ctl->requeue = 1;
>>> +        mlog(ML_BASTS, "lockres %s, ReQ: Downconvert busy\n",
>>> +             lockres->l_name);
>>> +        ret = 0;
>>
>> Ditto. If EBUSY is not a normal case, I'd like just requeue it but not
>> change it to normal return code.
>> You know ML_BASTS is always switched off in production environment.
> Since this case should be considered as a normal case, although it's rare.
> We should not print any error message to kernel journal, but if the user
> turn on the BASTS trace, he should watch this trace for debugging.
> 

Okay, since we leave an error message above, we can return normal to
caller. And now caller only print a simple error which doesn't have
much meaning.

BTW, could we change it like:

ret = ocfs2_downconvert_lock();
if (ret == -EBUSY) {
	mlog(ML_BASTS, ...);
	/* Describe the case why we have to requeue */
	goto requeue;
}

...
requeue:
	ctl->requeue = 1;
	return 0;



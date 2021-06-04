Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAC39C190
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFDUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:49:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48957 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFDUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:49:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622839640; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=AeE9L/uymuy4P/CGTWAHqfDB7Asj3kbTFMENGCb52lI=; b=vKdvote8KBufZsuVry6nWlXrOxnzAI5a35dIgut6sl68/e4zJ/YQt39WEStJdBKRAKgRsp9R
 R3wwI97MNuWLC5YYIzwcSMLhkBCZo54oJv1iFmuRO+V4US35CLn5TXa1eS8PmcrDJOPEzwF8
 Y17/7t7+pC2rP0gExrJ5kHWD2m8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60ba9145e570c05619fc36ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Jun 2021 20:47:01
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCD51C433D3; Fri,  4 Jun 2021 20:47:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88B81C4338A;
        Fri,  4 Jun 2021 20:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88B81C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: [PATCH 1/1] remoteproc: use freezable workqueue for crash
 notifications
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519234418.1196387-1-elder@linaro.org>
 <20210519234418.1196387-2-elder@linaro.org> <YLBpmdZoGDXNz64y@builder.lan>
 <be4ea351-7144-8b53-6fd7-6a2204e0040d@codeaurora.org>
Message-ID: <f708d462-d863-ed3c-159d-acd5bffc6cba@codeaurora.org>
Date:   Fri, 4 Jun 2021 13:46:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <be4ea351-7144-8b53-6fd7-6a2204e0040d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/28/2021 5:12 PM, Siddharth Gupta wrote:
>
> On 5/27/2021 8:55 PM, Bjorn Andersson wrote:
>> On Wed 19 May 18:44 CDT 2021, Alex Elder wrote:
>>
>>> When a remoteproc has crashed, rproc_report_crash() is called to
>>> handle whatever recovery is desired.  This can happen at almost any
>>> time, often triggered by an interrupt, though it can also be
>>> initiated by a write to debugfs file remoteproc/remoteproc*/crash.
>>>
>>> When a crash is reported, the crash handler worker is scheduled to
>>> run (rproc_crash_handler_work()).  One thing that worker does is
>>> call rproc_trigger_recovery(), which calls rproc_stop().  That calls
>>> the ->stop method for any remoteproc subdevices before making the
>>> remote processor go offline.
>>>
>>> The Q6V5 modem remoteproc driver implements an SSR subdevice that
>>> notifies registered drivers when the modem changes operational state
>>> (prepare, started, stop/crash, unprepared).  The IPA driver
>>> registers to receive these notifications.
>>>
>>> With that as context, I'll now describe the problem.
>>>
>>> There was a situation in which buggy modem firmware led to a modem
>>> crash very soon after system (AP) resume had begun.  The crash caused
>>> a remoteproc SSR crash notification to be sent to the IPA driver.
>>> The problem was that, although system resume had begun, it had not
>>> yet completed, and the IPA driver was still in a suspended state.
>>>
>>> This scenario could happen to any driver that registers for these
>>> SSR notifications, because they are delivered without knowledge of
>>> the (suspend) state of registered recipient drivers.
>>>
>>> This patch offers a simple fix for this, by having the crash
>>> handling worker function run on the system freezable workqueue.
>>> This workqueue does not operate if user space is frozen (for
>>> suspend).  As a result, the SSR subdevice only delivers its
>>> crash notification when the system is fully operational (i.e.,
>>> neither suspended nor in suspend/resume transition).
>>>
>> This makes sense to me; both that it ensures that we spend our resources
>> on the actual system resume and that it avoids surprises from this
>> happening while the system still is in a funky state...
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> But it would be nice to get some input from other users of the
>> framework.
> This patch sounds like a good idea for cases where the
> request_firmware() APIs fallback to userspace firmware loading.
>
> Will test out this patch and report back.
>
> Thanks,
> Sid
I was able to test out this change with one of our usecases, no
issues to report.

Could you please CC stable as well?

Thanks,
Sid

Tested-by: Siddharth Gupta <sidgup@codeaurora.org>
>>
>> Regards,
>> Bjorn
>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>   drivers/remoteproc/remoteproc_core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index 39cf44cb08035..6bedf2d2af239 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -2724,8 +2724,8 @@ void rproc_report_crash(struct rproc *rproc, 
>>> enum rproc_crash_type type)
>>>       dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>>>           rproc->name, rproc_crash_to_string(type));
>>>   -    /* create a new task to handle the error */
>>> -    schedule_work(&rproc->crash_handler);
>>> +    /* Have a worker handle the error; ensure system is not 
>>> suspended */
>>> +    queue_work(system_freezable_wq, &rproc->crash_handler);
>>>   }
>>>   EXPORT_SYMBOL(rproc_report_crash);
>>>   --
>>> 2.27.0
>>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15C397531
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhFAOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhFAOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:14:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981FBC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:12:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d25so15461189ioe.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OUIJD/fmYAlR+wqYWbhMwLjHThhSbr6I4Y+gE7MD5qM=;
        b=TpLYm2SUozQQMMUBgo8b7nAU1WGe1TaAWmPtyLZBONc7XD16vrLDHEz7X96X9EkXL9
         pbN6/gJ6bBwg/AEGyt5EKGHNNc52exGocny+48sN22iR3K0TDaDjwRzkgI7gN//fSlMI
         kgAzttL1HRNG45PovRFtHChklbNlnn6h5TSFCn/jzIhNVk/NV5HPWG6M5DQW8BZg+wEY
         2oREVTc4h8F4sF1tVVNnoVnM+ylT6L874risva6TFwnZdonPBVXpk43BXylUnARPBT2M
         lTeSOHm5lppOcQH4Gy0rZ8qGkdbo8XCqYMzrmoVVpcQzPQ8+BHmiqudy6PrpjwQCPOUI
         mddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OUIJD/fmYAlR+wqYWbhMwLjHThhSbr6I4Y+gE7MD5qM=;
        b=KZp+371KzWmEfDfG3v1s5DqLjMFUtXmhJf/QWd2RnLT+Xk3GuqxMud5vNOjAy1PURE
         /gTUQtUwpswvQ3cCyWWSBPbWwQ9MyUHHcSXs5AqpGXEsA2x1Dzu2FNRWSp5CFIG4m1tL
         FvBrj3bBXlyyptGexfS9JCcQUtizcVT+t9Jogikya4dP5bz2qvtDja7sBHQi1Gxq0r9C
         MMGDppoxl6V5wPGeIgPv2Me5B1HKo1ruSuUvmgHCHN8rcA+roHc+d/eUXTm3elcmvmEs
         j+3CZ5PZVb7RFQR9PLMaNi2tCQS6mOnJiLZpC/E0nshmuF2NDoK5S43hCduVvmIBV3Kc
         qQyQ==
X-Gm-Message-State: AOAM530AWTyGBi4Isdy2aWJB/2Ct9Q9LUDRSmWZVyp8MAf1UlG76owEe
        DCEjbKtNfeXm8xFDTtGfN2ZN2BRznyV3Rg8v
X-Google-Smtp-Source: ABdhPJyaG0jU/YUXrPCuctAIH/L6dIsWbsTus66LP2CUN2gN7cNH1qItSQ/jAbzBR3fBT122DVnigA==
X-Received: by 2002:a6b:6a0c:: with SMTP id x12mr11331174iog.81.1622556758618;
        Tue, 01 Jun 2021 07:12:38 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f26sm5113582ioo.17.2021.06.01.07.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 07:12:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] remoteproc: use freezable workqueue for crash
 notifications
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210519234418.1196387-1-elder@linaro.org>
 <20210519234418.1196387-2-elder@linaro.org> <YLBpmdZoGDXNz64y@builder.lan>
 <20210531172153.GA1718330@xps15>
From:   Alex Elder <elder@linaro.org>
Message-ID: <c52a7df2-10d9-e1c9-f9bd-7fd205ec003a@linaro.org>
Date:   Tue, 1 Jun 2021 09:12:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531172153.GA1718330@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 12:21 PM, Mathieu Poirier wrote:
> On Thu, May 27, 2021 at 10:55:05PM -0500, Bjorn Andersson wrote:
>> On Wed 19 May 18:44 CDT 2021, Alex Elder wrote:
>>
>>> When a remoteproc has crashed, rproc_report_crash() is called to
>>> handle whatever recovery is desired.  This can happen at almost any
>>> time, often triggered by an interrupt, though it can also be
>>> initiated by a write to debugfs file remoteproc/remoteproc*/crash.
>>>
>>> When a crash is reported, the crash handler worker is scheduled to
>>> run (rproc_crash_handler_work()).  One thing that worker does is
>>> call rproc_trigger_recovery(), which calls rproc_stop().  That calls
>>> the ->stop method for any remoteproc subdevices before making the
>>> remote processor go offline.
>>>
>>> The Q6V5 modem remoteproc driver implements an SSR subdevice that
>>> notifies registered drivers when the modem changes operational state
>>> (prepare, started, stop/crash, unprepared).  The IPA driver
>>> registers to receive these notifications.
>>>
>>> With that as context, I'll now describe the problem.
>>>
>>> There was a situation in which buggy modem firmware led to a modem
>>> crash very soon after system (AP) resume had begun.  The crash caused
>>> a remoteproc SSR crash notification to be sent to the IPA driver.
>>> The problem was that, although system resume had begun, it had not
>>> yet completed, and the IPA driver was still in a suspended state.
> 
> This is a very tight race condition - I agree with you that it is next to
> impossible to test.
> 
>>>
>>> This scenario could happen to any driver that registers for these
>>> SSR notifications, because they are delivered without knowledge of
>>> the (suspend) state of registered recipient drivers.
>>>
>>> This patch offers a simple fix for this, by having the crash
>>> handling worker function run on the system freezable workqueue.
>>> This workqueue does not operate if user space is frozen (for
>>> suspend).  As a result, the SSR subdevice only delivers its
>>> crash notification when the system is fully operational (i.e.,
>>> neither suspended nor in suspend/resume transition).
>>>
> 
> I think the real fix for this problem should be in the platform driver where
> the remoteproc interrupt would be masked while suspending and re-enabled again
> when resuming.  The runtime PM API would work just fine for that...  But doing

I considered that (and sent a private e-mail to Bjorn with that
as a suggestion), but as he pointed out, there's a chance this
would include disabling an interrupt that is needed to trigger a
system resume.

> so wouldn't guarantee that other drivers, i.e IPA, would be operational.  Unless
> of one is a child of the other or using a bus like mechanic, and getting
> to that point will introduce a lot more churn than what this patch does.

Agreed.  I think either the remoteproc driver should handle it
centrally, or all drivers that could be affected by this scenario
should be updated to handle it.  To my knowledge only IPA is
affected, but if it's possible for remoteproc to handle it, it's
simpler overall.

Thanks for the review.

					-Alex

> The proposed solution will work since user space is expected to resume when
> the kernel and drivers are fully operational.  As you pointed out the only
> concern is with other users, which may not be noticeable given the very small
> delay that is introduced.  As such:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro>
> 
> But be mindful the patch will have to be reverted if someone complains, whether
> that happens in two weeks or 10 months.
> 
> Thanks,
> Mathieu
> 
>>
>> This makes sense to me; both that it ensures that we spend our resources
>> on the actual system resume and that it avoids surprises from this
>> happening while the system still is in a funky state...
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> But it would be nice to get some input from other users of the
>> framework.
>>
>> Regards,
>> Bjorn
>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>   drivers/remoteproc/remoteproc_core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index 39cf44cb08035..6bedf2d2af239 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -2724,8 +2724,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>>>   	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>>>   		rproc->name, rproc_crash_to_string(type));
>>>   
>>> -	/* create a new task to handle the error */
>>> -	schedule_work(&rproc->crash_handler);
>>> +	/* Have a worker handle the error; ensure system is not suspended */
>>> +	queue_work(system_freezable_wq, &rproc->crash_handler);
>>>   }
>>>   EXPORT_SYMBOL(rproc_report_crash);
>>>   
>>> -- 
>>> 2.27.0
>>>


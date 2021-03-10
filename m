Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2534334C16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCJW7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:59:11 -0500
Received: from z11.mailgun.us ([104.130.96.11]:17040 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhCJW7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:59:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615417140; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NZPFVKOhoarmXo1gvuFRbDFcPH5WTj7PPL72LKMrY3Q=;
 b=xR8Cv34BN42CQdQfMMJA5DY+i8/FB/xBxHJFya9KHEedk16I16z/KtXErPpa4mBYO+HwotEC
 UMzPUI00FHzEZ38duvq7tLvwCwEU/sesG6+ooaPH8gfqzGWGvljbnvVEDL6gWHeaZ+wzvbRR
 JojbhcR2//6rDu6Wck78+VQe9Tw=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60494f20e90f410d8892ca1b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 22:58:40
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EED9AC433ED; Wed, 10 Mar 2021 22:58:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22269C433CA;
        Wed, 10 Mar 2021 22:58:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Mar 2021 14:58:39 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, carl.yin@quectel.com,
        naveen.kumar@quectel.com
Subject: Re: [PATCH v3 2/3] bus: mhi: core: Move to polling method to wait for
 MHI ready
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <df566e64-8335-2ab2-85c8-bed4ec5b649d@codeaurora.org>
References: <1614138270-2374-1-git-send-email-bbhatt@codeaurora.org>
 <1614138270-2374-3-git-send-email-bbhatt@codeaurora.org>
 <df566e64-8335-2ab2-85c8-bed4ec5b649d@codeaurora.org>
Message-ID: <7c4abd2122178ec1db4ee69c1188be06@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-10 11:02 AM, Jeffrey Hugo wrote:
> On 2/23/2021 8:44 PM, Bhaumik Bhatt wrote:
>> In certain devices, it is likely that there is no incoming MHI
>> interrupt for a transition to MHI READY state. One such example
>> is the move from Pass Through to an SBL or AMSS execution
>> environment. In order to facilitate faster bootup times as there
>> is no need to wait until timeout_ms completes, MHI host can poll
>> every 25 milliseconds to check if device has entered MHI READY
>> until a maximum timeout of twice the timeout_ms is reached.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>   drivers/bus/mhi/core/pm.c | 31 ++++++++++++++-----------------
>>   1 file changed, 14 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
>> index 681960c..5fe33d4 100644
>> --- a/drivers/bus/mhi/core/pm.c
>> +++ b/drivers/bus/mhi/core/pm.c
>> @@ -153,34 +153,31 @@ static void mhi_toggle_dev_wake(struct 
>> mhi_controller *mhi_cntrl)
>>   /* Handle device ready state transition */
>>   int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
>>   {
>> -	void __iomem *base = mhi_cntrl->regs;
>>   	struct mhi_event *mhi_event;
>>   	enum mhi_pm_state cur_state;
>>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> -	u32 reset = 1, ready = 0;
>>   	int ret, i;
>>   -	/* Wait for RESET to be cleared and READY bit to be set by the 
>> device */
>> -	wait_event_timeout(mhi_cntrl->state_event,
>> -			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
>> -			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
>> -					      MHICTRL_RESET_MASK,
>> -					      MHICTRL_RESET_SHIFT, &reset) ||
>> -			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
>> -					      MHISTATUS_READY_MASK,
>> -					      MHISTATUS_READY_SHIFT, &ready) ||
>> -			   (!reset && ready),
>> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
>> -
>>   	/* Check if device entered error state */
>>   	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
>>   		dev_err(dev, "Device link is not accessible\n");
>>   		return -EIO;
>>   	}
>>   -	/* Timeout if device did not transition to ready state */
>> -	if (reset || !ready) {
>> -		dev_err(dev, "Device Ready timeout\n");
>> +	/* Wait for RESET to be cleared and READY bit to be set by the 
>> device */
>> +	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
>> +				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
>> +				 25000);
>> +	if (ret) {
>> +		dev_err(dev, "Device failed to clear MHI Reset\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
>> +				 MHISTATUS_READY_MASK, MHISTATUS_READY_SHIFT, 1,
>> +				 25000);
> 
> You use the magic number "25000" twice here.  Its my understanding
> that the preference is to inline a magic number if its used in one
> spot, but use a macro if its used more than that.
> 
> Both uses are confined to this function, and in close proximity, so
> chances that one gets updated without the other seem minimal, so this
> feels like a borderline case.  I don't know if Mani has an opinion
> here.
> 
> I'd probably err on the side of making a macro or a single variable.
> If not, I think some comments explaining the value are warranted
> (should comment the macro as well).
> 
I think just using a variable would be good enough here. I can add a 
comment
when defining the interval variable.
>> +	if (ret) {
>> +		dev_err(dev, "Device failed to enter MHI Ready\n");
>>   		return -ETIMEDOUT;
>>   	}
>> 

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F075D3EDDAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhHPTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:14:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32642 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhHPTO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:14:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629141236; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=y3QxgLLMAHDGT/O91XFpBlSppDSzi2ZVZ41kaemQDLo=; b=jPawhMLrm8pkw+d4/MWzN5XOhBKw7dOtpKAZqzQPoKUMbOCt1eAUX2tHBaZTkcSr4XI+OuwF
 /rx3jHsACiCxGx/ecYjcnWlDm7cyb2oyT3qIUmJVGCxISEbU7DnEB7V9zQBEK24n3Ofxp1l9
 rwsLLZUlH6LV/1wBB1QTufhaf1k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 611ab8e3b3873958f5f82c25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 19:13:39
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54883C43618; Mon, 16 Aug 2021 19:13:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.9] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53ABAC43460;
        Mon, 16 Aug 2021 19:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 53ABAC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
 <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
 <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
 <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
 <00952bdc-acc2-f373-9286-6a8380e0b7d1@synopsys.com>
 <875yw7jkz6.fsf@kernel.org>
 <89b4d57c-f44a-ceff-45f3-a308e1d8d135@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <4c5ee1be-5cda-f56b-7f69-73124a16abba@codeaurora.org>
Date:   Mon, 16 Aug 2021 12:13:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <89b4d57c-f44a-ceff-45f3-a308e1d8d135@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 8/15/2021 5:33 PM, Thinh Nguyen wrote:
> Felipe Balbi wrote:
>>
>> Hi,
>>
>> Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>>>>>>>>> If this occurs, then the entire pullup disable routine is skipped and
>>>>>>>>>>> proper cleanup and halting of the controller does not complete.
>>>>>>>>>>> Instead of returning an error (which is ignored from the UDC
>>>>>>>>>>> perspective), do what is mentioned in the comments and force the
>>>>>>>>>>> transaction to complete and put the ep0state back to the SETUP phase.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>>>>>>>> ---
>>>>>>>>>>>  drivers/usb/dwc3/ep0.c    | 4 ++--
>>>>>>>>>>>  drivers/usb/dwc3/gadget.c | 6 +++++-
>>>>>>>>>>>  drivers/usb/dwc3/gadget.h | 3 +++
>>>>>>>>>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>> index 6587394..abfc42b 100644
>>>>>>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>> @@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>>>>>>>>>>  	return ret;
>>>>>>>>>>>  }
>>>>>>>>>>>  
>>>>>>>>>>> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>>  {
>>>>>>>>>>>  	struct dwc3_ep		*dep;
>>>>>>>>>>>  
>>>>>>>>>>> @@ -1073,7 +1073,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>>>>>>>>>>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>>>>>>>>>>>  }
>>>>>>>>>>>  
>>>>>>>>>>> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>>  {
>>>>>>>>>>>  	struct dwc3_gadget_ep_cmd_params params;
>>>>>>>>>>>  	u32			cmd;
>>>>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>> index 54c5a08..a0e2e4d 100644
>>>>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>> @@ -2437,7 +2437,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>>>>>>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>>>>>>>>>>  		if (ret == 0) {
>>>>>>>>>>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>>>>>>>>>>> -			return -ETIMEDOUT;
>>>>>>>>>>> +			spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[0]);
>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
>>>>>>>>>>
>>>>>>>>>> End transfer command takes time, need to wait for it to complete before
>>>>>>>>>> issuing Start transfer again. Also, why restart again when it's about to
>>>>>>>>>> be disconnected.
>>>>>>>>>
>>>>>>>>> I can try without restarting it again, and see if that works.  Instead
>>>>>>>>> of waiting for the command complete event, can we set the ForceRM bit,
>>>>>>>>> similar to what we do for dwc3_remove_requests()?
>>>>>>>>>
>>>>>>>>
>>>>>>>> ForceRM=1 means that the controller will ignore updating the TRBs
>>>>>>>> (including not clearing the HWO and remain transfer size). The driver
>>>>>>>> still needs to wait for the command to complete before issuing Start
>>>>>>>> Transfer command. Otherwise Start Transfer won't go through. If we know
>>>>>>>> that we're not going to issue Start Transfer any time soon, then we may
>>>>>>>> be able to get away with ignoring End Transfer command completion.
>>>>>>>>
>>>>>>>
>>>>>>> I see.  Currently, in the place that we do use
>>>>>>> dwc3_ep0_end_control_data(), its followed by
>>>>>>> dwc3_ep0_stall_and_restart() which would execute start transfer.  For
>>>>>>
>>>>>> That doesn't look right. You can try to see if it can recover from a
>>>>>> control write request. Often time we do control read and not write.
>>>>>> (i.e. try to End Transfer and immediately Start Transfer on the same
>>>>>> direction control endpoint).
>>>>>>
>>>>> OK, I can try, but just to clarify, I was referring to how it was being
>>>>> done in:
>>>>>
>>>>> static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
>>>>> 		const struct dwc3_event_depevt *event)
>>>>> {
>>>>> ...
>>>>> 		if (dwc->ep0_expect_in != event->endpoint_number) {
>>>>> 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
>>>>>
>>>>> 			dev_err(dwc->dev, "unexpected direction for Data Phase\n");
>>>>> 			dwc3_ep0_end_control_data(dwc, dep);
>>>>> 			dwc3_ep0_stall_and_restart(dwc);
>>>>> 			return;
>>>>> 		}
>>>>>
>>>
>>> Looking at this snippet again, it looks wrong. For control write
>>> unexpected direction, if the driver hasn't setup and started the DATA
>>> phase yet, then it's fine, but there is a problem if it did.
>>>
>>> Since dwc3_ep0_end_control_data() doesn't issue End Transfer command to
>>> ep0 due to the resource_index check, it doesn't follow the control
>>
>> IIRC resource_index is always non-zero, so the command should be
> 
> No, resource_index for ep0out is 0, ep0in is 1. You can check from any
> of the driver tracepoint log for the return value of Start Transfer
> command for the resource index of ep0. There could be a mixed up with
> the undocumented return value of Set Endpoint Transfer Resource command
> before when this code was written, don't mix up with that.
> 
>> triggered. If you have access to a Lecroy USB Trainer, could you script
>> this very scenario for verification?
> 
> For anyone who wants to work on this, we don't need a LeCroy USB
> trainer. If you use xhci host, just modify the xhci-ring.c to queue a
> wrong direction DATA phase TRB of a particular control write request
> test, and continue with the next control requests.
> 
Let me give this a try since I already have a modified (broken :)) XHCI
stack.

Thanks
Wesley Cheng
>>
>>> transfer flow model in the programming guide. This may cause
>>> dwc3_ep0_stall_and_restart() to overwrite the TRBs for the DATA phase
>>> with SETUP stage. Also, if the ep0 is already started, the driver won't
>>> issue Start Transfer command again.
>>
>>> This issue is unlikely to occur unless we see a misbehave host for
>>> control write request. Regardless, we need to fix this. I may need some
>>
>> right, it would be a misbehaving host, however databook called it out as
>> something that _can_ happen. Moreover, I have vague memories of this
>> being one of the test cases in Lecroy's USB Certification Suite.
>>
> 
> Yes, it's something that can happen, and dwc3 should be able to handle
> it. If you remember which test in particular that tests this, let me
> know. I want to check how it was passed.
> 
>>> time before I can create a patch and test it. If you or anyone is up to
>>> take this on, it'd be highly appreciated.
>>
>> Before we go ahead writing a patch for this, I'd really like to see
>> traces showing this failure and a minimal reproducer. The reproducer
>> would probably have to be a script for Lecroy's USB Trainer.
>>
>> Keep in mind this entire ep0 stack used to pass USBCV on every -rc and
>> major release (before I lost access to all my USB gear heh).
>>
> 
> Are you referring to Ch9 USBCV? I don't recall there's a particular test
> for this.
> 
> There should be a red flag whenever we see End Transfer command
> immediately follows by a Start Transfer command without any waiting for
> End Transfer completion. Though, in this case, we don't go through with
> the End Transfer for ep0 due to the resource_index check in
> dwc3_ep0_end_control_data().
> 
> BR,
> Thinh
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

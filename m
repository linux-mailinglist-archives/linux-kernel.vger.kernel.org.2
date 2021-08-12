Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011123EAD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhHLXUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:20:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43928 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235127AbhHLXUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:20:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628810391; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HKumf2afBu1a1S9pqj0Ftin/QsVFKauainQ39Momt1c=; b=mqDFPx/e7e1NKznV/as24NbzwE117bDqhuLLLt0NBZ7v88zqNMZrUUK+e8idi1212xFiojbN
 /AYinZH9RFLV2pM2sjagEjwdhFVxhcO+cylTSYJygAMsUv8j4RdfWGreGyBzseFQLyHBEDPT
 2mhFJJUfggmZ/VDCdHgt95w09Cg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6115ac76b14e7e2ecbc7c6a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 23:19:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BB40C4338A; Thu, 12 Aug 2021 23:19:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.26] (075-140-094-099.biz.spectrum.com [75.140.94.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 574F8C433F1;
        Thu, 12 Aug 2021 23:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 574F8C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
Date:   Thu, 12 Aug 2021 16:19:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 8/12/2021 2:31 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 8/11/2021 5:47 PM, Thinh Nguyen wrote:
>>> Wesley Cheng wrote:
>>>> During a USB cable disconnect, or soft disconnect scenario, a pending
>>>> SETUP transaction may not be completed, leading to the following
>>>> error:
>>>>
>>>>     dwc3 a600000.dwc3: timed out waiting for SETUP phase
>>>
>>> How could it be a case of cable disconnect? The pullup(0) only applies
>>> for soft-disconnect scenario. If the device initiated a disconnect, then
>>
>> Thanks for the response.  I guess this is specific for some use cases,
>> but some applications such as ADB will close the FFS EP files after it
>> gets the disconnection event, leading to this pullup disable as well.
>> So its specific to that particular use case.
> 
> Does that mean that the ADB application won't expect a connection until
> user intervention or some other notification to do pullup(1)?
> 

Yes, correct.  The Android USB framework will trigger the pullup(1) again.

>>
>>> the driver should wait for the control request to complete. If it times
>>> out, something is already wrong here. The programming guide only
>>> mentions that we should wait for completion, but it doesn't say about
>>> recovery in a case of hung transfer. I need to check internally but it
>>> should be safe to issue End Transfer.
>>>
>>
>> Yes, what I did was modify a device running the Linux XHCI stack w/o
>> reading/sending out the SETUP DATA phase, so that on the device end we'd
>> always run into that situation where there's still a pending EP0 TRB queued.
> 
> Is this only for validation purpose?
> 

Yes, just to help verify the fix by injecting the error condition.

>>
>> We're running multiple devices with this fix as well, and doing device
>> initiated disconnect.
>>
>>>>
>>>> If this occurs, then the entire pullup disable routine is skipped and
>>>> proper cleanup and halting of the controller does not complete.
>>>> Instead of returning an error (which is ignored from the UDC
>>>> perspective), do what is mentioned in the comments and force the
>>>> transaction to complete and put the ep0state back to the SETUP phase.
>>>>
>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>> ---
>>>>  drivers/usb/dwc3/ep0.c    | 4 ++--
>>>>  drivers/usb/dwc3/gadget.c | 6 +++++-
>>>>  drivers/usb/dwc3/gadget.h | 3 +++
>>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>> index 6587394..abfc42b 100644
>>>> --- a/drivers/usb/dwc3/ep0.c
>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>> @@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>  {
>>>>  	struct dwc3_ep		*dep;
>>>>  
>>>> @@ -1073,7 +1073,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>>>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>>>>  }
>>>>  
>>>> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>  {
>>>>  	struct dwc3_gadget_ep_cmd_params params;
>>>>  	u32			cmd;
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 54c5a08..a0e2e4d 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -2437,7 +2437,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>>>  		if (ret == 0) {
>>>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>>>> -			return -ETIMEDOUT;
>>>> +			spin_lock_irqsave(&dwc->lock, flags);
>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[0]);
>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
>>>
>>> End transfer command takes time, need to wait for it to complete before
>>> issuing Start transfer again. Also, why restart again when it's about to
>>> be disconnected.
>>
>> I can try without restarting it again, and see if that works.  Instead
>> of waiting for the command complete event, can we set the ForceRM bit,
>> similar to what we do for dwc3_remove_requests()?
>>
> 
> ForceRM=1 means that the controller will ignore updating the TRBs
> (including not clearing the HWO and remain transfer size). The driver
> still needs to wait for the command to complete before issuing Start
> Transfer command. Otherwise Start Transfer won't go through. If we know
> that we're not going to issue Start Transfer any time soon, then we may
> be able to get away with ignoring End Transfer command completion.
> 

I see.  Currently, in the place that we do use
dwc3_ep0_end_control_data(), its followed by
dwc3_ep0_stall_and_restart() which would execute start transfer.  For
the most part, we were trying to follow the flow diagram in:

	4.4 Control Transfer Programming Model

We'd technically be in the "wait for host" stage at this point, so hence
why we issued the end transfer, then followed with the stall and restart.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

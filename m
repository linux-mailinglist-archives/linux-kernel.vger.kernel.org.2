Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CD3EA936
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhHLRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:12:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47185 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhHLRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:12:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628788344; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uEmi5V6gGqQLIMtybEuP9G2G3UWbtuAyTLxZ9xJUlAo=; b=IlGH+Xt80Lvu1PQGYvQ6vgQfHq8YF/IqXeHnagBGuu94mYFB3GnUFvi4CtZT/rvrb0lR/1nr
 CjG5cw5iAgrlX/9fTbIiI2JIecwFFCe9/emO14SORcz+Arsajl3ELVIWSvpYz4Ec1hZiTDUy
 stzcGQqe107qFZ++cao5wmkXTDI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61155667f746c298d93fa7f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 17:12:07
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4451C43217; Thu, 12 Aug 2021 17:12:06 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24553C433F1;
        Thu, 12 Aug 2021 17:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24553C433F1
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
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
Date:   Thu, 12 Aug 2021 10:12:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 8/11/2021 5:47 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> During a USB cable disconnect, or soft disconnect scenario, a pending
>> SETUP transaction may not be completed, leading to the following
>> error:
>>
>>     dwc3 a600000.dwc3: timed out waiting for SETUP phase
> 
> How could it be a case of cable disconnect? The pullup(0) only applies
> for soft-disconnect scenario. If the device initiated a disconnect, then

Thanks for the response.  I guess this is specific for some use cases,
but some applications such as ADB will close the FFS EP files after it
gets the disconnection event, leading to this pullup disable as well.
So its specific to that particular use case.

> the driver should wait for the control request to complete. If it times
> out, something is already wrong here. The programming guide only
> mentions that we should wait for completion, but it doesn't say about
> recovery in a case of hung transfer. I need to check internally but it
> should be safe to issue End Transfer.
> 

Yes, what I did was modify a device running the Linux XHCI stack w/o
reading/sending out the SETUP DATA phase, so that on the device end we'd
always run into that situation where there's still a pending EP0 TRB queued.

We're running multiple devices with this fix as well, and doing device
initiated disconnect.

>>
>> If this occurs, then the entire pullup disable routine is skipped and
>> proper cleanup and halting of the controller does not complete.
>> Instead of returning an error (which is ignored from the UDC
>> perspective), do what is mentioned in the comments and force the
>> transaction to complete and put the ep0state back to the SETUP phase.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/ep0.c    | 4 ++--
>>  drivers/usb/dwc3/gadget.c | 6 +++++-
>>  drivers/usb/dwc3/gadget.h | 3 +++
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 6587394..abfc42b 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>  	return ret;
>>  }
>>  
>> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>  {
>>  	struct dwc3_ep		*dep;
>>  
>> @@ -1073,7 +1073,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>>  }
>>  
>> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>  {
>>  	struct dwc3_gadget_ep_cmd_params params;
>>  	u32			cmd;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 54c5a08..a0e2e4d 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2437,7 +2437,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>  		if (ret == 0) {
>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>> -			return -ETIMEDOUT;
>> +			spin_lock_irqsave(&dwc->lock, flags);
>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[0]);
>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
> 
> End transfer command takes time, need to wait for it to complete before
> issuing Start transfer again. Also, why restart again when it's about to
> be disconnected.

I can try without restarting it again, and see if that works.  Instead
of waiting for the command complete event, can we set the ForceRM bit,
similar to what we do for dwc3_remove_requests()?

> 
> We'd also need to watch out for soft-connect in quick succession before
> the End Transfer command completes.
> 
>> +			dwc3_ep0_stall_and_restart(dwc);
>> +			spin_unlock_irqrestore(&dwc->lock, flags);
>>  		}
>>  	}
>>  
>> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
>> index 77df4b6..632f7b7 100644
>> --- a/drivers/usb/dwc3/gadget.h
>> +++ b/drivers/usb/dwc3/gadget.h
>> @@ -114,6 +114,9 @@ int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
>>  int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
>>  int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>  		gfp_t gfp_flags);
>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
>> +
>>  int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
>>  void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
>>  
>>
> 
> BR,
> Thinh
> 

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

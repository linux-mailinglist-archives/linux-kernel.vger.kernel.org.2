Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827F3381F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCKX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:57:18 -0500
Received: from z11.mailgun.us ([104.130.96.11]:49078 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCKX4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:56:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615506996; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=IMvwIvr/IrRrjCpO6L1MT0CTzwm6o6pkNDbvod+bYJk=; b=m3HHhgWyapfJiCADqlMHAQFwp5GJQ45NsjyzbdODuNFzNyhUQG/mSIXADaRXYNNbr/ZOkMYL
 nhI+roEXyCQw86OWBCWu+1udXAIzKVGQajOK0fOPrFYXXW6EnO4fg3SywLXFxXuzbso7Twqs
 17nfaEs786wKiz1flRCoKkJfLVw=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 604aae31e2200c0a0d102163 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 23:56:33
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7EBBC433C6; Thu, 11 Mar 2021 23:56:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.99.85] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A89AC433C6;
        Thu, 11 Mar 2021 23:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A89AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <1615502070-19705-1-git-send-email-wcheng@codeaurora.org>
 <35079ed1-d730-6dc7-9e4c-639b33115c79@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <f727beb0-4ae7-d0aa-4136-6d5a310ab7f4@codeaurora.org>
Date:   Thu, 11 Mar 2021 15:56:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <35079ed1-d730-6dc7-9e4c-639b33115c79@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 3:18 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> In the situations where the DWC3 gadget stops active transfers, once
>> calling the dwc3_gadget_giveback(), there is a chance where a function
>> driver can queue a new USB request in between the time where the dwc3
>> lock has been released and re-aquired.  This occurs after we've already
>> issued an ENDXFER command.  When the stop active transfers continues
>> to remove USB requests from all dep lists, the newly added request will
>> also be removed, while controller still has an active TRB for it.
>> This can lead to the controller accessing an unmapped memory address.
>>
>> Fix this by ensuring parameters to prevent EP queuing are set before
>> calling the stop active transfers API.
>>
>> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the controller")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>> Changes since V1:
>>  - Added Fixes tag to point to the commit this is addressing
>>
>>  drivers/usb/dwc3/gadget.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4780983..4d98fbf 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -783,8 +783,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>  
>>  	trace_dwc3_gadget_ep_disable(dep);
>>  
>> -	dwc3_remove_requests(dwc, dep);
>> -
>>  	/* make sure HW endpoint isn't stalled */
>>  	if (dep->flags & DWC3_EP_STALL)
>>  		__dwc3_gadget_ep_set_halt(dep, 0, false);
>> @@ -803,6 +801,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>  		dep->endpoint.desc = NULL;
>>  	}
>>  
>> +	dwc3_remove_requests(dwc, dep);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1617,7 +1617,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  {
>>  	struct dwc3		*dwc = dep->dwc;
>>  
>> -	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>> +	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
>>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>  				dep->name);
>>  		return -ESHUTDOWN;
>> @@ -2247,6 +2247,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  	if (!is_on) {
>>  		u32 count;
>>  
>> +		dwc->connected = false;
> 
> 
> You want to set this before __dwc3_gadget_stop() right? Then you may
> want to remove this same setting few lines below this. Otherwise, this
> looks good.
> 
> Thanks,
> Thinh
> 
Hi Thinh,

Ah, good catch, must've missed that while porting this over from my
local branch.  Will remove that connected false setting a few lines down.

Thanks
Wesley Cheng

> 
>>  		/*
>>  		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>>  		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
>> @@ -3329,8 +3330,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  {
>>  	u32			reg;
>>  
>> -	dwc->connected = true;
>> -
>>  	/*
>>  	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
>>  	 * would cause a missing Disconnect Event if there's a
>> @@ -3370,6 +3369,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  	 * transfers."
>>  	 */
>>  	dwc3_stop_active_transfers(dwc);
>> +	dwc->connected = true;
>>  
>>  	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>  	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
>>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

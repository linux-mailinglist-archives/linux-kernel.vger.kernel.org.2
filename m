Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01303A32FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFJSYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:24:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22203 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhFJSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:24:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623349335; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=E3TulAYeD48+XPfMqj2062F9NYilPaepjuhGKVCkFIg=; b=JPfDRQCRBDuXDGwl7k7WXjexphTcfqgq9faLaeSFMJ8pTTjfT2p64fBsxoK2GYVdPCoZeo9X
 DC03hyt4xsRYZuY9ABfohLpBKF/nYVst2i6ml6yJz1T4QxW3KfcdO1cqu0MwQ4lncQRWApSZ
 2mxGFpNvvsIjP5TqaQAmNSqujro=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60c25842f726fa41880f020e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Jun 2021 18:21:54
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C694C4360C; Thu, 10 Jun 2021 18:21:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.62.3] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B639C433D3;
        Thu, 10 Jun 2021 18:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B639C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup
 disable
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
 <87h7i60ye8.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <724ba69a-8c67-4b4b-3e6a-a5834b09e6e1@codeaurora.org>
Date:   Thu, 10 Jun 2021 11:21:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87h7i60ye8.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2021 4:09 AM, Felipe Balbi wrote:
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
>> Current sequence utilizes dwc3_gadget_disable_irq() alongside
>> synchronize_irq() to ensure that no further DWC3 events are generated.
>> However, the dwc3_gadget_disable_irq() API only disables device
>> specific events.  Endpoint events can still be generated.  Briefly
>> disable the interrupt line, so that the cleanup code can run to
>> prevent device and endpoint events. (i.e. __dwc3_gadget_stop() and
>> dwc3_stop_active_transfers() respectively)
>>
>> Without doing so, it can lead to both the interrupt handler and the
>> pullup disable routine both writing to the GEVNTCOUNT register, which
>> will cause an incorrect count being read from future interrupts.
>>
>> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the controller")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/gadget.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 49ca5da..89aa9ac 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2260,13 +2260,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  	}
>>  
>>  	/*
>> -	 * Synchronize any pending event handling before executing the controller
>> -	 * halt routine.
>> +	 * Synchronize and disable any further event handling while controller
>> +	 * is being enabled/disabled.
>>  	 */
>> -	if (!is_on) {
>> -		dwc3_gadget_disable_irq(dwc);
>> -		synchronize_irq(dwc->irq_gadget);
>> -	}
>> +	disable_irq(dwc->irq_gadget);
>>  
>>  	spin_lock_irqsave(&dwc->lock, flags);
> 
> spin_lock_irqsave() is already disabling interrupt, right? Why do we
> need another call to disable_irq()?
> 

Hi Felipe,

Yes, I remember you brought up that point as well before.  So when I
checked the logs (USB and scheduler ftrace) for this issue, I clearly
saw that we were handling a soft disconnect on CPU3 and then an DWC3 IRQ
being scheduled into CPU0.  Last time we discussed, I mentioned that
spin_lock_irqsave() only disables interrupts on that particular CPU the
thread is running on.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

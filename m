Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4913A34CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:30:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43328 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJUaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:30:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623356889; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=iTxrC4mF4w/Quqh7s+egckNZ4to2Zt81mjmqcIDFHTE=; b=dV/HjaYFOyr5ZAnPrcWCkZcN4Disyyqb5LTO+C17rrFtN4ANO1ig82YUCbeXnaSFwssauXU5
 gqYj0GjcxEj/emuxuCF8QrguWksE65ExT3sv0yYP3uJiib+JIj4Zs5fMFHUxI2wxPxnD5wxN
 GKwGMxq1WL6XzhW9TuumNoT45P8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c275ceed59bf69cc763aab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Jun 2021 20:27:58
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B0C9C4323A; Thu, 10 Jun 2021 20:27:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.41.194] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4A37C433F1;
        Thu, 10 Jun 2021 20:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4A37C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup
 disable
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
 <87h7i60ye8.fsf@kernel.org>
 <724ba69a-8c67-4b4b-3e6a-a5834b09e6e1@codeaurora.org>
Message-ID: <a59a81c1-367f-b4b0-b6bf-dbe91ab3613d@codeaurora.org>
Date:   Thu, 10 Jun 2021 13:27:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <724ba69a-8c67-4b4b-3e6a-a5834b09e6e1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2021 11:21 AM, Wesley Cheng wrote:
> 
> 
> On 6/10/2021 4:09 AM, Felipe Balbi wrote:
>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>
>>> Current sequence utilizes dwc3_gadget_disable_irq() alongside
>>> synchronize_irq() to ensure that no further DWC3 events are generated.
>>> However, the dwc3_gadget_disable_irq() API only disables device
>>> specific events.  Endpoint events can still be generated.  Briefly
>>> disable the interrupt line, so that the cleanup code can run to
>>> prevent device and endpoint events. (i.e. __dwc3_gadget_stop() and
>>> dwc3_stop_active_transfers() respectively)
>>>
>>> Without doing so, it can lead to both the interrupt handler and the
>>> pullup disable routine both writing to the GEVNTCOUNT register, which
>>> will cause an incorrect count being read from future interrupts.
>>>
>>> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the controller")
>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 11 +++++------
>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 49ca5da..89aa9ac 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2260,13 +2260,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>  	}
>>>  
>>>  	/*
>>> -	 * Synchronize any pending event handling before executing the controller
>>> -	 * halt routine.
>>> +	 * Synchronize and disable any further event handling while controller
>>> +	 * is being enabled/disabled.
>>>  	 */
>>> -	if (!is_on) {
>>> -		dwc3_gadget_disable_irq(dwc);
>>> -		synchronize_irq(dwc->irq_gadget);
>>> -	}
>>> +	disable_irq(dwc->irq_gadget);
>>>  
>>>  	spin_lock_irqsave(&dwc->lock, flags);
>>
>> spin_lock_irqsave() is already disabling interrupt, right? Why do we
>> need another call to disable_irq()?
>>
> 
> Hi Felipe,
> 
> Yes, I remember you brought up that point as well before.  So when I
> checked the logs (USB and scheduler ftrace) for this issue, I clearly
> saw that we were handling a soft disconnect on CPU3 and then an DWC3 IRQ
> being scheduled into CPU0.  Last time we discussed, I mentioned that
> spin_lock_irqsave() only disables interrupts on that particular CPU the
> thread is running on.
> 
Hi Felipe,

Let me share the ftrace snippets as well:

USB FTRACE:

<idle>-0    [002]   304.567900:  dwc3_gadget_ep_cmd   name=ep0out
cmd=1030  param0=0  param1=4026523648  param2=0  cmd_status=0
<idle>-0    [004]   304.583225:  dwc3_gadget_ep_cmd   name=ep1out
cmd=134152  param0=0  param1=0  param2=0  cmd_status=0

//We don't have any logging in pullup disable, but this is when that
occurs, as we start to see -ESHUTDOWN statuses due to stop active
transfer.
<idle>-0    [004]   304.583237:  dwc3_gadget_giveback   name=ep1out
req=1243650560  actual=0  length=16384  status=4294967188  zero=0
short_not_ok=0  no_interrupt=0
<idle>-0    [004]   304.583275:  dwc3_gadget_giveback   name=ep1out
req=1243645440  actual=0  length=16384  status=4294967188  zero=0
short_not_ok=0  no_interrupt=0
<idle>-0    [004]   304.583282:  dwc3_gadget_giveback   name=ep1out
req=1243648256  actual=0  length=16384  status=4294967188  zero=0
short_not_ok=0  no_interrupt=0
<idle>-0    [004]   304.583312:  dwc3_gadget_giveback   name=ep1out
req=4075146240  actual=0  length=16384  status=4294967188  zero=0
short_not_ok=0  no_interrupt=0
...
//USB gadget disconnect is printed AFTER the pullup(0) routine is complete.
<idle>-0    [004]   304.584240:  usb_gadget_disconnect   speed=3
max_speed=6  state=7  mA=500  sg_supported=1  is_otg=0
is_a_peripheral=0  b_hnp_enable=0  a_hnp_support=0
hnp_polling_support=0  host_request_flag=0  quirk_ep_out_aligned_size=0
 quirk_altset_not_supp=0  quirk_stall_not_supp=0  quirk_zlp_not_supp=0
is_selfpowered=0  deactivated=0  connected=1  ret=4294967186

---------------------------------------------------------
CPU2 SCHED FTRACE:

kworker/u16:5-192    [002]   304.583354:  irq_handler_entry   irq=343
name=dwc3-msm
kworker/u16:5-192    [002]   304.583356:  irq_handler_exit   irq=343
ret=0
kworker/u16:5-192    [002]   304.583358:  irq_handler_entry   irq=343
name=dwc3
kworker/u16:5-192    [002]   304.583366:  irq_handler_exit   irq=343
ret=2
kworker/u16:5-192    [002]   304.583377:  sched_wakeup
comm=irq/343-dwc3  pid=20174  prio=100  success=1  target_cpu=2
kworker/u16:5-192   [002]  304.583411: sched_switch:
prev_comm=kworker/u16:5 prev_pid=192 prev_prio=120 prev_state=R ==>
next_comm=irq/343-dwc3 next_pid=20174 next_prio=100
irq/343-dwc3-20174    [002]   304.583454:  irq_handler_entry   irq=343
name=dwc3-msm
irq/343-dwc3-20174    [002]   304.583455:  irq_handler_exit   irq=343
ret=0
irq/343-dwc3-20174    [002]   304.583458:  irq_handler_entry   irq=343
name=dwc3
irq/343-dwc3-20174    [002]   304.583465:  irq_handler_exit   irq=343
ret=2

So if we assume that the point of error happens @ 304.567900 due to the
below points:
- DWC3 pullup disable routine synchronized IRQs (w/ previous logic)
before calling stop active transfers.
- DWC3 request statuses shows ESHUTDOWN, which occurs during stop active
transfer, as we call giveback w/ that error code

Then we can see that on CPU2, we're still getting DWC3 core IRQs, and
DWC3 IRQ handler is returning --> 2, which is IRQ_WAKE_THREAD.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

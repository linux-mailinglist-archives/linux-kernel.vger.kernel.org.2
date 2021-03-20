Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02D2342ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 06:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCTFaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 01:30:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53757 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhCTFav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:30:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616218251; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tVFo5x+lxEseDgWsohpDyCKYL21MNOsMDKQ0tV9WPrU=; b=szdbahO8c4x9XunvlRJmTz7IaUgNogb5ei+x6DJnE69NZKpOpwO/g2SvFAyKrhg2Cu9Ja4qT
 Qcs1t+kKn4z57wpNsvu7YUPemD5pKoAB4lwVpoRDEfy0YCAGkQFf8pgHjZvZnCrUspAPP4XP
 +62xjIzVhC5IyjIXGwnQ8pBS5Bk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6055887ee2200c0a0d48cfd0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 20 Mar 2021 05:30:38
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE13DC433CA; Sat, 20 Mar 2021 05:30:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.100.126] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4156AC433C6;
        Sat, 20 Mar 2021 05:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4156AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
 <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
 <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
 <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <d77bbea0-04eb-9426-5b16-50e408b2e787@codeaurora.org>
Date:   Fri, 19 Mar 2021 22:30:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,


On 3/19/2021 7:01 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>>
>>
>> On 3/19/2021 5:40 PM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> Wesley Cheng wrote:
>>>> The current dwc3_gadget_reset_interrupt() will stop any active
>>>> transfers, but only addresses blocking of EP queuing for while we are
>>>> coming from a disconnected scenario, i.e. after receiving the disconnect
>>>> event.  If the host decides to issue a bus reset on the device, the
>>>> connected parameter will still be set to true, allowing for EP queuing
>>>> to continue while we are disabling the functions.  To avoid this, set the
>>>> connected flag to false until the stop active transfers is complete.
>>>>
>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>> ---
>>>>  drivers/usb/dwc3/gadget.c | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 6e14fdc..d5ed0f69 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -3327,6 +3327,15 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>>>  	u32			reg;
>>>>  
>>>>  	/*
>>>> +	 * Ideally, dwc3_reset_gadget() would trigger the function
>>>> +	 * drivers to stop any active transfers through ep disable.
>>>> +	 * However, for functions which defer ep disable, such as mass
>>>> +	 * storage, we will need to rely on the call to stop active
>>>> +	 * transfers here, and avoid allowing of request queuing.
>>>> +	 */
>>>> +	dwc->connected = false;
>>>> +
>>>> +	/*
>>>>  	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
>>>>  	 * would cause a missing Disconnect Event if there's a
>>>>  	 * pending Setup Packet in the FIFO.
>>>>
>>>
>>> This doesn't look right. Did you have rebase issue with your local
>>> change again?
>>>
>>> BR,
>>> Thinh
>>>
>> Hi Thinh,
>>
>> This was rebased on Greg's usb-linus branch, which has commit
>> f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while stopping
>> transfers") merged.
> 
> Ah I see.
> 
>>
>> commit f09ddcfcb8c5  moved the dwc->connected = true to after we have
>> finished stop active transfers.  However, this change will also ensure
>> that the connected flag is set to false to ensure that when we call stop
>> active transfers, nothing can prepare TRBs.  (previous commit only
>> addresses the case where we get the reset interrupt when coming from a
>> disconnected state)
>>
> 
> That still doesn't address this issue.
> 
> Because:
> 1) We're still protected by the spin_lock_irq*(), so this change doesn't
> make any difference while handling an event.

Thank you for the feedback.  So it is true that we lock dwc->lock while
handling EP/device events, but what these changes are trying to address
is that during dwc3_stop_active_transfers() we will eventually call
dwc3_gadget_giveback() to call the complete() functions registered by
the function driver.  Before we call the complete() callbacks, we unlock
dwc->lock, so we are no longer protected, and if there was a pending ep
queue from a function driver, that would allow it to acquire the lock
and continue preparing the TRBs.

> 2) We don't enable the interrupt for END_TRANSFER command completion
> when doing dwc3_stop_active_transfers(), the
> DWC3_EP_END_TRANSFER_PENDING flag will not be set to prevent preparing
> new requests.
> 
Agreed.  That is the reason for adding the check to dwc->connected in
__dwc3_gadget_ep_queue()

if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;

> We should do dwc->connected = true when we handle connection_done
> interrupt instead. The END_TRANSFER command should complete before this.
> 
So how this change will address the issue is:

1.  IRQ handler will acquire dwc->lock
2.  dwc3_gadget_reset_handler() sets dwc->connected = false
3.  Call to dwc3_stop_active_transfers()
	---> dwc3_gadget_giveback() releases dwc->lock
4.  If there was a pending ep queue (waiting for dwc->lock) it can
continue here
5.  __dwc3_gadget_ep_queue() exits early due to dwc->connected = false
6.  dwc3_gadget_giveback() re-acquires dwc->lock and continues

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

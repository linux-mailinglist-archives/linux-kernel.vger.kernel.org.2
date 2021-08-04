Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323083DFB5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhHDGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 02:19:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14498 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhHDGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:19:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628057970; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MvT690lgnJQyLYZVI6U25Gaz7oGo0Bzcm+74dXOx2iY=; b=WHMbG/5ofgFeOo1NH6/F1H+B4DtcRfoo8i1JhH5KxG4vgXBiZ0JZjRCjdahgGvwmI5kpANdy
 +VNKuyw2JAEy95epmg2IQCU8xTuL3nTnc+bpsjsX6paNrwx3IqCSvVRL6kq1EmznyxH3GnNL
 OqCpmDVyiTQkJHLIWq5tp+VDM8M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 610a31703341038a23603d7e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 06:19:28
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06D47C4338A; Wed,  4 Aug 2021 06:19:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.9] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3E02C433F1;
        Wed,  4 Aug 2021 06:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3E02C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid runtime resume if disabling
 pullup
To:     Felipe Balbi <balbi@kernel.org>, Jack Pham <jackp@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1627691374-15711-1-git-send-email-wcheng@codeaurora.org>
 <20210802213301.GG25299@jackp-linux.qualcomm.com> <87tuk7558p.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <affc3877-43af-8816-247f-fe4631486f1c@codeaurora.org>
Date:   Tue, 3 Aug 2021 23:19:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tuk7558p.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2021 12:58 AM, Felipe Balbi wrote:
> 
> Jack Pham <jackp@codeaurora.org> writes:
> 
>> Hi Wesley,
>>
>> On Fri, Jul 30, 2021 at 05:29:34PM -0700, Wesley Cheng wrote:
>>> If the device is already in the runtime suspended state, any call to
>>> the pullup routine will issue a runtime resume on the DWC3 core
>>> device.  If the USB gadget is disabling the pullup, then avoid having
>>> to issue a runtime resume, as DWC3 gadget has already been
>>> halted/stopped.
>>>
>>> This fixes an issue where the following condition occurs:
>>>
>>> usb_gadget_remove_driver()
>>> -->usb_gadget_disconnect()
>>>  -->dwc3_gadget_pullup(0)
>>>   -->pm_runtime_get_sync() -> ret = 0
>>>   -->pm_runtime_put() [async]
>>> -->usb_gadget_udc_stop()
>>>  -->dwc3_gadget_stop()
>>>   -->dwc->gadget_driver = NULL
>>> ...
>>>
>>> dwc3_suspend_common()
>>> -->dwc3_gadget_suspend()
>>>  -->DWC3 halt/stop routine skipped, driver_data == NULL
>>>
>>> This leads to a situation where the DWC3 gadget is not properly
>>> stopped, as the runtime resume would have re-enabled EP0 and event
>>> interrupts, and since we avoided the DWC3 gadget suspend, these
>>> resources were never disabled.
>>>
>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index a29a4ca..5d08454 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2435,6 +2435,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>  	}
>>>  
>>>  	/*
>>> +	 * Avoid issuing a runtime resume if the device is already in the
>>> +	 * suspended state during gadget disconnect.  DWC3 gadget was already
>>> +	 * halted/stopped during runtime suspend.
>>> +	 */
>>> +	if (!is_on) {
>>> +		pm_runtime_barrier(dwc->dev);
>>> +		if (pm_runtime_suspended(dwc->dev))
>>> +			return 0;
>>> +	}
>>> +
>>> +	/*
>>>  	 * Check the return value for successful resume, or error.  For a
>>>  	 * successful resume, the DWC3 runtime PM resume routine will handle
>>>  	 * the run stop sequence, so avoid duplicate operations here.

Hi Jack/Felipe,

>>
>> Should this also go to stable with Fixes: 77adb8bdf422 ("usb: dwc3:
>> gadget: Allow runtime suspend if UDC unbinded") ?
> 
> sounds like a good idea.
> 

Sure, will update the commit text with the fixes tag.  Thanks!

Regards,
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

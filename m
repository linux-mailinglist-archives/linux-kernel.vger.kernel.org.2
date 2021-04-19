Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E43649F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhDSSkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:40:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27302 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhDSSkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:40:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618857571; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=U8pdmgPGHa+iJKzFbNlIcK8n7KR3QFfb/tZEk5F61lw=; b=YGlGITV/tp8hmuFUPsKcSfkGZDBq1bmKbgdAHQIE+NL9KJOM/kN/kKb8FJw2SkMzE/oKl9H+
 NLR33M0MsyEhldr8c6MtGvif8EpSO5axweV7uK0seiDiOQBPLxPMo+NFnmglNzt4iyEJHSRi
 y4/ynG5eShs1V+HldZuOE9nBYVU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 607dce61febcffa80f705bf5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Apr 2021 18:39:29
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E6D2C433D3; Mon, 19 Apr 2021 18:39:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.119.120] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34A28C433F1;
        Mon, 19 Apr 2021 18:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34A28C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
References: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
 <87mtu0njvj.fsf@kernel.org>
 <677afbd3-6c72-29c0-ca25-88dd1bff335a@codeaurora.org>
 <2e956314-b3e1-5c0e-104a-7416cf81f3ba@synopsys.com>
 <4c2c6d76-e4d5-67f5-d91c-7e402b0828f7@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <ab660f3f-9275-8f82-7c37-cb2a41eb7c3f@codeaurora.org>
Date:   Mon, 19 Apr 2021 11:39:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4c2c6d76-e4d5-67f5-d91c-7e402b0828f7@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/2021 12:28 PM, Thinh Nguyen wrote:
> Thinh Nguyen wrote:
>> Wesley Cheng wrote:
>>>
>>>
>>> On 4/14/2021 11:26 PM, Felipe Balbi wrote:
>>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>>
>>>>> If an error is received when issuing a start or update transfer
>>>>> command, the error handler will stop all active requests (including
>>>>> the current USB request), and call dwc3_gadget_giveback() to notify
>>>>> function drivers of the requests which have been stopped.  Avoid
>>>>> having to cancel the current request which is trying to be queued, as
>>>>> the function driver will handle the EP queue error accordingly.
>>>>> Simply unmap the request as it was done before, and allow previously
>>>>> started transfers to be cleaned up.
>>>>>
>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>> ---
>>>>>  drivers/usb/dwc3/gadget.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>> index e1b04c97..4200775 100644
>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>> @@ -1399,6 +1399,11 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
>>>>>  		if (ret == -EAGAIN)
>>>>>  			return ret;
>>>>>  
>>>>> +		/* Avoid canceling current request, as it has not been started */
>>>>> +		if (req->trb)
>>>>> +			memset(req->trb, 0, sizeof(struct dwc3_trb));
>>>>
>>>> we don't need a full memset. I think ensuring HWO bit is zero is enough.
>>>>
>>> Hi Felipe,
>>>
>>> Thanks for the input/review, will make this change to just clear the HWO.
>>>
>>
>> Make sure to increment the dequeue pointer also. I think you can use
>> dwc3_gadget_ep_skip_trbs().
>>
> 
> Nevermind. There maybe a problem with using dwc3_gadget_ep_skip_trbs().
> 
> Thinh
> 
Hi Thinh,

Thank you for your input.  In this case (if kick transfer fails w/ an
error), would we still need to mess with the enqueue/dequeue pointers?
Not sure if my assumption is correct, but the TRB wouldn't have been
started, so we can use the same (failed) TRB for future requests, right?

I think one thing I will need to update is to loop through num_trbs and
clear all HWO bits if the above is not needed.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

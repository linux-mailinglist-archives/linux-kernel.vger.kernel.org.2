Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922773F492B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhHWLAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:00:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14228 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhHWLAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:00:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629716376; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MJCv4YecPSOTSMkjIN24O75yrgZxZR9C54D+qxlobsE=; b=CGJ/ZUTJXMq3Vd7UQnODB4xbbB4kKoFl+TGxpwM8YBXJskKPD4DHU5lkCpqaAkbVrKoN+zho
 1/gP123lktag4Luy6SQIhUdHQQp5j27iusrRBIPEFbhMISYIb5Fv+hNS0jn0sRpPPXLOyjVK
 XeQiRSVEsRIg4C4Kuz0t8ALFrq0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61237f9589fbdf3ffec135a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 10:59:33
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94210C4338F; Mon, 23 Aug 2021 10:59:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.9] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA675C43460;
        Mon, 23 Aug 2021 10:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BA675C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Stop EP0 transfers during pullup
 disable
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <20210823092324.1949-1-wcheng@codeaurora.org>
 <87eeakld0d.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <9e11d0dc-c043-6b55-2c33-fb1a55b18156@codeaurora.org>
Date:   Mon, 23 Aug 2021 03:59:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87eeakld0d.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 8/23/2021 2:34 AM, Felipe Balbi wrote:
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
>> During a USB cable disconnect, or soft disconnect scenario, a pending
>> SETUP transaction may not be completed, leading to the following
>> error:
>>
>>     dwc3 a600000.dwc3: timed out waiting for SETUP phase
>>
>> If this occurs, then the entire pullup disable routine is skipped and
>> proper cleanup and halting of the controller does not complete.
> 
> nit: might want to add a blank line between paragraphs to aid
> readability
> 
>> Instead of returning an error (which is ignored from the UDC
>> perspective), allow the pullup disable to routine to continue, which
>                                          ^^
>                                          remove this?
> 
>> will also handle disabling of EP0/1.  This will end any active
>> transfers as well.  Ensure to clear any delayed_status as well, as the
>> timeout could happen within the STATUS stage.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>> Changes in v2:
>>  - Removed calls to dwc3_ep0_end_control_data() and just allow the ep disables
>>    on EP0 handle the proper ending of transfers.
>>  - Ensure that delayed_status is cleared, as ran into enumeration issues if the
>>    SETUP transaction fails on a STATUS stage.  Saw delayed_status == TRUE on the
>>    next connect, which blocked further SETUP transactions to be handled.
>>
>>  drivers/usb/dwc3/gadget.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 5d084542718d..8b6a95c35741 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2430,7 +2430,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>  		if (ret == 0) {
>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>> -			return -ETIMEDOUT;
>>  		}
> 
> Since the `if' now has a single statement, you should remove the curly braces.
> 
Thanks for the reviews!  Will fix them up and resend.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

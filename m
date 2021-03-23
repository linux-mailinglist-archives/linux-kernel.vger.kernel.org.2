Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA67345811
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCWG6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:58:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52828 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhCWG5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:57:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616482661; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QnUCgCrhL886f7t95cngGpyvXjpcNMxnX81E/1wAPZ0=; b=Ck/xba8UfqFgAWh3qhAhcoj1KQ3/B10jFzibNRqwEaEVhS/q904BUT1pUtpBBYOJWai8uhDW
 MxpIHADvGoCPWOrQHHD8haxmF+V2MCHAZ7vUwQV0q/ggFilNX50lECl8Hotb0zrSRcDrqJkg
 PwvcmYU1vo9xYhbzljwAu5c11YA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 605991606dc1045b7d64bdfa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 06:57:36
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 758C1C433ED; Tue, 23 Mar 2021 06:57:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.91.149] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E16CC433CA;
        Tue, 23 Mar 2021 06:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E16CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: gadget: Stall OS descriptor request for unsupported
 functions
To:     Jack Pham <jackp@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
References: <1616464217-2650-1-git-send-email-wcheng@codeaurora.org>
 <20210323062542.GA17922@jackp-linux.qualcomm.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <297cf185-70d6-5018-08ab-e069dc84d8e0@codeaurora.org>
Date:   Mon, 22 Mar 2021 23:57:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323062542.GA17922@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2021 11:25 PM, Jack Pham wrote:
> Hi Wesley,
> 
> On Mon, Mar 22, 2021 at 06:50:17PM -0700, Wesley Cheng wrote:
>> From: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
>>
>> Hosts which request "OS descriptors" from gadgets do so during
>> the enumeration phase and before the configuration is set with
>> SET_CONFIGURATION. Composite driver supports OS descriptor
>> handling in composite_setup function. This requires to pass
>> signature field, vendor code, compatibleID and subCompatibleID
>> from user space.
>>
>> For USB compositions that contain functions which don't implement os
>> descriptors, Windows is sending vendor specific requests for os
>> descriptors and composite driver handling this request with invalid
>> data. With this invalid info host resetting the bus and never
>> selecting the configuration and leading enumeration issue.
>>
>> Fix this by bailing out from the OS descriptor setup request
>> handling if the functions does not have OS descriptors compatibleID.
>>
>> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/gadget/composite.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index 72a9797..473edda6 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -1945,6 +1945,12 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>>  				buf[6] = w_index;
>>  				/* Number of ext compat interfaces */
>>  				count = count_ext_compat(os_desc_cfg);
>> +				/*
>> +				 * Bailout if device does not
>> +				 * have ext_compat interfaces.
>> +				 */
>> +				if (count == 0)
>> +					break;
>>  				buf[8] = count;
>>  				count *= 24; /* 24 B/ext compat desc */
>>  				count += 16; /* header */
> 
> Do we still need this fix? IIRC we had this change in our downstream
> kernel to fix the case when dynamically re-configuring ConfigFS, i.e.
> changing the composition of functions wherein none of the interfaces
> support OS Descriptors, so this causes count_ext_compat() to return
> 0 and results in the issue described in $SUBJECT.
> 
Hi Jack,

You're correct.  We can address this as well in the userspace perspective.

> But I think this is more of a problem of an improperly configured
> ConfigFS gadget. If userspace instead removes the config from the
> gadget's os_desc subdirectory that should cause cdev->os_desc_config to
> be set to NULL and hence composite_setup() should never enter this
> handling at all, right?

Sure, I'll go with fixing it in the userspace, since the support to
stall the OS desc is already present in the composite driver as you
mentioned.  Thanks for the input.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902AF3B9D41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhGBIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:03:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24865 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhGBIDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:03:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625212870; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fm1B5BNET6BDsQrPVz8M3jEbJSGGPTas8DsTraQQ0io=; b=r4wd6JrAZ1Af0/mhnn0pbAz6GqqoAfDROgMlojOVUl13YyYKZvI90vhk/lcE263DswHW7wks
 6zryKCDISXdTIFU4HabBfsFaMnMJcl/Loe8tmWKCaoMaYqddKZlJwt/0DuPZyLt9IrxlP0Pk
 eKMXp8e3B7KP4xbJ2rbCWI7f7yI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60dec79d7b2963a282197f39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Jul 2021 08:00:29
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D310BC43460; Fri,  2 Jul 2021 08:00:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.67.21] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F78FC433F1;
        Fri,  2 Jul 2021 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F78FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v11 1/5] usb: gadget: udc: core: Introduce check_config to
 verify USB configuration
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jackp@codeaurora.org,
        fntoth@gmail.com
References: <1625043642-29822-1-git-send-email-wcheng@codeaurora.org>
 <1625043642-29822-2-git-send-email-wcheng@codeaurora.org>
 <YN6dY8RBXRN4BW3n@kroah.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <95224646-6dd7-874e-517c-b106b474e487@codeaurora.org>
Date:   Fri, 2 Jul 2021 01:00:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN6dY8RBXRN4BW3n@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2021 10:00 PM, Greg KH wrote:
> On Wed, Jun 30, 2021 at 02:00:38AM -0700, Wesley Cheng wrote:
>> Some UDCs may have constraints on how many high bandwidth endpoints it can
>> support in a certain configuration.  This API allows for the composite
>> driver to pass down the total number of endpoints to the UDC so it can verify
>> it has the required resources to support the configuration.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/gadget/udc/core.c | 25 +++++++++++++++++++++++++
>>  include/linux/usb/gadget.h    |  4 ++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index b7f0b1e..f1f44a6 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1003,6 +1003,31 @@ int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
>>  }
>>  EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
>>  
>> +/**
>> + * usb_gadget_check_config - checks if the UDC can support the number of eps

Hi Greg,

Thanks for the feedback.
> 
> "eps"?  What is that?
>

Fixed to "endpoints"

>> + * @gadget: controller to check the USB configuration
>> + * @ep_map: bitmap of endpoints being requested by a USB configuration
> 
> There is no such option in this function, did you run 'make htmldocs'
> and see that this adds a warning?
> 
Removed the ep_map comment, as we've removed it from the arguments.

>> + *
>> + * Ensure that a UDC is able to support the number of endpoints within a USB
>> + * configuration, and that there are no resource limitations to support all
>> + * requested eps.
>> + *
>> + * Returns zero on success, else a negative errno.
>> + */
>> +int usb_gadget_check_config(struct usb_gadget *gadget)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!gadget->ops->check_config)
>> +		goto out;
>> +
>> +	ret = gadget->ops->check_config(gadget);
>> +
>> +out:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_check_config);
> 
> This can be written in the much simpler form:
> {
> 	if (gadget->ops->check_config)
> 		return gadget->ops->check_config(gadget);
> 	return 0;
> }
>
thanks for this suggestion.

> But where are the endpoints that need to be checked???
> 
> How is this working?
> 
The USB gadget will have ep_list, do we'll be looping through the
endpoints that have been claimed to get the number of IN eps being used
by a particular configuration.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

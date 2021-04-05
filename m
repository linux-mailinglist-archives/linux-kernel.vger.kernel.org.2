Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1225A3541F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhDEMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhDEMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:07:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899BC061756;
        Mon,  5 Apr 2021 05:06:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hq27so16453276ejc.9;
        Mon, 05 Apr 2021 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rSfRvLWrKrxqOWFWFbi1dZLa9tAVnjrn923CZO/U4g=;
        b=Ma/2dT10LaCxunfVJKFCuXhGAXK8K97CAw0pfQ1qHNkE4Ul9XOGU3qS+cKtNWFWOCv
         s7wmsUZXtu0U73/t1YOdIVJKMh890U2UQOckB8H6GsfeC/lIX525nESn4F/tu25R2DU5
         XJ+RTS6iKZOwj6wHFfKDQ88+qjACpwYjvGxTWNjDep2MrnNZrVrf5EZ6TpYk1SUIuFJv
         USQI+ad3RLfBQV4edo/hSV2qHzP+5DlY4FJxZv2cMrqBHWZy+q9I5sGCVnsjPdWo1kpT
         Rb50TsVdQPJsQ2E7UpCURBJHUqQ0cbAHRGAbXgkQCJU9c4V4ePmkOf2MXCxOpgxxdaJo
         4rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rSfRvLWrKrxqOWFWFbi1dZLa9tAVnjrn923CZO/U4g=;
        b=lq0wCyLwADkOdCJz4Q9iup9exl4gikQIF2lobDtFJsWPas8X9LjJsKSdt7J2at/iCo
         n1Y8+0Qd1fEhPTA7oEE8Z+bANiJaT4EoLQPda2jrBQ1N3cKDrJs9bBtYbDEpFKvzWKha
         wXi069ui9BGBEcmKWeV7SAJt8H7q6lHQcoYpCwva6Zi/vAYycSM9iMzfjgf7o0pyq0Kl
         RTCTuOksEgkk4EBz6qVZ7lXp297ObC+/c6EvK+twJdbmX9vKm/LPCAfS8JihpNzTSew/
         k8oxDp/YadZQyq8Q0ZTO3xzlLtEO6jhblEYxoWZL9LkNZ99Ms9+hj3QvvJH3WcXIcIn2
         PNgA==
X-Gm-Message-State: AOAM532dAujeyBTOeNcPgxV0SQ0HQSVXFxYUmAqZBHqjmo4LoOpU/fv6
        ztr8JFHN3LMDvNWeOZZkSH/LUMqZLpnFGA==
X-Google-Smtp-Source: ABdhPJyHCrBP9yUQFBO7FgOBG7YXEFb6sEQFEXhIIiXi/+6S+EKx9/fBFD7RGOaVQLDPa6CdqSG2sg==
X-Received: by 2002:a17:906:2704:: with SMTP id z4mr10264061ejc.137.1617624372271;
        Mon, 05 Apr 2021 05:06:12 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d19sm10914090edr.45.2021.04.05.05.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 05:06:11 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] usb: dwc3: of-simple: bail probe if no dwc3 child
 node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heiko@sntech.de, robh+dt@kernel.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20210401213652.14676-1-jbx6244@gmail.com>
 <20210401213652.14676-2-jbx6244@gmail.com> <YGq2IaygRQaAcLli@kroah.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <abd513bc-dee9-d87b-6841-338bfb2f30d0@gmail.com>
Date:   Mon, 5 Apr 2021 14:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <YGq2IaygRQaAcLli@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 9:02 AM, Greg KH wrote:
> On Thu, Apr 01, 2021 at 11:36:49PM +0200, Johan Jonker wrote:
>> For some of the dwc3-of-simple compatible SoCs we
>> don't want to bind this driver to a dwc3 node,
>> but bind that node to the 'snps,dwc3' driver instead.
>> The kernel has no logic to decide which driver to bind
>> to if there are 2 matching drivers, so bail probe if no
>> dwc3 child node.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>> index 71fd620c5..8d3baa5df 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>  
>>  	int			ret;
>>  
>> +	/* Bail probe if no dwc3 child node. */
>> +	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
>> +		return -ENODEV;
> 

> Why is this part of the "convert to yaml" patch series?  Shouldn't this
> be a separate, independant patch?
independent


Hi Greg,

As pointed out by Rob in the v3 review process the YAML conversion has
some side effects for new dt files. A good habit is to fix things before
they become in effect. That's why this patch is placed before the dtsi
changes and why Heiko asked to have a look at it.

For the sake of completeness there are other less optimal options:
- remove rk3399 support from dwc3-of-simple.c
- unselect CONFIG_USB_DWC3_OF_SIMPLE for new rk3399 device trees

In that case at least have it on record why USB maintainers didn't apply
it in case someone else start to complain about it later when Heiko goes
ahead with it.

Johan Jonker

> 
> thanks,
> 
> greg k-h
> 


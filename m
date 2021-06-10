Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE823A28AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhFJJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhFJJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623318547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzmQyMB3ihhoFyRGhb0qD+kcZURr7tTGlAKYMfHT6ds=;
        b=RAP7ifSrDTHsD0rFcZ6wAHEpo0f8vAUMfkUuyxTF3SmxFtMpUX56gOpd4RSYRbDu+xgGDZ
        vy9YFW2jG2BwOpilYPvik9Aua1xcrSL2/eKDTVCGCsm7Vo7HPNq2i1W1J/3+bo0LBV6EnG
        nphHbn2xstsz5L675WrXwzQmcixgyfs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-X_oUYv_4Pp2uxOrmusYieg-1; Thu, 10 Jun 2021 05:49:06 -0400
X-MC-Unique: X_oUYv_4Pp2uxOrmusYieg-1
Received: by mail-ed1-f71.google.com with SMTP id x12-20020a05640226ccb0290393aaa6e811so4091899edd.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TzmQyMB3ihhoFyRGhb0qD+kcZURr7tTGlAKYMfHT6ds=;
        b=drFBos1ys7TvxL/loDAVWvTHKvc/+02z/TMQTfWMEjNb8o8rcurgXqkdnmqmEU4TeP
         APoGN8fe6I4iN5JYEF6BNFAmJ1uPQ7ecQsqPTAUohj738SRoNqiUbSkghJvFivKYfjWC
         GzkKbV/H4gMzDpQnabmtjGblrroMK4ZltFpWqYG9oYpYxJtWiciw/UEB5zDxGhhg2Zfg
         onGc+18WtI2U8VE0d0cwExyclXpN3CMELWeUYyFq91uNN2P980nHC+q24I7FAAAV5gWr
         ZPFW0jcD5Uhlb52Gh5JIEjovqtnCVatwgtgfbTozp6DhWWV9IVm/XIkx3k0KZAM4ESG1
         q35w==
X-Gm-Message-State: AOAM532bsKXRrE7M0fyfffDaJV0/72MD0zNNAQXNlXhAF7MXQLZFRNP0
        2lm2cKkKWFkIIM3h9TeRtXT15LnBTKNo8VOfTBSTOM6XNxU29g79Uem8cqr7K9uFWPr3GEmSCCA
        dHuCKEhRaW9R237cUZIfSKDKrWkKRpwY/0ZpnklFctMw0JbQ2sWefksxcqoelZuulqfu7kw63J6
        QS
X-Received: by 2002:a05:6402:188:: with SMTP id r8mr3762815edv.75.1623318544607;
        Thu, 10 Jun 2021 02:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5WFmaCEP1KGSJCdzkwyIGb9MzRF5D9kUhTmpgRRMO2eBu8iJOcUzIxMoWndVrQzdsDoQPkQ==
X-Received: by 2002:a05:6402:188:: with SMTP id r8mr3762792edv.75.1623318544403;
        Thu, 10 Jun 2021 02:49:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n11sm828862ejg.43.2021.06.10.02.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:49:04 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
 <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
 <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
 <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2d32dbab-7972-d064-6b5f-0789872db834@redhat.com>
Date:   Thu, 10 Jun 2021 11:49:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/21 11:43 AM, Chanwoo Choi wrote:
> On 6/8/21 7:10 PM, Matti Vaittinen wrote:
>> The extcon IRQ schedules a work item. IRQ is requested using devm while
>> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
>> potential case where the WQ has been emptied (.remove() was ran) but
>> devm unwinding of IRQ was not yet done. It may be possible the IRQ is
>> triggered at this point scheduling new work item to the already flushed
>> queue.
>>
>> According to the input documentation the input device allocated by
>> devm_input_allocate_device() does not need to be explicitly unregistered.
>> Use the new devm_work_autocancel() and remove the remove() to simplify the
>> code.
>>
>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>
>> Please note that the change is compile-tested only. All proper testing is
>> highly appreciated.
>> ---
>>  drivers/extcon/extcon-max77693.c | 17 +++++------------
>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
>> index 92af97e00828..1f1d9ab0c5c7 100644
>> --- a/drivers/extcon/extcon-max77693.c
>> +++ b/drivers/extcon/extcon-max77693.c
>> @@ -5,6 +5,7 @@
>>  // Copyright (C) 2012 Samsung Electrnoics
>>  // Chanwoo Choi <cw00.choi@samsung.com>
>>  
>> +#include <linux/devm-helpers.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/i2c.h>
>> @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, info);
>>  	mutex_init(&info->mutex);
>>  
>> -	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
>> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
>> +				   max77693_muic_irq_work);
>> +	if (ret)
>> +		return ret;
>>  
>>  	/* Support irq domain for MAX77693 MUIC device */
>>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
>> @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct platform_device *pdev)
>>  	return ret;
>>  }
>>  
>> -static int max77693_muic_remove(struct platform_device *pdev)
>> -{
>> -	struct max77693_muic_info *info = platform_get_drvdata(pdev);
>> -
>> -	cancel_work_sync(&info->irq_work);
>> -	input_unregister_device(info->dock);
> 
> I think that you have to keep the input_unregister_device().

As mentioned in the commit message, in input_unregister_device
is not necessary for input-devices created with
devm_input_allocate_device():

"According to the input documentation the input device allocated by
devm_input_allocate_device() does not need to be explicitly unregistered."

I have verified that the documentation is correct here, so there is
no need to keep the input_unregister_device() as it was never necessary
to have that there.

Regards,

Hans



> 
>> -
>> -	return 0;
>> -}
>> -
>>  static struct platform_driver max77693_muic_driver = {
>>  	.driver		= {
>>  		.name	= DEV_NAME,
>>  	},
>>  	.probe		= max77693_muic_probe,
>> -	.remove		= max77693_muic_remove,
>>  };
>>  
>>  module_platform_driver(max77693_muic_driver);
>>
> 


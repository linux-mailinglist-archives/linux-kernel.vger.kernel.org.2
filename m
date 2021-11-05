Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56926445E23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKEC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhKEC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:58:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD0C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 19:56:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v20so10219020plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sldp+dEA/S3fed/PPXTlW+EzxdJTFfKjqSSoeZHFt94=;
        b=WNWCD5Wz6aytXpg2bn/p5/52YbT3FeflDludwI2sImT4WEN4YrvdlTFCp7i/e4mX9y
         pRNCYGqROvhhYio/q11i42l86JotYT4o8hM5QKbxtFqHtQLIJi1VRG+kaIgwrP4lzo2s
         ccu0LN4+NWKFr2+8x28tYLDEqjpOYJU3HoiqK79bki4Ifk+UYm2IIU83/MtW4V11Pay8
         Ib9BG5JUGpMM0305IvRIPgrvm2RZlI+Z9hIDEgUItjWizybR8K5pdyT4ZGbh//gW2t0g
         cRAzDfjDUE8FW/55cw4cy/Eh4D4efDYd4SZm9+ylBQ6GbHks73ylnxsJsBoZbmaVBYre
         wOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sldp+dEA/S3fed/PPXTlW+EzxdJTFfKjqSSoeZHFt94=;
        b=N9E1/iGLw2RNdqyvrLTnY1Ts27FGlt8I02Rnrxtz7U4a7xKBAxlsZAeCV46pAQDo3e
         JU0UYJNaQxXC/m+o5fLzpOk5ksz/8cuUGXklvhFXwFihjB/UJQCQ5Yy1na0NlCx/Vog6
         bA+6AisN9r/MOKcpRzYhiRzO1VbmqYC0/ir1p4MkTUb0hpgS57y0tNRdjMDybcXTnR75
         IxyKHvJ0YPrx7FljF6pH/7B7r4n5vkbGIsjgQrF4NC2uFLtzB3+LBxuVe3Hidt98Ceji
         Rk03aKLPoP3XowW4woINd9gHDU31iSK1ekfmALWzPdhbhRPCVMsCDkKzpkOE/L25ssMu
         R9AA==
X-Gm-Message-State: AOAM531EO4Etoq+wvxTuEtMF6hdUOSlrT7khxcYoRUtoDqVEj7HSi8HU
        QRoDCcytcv0JZJgRm+xXCs/5+lqJDxg=
X-Google-Smtp-Source: ABdhPJypwO55FF48mMTgLOXlgYlvP3+fyv+itreGkJB2dinAEKGEXapmrwQnC2nrvR6hL6ObL0Ujiw==
X-Received: by 2002:a17:90a:e7c4:: with SMTP id kb4mr27289226pjb.237.1636080975251;
        Thu, 04 Nov 2021 19:56:15 -0700 (PDT)
Received: from [10.230.2.240] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id h20sm6347511pfh.175.2021.11.04.19.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 19:56:14 -0700 (PDT)
Message-ID: <9318932a-9b00-62be-eeb9-ca755a05c841@gmail.com>
Date:   Thu, 4 Nov 2021 19:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] bus: brcmstb_gisb: Allow building as module
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210924191035.1032106-1-f.fainelli@gmail.com>
 <20211105025155.GA2922689@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211105025155.GA2922689@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2021 7:51 PM, Guenter Roeck wrote:
> On Fri, Sep 24, 2021 at 12:10:34PM -0700, Florian Fainelli wrote:
>> Allow building the Broadcom STB GISB arbiter driver as a module, however
>> similar to interrupt controller drivers, don't allow its unbind/removal
>> since it is not quite prepared for that and we want it to catch bus
>> errors all the time.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Hmm, did you actually test that ?

Great way to introduce someone to a problem, really.

> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> ERROR: modpost: "board_be_handler" [drivers/bus/brcmstb_gisb.ko] undefined!

I did not indeed test a modular build for MIPS and had not anticipated 
it to fail. Thomas, do you have any objections exporting 
board_be_handler to modules or would you rather not do it and force the 
driver to be boolean for MIPS?

> 
> Guenter
> 
>>   drivers/bus/Kconfig        | 2 +-
>>   drivers/bus/brcmstb_gisb.c | 7 ++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index a5b96f3aad67..9cfeae3fc244 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -30,7 +30,7 @@ config ARM_INTEGRATOR_LM
>>   	  found on the ARM Integrator AP (Application Platform)
>>   
>>   config BRCMSTB_GISB_ARB
>> -	bool "Broadcom STB GISB bus arbiter"
>> +	tristate "Broadcom STB GISB bus arbiter"
>>   	depends on ARM || ARM64 || MIPS
>>   	default ARCH_BRCMSTB || BMIPS_GENERIC
>>   	help
>> diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
>> index 6551286a60cc..4c2f7d61cb9b 100644
>> --- a/drivers/bus/brcmstb_gisb.c
>> +++ b/drivers/bus/brcmstb_gisb.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (C) 2014-2017 Broadcom
>> + * Copyright (C) 2014-2021 Broadcom
>>    */
>>   
>>   #include <linux/init.h>
>> @@ -536,6 +536,7 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
>>   		.name	= "brcm-gisb-arb",
>>   		.of_match_table = brcmstb_gisb_arb_of_match,
>>   		.pm	= &brcmstb_gisb_arb_pm_ops,
>> +		.suppress_bind_attrs = true,
>>   	},
>>   };
>>   
>> @@ -546,3 +547,7 @@ static int __init brcm_gisb_driver_init(void)
>>   }
>>   
>>   module_init(brcm_gisb_driver_init);
>> +
>> +MODULE_AUTHOR("Broadcom");
>> +MODULE_DESCRIPTION("Broadcom STB GISB arbiter driver");
>> +MODULE_LICENSE("GPL v2");

-- 
Florian

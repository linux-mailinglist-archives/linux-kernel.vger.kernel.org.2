Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA45F399F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFCLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhFCLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622718363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRhiOoZe1mTEXihan/H9F13k5t1L9W/jbplk2JNgig4=;
        b=FmXNuODqC3Kxp0doNzZja32G9sRvxL8DhCQWiS96Llp6BP+VQVUPJf3DuktbTc0hhC3lMy
        Lsfp9hqn50/nerjfpvSFZaVhw95BzlfakRTZoArbk5FijQ49n9UDpU+oIg9LWuIOh+HTTH
        CGAnwvHKKOlaQDJtU0KZjzhW8NXvFaw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-rlK5uRZuMxeRlaalgXfpew-1; Thu, 03 Jun 2021 07:06:02 -0400
X-MC-Unique: rlK5uRZuMxeRlaalgXfpew-1
Received: by mail-ej1-f70.google.com with SMTP id z1-20020a1709068141b02903cd421d7803so1803370ejw.22
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRhiOoZe1mTEXihan/H9F13k5t1L9W/jbplk2JNgig4=;
        b=oVMnnBKG9IE0YH/0WKULI/zTxzB6hc3yBwW0+mrlY1/TiNuS6wEY9q7m0vezyoF9nT
         /1h5DikPFhmQTqWq39R3nSt8PS4+nmmuuP9UtxcvSZvIN3hIfJ27I/d1wZr65dRJ02bk
         NFv5xYO0/3IoFY6QhucwQz4SQrxU+Ny1WvAC0MqNaz0ZMw0AeA2HU9M3H3ApiViYaLCG
         A9BxobhX3ItbwwutlLnV1mR5M2gu85709wSPXPxMUl6zZnpglZ0mQtaFLJDPf6jqePSR
         u2jZogrHbGBBPZYUZ8xKAJyxhr4dRjsYDBTRULwV6VZbb58WMUAlFl+5HzZzqcsQpwML
         iJBA==
X-Gm-Message-State: AOAM531HKlG1HUrYQTcQhd+wC0yncc4qywJLfdI4BfFtXPBFcyFMKIMy
        EcZf9w4K2whCtGKYCoCQq7+gEJm0xctyQogZpcQ2EEARtFmo13lotHC89/8WW07lKmbbX0SKbdT
        GMv8rhvX5mKNVc/bJ2O8jjLPu3vQ0jlJvOZJtru+WYHY47ki4xeVOg6SHX4JQCdVwzzrOm+pqXO
        BS
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr43784608eds.163.1622718361021;
        Thu, 03 Jun 2021 04:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHUn+3A7/1pTM/kN+87ikBefLFwqocZZGD74h0oNyoZ+eWqf4gmNGMHHT7DQLZTza+eAJ7ZQ==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr43784589eds.163.1622718360827;
        Thu, 03 Jun 2021 04:06:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r1sm1557815edp.90.2021.06.03.04.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 04:06:00 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: toshiba_acpi: Fix missing error code in
 toshiba_acpi_setup_keyboard()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        coproscefalo@gmail.com
Cc:     mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1622628348-87035-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3921079d-92cf-a057-0404-231280f2c092@redhat.com>
Date:   Thu, 3 Jun 2021 13:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1622628348-87035-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/2/21 12:05 PM, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'error'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/platform/x86/toshiba_acpi.c:2834 toshiba_acpi_setup_keyboard()
> warn: missing error code 'error'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/toshiba_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index fa7232a..352508d 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2831,6 +2831,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
>  
>  	if (!dev->info_supported && !dev->system_event_supported) {
>  		pr_warn("No hotkey query interface found\n");
> +		error = -EINVAL;
>  		goto err_remove_filter;
>  	}
>  
> 


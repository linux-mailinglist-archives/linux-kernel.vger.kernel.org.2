Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD23161B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBJJBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhBJIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612947182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbWilXPmhjifHrII7qdPfl8oFAeHMhd/LQtQOsMv3Eo=;
        b=XOib9jgypu1hG3PK1/4MqHg1uECZnztUEOTGuY5aEDHnIa3W7YK4nhEzFaR9DojabyVjVK
        2ifi27+KrsUWSBz1AUKM1ZLI0mJn2zmgot5EQgKsjBr16xRCANaJgXe6L5Hxq4DhuyP6GZ
        382Rc89DGZhdk+lGdrCddsQJ9+37ZNs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-o6vvhWNjNlm-24qsCP84Ng-1; Wed, 10 Feb 2021 03:53:00 -0500
X-MC-Unique: o6vvhWNjNlm-24qsCP84Ng-1
Received: by mail-ej1-f69.google.com with SMTP id yd11so1966285ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbWilXPmhjifHrII7qdPfl8oFAeHMhd/LQtQOsMv3Eo=;
        b=FTlJxEExje7f14+4WAG7IFb/LGjqXlU/Ie3VHof/Z8/cdqZFoCUaudapQg/H6MktAP
         tTLPn4RTC+EBW2y4ka+wxhknodxusp05ST5D1nuoG8wcRbj16oA6tuaePu7EKjPVTaP+
         WyMBNJhq3D/NW4mEmCGwQaRe8U01hL2d539wgoWHsG1lqm45yf52Uqf9JNvuf8tro9yB
         nTAG2lArGqXgv/aBfOBFZCWtQfNoB6F4g/IPSXHkm/F0Gq1Ra+n+3A05cRMXtZF6FbBj
         5uPh8AfbrklGW3fW/e8LDV/H4DY2tEp04trhfVPrw/Z0ZkjNpmXcOK4asKGE0bTuqOj2
         tZkA==
X-Gm-Message-State: AOAM531kKGzTRuhkr/4ebU4tGCEPHxVxeK/OtxMx1Ad+mP1potdmcQzG
        i7xZuxvx2TFX1Co572Hx4VAeteSCmntYxQ+PiFra5fqgaC8qtVPDj3pDtSX9RNMRYshYmR7jnSq
        S5fQ4xILEg1Ww8Tf09eg+7cb6d0OjsDv3z7iWiE0cDv5zj4Kdno9NkcXaawLIhyrHLZK+6wd+KQ
        HY
X-Received: by 2002:a17:906:f2cd:: with SMTP id gz13mr1935449ejb.83.1612947179141;
        Wed, 10 Feb 2021 00:52:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8SBuC2F4Xj7VAkMbqdL+su/Z8wad5yGl2uSiRycmqXw2K2IIxk6tQJI3KBJuEyXtUjul2aA==
X-Received: by 2002:a17:906:f2cd:: with SMTP id gz13mr1935434ejb.83.1612947178962;
        Wed, 10 Feb 2021 00:52:58 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f13sm667102ejf.42.2021.02.10.00.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 00:52:58 -0800 (PST)
Subject: Re: [PATCH -next] mfd: arizona: Make some symbols static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20210210075626.1096193-1-weiyongjun1@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c5d3a077-62ff-a5b5-d57e-e6a1858ea9db@redhat.com>
Date:   Wed, 10 Feb 2021 09:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210075626.1096193-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/10/21 8:56 AM, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/mfd/arizona-spi.c:28:31: warning:
>  symbol 'reset_gpios' was not declared. Should it be static?
> drivers/mfd/arizona-spi.c:29:31: warning:
>  symbol 'ldoena_gpios' was not declared. Should it be static?
> 
> Those symbols are not used outside of arizona-spi.c, so this
> commit marks them static.
> 
> Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you for catching this.

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/mfd/arizona-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 24a2c75d691a..aa1d6f94ae53 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -25,8 +25,8 @@
>  #include "arizona.h"
>  
>  #ifdef CONFIG_ACPI
> -const struct acpi_gpio_params reset_gpios = { 1, 0, false };
> -const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
> +static const struct acpi_gpio_params reset_gpios = { 1, 0, false };
> +static const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
>  
>  static const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
>  	{ "reset-gpios", &reset_gpios, 1, },
> 


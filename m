Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641F642B9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhJMH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238811AbhJMH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634111777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYCx6QA03aEfkBFxuhO6FE77UExJaIFiU4NvMPhxTrk=;
        b=PlEipi6HpjfTH+bi3RL+YJ4gNJrrx45oOby4O+siXeDBT6ncrpE5lNll7mYaCL2wc+mPNo
        FCT9LcgCR637cusLaQ3064HS8gaR09ksGC1NBrzPbsU/yh2WRGAPiMUtTtZx3dnb2T+OuK
        +XQV0p428hTGsC/gVriR1ehgH8kbZME=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-OkTmQH7xNpGPrO7IWO3p1Q-1; Wed, 13 Oct 2021 03:56:16 -0400
X-MC-Unique: OkTmQH7xNpGPrO7IWO3p1Q-1
Received: by mail-ed1-f72.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so1480641edv.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iYCx6QA03aEfkBFxuhO6FE77UExJaIFiU4NvMPhxTrk=;
        b=LcW8jklb+PWmnf3LO6AOSRAuEWkLyrmj6O0iSGT53wnMDC7qYGZT2/ZGf4pDGNPQ0m
         AYm14HVZG2KKCj+64rfmiKrAQkSpVtCNdwkEHYbt8aaUH8A71MaKRtJ9bA60hLI3BFVo
         O0NIawiD45to9Vt8O/VETTivX1CdrDHj6SpvoEFf5nZiPFY99iESVVFEEH285EtuVzp2
         AdAtvqKjvIXiN8rYETJL36vifFMjyHu+Fk6L+b5JqA5XWkLEAcjqizg34AT3/doBwEyG
         HVXM8wdIJOBbGE/bGtNMkkt9iIrVp/WO5vtHQRwpX9Ymj5VOUt0AjaqPXVAMwiN9R0R4
         t52A==
X-Gm-Message-State: AOAM530DqHIn2bb6uvHIc7wWY9PFbxdnGB+eerSu7hLIAGwiLLwcrTrd
        0NLOm/J5xbzK3wlKHCgWDaTQ7/fAhlShkgORhPgpwWDOiEEgJJxgCf16GZPgP+KliTR27WBEZMA
        MExCrbZGlRbu54Z0KQ/k/e3LG0DzB6RtELdqAy7xbKppss5swPWjvSqUb17sS2TlQreCZypwAmU
        cd
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr8588484ejw.236.1634111774442;
        Wed, 13 Oct 2021 00:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Xl6LIWOme9HIaIrTzGrLU+Kom/tJW5QrUAH3bcc0NiuoM/wm2WjlaCKxRAVx2KODUt1GWA==
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr8588453ejw.236.1634111774084;
        Wed, 13 Oct 2021 00:56:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m9sm7475858edl.66.2021.10.13.00.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 00:56:13 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci_platform: fix null-ptr-deref in
 ahci_platform_enable_regulators()
To:     Wang Hai <wanghai38@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211013061631.2958938-1-wanghai38@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e5beb06d-7f75-b123-a14b-7a2f447e8eb5@redhat.com>
Date:   Wed, 13 Oct 2021 09:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013061631.2958938-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/21 8:16 AM, Wang Hai wrote:
> I got a null-ptr-deref report:
> 
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> ...
> RIP: 0010:regulator_enable+0x84/0x260
> ...
> Call Trace:
>  ahci_platform_enable_regulators+0xae/0x320
>  ahci_platform_enable_resources+0x1a/0x120
>  ahci_probe+0x4f/0x1b9
>  platform_probe+0x10b/0x280
> ...
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> If devm_regulator_get() in ahci_platform_get_resources() fails,
> hpriv->phy_regulator will point to NULL, when enabling or disabling it,
> null-ptr-deref will occur.
> 
> ahci_probe()
> 	ahci_platform_get_resources()
> 		devm_regulator_get(, "phy") // failed, let phy_regulator = NULL
> 	ahci_platform_enable_resources()
> 		ahci_platform_enable_regulators()
> 			regulator_enable(hpriv->phy_regulator) // null-ptr-deref
> 
> commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional()
> misuse") replaces devm_regulator_get_optional() with devm_regulator_get(),
> but PHY regulator omits to delete "hpriv->phy_regulator = NULL;" like AHCI.
> Delete it like AHCI regulator to fix this bug.
> 
> Fixes: commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional() misuse")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..0910441321f7 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -440,10 +440,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
>  	if (IS_ERR(hpriv->phy_regulator)) {
>  		rc = PTR_ERR(hpriv->phy_regulator);
> -		if (rc == -EPROBE_DEFER)
> -			goto err_out;
> -		rc = 0;
> -		hpriv->phy_regulator = NULL;
> +		goto err_out;
>  	}
>  
>  	if (flags & AHCI_PLATFORM_GET_RESETS) {
> 


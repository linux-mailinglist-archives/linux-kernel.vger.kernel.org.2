Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82885356E72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348348AbhDGOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348250AbhDGOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617805392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVyiDWShbCf6rFt8W3DQDH822FOwiFYHJb1DwH4NLUw=;
        b=FT+bDgHRsjx9VCPEgNh/+93HLnpz8Nbvl3xA3RCrmtC3rP/ppHxsseKD0l39rgdMypkPIP
        y9vj+ypFYCsjbRRMy8Yz5P+5fBHLPGMPKqOzE/gS+Mz7+9sjnIUt/7SA3xGjBYjzScuhBX
        HFavwEjV3wLlOYZrHzBVQV5jG4IKaAE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-X00QCAR5N3uPSUjjwaUQeA-1; Wed, 07 Apr 2021 10:23:10 -0400
X-MC-Unique: X00QCAR5N3uPSUjjwaUQeA-1
Received: by mail-ed1-f71.google.com with SMTP id i19so12257338edy.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVyiDWShbCf6rFt8W3DQDH822FOwiFYHJb1DwH4NLUw=;
        b=EhqIfdTyzG9KJR4FRzKVhsjEP93ua2umEywdUTZJAFReV2EsAAPS5l3VLmx8PWrWOT
         UfbkVy3Zt34tktbxxzEfhB1G2E3hmWuLspiIuN7PZWwMz5kJsL3JwUkCKyUVTwR8AZxT
         nYTu1lsf0J1vO0xA+ZpKHdB8+kqgmkxMIC66v2jkrycJSzTY5FvBPN/bCNe0iCzGGNPw
         1Z9HtYAjhN0rCTkOCLrRdE5C9uyqrUxq/aRrAHVj+Dp8XHJzQYLtdxiDa8McnGlYUnZ8
         44eP4+DPybqz+xvvlgZxkk5iwQu6coPeXTW2tx5gKC97eHs1XgxrZvwLxxC/YjpTx9sY
         bUFA==
X-Gm-Message-State: AOAM531dV9Z9Vxesj4NaNigNqI7DxcafhJjeEb0pLncT3Hal9jN1lZvX
        i3Gq1904hijzZSyCmUT22ikY6wt7uw4+tUVC/vRz6uY1SqTD9SOyk8VGMd7jEw2OC5yFsFJhuwu
        bZP0DsYmZ5IiFRMANVHvfhKHZqXEUJlFDcrR37hmimdUQXwc24reypxPTxHwJXULwlHKkel1tx+
        OU
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr4762635edd.134.1617805389218;
        Wed, 07 Apr 2021 07:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWL4xswvyEz2QVSSs/SoBM6G+ynGMmY/lkQvA5Ma9/Qouqe27s32LovUW7+bp1IDw1dlm6Pw==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr4762609edd.134.1617805388977;
        Wed, 07 Apr 2021 07:23:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f11sm2682995ejh.120.2021.04.07.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:23:08 -0700 (PDT)
Subject: Re: [PATCH 1/9] platform/x86: intel_pmc_core: Don't use global pmcdev
 in quirks
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
 <20210401030558.2301621-2-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e374b74-3587-b5d8-2c5c-a8ab184d8858@redhat.com>
Date:   Wed, 7 Apr 2021 16:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401030558.2301621-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 5:05 AM, David E. Box wrote:
> The DMI callbacks, used for quirks, currently access the PMC by getting
> the address a global pmc_dev struct. Instead, have the callbacks set a
> global quirk specific variable. In probe, after calling dmi_check_system(),
> pass pmc_dev to a function that will handle each quirk if its variable
> condition is met. This allows removing the global pmc_dev later.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/intel_pmc_core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b5888aeb4bcf..260d49dca1ad 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1186,9 +1186,15 @@ static const struct pci_device_id pmc_pci_ids[] = {
>   * the platform BIOS enforces 24Mhz crystal to shutdown
>   * before PMC can assert SLP_S0#.
>   */
> +static bool xtal_ignore;
>  static int quirk_xtal_ignore(const struct dmi_system_id *id)
>  {
> -	struct pmc_dev *pmcdev = &pmc;
> +	xtal_ignore = true;
> +	return 0;
> +}
> +
> +static void pmc_core_xtal_ignore(struct pmc_dev *pmcdev)
> +{
>  	u32 value;
>  
>  	value = pmc_core_reg_read(pmcdev, pmcdev->map->pm_vric1_offset);
> @@ -1197,7 +1203,6 @@ static int quirk_xtal_ignore(const struct dmi_system_id *id)
>  	/* Low Voltage Mode Enable */
>  	value &= ~SPT_PMC_VRIC1_SLPS0LVEN;
>  	pmc_core_reg_write(pmcdev, pmcdev->map->pm_vric1_offset, value);
> -	return 0;
>  }
>  
>  static const struct dmi_system_id pmc_core_dmi_table[]  = {
> @@ -1212,6 +1217,14 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
>  	{}
>  };
>  
> +static void pmc_core_do_dmi_quirks(struct pmc_dev *pmcdev)
> +{
> +	dmi_check_system(pmc_core_dmi_table);
> +
> +	if (xtal_ignore)
> +		pmc_core_xtal_ignore(pmcdev);
> +}
> +
>  static int pmc_core_probe(struct platform_device *pdev)
>  {
>  	static bool device_initialized;
> @@ -1253,7 +1266,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	mutex_init(&pmcdev->lock);
>  	platform_set_drvdata(pdev, pmcdev);
>  	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> -	dmi_check_system(pmc_core_dmi_table);
> +	pmc_core_do_dmi_quirks(pmcdev);
>  
>  	/*
>  	 * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
> 


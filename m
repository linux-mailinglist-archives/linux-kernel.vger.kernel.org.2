Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ECB30CA0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhBBShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238611AbhBBSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612290806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyl4UhLeDGYOAotIfdCQEOAc+/SmCI2MbVX25WRRUF4=;
        b=MRoe0WSs+gnwGtGPWdL/DlOBc6jV1rD0/YQ4xhV8cgazihIg16H0aKCBf8pNUtlAdb/jit
        9ge10qd9SOduPzZSQ9QVBqvhSPgZUqlSC3+hLvcrnN9hPS91/NYVN/8PiUciA21cIkaEpJ
        bPI+aIgxIONN4MwYcyNSyyoybzjplGI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-ZwdFpswhOzW_YSO4Vq3S-g-1; Tue, 02 Feb 2021 13:33:22 -0500
X-MC-Unique: ZwdFpswhOzW_YSO4Vq3S-g-1
Received: by mail-ej1-f70.google.com with SMTP id q11so10391046ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fyl4UhLeDGYOAotIfdCQEOAc+/SmCI2MbVX25WRRUF4=;
        b=KsmtTsIYTFRIPwLIiW7vx0tE7y+rCUPMUWMjCFZlLlX/tBJKnlL7Gvf1OVKVUJ4h6q
         sNIi6cqTIsLAui+QSvSHq5fJELlkDd2ikP3evoM0A8Zbk7BfOjp6LE3u1nSV4j4kxJ36
         Le25aQfHQa8yFIeYDZ81LZqlmKsT6IT/4aaSC9tHZt3kBJqpTcQjDrsCbRbRz8JjHpzw
         RpQJ6PRTaoKyMDSGCQRMpRk8nMuhQJVyz8uoy0kJTJwYyNS9wN9Ih+aHRTxPmKm5pvu6
         qkCCJlTbn6CKBj3yiOkZhJHUTtre28mnJT9dzrbXuL4PM5mbwbprNPatqwdhE0lnnjXp
         Anhw==
X-Gm-Message-State: AOAM531nJ9jgtYfkRvcvLm8mRbbN3pGQvEbje7Me0iqKMKe3z3QGrGRp
        rWmARBJ37gfssR0wVXcrODYenjkbXbYaY4BV1PWP+/iU28A7ZGeAtAyNWpRqS8ztRaXYMHUhSY2
        AD+y2nKycSz/1uwT2PDlDDBfyNjxEDgAuHNQPF6XJe5nkGh9vNsFFdUe9ZlOurO/AOO85CrecWh
        HG
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr246966edv.215.1612290800589;
        Tue, 02 Feb 2021 10:33:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFoJxObjMsf7HhEymSiv0tpTYhbIkkTjLf+SQ/b0Whvh9vGWxliQWJDMqcfSvIXGTip/DQ3w==
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr246951edv.215.1612290800412;
        Tue, 02 Feb 2021 10:33:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id k6sm9752409ejb.84.2021.02.02.10.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 10:33:19 -0800 (PST)
Subject: Re: [PATCH] platform/x86: amd-pmc: put device on error paths
To:     Pan Bian <bianpan2016@163.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121045005.73342-1-bianpan2016@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aed49969-9b6b-c625-9d83-78efbd2276de@redhat.com>
Date:   Tue, 2 Feb 2021 19:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121045005.73342-1-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/21 5:50 AM, Pan Bian wrote:
> Put the PCI device rdev on error paths to fix potential reference count
> leaks.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

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
>  drivers/platform/x86/amd-pmc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 0102bf1c7916..df140019c4bd 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -210,31 +210,39 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  	dev->dev = &pdev->dev;
>  
>  	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (!rdev || !pci_match_id(pmc_pci_ids, rdev))
> +	if (!rdev || !pci_match_id(pmc_pci_ids, rdev)) {
> +		pci_dev_put(rdev);
>  		return -ENODEV;
> +	}
>  
>  	dev->cpu_id = rdev->device;
>  	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
>  	if (err) {
>  		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
>  	}
>  
>  	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
> -	if (err)
> +	if (err) {
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
> +	}
>  
>  	base_addr_lo = val & AMD_PMC_BASE_ADDR_HI_MASK;
>  
>  	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_HI);
>  	if (err) {
>  		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
>  	}
>  
>  	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
> -	if (err)
> +	if (err) {
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
> +	}
>  
>  	base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>  	pci_dev_put(rdev);
> 


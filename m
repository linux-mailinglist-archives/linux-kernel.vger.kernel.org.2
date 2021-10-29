Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA91043F7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhJ2Hnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhJ2Hn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635493261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezW3HIUOk/Ta+8knWwp6sqzSWa8C+PRevk7L7uvW6Kc=;
        b=YHP2lIaspb+3fDjrCl3rQB37rlE8MrRESzaMi272I2fkDbxsVMs1TAcbOm+R7PMCJ4hx7b
        YU4iy9AZm4wfrnedRZ9PkzHWDK0JXDeXcPoOEzEezarxKyBXk4y09lRgSwTcBCeNSROwUf
        aTS1OP7eQPxKBcalDbuVwPqjY8J/Xbc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-gTPoury-NSW0OYnxoGnlGA-1; Fri, 29 Oct 2021 03:40:59 -0400
X-MC-Unique: gTPoury-NSW0OYnxoGnlGA-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso8333842edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ezW3HIUOk/Ta+8knWwp6sqzSWa8C+PRevk7L7uvW6Kc=;
        b=S63g74xc7UYLoFFYqeussV0h7ZEjrueXfTuoi5Ue8MDemVsrKjwLI7MXPFl3TU7047
         x/ivB3l7PyX/7PsG6Z8uy/UsV8cPvDqp5F2IKvBzf08wRL5mnwJojAfpgn5ttYVPrOp9
         z1R1hT5BhrY0PAEV23nhJLD8OxRSdSv6AGb+bK3fm77AaSI5NI5omUnTeAF/uPNFfhgb
         DibTbfcWodH/znJ9DxpXeLZOO9L4jzkIOxluiMYC6vHhdzybHnHEhbB5GRErtxGa0BeD
         I/sRTHlOPkxJJQ4ErqWlNSP9mPt2mCqEtpXD0YoYzZNdgjnrfzWMO6HLwWsZYknl57V/
         TJIA==
X-Gm-Message-State: AOAM533S2KwSDwzkjFIWjbYkXFQUwt0gy4vylJmDMa293NCc4ojt2CxR
        mHNWnbl0jTdnnEpo3sDJCdFcfE2pUsYVb7cjr+T/LpAoqjrjE8r1me1sZsGymaoaMVbdfO4k8YE
        7DexN/HlRd8Z7gcURoR1yzl/u
X-Received: by 2002:a17:906:4806:: with SMTP id w6mr9415424ejq.110.1635493258135;
        Fri, 29 Oct 2021 00:40:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP1ZLwopYqaBpV3kdvrpYPrf/9MYpVMbL5fHo+9QVj/rfCl3sJDUbnF6HZGzyKv8WY9MhoqA==
X-Received: by 2002:a17:906:4806:: with SMTP id w6mr9415395ejq.110.1635493257778;
        Fri, 29 Oct 2021 00:40:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id be9sm3071411edb.61.2021.10.29.00.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 00:40:57 -0700 (PDT)
Message-ID: <28833c69-9a51-fb14-7ba5-bcb71e88ca14@redhat.com>
Date:   Fri, 29 Oct 2021 09:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
References: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/21 09:02, Mauro Carvalho Chehab wrote:
> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
> loading the fbcon driver, as otherwise the i915 driver will
> fail to configure pwm:
> 
> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
> [   13.682380] Console: switching to colour dummy device 80x25
> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> [   13.739044] fbcon: i915drmfb (fb0) is primary device
> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> ...
> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
> 
> (some extra debug printk's were added to the above)
> 
> As suggested by Hans, this patch also addresses an issue with
> the dependencies, as, for this driver to be a bool, it also
> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/mfd/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ca0edab91aeb..f9092c79c4e8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
>  config INTEL_SOC_PMIC_CHTDC_TI
>  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
>  	depends on GPIOLIB
> -	depends on I2C
> +	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y
>  	depends on ACPI
>  	depends on X86
>  	select MFD_CORE
> @@ -642,6 +642,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
>  	  Select this option for supporting Dollar Cove (TI version) PMIC
>  	  device that is found on some Intel Cherry Trail systems.
>  
> +	  This option is a bool as it provides an ACPI OpRegion which must be
> +	  available before any devices using it are probed. This option also
> +	  needs the designware-i2c driver to be builtin for the same reason.
> +
>  config INTEL_SOC_PMIC_MRFLD
>  	tristate "Support for Intel Merrifield Basin Cove PMIC"
>  	depends on GPIOLIB
> 


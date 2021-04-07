Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39858356E89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbhDGO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348473AbhDGO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617805671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gft0jQWiRn/fmLudDYjZgnTUdKax4tNm9nPleM7hO78=;
        b=JYwu9ofqAoTBIUHUi0xrMZNUvWdtQSr22GslZGDkkcyzgeyWhAvjDO5xahkTWRgtxWcIin
        nhE7eTljqYrKuEKeDBOBRgh3tpJV9f2hGFP4J+FgPtudHPuJMB2Rva+HqJm6KvQy4UuIUi
        OmIkcC3xJ8BySp1JxTIc7x77mA//Wvs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-3EEz2v-kNxWVUMVeUAtiVA-1; Wed, 07 Apr 2021 10:27:49 -0400
X-MC-Unique: 3EEz2v-kNxWVUMVeUAtiVA-1
Received: by mail-ej1-f71.google.com with SMTP id dv7so3990561ejb.22
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gft0jQWiRn/fmLudDYjZgnTUdKax4tNm9nPleM7hO78=;
        b=DpnXRcuicf2t732n+8I8gDNhzZXME09UMwQSiKG000v8qo9e1UlrOS9NnusIXRgSH6
         foo+rfQsxN3E/plPW5xL0YNP7eZNo42SeTbpEd6eFh3/bUfhMv7qEbvHgK4peu2S7gU1
         c3X3slv+FsEjGUHlh0hXdLlxHU3DsHSZuKyU1s3dL8pkSipWIegesIiR43uW3wHETyXB
         +Yr+e8D5oxiGtpwZ2XV/VjV/qLf1qi9YuygTypSdug+Jd02Y/RITR8i/vZSqwoXXt2s9
         8tnJ05kDAO2EpuH28bFsjy29LGtDjabBrXMkGNnLDW86kvtw6M59CfiSU6VLucdL3GYU
         tJqw==
X-Gm-Message-State: AOAM532sIQ4SqcKiojGbXwk0auSbBY5JWo++bth36GHKMb5qMkIMlGxr
        dxdgfKNjAaNGPBpma7HMUd0alS2F4PjpbNJOH08BDXAyxeRg87O7Fv2eR3IFqffnE0WylygE7Ni
        otkwyEMZ/jIy2bM14iX50odCMbAsmIi4P/Ki5pFG1giLqxeEVLsxmKwUAMlRpbHlhjqvU/fPUvs
        aG
X-Received: by 2002:aa7:c694:: with SMTP id n20mr4707242edq.51.1617805667988;
        Wed, 07 Apr 2021 07:27:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr1SsbFrBUY2eJ7+tVkiwHletcZzL7DWO69w7ot05onv/ASefQumUSH1ZnACb+UHxpGZoPpA==
X-Received: by 2002:aa7:c694:: with SMTP id n20mr4707211edq.51.1617805667747;
        Wed, 07 Apr 2021 07:27:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bj7sm12881301ejb.28.2021.04.07.07.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:27:47 -0700 (PDT)
Subject: Re: [PATCH 5/9] platform/x86: intel_pmc_core: Get LPM requirements
 for Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
 <20210401030558.2301621-6-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c9f29af-e130-0704-152d-27a652427a3e@redhat.com>
Date:   Wed, 7 Apr 2021 16:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401030558.2301621-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 5:05 AM, David E. Box wrote:
> From: Gayatri Kammela <gayatri.kammela@intel.com>
> 
> Platforms that support low power modes (LPM) such as Tiger Lake maintain
> requirements for each sub-state that a readable in the PMC. However, unlike
> LPM status registers, requirement registers are not memory mapped but are
> available from an ACPI _DSM. Collect the requirements for Tiger Lake using
> the _DSM method and store in a buffer.
> 
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 49 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h |  2 ++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ba0db301f07b..0ec26a4c715e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -23,7 +23,9 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/uaccess.h>
> +#include <linux/uuid.h>
>  
> +#include <acpi/acpi_bus.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/msr.h>
> @@ -31,6 +33,9 @@
>  
>  #include "intel_pmc_core.h"
>  
> +#define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
> +#define ACPI_GET_LOW_MODE_REGISTERS	1
> +
>  /* PKGC MSRs are common across Intel Core SoCs */
>  static const struct pmc_bit_map msr_map[] = {
>  	{"Package C2",                  MSR_PKG_C2_RESIDENCY},
> @@ -587,6 +592,46 @@ static const struct pmc_reg_map tgl_reg_map = {
>  	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
>  };
>  
> +static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
> +{
> +	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +	const int num_maps = pmcdev->map->lpm_num_maps;
> +	size_t lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
> +	union acpi_object *out_obj;
> +	struct acpi_device *adev;
> +	guid_t s0ix_dsm_guid;
> +	u32 *lpm_req_regs;
> +
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return;
> +
> +	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
> +				     GFP_KERNEL);
> +	if (!lpm_req_regs)
> +		return;
> +
> +	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
> +
> +	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
> +				    ACPI_GET_LOW_MODE_REGISTERS, NULL);

Since you are using ACPI functions here, maybe change:

	depends on PCI

In the config INTEL_PMC_CORE Kconfig entry to:

	depends on PCI && ACPI

Note all functions you use are stubbed when !ACPI, so this
should build fine without this, but it will turn this function
into a no-op. If you prefer not to add the depends on ACPI that
is fine too.



> +	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> +		u32 *addr = (u32 *)out_obj->buffer.pointer;
> +		int size = out_obj->buffer.length;
> +
> +		if (size != lpm_size)

	You're leaking lpm_req_regs here (sort of) maybe devm_free it here ?

> +			return;
> +
> +		memcpy_fromio(lpm_req_regs, addr, lpm_size);

This is wrong, the memory in an ACPI buffer is not IO-mem it is normal memory.

> +	} else
> +		acpi_handle_debug(adev->handle,
> +				  "_DSM function 0 evaluation failed\n");
> +
> +	ACPI_FREE(out_obj);
> +
> +	pmcdev->lpm_req_regs = lpm_req_regs;

You do this even if the "if (out_obj && out_obj->type == ACPI_TYPE_BUFFER)"
check above failed, making pmcdev->lpm_req_regs point to a block of
memory filled with zeros. That does not seem right.

> +}
> +
>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
>  {
>  	return readl(pmcdev->regbase + reg_offset);
> @@ -1312,10 +1357,14 @@ static int pmc_core_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mutex_init(&pmcdev->lock);
> +
>  	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
>  	pmc_core_get_low_power_modes(pmcdev);
>  	pmc_core_do_dmi_quirks(pmcdev);
>  
> +	if (pmcdev->map == &tgl_reg_map)
> +		pmc_core_get_tgl_lpm_reqs(pdev);
> +
>  	/*
>  	 * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
>  	 * a cable is attached. Tell the PMC to ignore it.
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 3800c1ba6fb7..81d797feed33 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -288,6 +288,7 @@ struct pmc_reg_map {
>   * @s0ix_counter:	S0ix residency (step adjusted)
>   * @num_modes:		Count of enabled modes
>   * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
> + * @lpm_req_regs:	List of substate requirements
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -304,6 +305,7 @@ struct pmc_dev {
>  	u64 s0ix_counter;
>  	int num_modes;
>  	int lpm_en_modes[LPM_MAX_NUM_MODES];
> +	u32 *lpm_req_regs;
>  };
>  
>  #define pmc_for_each_mode(i, mode, pmcdev)		\
> 

Regards,

Hams


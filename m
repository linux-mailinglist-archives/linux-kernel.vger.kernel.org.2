Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDD362EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhDQIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 04:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229631AbhDQIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 04:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618649569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPsi63kn4XR+OnMi+pQNAtLM9r4YAOOOEg9vVdyVJPU=;
        b=GXkgRjy8D3YnZ43XH1c9GY9lYN7BonrBi6H9HdwyY8rgpql65gryfYhixulq7wLlHgx0uH
        sYky+ViRZjgDZXLcDFfHZ8CLEnt1Hnhuuh35RUAA6B4f7WNC8On3HAgfSk4RHWiUHxHdUk
        jz9p8NAHy2dktyKPSeL11gMLH5m2LaA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-mgT6tybPO42Fi_a6GCr2wA-1; Sat, 17 Apr 2021 04:52:47 -0400
X-MC-Unique: mgT6tybPO42Fi_a6GCr2wA-1
Received: by mail-ed1-f70.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso8442121edb.23
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 01:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPsi63kn4XR+OnMi+pQNAtLM9r4YAOOOEg9vVdyVJPU=;
        b=T+jOkUeGlZJP/1OYaNup8YPsJpzzN4iY7zO/ArEtPCbDXFdQyGPIJvXdLdRVGm8p0y
         6eZNXfAsZN8COVf4bKhZAD1mZ5wW3pLKDbTan7MpL+1av6UMI9+XO30Q+v0Ba4y1Hqp4
         IaOtO85eyohDfu1s4DBlKsTrtigyaDdut4dZzh3lUy/KtBCzpzyOh3z/vlzgTFOEuHFr
         vJYIIqf0P3+xt1Bdr+2b64QxwJpH2tOQTHZL7/SXzemaul5TnmxokH4eQMmcKcj/yQQO
         q0lRI9aVU/P87VKuWpUOOPx9JOfOR8JPjj4oWnyIPXTBkOr//Itzl9DxDxnQpc0ZtaUA
         p6QQ==
X-Gm-Message-State: AOAM531zf6tkggo9LDOJhf2fEttfijdkLjZD8BZWItDny7zDZ3NknOCc
        8iZkoo7Km1rY692N0XXKJCcMQW3qjyMHL8VRkEDL6iryl3WqnI+uaziBdUjzlCXCARMts1RTXmy
        HmePcTbj/LtCbKrmGOiJwg2CWCssO9Ag8B5BgTJiM13SntrCWmIS+fZTKtoiJT0e/GwbAzHTgKC
        83
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr2323606ejj.208.1618649566116;
        Sat, 17 Apr 2021 01:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlgHMIE1JdPYYoCLXs6cnTNQi7ZuGmcb0nsvC9/7mpCwvtBg5JNaeyENIzvZjMkb/uWQerEA==
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr2323588ejj.208.1618649565852;
        Sat, 17 Apr 2021 01:52:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f10sm7562715edd.29.2021.04.17.01.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 01:52:45 -0700 (PDT)
Subject: Re: [PATCH V2 5/9] platform/x86: intel_pmc_core: Get LPM requirements
 for Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
 <20210417031252.3020837-6-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2c2cca5-3984-6554-040a-3ffe74c0ca0c@redhat.com>
Date:   Sat, 17 Apr 2021 10:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210417031252.3020837-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 4/17/21 5:12 AM, David E. Box wrote:
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
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Erm, I did not give my "Reviewed-by: Hans de Goede <hdegoede@redhat.com>"
for this patch, because it still needed some work.

Next time please only add my Reviewed-by to patches where I
explicitly replied with a Reviewed-by.

The same goes for patch 7/9

Regards,

Hans



> ---
> 
> V2:	- Move buffer allocation so that it does not need to be freed
> 	  (which was missing anyway) when an error is encountered.
> 	- Use label to free out_obj after errors
> 	- Use memcpy instead of memcpy_fromio for ACPI memory
> 
>  drivers/platform/x86/intel_pmc_core.c | 56 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h |  2 +
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 0e59a84b51bf..97efe9a6bd01 100644
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
> @@ -590,6 +595,53 @@ static const struct pmc_reg_map tgl_reg_map = {
>  	.etr3_offset = ETR3_OFFSET,
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
> +	u32 *lpm_req_regs, *addr;
> +
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return;
> +
> +	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
> +
> +	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
> +				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
> +	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> +		int size = out_obj->buffer.length;
> +
> +		if (size != lpm_size) {
> +			acpi_handle_debug(adev->handle,
> +				"_DSM returned unexpected buffer size,"
> +				" have %d, expect %ld\n", size, lpm_size);
> +			goto free_acpi_obj;
> +		}
> +	} else {
> +		acpi_handle_debug(adev->handle,
> +				  "_DSM function 0 evaluation failed\n");
> +		goto free_acpi_obj;
> +	}
> +
> +	addr = (u32 *)out_obj->buffer.pointer;
> +
> +	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
> +				     GFP_KERNEL);
> +	if (!lpm_req_regs)
> +		goto free_acpi_obj;
> +
> +	memcpy(lpm_req_regs, addr, lpm_size);
> +	pmcdev->lpm_req_regs = lpm_req_regs;
> +
> +free_acpi_obj:
> +	ACPI_FREE(out_obj);
> +}
> +
>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
>  {
>  	return readl(pmcdev->regbase + reg_offset);
> @@ -1424,10 +1476,14 @@ static int pmc_core_probe(struct platform_device *pdev)
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
> index aa44fd5399cc..64fb368f40f6 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -294,6 +294,7 @@ struct pmc_reg_map {
>   * @s0ix_counter:	S0ix residency (step adjusted)
>   * @num_lpm_modes:	Count of enabled modes
>   * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
> + * @lpm_req_regs:	List of substate requirements
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -310,6 +311,7 @@ struct pmc_dev {
>  	u64 s0ix_counter;
>  	int num_lpm_modes;
>  	int lpm_en_modes[LPM_MAX_NUM_MODES];
> +	u32 *lpm_req_regs;
>  };
>  
>  #define pmc_for_each_mode(i, mode, pmcdev)		\
> 


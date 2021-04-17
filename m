Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E720C362EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhDQJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhDQJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618650058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iavCArchwV7RgiQPAM67ldgssKis2X2H1PDR7CgoWuw=;
        b=M6gtcGLIWDhkUkDcOEj3tfGIOpNio3YT5fjALQy9KZnxbhoDOndRe50YmF5IEz0C3dJgLP
        9RtAAhK6Ux/A+tZ2NqhJd1ILbK0efi97CiC0QxcABB/M40YtUFkrOi6HS2SSs5HGEAr+rw
        2qdXCPBsz+Ze+wYNAopRDj0dh3Z+clo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-9ltugHtRM1KOTFgh3762uw-1; Sat, 17 Apr 2021 05:00:56 -0400
X-MC-Unique: 9ltugHtRM1KOTFgh3762uw-1
Received: by mail-ed1-f71.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so2824248edr.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 02:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iavCArchwV7RgiQPAM67ldgssKis2X2H1PDR7CgoWuw=;
        b=dl/77fwr7+dTE9g6ldF64LUmPD/1HXqs01A8c5UCj9OKrjnVHJaDjdnL0ROGOXbXNR
         Yqdr2FqcgBVdJUonGBa6lpAkyAAyL3HZCa50suDfVbk8A2OgtHMerBm7ooEOVA4o1Eg/
         Ejz5ub/ZulW0ftzXJgkGoFDbdy6Dx2b0lcWGft2v+MaAHVbYn28adrj1UW5O5v7LlFy3
         PfskVowAyibhu65XzzGLUXeVXiJOcXJiXulf/ozgugT0PJ/h/D9xRuDsuXOW2JQx7cOZ
         73rfybr5ybk+kJd+bV8RKf5NYbyzVgCMbwjWSQ4LLAMi/zE/TLml3C3j+jxvhsIPBMq+
         +VwA==
X-Gm-Message-State: AOAM531XhxdCbxEcRzeoqYkLQR650wIOx1zF8HaGTAiD9CfTG+x57B/l
        odgWdt2i4f9LI5Aq1wg+TE8g1qi3vndeT6U6WdZILHpx9JaXx1zORxI5WQm1UNX226413hPIS2i
        Ako5AintuYYSMI86ohLMnZoUV7QaFiFu5RHuHQYN3QDsGbzIoWo9M6vw61M1jOwhAvqGNHJGWPD
        86
X-Received: by 2002:a17:906:b156:: with SMTP id bt22mr8215896ejb.181.1618650055210;
        Sat, 17 Apr 2021 02:00:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbxonGH/xSU3qqYcwukU7crYKfSYUtFyCOSDuoHnb4ZvcDdfJox4dp/8dWcNt1AfEtBisK+A==
X-Received: by 2002:a17:906:b156:: with SMTP id bt22mr8215868ejb.181.1618650054872;
        Sat, 17 Apr 2021 02:00:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f13sm5872707ejb.33.2021.04.17.02.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 02:00:54 -0700 (PDT)
Subject: Re: [PATCH V2 5/9] platform/x86: intel_pmc_core: Get LPM requirements
 for Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
 <20210417031252.3020837-6-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6dd84b65-44b4-ae12-fe84-c61d8efd43f3@redhat.com>
Date:   Sat, 17 Apr 2021 11:00:54 +0200
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

Hi,

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

The type of lpm_size should be an u32, so that it matches
the type of out_obj->buffer.length.

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

out_obj->buffer.length is an u32, please make this an u32 too.

> +
> +		if (size != lpm_size) {
> +			acpi_handle_debug(adev->handle,
> +				"_DSM returned unexpected buffer size,"
> +				" have %d, expect %ld\n", size, lpm_size);

And use %u here (twice), this should also fix the warnings reported
by the kernel test robot.

If there are no objections against the suggested changes, then I can
fix this up while merging this.

Please let me know if the suggested changes are ok with you.

Regards,

Hans


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


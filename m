Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8C356E79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbhDGOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235762AbhDGOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617805426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwbR+/upg2Ec94XWjtYYxLPU9OMlD8Hz5nT5kMrJq8c=;
        b=bLjc9nAg4ZAD2JlSJX8UOMGICMWZS9rA/E9oDKT951OkW5tJhtLDZdHJ2DUgj5EW/p+SfT
        +xyV2zUwH7rg54Z8wnAjgFrLfabXhur2fZIiTv+4J5KoPystNjEKC1mjn26vsS9JEwTHOP
        ElUgIGRsRRRq7RGtM74nRpN/No4UoQY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-aUWFHOw6M2G4RubyBZn_Jw-1; Wed, 07 Apr 2021 10:23:45 -0400
X-MC-Unique: aUWFHOw6M2G4RubyBZn_Jw-1
Received: by mail-ed1-f71.google.com with SMTP id m21so2561952edp.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwbR+/upg2Ec94XWjtYYxLPU9OMlD8Hz5nT5kMrJq8c=;
        b=E1fpCf4VYPJ35QFoEek2/eI9/1E98c3zLG+qHX5APEPhRC3Ae2hgbYuTBw4JMKUBDb
         9sZ/iciGFcrBXGEIwl94EJRKRLtwyup9kyv05BjH3R6qlIUtS1lW46GJ/tLA2igEV0lp
         tuYOUBZeC6egSJDLEpPW5EnQ3QGGoH9FDEqJwt8+syX6Cxc8nCQsXfPlCeo4/yYZmZad
         rrgKNLxiynFJd0Ym3s+VJHsMX5IQpfwrbH6FPxbQSab2JOtD7n2xfHdnqL/oJqD6W/oS
         Nd5M/BLeZlb1FNmeyhLwIDXq8IU8Nl8LnTtvjzX8MfduV9sp42QIpn95l+rseNVvDptB
         HEPA==
X-Gm-Message-State: AOAM532ZYx6Xm4rXfyU6YQJyJhk2B5Efnv6+AApN8NG5IUqtJ3N39gRK
        vDUxrOUvW05P5k5Vw3SeUeGsOllVsstv3AZpQKAt6jqZRg76fakjSTyqawsZzrJRQ5+/H4XST95
        3AVsidAg1L/XDvCXNC1k8HhgAhsJUmk6hXBKEnA7lsbTY2P6Af8qvZJIQyHNgcTq9+sPgegLqGE
        bV
X-Received: by 2002:a05:6402:514c:: with SMTP id n12mr4754655edd.224.1617805423319;
        Wed, 07 Apr 2021 07:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPQmenwNkW4XXsq/H03hz8nT5HmasGCyXqHtI5HA/gV3rJvia8PVjZVa6W/saO2Qsdi4l/zg==
X-Received: by 2002:a05:6402:514c:: with SMTP id n12mr4754634edd.224.1617805423094;
        Wed, 07 Apr 2021 07:23:43 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm16079189edy.72.2021.04.07.07.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:23:42 -0700 (PDT)
Subject: Re: [PATCH 4/9] platform/x86: intel_pmc_core: Show LPM residency in
 microseconds
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
 <20210401030558.2301621-5-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <43784b22-885c-4b33-8d8f-05f8a18d31dd@redhat.com>
Date:   Wed, 7 Apr 2021 16:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401030558.2301621-5-david.e.box@linux.intel.com>
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
> Modify the low power mode (LPM or sub-state) residency counters to display
> in microseconds just like the slp_s0_residency counter. The granularity of
> the counter is approximately 30.5us per tick. Double this value then divide
> by two to maintain accuracy.
> 
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++--
>  drivers/platform/x86/intel_pmc_core.h |  3 +++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ce300c2942d0..ba0db301f07b 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -578,6 +578,7 @@ static const struct pmc_reg_map tgl_reg_map = {
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>  	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
>  	.lpm_num_maps = TGL_LPM_NUM_MAPS,
> +	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
>  	.lpm_en_offset = TGL_LPM_EN_OFFSET,
>  	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
>  	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
> @@ -1026,17 +1027,26 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
>  
> +static inline u64 adjust_lpm_residency(struct pmc_dev *pmcdev, u32 offset,
> +				       const int lpm_adj_x2)
> +{
> +	u64 lpm_res = pmc_core_reg_read(pmcdev, offset);
> +
> +	return GET_X2_COUNTER((u64)lpm_adj_x2 * lpm_res);
> +}
> +
>  static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> +	const int lpm_adj_x2 = pmcdev->map->lpm_res_counter_step_x2;
>  	u32 offset = pmcdev->map->lpm_residency_offset;
>  	int i, mode;
>  
>  	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
>  
>  	pmc_for_each_mode(i, mode, pmcdev) {
> -		seq_printf(s, "%-10s %-15u\n", pmc_lpm_modes[mode],
> -			   pmc_core_reg_read(pmcdev, offset + (4 * mode)));
> +		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
> +			   adjust_lpm_residency(pmcdev, offset + (4 * mode), lpm_adj_x2));
>  	}
>  
>  	return 0;
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 5a4e3a49f5b1..3800c1ba6fb7 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -188,9 +188,11 @@ enum ppfear_regs {
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
>  
>  #define LPM_MAX_NUM_MODES			8
> +#define GET_X2_COUNTER(v)			((v) >> 1)
>  
>  #define TGL_NUM_IP_IGN_ALLOWED			22
>  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
> +#define TGL_PMC_LPM_RES_COUNTER_STEP_X2		61	/* 30.5us * 2 */
>  
>  /*
>   * Tigerlake Power Management Controller register offsets
> @@ -263,6 +265,7 @@ struct pmc_reg_map {
>  	const u32 pm_vric1_offset;
>  	/* Low Power Mode registers */
>  	const int lpm_num_maps;
> +	const int lpm_res_counter_step_x2;
>  	const u32 lpm_en_offset;
>  	const u32 lpm_priority_offset;
>  	const u32 lpm_residency_offset;
> 


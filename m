Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6778332C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCIQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCIQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:45:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD40C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:45:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u16so16946918wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HQAapd2VYff0FVMH+At0UuE1zM/4LNj6vNP0aGstbj4=;
        b=f7i6/zFL5uCo6uPBWoKGpNHNJRsNwgOhsJ8NP0zJqHE/fIYYt7SzSCqGlzOChkykzL
         rEh+Vix2cdfJL5JqvUXCB91eeqObk4nSKwOhx7CpRliLDuE3hrr+g2mfkOtKpzdIJOZy
         J6dycplUlG4YnjIigvDTQ0qWsrDAmDW0BNDPjrDicjkWDn25UODM7uW0iEQRUzxEl9tc
         Xwddm4Q+wljabinj9dJyQIfQ0WDO4jdzGDk9hGl2oiOkSlFE8jgd1LL2CIEnxN9OYZEg
         pWahPXl+XiV8ERvLl/qz+F3NFKC9+Q0RXVVCa2SmWG7gUaQnSgmVU/kgqlogCjqBBZP0
         mN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HQAapd2VYff0FVMH+At0UuE1zM/4LNj6vNP0aGstbj4=;
        b=QE0/Fx2HNKqv/OY3eWcwObS1c5GznrMXeW04OuJTx4FsyieM5tcpdTf5t39DmFsz64
         sDa6zisVfZFlCUwxm1h5NVNr4vyRl4okkncnR1FZBQO1dV3h0JSRi/XDr7uE99sAW92G
         HGNgTJpqrWO5ivBJ7/vOEwBy0k9QCjFLO/FtrbNeGdWRXuEnNzwIUhbcrJn/HN7PmRFC
         JhG+HTZfHj82q95I/dWBkcIIOAwRIxN24ZnZjymw6KLB4EI3vKZ+7tH5PRcO2o5FKVz0
         PrbZ2sfDMA2kfkhYGgIAjEnUSmXRRVB2oO6y30EUH5QGIlSAXxK0HWqlPHJJVKpGNgYR
         I6cg==
X-Gm-Message-State: AOAM530o4N4RT69NJetXUS9Xk275VxacQ1Q0FPCvJg77eesDSj1RNCti
        PikiMhzkfbyUdonBp27o8Pa7S/f644etLQ==
X-Google-Smtp-Source: ABdhPJwDMP0K8mu7QTzWcY95OMns2CzLD9V4ndIZmXoVoRCvUj1IsCW1jpwW4Fn0nQRg0y8YkoPfgQ==
X-Received: by 2002:a05:6000:221:: with SMTP id l1mr29124435wrz.370.1615308308069;
        Tue, 09 Mar 2021 08:45:08 -0800 (PST)
Received: from dell ([91.110.221.192])
        by smtp.gmail.com with ESMTPSA id u23sm4908290wmn.26.2021.03.09.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:45:07 -0800 (PST)
Date:   Tue, 9 Mar 2021 16:45:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2 V2] MFD: intel_pmt: Add support for DG1
Message-ID: <20210309164505.GS4931@dell>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224201005.1034005-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021, David E. Box wrote:

> Adds PMT Telemetry aggregator support for the DG1 graphics PCIe card. The
> device does not have the DVSEC region in its PCI config space so hard
> code the discovery table data in the driver. Also requires a fix for DG1
> in the Telemetry driver for how the ACCESS_TYPE field is used.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> Based on 5.11-rc1 review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Changes from V1:
> 
> 	- New patch
> 
>  drivers/mfd/intel_pmt.c                    | 101 +++++++++++++++------
>  drivers/platform/x86/intel_pmt_class.c     |  46 ++++++++++
>  drivers/platform/x86/intel_pmt_class.h     |   1 +
>  drivers/platform/x86/intel_pmt_telemetry.c |  20 ----
>  4 files changed, 119 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> index 65da2b17a204..dd7eb614c28e 100644
> --- a/drivers/mfd/intel_pmt.c
> +++ b/drivers/mfd/intel_pmt.c
> @@ -49,10 +49,14 @@ enum pmt_quirks {
>  
>  	/* Use shift instead of mask to read discovery table offset */
>  	PMT_QUIRK_TABLE_SHIFT	= BIT(2),
> +
> +	/* DVSEC not present (provided in driver data) */
> +	PMT_QUIRK_NO_DVSEC	= BIT(3),
>  };
>  
>  struct pmt_platform_info {
>  	unsigned long quirks;
> +	struct intel_dvsec_header **capabilities;
>  };
>  
>  static const struct pmt_platform_info tgl_info = {
> @@ -60,6 +64,26 @@ static const struct pmt_platform_info tgl_info = {
>  		  PMT_QUIRK_TABLE_SHIFT,
>  };
>  
> +/* DG1 Platform with DVSEC quirk*/
> +static struct intel_dvsec_header dg1_telemetry = {
> +	.length = 0x10,
> +	.id = 2,
> +	.num_entries = 1,
> +	.entry_size = 3,
> +	.tbir = 0,
> +	.offset = 0x466000,
> +};
> +
> +static struct intel_dvsec_header *dg1_capabilities[] = {
> +	&dg1_telemetry,
> +	NULL
> +};
> +
> +static const struct pmt_platform_info dg1_info = {
> +	.quirks = PMT_QUIRK_NO_DVSEC,
> +	.capabilities = dg1_capabilities,
> +};
> +
>  static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
>  		       unsigned long quirks)
>  {
> @@ -147,37 +171,54 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (info)
>  		quirks = info->quirks;
>  
> -	do {
> -		struct intel_dvsec_header header;
> -		u32 table;
> -		u16 vid;
> +	if (info && (info->quirks & PMT_QUIRK_NO_DVSEC)) {

Nit: Why not use 'quirks' from a few lines above?

> +		struct intel_dvsec_header **header;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

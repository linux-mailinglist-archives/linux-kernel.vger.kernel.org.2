Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483B3BDEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 23:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhGFVGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 17:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhGFVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 17:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625605443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rq8U+vTL62FFXy3XaC+Iae121lZCkhh5N1dZH3VvP4o=;
        b=Wh+vhONp5PzAPv3IwYvi4OBQzrUW3sSalppeNyCvSp8+WhD1Zx6FcW6FojjNL8d4uyTERN
        0VC8ZMmtm2thcEcgL0165zw4G3Szwa2nYN7uv8czZm4n8HqT2lCuVdgTLLYbXEtONHML0B
        s9462oOX70b6bTRd8r3UtB7nU6PtHAA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-rOduqwk7NXm0RSqOYZJxKg-1; Tue, 06 Jul 2021 17:04:02 -0400
X-MC-Unique: rOduqwk7NXm0RSqOYZJxKg-1
Received: by mail-ot1-f71.google.com with SMTP id h10-20020a9d600a0000b0290467bd8bd570so41995otj.22
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 14:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rq8U+vTL62FFXy3XaC+Iae121lZCkhh5N1dZH3VvP4o=;
        b=FDERBuh+C4Ek5V2Qh1mDmXLXdR8Zh0/EAS0mqgn/OH2qoQU8DNJ8b6BOFtmama2shd
         kjh+kJxE/AjpX2X3BkGdGosta7iPJ12yWh9Moac+mftEJZlqzsg4zX+Gd6Uii/D3Jjye
         1UF2T98uieDE5UV67PEa/QrsH/+uN7zBDeZys7bB1jO/DBXpJxMaQsrcWis+2M9fwfrz
         XCPFG4FYRe8Iw1vlYra25jZGsBw3Q9b5KKaS6/hopdCQhlRDMBk4Jdq2dN/ho+k5fkaR
         z5359+HR7hiPBQOMSeRVukv91baVYfudgBx0PCQ1my5+OKe2f7ntWKt/WgesKGep+YPg
         wj4Q==
X-Gm-Message-State: AOAM532gZoG95MD52UhxmhDcRDvqFoZmwg3VWbxoaNUWmkI508Gdxg/M
        2aNsTgLMlzrGDeiZMIOJnUVu9p3GtTdcXjJqEYFZyRKkDHCdBUww2C1cx8nIuvR7lb2x9XEX8bz
        eUyyDWH5Y/uO/YtMh6PADj1RD
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr3670300oiw.132.1625605440942;
        Tue, 06 Jul 2021 14:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx62HKLlemehPY2UyA8H0YEjxeJSEUxb/U3f7pKIm7DwzFJJAuko85berITKZR0ayBmECKR7w==
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr3670283oiw.132.1625605440801;
        Tue, 06 Jul 2021 14:04:00 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a7sm3074816ooo.9.2021.07.06.14.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 14:04:00 -0700 (PDT)
Subject: Re: [PATCH v8 1/5] drivers: firmware: Add PDI load API support
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org, arnd@arndb.de,
        rajan.vaja@xilinx.com, gregkh@linuxfoundation.org,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-2-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c2c06484-556d-1003-ad45-301e5b22210b@redhat.com>
Date:   Tue, 6 Jul 2021 14:03:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210626155248.5004-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/21 8:52 AM, Nava kishore Manne wrote:
> This patch adds load PDI API support to enable full/partial PDI loading
> from linux. Programmable Device Image (PDI) is combination of headers,
> images and bitstream files to be loaded.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes for v2:
>                -Updated API Doc and commit msg.
>                 No functional changes.
>
> Changes for v3:
>                -None.
>
> Changes for v4:
>                -Rebased the changes on linux-next.
>                 No functional changes
>
> Changes for v5:
>                -None.
>
> Changes for v6:
>                -None.
>
> Changes for v7:
>                -None.
>
> Changes for v8:
>                 -None.
>
>   drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 10 ++++++++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 15b138326ecc..2db571da9ad8 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1011,6 +1011,23 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
>   
> +/**
> + * zynqmp_pm_load_pdi - Load and process PDI
> + * @src:       Source device where PDI is located
> + * @address:   PDI src address
> + *
> + * This function provides support to load PDI from linux
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> +{
> +	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
> +				   lower_32_bits(address),
> +				   upper_32_bits(address), 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
> +
>   /**
>    * zynqmp_pm_aes - Access AES hardware to encrypt/decrypt the data using
>    * AES-GCM core.
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9d1a5c175065..56b426fe020c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -52,6 +52,10 @@
>   #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>   #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
>   
> +/* Loader commands */
> +#define PM_LOAD_PDI	0x701
This should be defined in enum pm_api_id
> +#define PDI_SRC_DDR	0xF

This is only used by versal_fpga_ops_write(), consider moving the 
#define to versal-fpga.c

Tom

> +
>   /*
>    * Firmware FPGA Manager flags
>    * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
> @@ -411,6 +415,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
>   				 u32 *value);
>   int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>   				 u32 value);
> +int zynqmp_pm_load_pdi(const u32 src, const u64 address);
>   #else
>   static inline int zynqmp_pm_get_api_version(u32 *version)
>   {
> @@ -622,6 +627,11 @@ static inline int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>   {
>   	return -ENODEV;
>   }
> +
> +static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> +{
> +	return -ENODEV;
> +}
>   #endif
>   
>   #endif /* __FIRMWARE_ZYNQMP_H__ */


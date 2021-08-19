Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15B3F162B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhHSJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237121AbhHSJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629365376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+zm4Agz83gN++c6BAm7lqBB7TbF6xYzg3VELgKEpHo=;
        b=NxKu0WayrXjjLqlzW3MSJpbzilZs4Bpz862h26T9snPfqIwXp2l8/YlUYc464lPW5977Gg
        3vqHEbZ6SrTko82w8iU1DwMrmUHW1aTgPPk3pF6POLaPB13Ei0jCpM9QMTcSYVeevzAV/P
        OnQ8gC+MM5HxxfFLmG5egMB/CUs6IrY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-M8McsyaSMkanlbiDTGuGZA-1; Thu, 19 Aug 2021 05:29:33 -0400
X-MC-Unique: M8McsyaSMkanlbiDTGuGZA-1
Received: by mail-ej1-f71.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so2006128ejy.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f+zm4Agz83gN++c6BAm7lqBB7TbF6xYzg3VELgKEpHo=;
        b=mr4QTU3lcATXZDh36zUv3fCjAgZ3+QnjZn9CFpxd73J0NSe8vDAQjuWRnWCu76hCky
         kJpUvTJSTmZ9N67OHlIzvsXs6akCtOwFVHevWH/SDc6ALewHJwIlhOXJAuDHSHqwJmEk
         kNbu5ikubRFGO2kJy5H6M3MkLzFKuCsk3xs2xs19f3foG7Ekl16aNmsdA0ULIZ1a+mCh
         PLRaSuBIBhctuyKvw3vofQt8aTI8ULukFMB0dpS9wuIqGFU59NTi5kRp5I54jFmbtQ0P
         wMWQ4WNjTD+hsHxsTpOeQeP1vbcQdj1VqcGsqIl8Vti3AyCmdJSTExMnQDFyf2ccEqmm
         bkHw==
X-Gm-Message-State: AOAM5324AYBsaRxVy7gIljDL3vkuoikoVf/MZdbIxzVe91unvHiNDRin
        lPnRQKZDA8cnO3JWbNz+sfkZbV+W6yE3AHHAAo3/IbmMOQeF+wx9E/qWyKXvW8nPJsyCa0jGQu0
        wk05CX9iPNU+cKa+m0CGBHJbS
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr15339183edc.249.1629365371725;
        Thu, 19 Aug 2021 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfmq56c+VmPRS1YwYoFqrKw3LNseox11TEdcU1cjo4/HuBQLmoQYMSHJ+m/5xKMKL8hBe27w==
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr15339169edc.249.1629365371571;
        Thu, 19 Aug 2021 02:29:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id sa21sm1000669ejb.108.2021.08.19.02.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 02:29:31 -0700 (PDT)
Subject: Re: [PATCH v3 20/20] platform/x86: intel-wmi-thunderbolt: Move to
 intel sub-directory
To:     Kate Hsuan <hpa@redhat.com>, Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org
References: <20210819033001.20136-1-hpa@redhat.com>
 <20210819033001.20136-21-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5000a71-f1f9-4880-2b7e-4f2d89a83777@redhat.com>
Date:   Thu, 19 Aug 2021 11:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819033001.20136-21-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 5:30 AM, Kate Hsuan wrote:
> Move intel-wmi-thunderbolt to intel sub-directory to improve
> readability.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/platform/x86/Kconfig                         | 12 ------------
>  drivers/platform/x86/Makefile                        |  2 --
>  drivers/platform/x86/intel/Makefile                  |  1 +
>  drivers/platform/x86/intel/wmi/Kconfig               | 12 ++++++++++++
>  drivers/platform/x86/intel/wmi/Makefile              |  2 ++
>  .../wmi/thunderbolt.c}                               |  0
>  6 files changed, 15 insertions(+), 14 deletions(-)
>  rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 611930985b1d..adecdc0d4748 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -77,18 +77,6 @@ config UV_SYSFS
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called uv_sysfs.
>  
> -config INTEL_WMI_THUNDERBOLT
> -	tristate "Intel WMI thunderbolt force power driver"
> -	depends on ACPI_WMI
> -	help
> -	  Say Y here if you want to be able to use the WMI interface on select
> -	  systems to force the power control of Intel Thunderbolt controllers.
> -	  This is useful for updating the firmware when devices are not plugged
> -	  into the controller.
> -
> -	  To compile this driver as a module, choose M here: the module will
> -	  be called intel-wmi-thunderbolt.
> -
>  config MXM_WMI
>         tristate "WMI support for MXM Laptop Graphics"
>         depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 0a6dca068d5a..56cff979428b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -10,8 +10,6 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
>  
>  # WMI drivers
>  obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
> -
> -obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
>  obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>  obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index 0b27be3b9334..2c1bab610499 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -50,3 +50,4 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
>  
>  #WMI drivers
>  obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)		+= wmi/
> +obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)		+= wmi/

Here we have the issue of sending "make" twice into the same subdir again.

I've fixed this by adding a CONFIG_INTEL_WMI, similar to how I fixed
the same issue for the atomisp2 drivers.

I have made these changes while merging the series there is no need for
a new version.

Regards,

Hans








> diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
> index fc70728e0f1f..0d65fc90f5b1 100644
> --- a/drivers/platform/x86/intel/wmi/Kconfig
> +++ b/drivers/platform/x86/intel/wmi/Kconfig
> @@ -12,3 +12,15 @@ config INTEL_WMI_SBL_FW_UPDATE
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called intel-wmi-sbl-fw-update.
> +
> +config INTEL_WMI_THUNDERBOLT
> +	tristate "Intel WMI thunderbolt force power driver"
> +	depends on ACPI_WMI
> +	help
> +	  Say Y here if you want to be able to use the WMI interface on select
> +	  systems to force the power control of Intel Thunderbolt controllers.
> +	  This is useful for updating the firmware when devices are not plugged
> +	  into the controller.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called intel-wmi-thunderbolt.
> diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
> index bf1f118b6839..c2d56d25dea0 100644
> --- a/drivers/platform/x86/intel/wmi/Makefile
> +++ b/drivers/platform/x86/intel/wmi/Makefile
> @@ -5,3 +5,5 @@
>  
>  intel-wmi-sbl-fw-update-y				:= sbl-fw-update.o
>  obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
> +intel-wmi-thunderbolt-y					:= thunderbolt.o
> +obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
> diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
> similarity index 100%
> rename from drivers/platform/x86/intel-wmi-thunderbolt.c
> rename to drivers/platform/x86/intel/wmi/thunderbolt.c
> 


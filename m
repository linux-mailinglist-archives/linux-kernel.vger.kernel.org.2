Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1933F1591
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhHSItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237528AbhHSItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629362926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsSd1bot3DME93pxd8YXHXKyar3E/IXKipF+XPH6ikY=;
        b=jEk6jaVlEMeFXkcT/W4xhGSHmLJlAdML+cwGEcRLXqoIbJCxEFLzjxoijL59no9Nd+yXyf
        UjGF0/wFn9qRvivU/eb7RJoAM/vNAHvy9z0lvbzpVdrY07RxbV8Eyk2oMTOPOwRZ1SurFg
        eF0ZpQJpNpIntyF11K4sQCouKaCz32M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-E2aV6lvOPiaWYSLYIFb9IA-1; Thu, 19 Aug 2021 04:48:44 -0400
X-MC-Unique: E2aV6lvOPiaWYSLYIFb9IA-1
Received: by mail-ed1-f70.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so2479522edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsSd1bot3DME93pxd8YXHXKyar3E/IXKipF+XPH6ikY=;
        b=fQJIhkKMKBnWigUid4xudV+Kg1CTqd8ISGbln/YIMunPokFnv/gLuhM0NYye5I3/10
         zTG5+ednvn98kxOnoLj7skrogPiuJrvihmDbxZ2FbHAJ4nKj++O1QpuhjuozJRnZ2Csv
         QSlTfVVvQkXiljcZT392RrP7hpdSuZ8iy34OC3mcbs4vmLmQCu5tKkYwUk2ewKVLkvCH
         ozoWjmY9ETSc5tXEWRHuFZo6OT2L+XSRzrtSu5v+eQjHZGRonyuUaCmVTO0rt3PHWmoS
         GkTrYU+c/Crn0ldOobcJFoXJslOWNWeWV/HtAXiPrWNzeUWd+y+Y2jpt6MD8OOLlbLS5
         qOUA==
X-Gm-Message-State: AOAM532wjFUMH4vqw+2+Ba+NXlmTeKlDthiXnmPzG7Xw76m7qFeu63Qp
        W9K5eZQlchWi7CTEaSIHj9dImTXjQNo16NnwFz0Sw2t6KZwBd+IdTTRKiud+unQSn8V4mUiZiRO
        u7RZTQFT+I/PwLDHHu1GPG5y8
X-Received: by 2002:a17:907:7896:: with SMTP id ku22mr15092098ejc.166.1629362923103;
        Thu, 19 Aug 2021 01:48:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwBEn7v5zF6AJGnuPgb4biohFVw3Pg7V7dDmt35hStvvUP+WhWtKexsBxJE/5+W1tTw4dq1Q==
X-Received: by 2002:a17:907:7896:: with SMTP id ku22mr15092069ejc.166.1629362922877;
        Thu, 19 Aug 2021 01:48:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g23sm964270ejm.26.2021.08.19.01.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:48:42 -0700 (PDT)
Subject: Re: [PATCH v3 06/20] platform/x86: intel_scu: Move to intel
 sub-directory
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
 <20210819033001.20136-7-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77b2cc07-6883-df05-67cd-e98a1123806f@redhat.com>
Date:   Thu, 19 Aug 2021 10:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819033001.20136-7-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 5:29 AM, Kate Hsuan wrote:
> Move intel_scu to intel sub-directory to improve readability.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/Kconfig                  | 46 ----------------
>  drivers/platform/x86/Makefile                 |  6 +--
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  6 +++
>  drivers/platform/x86/intel/scu/Kconfig        | 52 +++++++++++++++++++
>  drivers/platform/x86/intel/scu/Makefile       | 13 +++++
>  .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |  0
>  .../scu/ipcutil.c}                            |  0
>  .../scu/pcidrv.c}                             |  0
>  .../scu/pltdrv.c}                             |  0
>  .../x86/{intel_scu_wdt.c => intel/scu/wdt.c}  |  0
>  11 files changed, 73 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/scu/Kconfig
>  create mode 100644 drivers/platform/x86/intel/scu/Makefile
>  rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (100%)
>  rename drivers/platform/x86/{intel_scu_ipcutil.c => intel/scu/ipcutil.c} (100%)
>  rename drivers/platform/x86/{intel_scu_pcidrv.c => intel/scu/pcidrv.c} (100%)
>  rename drivers/platform/x86/{intel_scu_pltdrv.c => intel/scu/pltdrv.c} (100%)
>  rename drivers/platform/x86/{intel_scu_wdt.c => intel/scu/wdt.c} (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 79b6e0abc2ab..baad2c2bdf5f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1158,52 +1158,6 @@ config INTEL_UNCORE_FREQ_CONTROL
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel-uncore-frequency.
>  
> -config INTEL_SCU_IPC
> -	bool
> -
> -config INTEL_SCU
> -	bool
> -	select INTEL_SCU_IPC
> -
> -config INTEL_SCU_PCI
> -	bool "Intel SCU PCI driver"
> -	depends on PCI
> -	select INTEL_SCU
> -	help
> -	  This driver is used to bridge the communications between kernel
> -	  and SCU on some embedded Intel x86 platforms. It also creates
> -	  devices that are connected to the SoC through the SCU.
> -	  Platforms supported:
> -	    Medfield
> -	    Clovertrail
> -	    Merrifield
> -	    Broxton
> -	    Apollo Lake
> -
> -config INTEL_SCU_PLATFORM
> -	tristate "Intel SCU platform driver"
> -	depends on ACPI
> -	select INTEL_SCU
> -	help
> -	  This driver is used to bridge the communications between kernel
> -	  and SCU (sometimes called PMC as well). The driver currently
> -	  supports Intel Elkhart Lake and compatible platforms.
> -
> -config INTEL_SCU_WDT
> -	bool
> -	default INTEL_SCU_PCI
> -	depends on INTEL_MID_WATCHDOG
> -	help
> -	  This is a specific platform code to instantiate watchdog device
> -	  on ACPI-based Intel MID platforms.
> -
> -config INTEL_SCU_IPC_UTIL
> -	tristate "Intel SCU IPC utility driver"
> -	depends on INTEL_SCU
> -	help
> -	  The IPC Util driver provides an interface with the SCU enabling
> -	  low level access for debug work and updating the firmware. Say
> -	  N unless you will be doing this on an Intel MID platform.
>  
>  config INTEL_TELEMETRY
>  	tristate "Intel SoC Telemetry Driver"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 37ad6a436dda..e6667008fc56 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -128,11 +128,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
>  
>  # Intel PMIC / PMC / P-Unit devices
>  
> -obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
> -obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
> -obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
> -obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
> -obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
> +
>  obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
>  					   intel_telemetry_pltdrv.o \
>  					   intel_telemetry_debugfs.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index e59ff836b592..7ad715f65c01 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -59,5 +59,6 @@ config INTEL_PUNIT_IPC
>  	  which is used to bridge the communications between kernel and P-Unit.
>  
>  source "drivers/platform/x86/intel/pmc/Kconfig"
> +source "drivers/platform/x86/intel/scu/Kconfig"
>  
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index 1f343ee7c9b4..71ae5db00864 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -18,3 +18,9 @@ obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
>  intel_punit_ipc-y			:= punit_ipc.o
>  obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
>  obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
> +obj-$(CONFIG_INTEL_SCU_IPC)		+= scu/
> +obj-$(CONFIG_INTEL_SCU_PCI)		+= scu/
> +obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
> +obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
> +obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/

This will cause make to dive into the scu subdir multiple times.

All CONFIG_INTEL_SCU* symbols either select or depend on CONFIG_INTEL_SCU, so we
can dive into the subdir only once based on this.

Also the Makefile line for diving into subdirs should be kept together.

I'll fix both up while merging the series there is no need for
a new version.

Regards,

Hans





> +
> diff --git a/drivers/platform/x86/intel/scu/Kconfig b/drivers/platform/x86/intel/scu/Kconfig
> new file mode 100644
> index 000000000000..9e9910ef5349
> --- /dev/null
> +++ b/drivers/platform/x86/intel/scu/Kconfig
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for drivers/platform/x86/intel
> +# Intel x86 Platform-Specific Drivers
> +#
> +
> +config INTEL_SCU_IPC
> +	bool
> +
> +config INTEL_SCU
> +	bool
> +	select INTEL_SCU_IPC
> +
> +config INTEL_SCU_PCI
> +	bool "Intel SCU PCI driver"
> +	depends on PCI
> +	select INTEL_SCU
> +	help
> +	  This driver is used to bridge the communications between kernel
> +	  and SCU on some embedded Intel x86 platforms. It also creates
> +	  devices that are connected to the SoC through the SCU.
> +	  Platforms supported:
> +	    Medfield
> +	    Clovertrail
> +	    Merrifield
> +	    Broxton
> +	    Apollo Lake
> +
> +config INTEL_SCU_PLATFORM
> +	tristate "Intel SCU platform driver"
> +	depends on ACPI
> +	select INTEL_SCU
> +	help
> +	  This driver is used to bridge the communications between kernel
> +	  and SCU (sometimes called PMC as well). The driver currently
> +	  supports Intel Elkhart Lake and compatible platforms.
> +
> +config INTEL_SCU_WDT
> +	bool
> +	default INTEL_SCU_PCI
> +	depends on INTEL_MID_WATCHDOG
> +	help
> +	  This is a specific platform code to instantiate watchdog device
> +	  on ACPI-based Intel MID platforms.
> +
> +config INTEL_SCU_IPC_UTIL
> +	tristate "Intel SCU IPC utility driver"
> +	depends on INTEL_SCU
> +	help
> +	  The IPC Util driver provides an interface with the SCU enabling
> +	  low level access for debug work and updating the firmware. Say
> +	  N unless you will be doing this on an Intel MID platform.
> diff --git a/drivers/platform/x86/intel/scu/Makefile b/drivers/platform/x86/intel/scu/Makefile
> new file mode 100644
> index 000000000000..27af4ba3be89
> --- /dev/null
> +++ b/drivers/platform/x86/intel/scu/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for drivers/platform/x86/intel
> +# Intel x86 Platform-Specific Drivers
> +#
> +
> +obj-$(CONFIG_INTEL_SCU_IPC)		+= ipc.o
> +obj-$(CONFIG_INTEL_SCU_PCI)		+= pcidrv.o
> +obj-$(CONFIG_INTEL_SCU_WDT)		+= wdt.o
> +intel_scu_pltdrv-y			:= pltdrv.o
> +obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
> +intel_scu_ipcutil-y			:= ipcutil.o
> +obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel/scu/ipc.c
> similarity index 100%
> rename from drivers/platform/x86/intel_scu_ipc.c
> rename to drivers/platform/x86/intel/scu/ipc.c
> diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel/scu/ipcutil.c
> similarity index 100%
> rename from drivers/platform/x86/intel_scu_ipcutil.c
> rename to drivers/platform/x86/intel/scu/ipcutil.c
> diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel/scu/pcidrv.c
> similarity index 100%
> rename from drivers/platform/x86/intel_scu_pcidrv.c
> rename to drivers/platform/x86/intel/scu/pcidrv.c
> diff --git a/drivers/platform/x86/intel_scu_pltdrv.c b/drivers/platform/x86/intel/scu/pltdrv.c
> similarity index 100%
> rename from drivers/platform/x86/intel_scu_pltdrv.c
> rename to drivers/platform/x86/intel/scu/pltdrv.c
> diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel/scu/wdt.c
> similarity index 100%
> rename from drivers/platform/x86/intel_scu_wdt.c
> rename to drivers/platform/x86/intel/scu/wdt.c
> 


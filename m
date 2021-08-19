Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426273F1547
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhHSIif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232467AbhHSIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629362276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sz0NgiSgU+Z4nktzfIXkPz0Dp7P4RXuvtmVDyU4WmU8=;
        b=JMj9OJZBLHurXxqW9L94l8HNvGU/DfU8Dg9j02ndd3c/38QUywRTqh2DYiQqArjJB+fLOk
        CLr4jATsyYPIB/0sauP7t/Qgj32dlRF05YNVdDpQwPv1PSdl+lpKKQ7zL5erf/2HLa52UH
        jyjA++1GJnQkQno660sKko+vpDXSeeE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Rd9ejO97PQWWFZTozt-GiA-1; Thu, 19 Aug 2021 04:37:54 -0400
X-MC-Unique: Rd9ejO97PQWWFZTozt-GiA-1
Received: by mail-ed1-f71.google.com with SMTP id j15-20020aa7c40f0000b02903be5fbe68a9so2468496edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sz0NgiSgU+Z4nktzfIXkPz0Dp7P4RXuvtmVDyU4WmU8=;
        b=sNuD4bUpgt/cn7S8+roxi/0XBJJkGfX0zkTi8yycGOggSicUkMAi8B0tdInfABOHjX
         nLFlKtjussE039RDpr3jOmqqJD2Uq9dUQ/xFewJfLCSi+uqdCcEo1CZ3Dcx2yEdZM8bN
         gtJBK/37W5FpnaYYs0qbMcnPhnyyc4H6mRLLU0LtMU82xHxdqNE0PMkfBqvQodoOhTpM
         qm0Dk0IPUX47GW+xENab4L7x58SY465RYMH1Nwr95Qjvptl/E3FMJ8r/td9bPPvqhJ11
         V7oALCmk1DxMoBU0aXxFIkXn3TDtu2ebxqq6JdzTZ/1surh1TXoRhxt+ppXuozQWSJDk
         /itw==
X-Gm-Message-State: AOAM532onai5OAptJRm32OwLBH7YmP3jtO0voZzUgxAksDu7bSUtfe6P
        x4Ts0cx8S+hcKgO21RfQOYrXjH3B1W5bZ3PJkn0O7Ial82PdRK6a3QmtMXn6f/5Y0ttVqr4nMAA
        11fWyuWweKyjrGEScVJa3V+uZ
X-Received: by 2002:a17:906:5306:: with SMTP id h6mr14379086ejo.248.1629362273767;
        Thu, 19 Aug 2021 01:37:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX8Qn7QL1l8AxChiZJBh5dZ54BL4lTZVS7SNV51he/yI1vgqN3ESle8/jDESsrhr6m/C1olA==
X-Received: by 2002:a17:906:5306:: with SMTP id h6mr14379072ejo.248.1629362273600;
        Thu, 19 Aug 2021 01:37:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b8sm1313079edv.96.2021.08.19.01.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:37:52 -0700 (PDT)
Subject: Re: [PATCH v3 05/20] platform/x86: intel_pmc_core: Move to intel
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
 <20210819033001.20136-6-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fdab924d-e318-9f8b-d651-ab348db2a7d1@redhat.com>
Date:   Thu, 19 Aug 2021 10:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819033001.20136-6-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 5:29 AM, Kate Hsuan wrote:
> Move intel_pmc_core to intel sub-directory
> to improve readability.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/platform/x86/Kconfig                  | 21 ---------------
>  drivers/platform/x86/Makefile                 |  2 --
>  drivers/platform/x86/intel/Kconfig            |  2 ++
>  drivers/platform/x86/intel/Makefile           |  1 +
>  drivers/platform/x86/intel/pmc/Kconfig        | 26 +++++++++++++++++++
>  drivers/platform/x86/intel/pmc/Makefile       |  9 +++++++
>  .../x86/{ => intel/pmc}/intel_pmc_core.h      |  0
>  .../pmc/pmc_core.c}                           |  0
>  .../pmc/pmc_core_pltdrv.c}                    |  0
>  9 files changed, 38 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (100%)
>  rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/pmc_core.c} (100%)
>  rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pmc_core_pltdrv.c} (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 019a625f1fa3..79b6e0abc2ab 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1158,27 +1158,6 @@ config INTEL_UNCORE_FREQ_CONTROL
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel-uncore-frequency.
>  
> -config INTEL_PMC_CORE
> -	tristate "Intel PMC Core driver"
> -	depends on PCI
> -	depends on ACPI
> -	help
> -	  The Intel Platform Controller Hub for Intel Core SoCs provides access
> -	  to Power Management Controller registers via various interfaces. This
> -	  driver can utilize debugging capabilities and supported features as
> -	  exposed by the Power Management Controller. It also may perform some
> -	  tasks in the PMC in order to enable transition into the SLPS0 state.
> -	  It should be selected on all Intel platforms supported by the driver.
> -
> -	  Supported features:
> -		- SLP_S0_RESIDENCY counter
> -		- PCH IP Power Gating status
> -		- LTR Ignore / LTR Show
> -		- MPHY/PLL gating status (Sunrisepoint PCH only)
> -		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
> -		- Low Power Mode registers (Tigerlake and beyond)
> -		- PMC quirks as needed to enable SLPS0/S0ix
> -
>  config INTEL_SCU_IPC
>  	bool
>  
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 344d7a4a33f0..37ad6a436dda 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -128,8 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
>  
>  # Intel PMIC / PMC / P-Unit devices
>  
> -obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
> -
>  obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
>  obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
>  obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index 78314ca39786..e59ff836b592 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -58,4 +58,6 @@ config INTEL_PUNIT_IPC
>  	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
>  	  which is used to bridge the communications between kernel and P-Unit.
>  
> +source "drivers/platform/x86/intel/pmc/Kconfig"
> +
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index a9aa5e15e8bd..1f343ee7c9b4 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -17,3 +17,4 @@ intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
>  obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
>  intel_punit_ipc-y			:= punit_ipc.o
>  obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
> +obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/

Please keep the Makefile line for diving into subdirs together at the top.

> diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
> new file mode 100644
> index 000000000000..d44a3e34210f
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmc/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/x86
> +# x86 Platform-Specific Drivers
> +#
> +
> +config INTEL_PMC_CORE
> +	tristate "Intel PMC Core driver"
> +	depends on PCI
> +	depends on ACPI
> +	help
> +	  The Intel Platform Controller Hub for Intel Core SoCs provides access
> +	  to Power Management Controller registers via various interfaces. This
> +	  driver can utilize debugging capabilities and supported features as
> +	  exposed by the Power Management Controller. It also may perform some
> +	  tasks in the PMC in order to enable transition into the SLPS0 state.
> +	  It should be selected on all Intel platforms supported by the driver.
> +
> +	  Supported features:
> +		- SLP_S0_RESIDENCY counter
> +		- PCH IP Power Gating status
> +		- LTR Ignore / LTR Show
> +		- MPHY/PLL gating status (Sunrisepoint PCH only)
> +		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
> +		- Low Power Mode registers (Tigerlake and beyond)
> +		- PMC quirks as needed to enable SLPS0/S0ix
> diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
> new file mode 100644
> index 000000000000..db305c9e5f37
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmc/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/x86
> +# x86 Platform-Specific Drivers
> +#
> +
> +intel_pmc_core-y			:= pmc_core.o
> +intel_pmc_core_pltdrv-y			:= pmc_core_pltdrv.o
> +obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o intel_pmc_core.o
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel/pmc/intel_pmc_core.h
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core.h
> rename to drivers/platform/x86/intel/pmc/intel_pmc_core.h

You did not drop the intel prefix on the intel_pmc_core.h file.

I'll fix both up while merging the series there is no need for
a new version.

Regards,

Hans


> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/pmc_core.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core.c
> rename to drivers/platform/x86/intel/pmc/pmc_core.c
> diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel/pmc/pmc_core_pltdrv.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
> rename to drivers/platform/x86/intel/pmc/pmc_core_pltdrv.c
> 


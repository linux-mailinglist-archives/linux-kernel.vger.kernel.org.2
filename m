Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721743E7DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhHJQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:52:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:30178 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHJQwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:52:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="194533719"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="194533719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 09:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="439352106"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2021 09:51:52 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 76BE7580922;
        Tue, 10 Aug 2021 09:51:52 -0700 (PDT)
Message-ID: <f6aba0db06b375f2df18934241deaad5b926ac4a.camel@linux.intel.com>
Subject: Re: [PATCH 07/20] Move Intel PMT driver of pdx86 to intel/ to
 improve readability.
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org
Date:   Tue, 10 Aug 2021 09:51:52 -0700
In-Reply-To: <20210810095832.4234-8-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
         <20210810095832.4234-8-hpa@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-10 at 17:58 +0800, Kate Hsuan wrote:
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Already done for these drivers in pdx86 for-next. Thanks.

> ---
>  drivers/platform/x86/Makefile                 |  4 +-
>  drivers/platform/x86/intel/Kconfig            |  2 +
>  drivers/platform/x86/intel/Makefile           |  3 ++
>  drivers/platform/x86/intel/pmt/Kconfig        | 41
> +++++++++++++++++++
>  drivers/platform/x86/intel/pmt/Makefile       |  9 ++++
>  .../x86/{ => intel/pmt}/intel_pmt_class.c     |  0
>  .../x86/{ => intel/pmt}/intel_pmt_class.h     |  0
>  .../x86/{ => intel/pmt}/intel_pmt_crashlog.c  |  0
>  .../x86/{ => intel/pmt}/intel_pmt_telemetry.c |  0
>  9 files changed, 56 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmt/Makefile
>  rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.c (100%)
>  rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.h (100%)
>  rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_crashlog.c
> (100%)
>  rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_telemetry.c
> (100%)
> 
> diff --git a/drivers/platform/x86/Makefile
> b/drivers/platform/x86/Makefile
> index 30771dd51a84..1310b1ebc3f0 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -123,9 +123,7 @@ obj-
> $(CONFIG_INTEL_UNCORE_FREQ_CONTROL)             += intel-uncore-
> frequency.o
>  # Intel PMIC / PMC / P-Unit devices
>  
>  
> -obj-$(CONFIG_INTEL_PMT_CLASS)          += intel_pmt_class.o
> -obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += intel_pmt_telemetry.o
> -obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += intel_pmt_crashlog.o
> +
>  obj-$(CONFIG_INTEL_PUNIT_IPC)          += intel_punit_ipc.o
>  obj-$(CONFIG_INTEL_SCU_IPC)            += intel_scu_ipc.o
>  obj-$(CONFIG_INTEL_SCU_PCI)            += intel_scu_pcidrv.o
> diff --git a/drivers/platform/x86/intel/Kconfig
> b/drivers/platform/x86/intel/Kconfig
> index 2565b676b911..38bfca25940d 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -25,5 +25,7 @@ source "drivers/platform/x86/intel/bxtwc/Kconfig"
>  source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
>  source "drivers/platform/x86/intel/mrfld/Kconfig"
>  source "drivers/platform/x86/intel/pmc_core/Kconfig"
> +source "drivers/platform/x86/intel/pmt/Kconfig"
> +
>  
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile
> b/drivers/platform/x86/intel/Makefile
> index 7a9faf15bfb9..746bee1db055 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -18,3 +18,6 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)    += bxtwc/
>  obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)    += chtdc_ti/
>  obj-$(CONFIG_INTEL_MRFLD_PWRBTN)       += mrfld/
>  obj-$(CONFIG_INTEL_PMC_CORE)           += pmc_core/
> +obj-$(CONFIG_INTEL_PMT_CLASS)          += pmt/
> +obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += pmt/
> +obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += pmt/
> diff --git a/drivers/platform/x86/intel/pmt/Kconfig
> b/drivers/platform/x86/intel/pmt/Kconfig
> new file mode 100644
> index 000000000000..1a5f0fa789e0
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmt/Kconfig
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +config INTEL_PMT_CLASS
> +       tristate
> +       help
> +         The Intel Platform Monitoring Technology (PMT) class driver
> provides
> +         the basic sysfs interface and file hierarchy used by PMT
> devices.
> +
> +         For more information, see:
> +         <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> +
> +         To compile this driver as a module, choose M here: the
> module
> +         will be called intel_pmt_class.
> +
> +config INTEL_PMT_TELEMETRY
> +       tristate "Intel Platform Monitoring Technology (PMT)
> Telemetry driver"
> +       depends on MFD_INTEL_PMT
> +       select INTEL_PMT_CLASS
> +       help
> +         The Intel Platform Monitory Technology (PMT) Telemetry
> driver provides
> +         access to hardware telemetry metrics on devices that
> support the
> +         feature.
> +
> +         To compile this driver as a module, choose M here: the
> module
> +         will be called intel_pmt_telemetry.
> +
> +config INTEL_PMT_CRASHLOG
> +       tristate "Intel Platform Monitoring Technology (PMT) Crashlog
> driver"
> +       depends on MFD_INTEL_PMT
> +       select INTEL_PMT_CLASS
> +       help
> +         The Intel Platform Monitoring Technology (PMT) crashlog
> driver provides
> +         access to hardware crashlog capabilities on devices that
> support the
> +         feature.
> +
> +         To compile this driver as a module, choose M here: the
> module
> +         will be called intel_pmt_crashlog.
> +
> diff --git a/drivers/platform/x86/intel/pmt/Makefile
> b/drivers/platform/x86/intel/pmt/Makefile
> new file mode 100644
> index 000000000000..b41f52e09f27
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmt/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +
> +obj-$(CONFIG_INTEL_PMT_CLASS)          += intel_pmt_class.o
> +obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += intel_pmt_telemetry.o
> +obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += intel_pmt_crashlog.o
> diff --git a/drivers/platform/x86/intel_pmt_class.c
> b/drivers/platform/x86/intel/pmt/intel_pmt_class.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmt_class.c
> rename to drivers/platform/x86/intel/pmt/intel_pmt_class.c
> diff --git a/drivers/platform/x86/intel_pmt_class.h
> b/drivers/platform/x86/intel/pmt/intel_pmt_class.h
> similarity index 100%
> rename from drivers/platform/x86/intel_pmt_class.h
> rename to drivers/platform/x86/intel/pmt/intel_pmt_class.h
> diff --git a/drivers/platform/x86/intel_pmt_crashlog.c
> b/drivers/platform/x86/intel/pmt/intel_pmt_crashlog.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmt_crashlog.c
> rename to drivers/platform/x86/intel/pmt/intel_pmt_crashlog.c
> diff --git a/drivers/platform/x86/intel_pmt_telemetry.c
> b/drivers/platform/x86/intel/pmt/intel_pmt_telemetry.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmt_telemetry.c
> rename to drivers/platform/x86/intel/pmt/intel_pmt_telemetry.c



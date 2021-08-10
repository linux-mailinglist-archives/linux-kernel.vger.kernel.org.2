Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2DE3E7DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhHJQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:56:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:5575 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhHJQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:55:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="211836517"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="211836517"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 09:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="675072191"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2021 09:55:02 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 2ADBB580922;
        Tue, 10 Aug 2021 09:55:02 -0700 (PDT)
Message-ID: <eb2f2024e0f58cffab76d6551eec499420196617.camel@linux.intel.com>
Subject: Re: [PATCH 08/20] Move Intel P-Unit of pdx86 to intel/ directory to
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
Date:   Tue, 10 Aug 2021 09:55:02 -0700
In-Reply-To: <20210810095832.4234-9-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
         <20210810095832.4234-9-hpa@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2021-08-10 at 17:58 +0800, Kate Hsuan wrote:
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/platform/x86/Kconfig                  | 43 -----------------
> --
>  drivers/platform/x86/Makefile                 |  2 +-
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  1 +
>  drivers/platform/x86/intel/punit/Kconfig      | 10 +++++
>  drivers/platform/x86/intel/punit/Makefile     |  6 +++
>  .../x86/{ => intel/punit}/intel_punit_ipc.c   |  0
>  7 files changed, 19 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/punit/Kconfig
>  create mode 100644 drivers/platform/x86/intel/punit/Makefile
>  rename drivers/platform/x86/{ => intel/punit}/intel_punit_ipc.c
> (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig
> b/drivers/platform/x86/Kconfig
> index b9a324ba17e3..00fa213e9adb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1086,49 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
>           will be called intel-uncore-frequency.
>  
>  
> -
> -config INTEL_PMT_CLASS
> -       tristate
> -       help
> -         The Intel Platform Monitoring Technology (PMT) class driver
> provides
> -         the basic sysfs interface and file hierarchy used by PMT
> devices.
> -
> -         For more information, see:
> -         <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> -
> -         To compile this driver as a module, choose M here: the
> module
> -         will be called intel_pmt_class.
> -
> -config INTEL_PMT_TELEMETRY
> -       tristate "Intel Platform Monitoring Technology (PMT)
> Telemetry driver"
> -       depends on MFD_INTEL_PMT
> -       select INTEL_PMT_CLASS
> -       help
> -         The Intel Platform Monitory Technology (PMT) Telemetry
> driver provides
> -         access to hardware telemetry metrics on devices that
> support the
> -         feature.
> -
> -         To compile this driver as a module, choose M here: the
> module
> -         will be called intel_pmt_telemetry.
> -
> -config INTEL_PMT_CRASHLOG
> -       tristate "Intel Platform Monitoring Technology (PMT) Crashlog
> driver"
> -       depends on MFD_INTEL_PMT
> -       select INTEL_PMT_CLASS
> -       help
> -         The Intel Platform Monitoring Technology (PMT) crashlog
> driver provides
> -         access to hardware crashlog capabilities on devices that
> support the
> -         feature.
> -
> -         To compile this driver as a module, choose M here: the
> module
> -         will be called intel_pmt_crashlog.
> -

Accidentally caught the above configs not part of P-Unit IPC driver.

> -config INTEL_PUNIT_IPC
> -       tristate "Intel P-Unit IPC Driver"
> -       help
> -         This driver provides support for Intel P-Unit Mailbox IPC
> mechanism,
> -         which is used to bridge the communications between kernel
> and P-Unit.
> -
>  config INTEL_SCU_IPC
>         bool
>  
> diff --git a/drivers/platform/x86/Makefile
> b/drivers/platform/x86/Makefile
> index 1310b1ebc3f0..dbb62085e7f9 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -124,7 +124,7 @@ obj-
> $(CONFIG_INTEL_UNCORE_FREQ_CONTROL)             += intel-uncore-
> frequency.o
>  
>  
>  
> -obj-$(CONFIG_INTEL_PUNIT_IPC)          += intel_punit_ipc.o
> +
>  obj-$(CONFIG_INTEL_SCU_IPC)            += intel_scu_ipc.o
>  obj-$(CONFIG_INTEL_SCU_PCI)            += intel_scu_pcidrv.o
>  obj-$(CONFIG_INTEL_SCU_PLATFORM)       += intel_scu_pltdrv.o
> diff --git a/drivers/platform/x86/intel/Kconfig
> b/drivers/platform/x86/intel/Kconfig
> index 38bfca25940d..189a34226fe0 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -26,6 +26,7 @@ source
> "drivers/platform/x86/intel/chtdc_ti/Kconfig"
>  source "drivers/platform/x86/intel/mrfld/Kconfig"
>  source "drivers/platform/x86/intel/pmc_core/Kconfig"
>  source "drivers/platform/x86/intel/pmt/Kconfig"
> +source "drivers/platform/x86/intel/punit/Kconfig"
>  
>  
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile
> b/drivers/platform/x86/intel/Makefile
> index 746bee1db055..9bd49a920900 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_INTEL_PMC_CORE)          += pmc_core/
>  obj-$(CONFIG_INTEL_PMT_CLASS)          += pmt/
>  obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += pmt/
>  obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += pmt/
> +obj-$(CONFIG_INTEL_PUNIT_IPC)          += punit/
> diff --git a/drivers/platform/x86/intel/punit/Kconfig
> b/drivers/platform/x86/intel/punit/Kconfig
> new file mode 100644
> index 000000000000..db56ef3bb086
> --- /dev/null
> +++ b/drivers/platform/x86/intel/punit/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# X86 Platform Specific Drivers
> +#
> +
> +config INTEL_PUNIT_IPC
> +       tristate "Intel P-Unit IPC Driver"
> +       help
> +         This driver provides support for Intel P-Unit Mailbox IPC
> mechanism,
> +         which is used to bridge the communications between kernel
> and P-Unit.
> diff --git a/drivers/platform/x86/intel/punit/Makefile
> b/drivers/platform/x86/intel/punit/Makefile
> new file mode 100644
> index 000000000000..f25284806f63
> --- /dev/null
> +++ b/drivers/platform/x86/intel/punit/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# X86 Platform Specific Drivers
> +#
> +
> +obj-$(CONFIG_INTEL_PUNIT_IPC)          += intel_punit_ipc.o
> \ No newline at end of file
> diff --git a/drivers/platform/x86/intel_punit_ipc.c
> b/drivers/platform/x86/intel/punit/intel_punit_ipc.c
> similarity index 100%
> rename from drivers/platform/x86/intel_punit_ipc.c
> rename to drivers/platform/x86/intel/punit/intel_punit_ipc.c



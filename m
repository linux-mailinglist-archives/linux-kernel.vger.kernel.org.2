Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067E3EDEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhHPUch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:32:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:25459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhHPUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:32:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="279678247"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="279678247"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 13:32:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="505074119"
Received: from xzhu13-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.7.115])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 13:32:04 -0700
Date:   Mon, 16 Aug 2021 13:32:04 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Subject: Re: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Message-ID: <20210816203204.a35yvbuuhjxjbjcw@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <cover.1626459866.git.gayatri.kammela@intel.com>
 <b2cb6b10b75445acceab3030c3a9aa585e7c7b65.1626459866.git.gayatri.kammela@intel.com>
 <20210816173738.oxndqtq6uaql7sz7@ldmartin-desk2>
 <MW3PR11MB45230D40F51FAB5C5A4E0FCBF2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45230D40F51FAB5C5A4E0FCBF2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:23:21PM -0700, Kammela, Gayatri wrote:
>> -----Original Message-----
>> From: De Marchi, Lucas <lucas.demarchi@intel.com>
>> Sent: Monday, August 16, 2021 10:38 AM
>> To: Kammela, Gayatri <gayatri.kammela@intel.com>
>> Cc: platform-driver-x86@vger.kernel.org; mgross@linux.intel.com;
>> hdegoede@redhat.com; irenic.rajneesh@gmail.com;
>> andriy.shevchenko@linux.intel.com; vicamo.yang@canonical.com;
>> Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; Box, David E
>> <david.e.box@intel.com>; linux-kernel@vger.kernel.org; Mashiah, Tamar
>> <tamar.mashiah@intel.com>; gregkh@linuxfoundation.org;
>> rajatja@google.com; Shyam-sundar.S-k@amd.com;
>> Alexander.Deucher@amd.com; mlimonci@amd.com; Andy Shevchenko
>> <andy.shevchenko@gmail.com>
>> Subject: Re: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move
>> intel_pmc_core* files to pmc subfolder
>>
>> On Fri, Jul 16, 2021 at 11:38:33AM -0700, Gayatri Kammela wrote:
>> >As part of collecting Intel x86 specific drivers in their own folder,
>> >move intel_pmc_core* files to its own subfolder there.
>> >
>> >Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> >Cc: David Box <david.e.box@intel.com>
>> >Cc: You-Sheng Yang <vicamo.yang@canonical.com>
>> >Cc: Hans de Goede <hdegoede@redhat.com>
>> >Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>> >Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
>> >---
>> > MAINTAINERS                                   |  2 +-
>> > drivers/platform/x86/Kconfig                  | 21 ------------------
>> > drivers/platform/x86/Makefile                 |  1 -
>> > drivers/platform/x86/intel/Kconfig            |  1 +
>> > drivers/platform/x86/intel/Makefile           |  1 +
>> > drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
>> > drivers/platform/x86/intel/pmc/Makefile       |  5 +++++
>> > .../{intel_pmc_core.c => intel/pmc/core.c}    |  2 +-
>> > .../{intel_pmc_core.h => intel/pmc/core.h}    |  0
>> > .../pmc/pltdrv.c}                             |  0
>> > 10 files changed, 31 insertions(+), 24 deletions(-)  create mode
>> >100644 drivers/platform/x86/intel/pmc/Kconfig
>> > create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>> > rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c}
>> >(99%)  rename drivers/platform/x86/{intel_pmc_core.h =>
>> >intel/pmc/core.h} (100%)  rename
>> >drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c}
>> >(100%)
>> >
>> >diff --git a/MAINTAINERS b/MAINTAINERS
>> >index 6c8be735cc91..c5d610885bf2 100644
>> >--- a/MAINTAINERS
>> >+++ b/MAINTAINERS
>> >@@ -9477,7 +9477,7 @@ M:     David E Box <david.e.box@intel.com>
>> > L:  platform-driver-x86@vger.kernel.org
>> > S:  Maintained
>> > F:  Documentation/ABI/testing/sysfs-platform-intel-pmc
>> >-F:  drivers/platform/x86/intel_pmc_core*
>> >+F:  drivers/platform/x86/intel/pmc/core*
>> >
>> > INTEL PMIC GPIO DRIVERS
>> > M:  Andy Shevchenko <andy@kernel.org>
>> >diff --git a/drivers/platform/x86/Kconfig
>> >b/drivers/platform/x86/Kconfig index 7d385c3b2239..cae72922f448 100644
>> >--- a/drivers/platform/x86/Kconfig
>> >+++ b/drivers/platform/x86/Kconfig
>> >@@ -1184,27 +1184,6 @@ config INTEL_MRFLD_PWRBTN
>> >       To compile this driver as a module, choose M here: the module
>> >       will be called intel_mrfld_pwrbtn.
>> >
>> >-config INTEL_PMC_CORE
>> >-    tristate "Intel PMC Core driver"
>> >-    depends on PCI
>> >-    depends on ACPI
>> >-    help
>> >-      The Intel Platform Controller Hub for Intel Core SoCs provides
>> access
>> >-      to Power Management Controller registers via various interfaces.
>> This
>> >-      driver can utilize debugging capabilities and supported features as
>> >-      exposed by the Power Management Controller. It also may perform
>> some
>> >-      tasks in the PMC in order to enable transition into the SLPS0 state.
>> >-      It should be selected on all Intel platforms supported by the driver.
>> >-
>> >-      Supported features:
>> >-            - SLP_S0_RESIDENCY counter
>> >-            - PCH IP Power Gating status
>> >-            - LTR Ignore / LTR Show
>> >-            - MPHY/PLL gating status (Sunrisepoint PCH only)
>> >-            - SLPS0 Debug registers (Cannonlake/Icelake PCH)
>> >-            - Low Power Mode registers (Tigerlake and beyond)
>> >-            - PMC quirks as needed to enable SLPS0/S0ix
>> >-
>> > config INTEL_PMT_CLASS
>> >     tristate
>> >     help
>> >diff --git a/drivers/platform/x86/Makefile
>> >b/drivers/platform/x86/Makefile index 7ee369aab10d..43d36f8c36f1
>> 100644
>> >--- a/drivers/platform/x86/Makefile
>> >+++ b/drivers/platform/x86/Makefile
>> >@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)
>>               += intel-uncore-frequency.o
>> > obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)  += intel_bxtwc_tmu.o
>> > obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN) += intel_chtdc_ti_pwrbtn.o
>> > obj-$(CONFIG_INTEL_MRFLD_PWRBTN)    += intel_mrfld_pwrbtn.o
>> >-obj-$(CONFIG_INTEL_PMC_CORE)                += intel_pmc_core.o
>> intel_pmc_core_pltdrv.o
>> > obj-$(CONFIG_INTEL_PMT_CLASS)               += intel_pmt_class.o
>> > obj-$(CONFIG_INTEL_PMT_TELEMETRY)   += intel_pmt_telemetry.o
>> > obj-$(CONFIG_INTEL_PMT_CRASHLOG)    += intel_pmt_crashlog.o
>> >diff --git a/drivers/platform/x86/intel/Kconfig
>> >b/drivers/platform/x86/intel/Kconfig
>> >index f2eef337eb98..8ca021785f67 100644
>> >--- a/drivers/platform/x86/intel/Kconfig
>> >+++ b/drivers/platform/x86/intel/Kconfig
>> >@@ -18,5 +18,6 @@ if X86_PLATFORM_DRIVERS_INTEL
>> >
>> > source "drivers/platform/x86/intel/int33fe/Kconfig"
>> > source "drivers/platform/x86/intel/int3472/Kconfig"
>> >+source "drivers/platform/x86/intel/pmc/Kconfig"
>> >
>> > endif # X86_PLATFORM_DRIVERS_INTEL
>> >diff --git a/drivers/platform/x86/intel/Makefile
>> >b/drivers/platform/x86/intel/Makefile
>> >index 0653055942d5..49962f4dfdec 100644
>> >--- a/drivers/platform/x86/intel/Makefile
>> >+++ b/drivers/platform/x86/intel/Makefile
>> >@@ -6,3 +6,4 @@
>> >
>> > obj-$(CONFIG_INTEL_CHT_INT33FE)             += int33fe/
>> > obj-$(CONFIG_INTEL_SKL_INT3472)             += int3472/
>> >+obj-$(CONFIG_INTEL_PMC_CORE)                += pmc/
>> >diff --git a/drivers/platform/x86/intel/pmc/Kconfig
>> >b/drivers/platform/x86/intel/pmc/Kconfig
>> >new file mode 100644
>> >index 000000000000..b4c955a35674
>> >--- /dev/null
>> >+++ b/drivers/platform/x86/intel/pmc/Kconfig
>> >@@ -0,0 +1,22 @@
>> >+# SPDX-License-Identifier: GPL-2.0-only
>> >+
>> >+config INTEL_PMC_CORE
>> >+    tristate "Intel PMC Core driver"
>> >+    depends on PCI
>> >+    depends on ACPI
>> >+    help
>> >+      The Intel Platform Controller Hub for Intel Core SoCs provides
>> access
>> >+      to Power Management Controller registers via various interfaces.
>> This
>> >+      driver can utilize debugging capabilities and supported features as
>> >+      exposed by the Power Management Controller. It also may perform
>> some
>> >+      tasks in the PMC in order to enable transition into the SLPS0 state.
>> >+      It should be selected on all Intel platforms supported by the driver.
>> >+
>> >+      Supported features:
>> >+            - SLP_S0_RESIDENCY counter
>> >+            - PCH IP Power Gating status
>> >+            - LTR Ignore / LTR Show
>> >+            - MPHY/PLL gating status (Sunrisepoint PCH only)
>> >+            - SLPS0 Debug registers (Cannonlake/Icelake PCH)
>> >+            - Low Power Mode registers (Tigerlake and beyond)
>> >+            - PMC quirks as needed to enable SLPS0/S0ix
>> >diff --git a/drivers/platform/x86/intel/pmc/Makefile
>> >b/drivers/platform/x86/intel/pmc/Makefile
>> >new file mode 100644
>> >index 000000000000..e0182e10a035
>> >--- /dev/null
>> >+++ b/drivers/platform/x86/intel/pmc/Makefile
>> >@@ -0,0 +1,5 @@
>> >+# SPDX-License-Identifier: GPL-2.0
>> >+#
>> >+
>> >+obj-$(CONFIG_INTEL_PMC_CORE)        += core.o
>> >+obj-$(CONFIG_INTEL_PMC_CORE)        += pltdrv.o
>>
>> is the module rename really intentional? If so, it needs to be renamed to
>> something else as just calling it core may conflict with other equally badly
>> named modules.
>Hi Lucas! Yes, the module rename is intentional. Thanks for reporting the issue. This issue has been addressed in V6. I have just sent the V7 https://patchwork.kernel.org/project/platform-driver-x86/list/

ok, thanks! I guess I forgot the -c flag to b4, that correctly
downloads v7:

	b4 am -c b2cb6b10b75445acceab3030c3a9aa585e7c7b65.1626459866.git.gayatri.kammela@intel.com
	...
	New revision: [PATCH v7 0/5] Add Alder Lake PCH-S support to PMC core driver

Lucas De Marchi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238563DEBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhHCLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:33:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:18035 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235329AbhHCLdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:33:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274715825"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="274715825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 04:32:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="511166743"
Received: from jdanieck-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.128.99])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 04:32:43 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v2 00/15] Introduce PECI subsystem
Date:   Tue,  3 Aug 2021 13:31:19 +0200
Message-Id: <20210803113134.2262882-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a second round of patches introducing PECI subsystem.
I don't think it is ready to be applied right away (we're still
missing r-b's), but I hope we have chance to complete discussion in
the 5.15 development cycle. I would appreciate if you could take
a look.

Note: All changes to arch/x86 are contained within patches 01-02, plus
small Kconfig change adding "depends on PECI" to GENERIC_LIB_X86
Kconfig in patch 10.

The Platform Environment Control Interface (PECI) is a communication
interface between Intel processors and management controllers (e.g.
Baseboard Management Controller, BMC).

This series adds a PECI subsystem and introduces drivers which run in
the Linux instance on the management controller (not the main Intel
processor) and is intended to be used by the OpenBMC [1], a Linux
distribution for BMC devices.
The information exposed over PECI (like processor and DIMM
temperature) refers to the Intel processor and can be consumed by
daemons running on the BMC to, for example, display the processor
temperature in its web interface.

The PECI bus is collection of code that provides interface support
between PECI devices (that actually represent processors) and PECI
controllers (such as the "peci-aspeed" controller) that allow to
access physical PECI interface. PECI devices are bound to PECI
drivers that provides access to PECI services. This series introduces
a generic "peci-cpu" driver that exposes hardware monitoring "cputemp"
and "dimmtemp" using the auxiliary bus.

Exposing "raw" PECI to userspace, either to write userspace drivers or
for debug/testing purpose was left out of this series to encourage
writing kernel drivers instead, but may be pursued in the future.

Introducing PECI to upstream Linux was already attempted before [2].
Since it's been over a year since last revision, and the series
changed quite a bit in the meantime, I've decided to start from v1.

I would also like to give credit to everyone who helped me with
different aspects of preliminary review:
- Pierre-Louis Bossart,
- Tony Luck, 
- Andy Shevchenko,
- Dave Hansen.

[1] https://github.com/openbmc/openbmc
[2] https://lore.kernel.org/openbmc/20191211194624.2872-1-jae.hyun.yoo@linux.intel.com/

Changes v1 -> v2:

Biggest changes when it comes to diffstat are locking in HWMON
(I decided to clean things up a bit while adding it), switching to
devres usage in more places and exposing sysfs interface in separate patch.

* Moved extending X86 ARCHITECTURE MAINTAINERS earlier in series (Dan)
* Removed "default n" for GENERIC_LIB_X86 (Dan)
* Added vendor prefix for peci-aspeed specific properties (Rob)
* Refactored PECI to use devres consistently (Dan)
* Added missing sysfs documentation and excluded adding peci-sysfs to
  separate patch (Dan)
* Used module_init() instead of subsys_init() for peci module initialization (Dan)
* Removed redundant struct peci_device member (Dan)
* Improved PECI Kconfig help (Randy/Dan)
* Fixed/removed log messages (Dan, Guenter)
* Refactored peci-cputemp and peci-dimmtemp and added missing locks (Guenter)
* Removed unused dev_set_drvdata() in peci-cputemp and peci-dimmtemp (Guenter)
* Fixed used types, names, fixed broken and added additional comments
  to peci-hwmon (Guenter, Zev)
* Refactored peci-dimmtemp to not return -ETIMEDOUT (Guenter)
* Added sanity check for min_peci_revision in peci-hwmon drivers (Zev)
* Added assert for DIMM_NUMS_MAX and additional warning in peci-dimmtemp (Zev)
* Fixed macro names in peci-aspeed (Zev)
* Refactored peci-aspeed sanitizing properties to a single helper function (Zev)
* Fixed peci_cpu_device_ids definition for Broadwell Xeon D (David)
* Refactor peci_request to use a single allocation (Zev)
* Used min_t() to improve code readability (Zev)
* Added macro for PECI_RDENDPTCFG_MMIO_WR_LEN_BASE and fixed adev type
  array name to more descriptive (Zev)
* Fixed peci-hwmon commit-msg and documentation (Zev)

Thanks
-Iwona

Iwona Winiarska (13):
  x86/cpu: Move intel-family to arch-independent headers
  x86/cpu: Extract cpuid helpers to arch-independent
  dt-bindings: Add generic bindings for PECI
  dt-bindings: Add bindings for peci-aspeed
  ARM: dts: aspeed: Add PECI controller nodes
  peci: Add core infrastructure
  peci: Add device detection
  peci: Add sysfs interface for PECI bus
  peci: Add support for PECI device drivers
  peci: Add peci-cpu driver
  hwmon: peci: Add cputemp driver
  hwmon: peci: Add dimmtemp driver
  docs: Add PECI documentation

Jae Hyun Yoo (2):
  peci: Add peci-aspeed controller driver
  docs: hwmon: Document PECI drivers

 Documentation/ABI/testing/sysfs-bus-peci      |  16 +
 .../devicetree/bindings/peci/peci-aspeed.yaml | 109 ++++
 .../bindings/peci/peci-controller.yaml        |  33 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/peci-cputemp.rst          |  90 +++
 Documentation/hwmon/peci-dimmtemp.rst         |  57 ++
 Documentation/index.rst                       |   1 +
 Documentation/peci/index.rst                  |  16 +
 Documentation/peci/peci.rst                   |  48 ++
 MAINTAINERS                                   |  32 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |  14 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  14 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  14 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/cpu.h                    |   3 -
 arch/x86/include/asm/intel-family.h           | 141 +---
 arch/x86/include/asm/microcode.h              |   2 +-
 arch/x86/kvm/cpuid.h                          |   3 +-
 arch/x86/lib/Makefile                         |   2 +-
 drivers/Kconfig                               |   3 +
 drivers/Makefile                              |   1 +
 drivers/edac/mce_amd.c                        |   3 +-
 drivers/hwmon/Kconfig                         |   2 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/peci/Kconfig                    |  31 +
 drivers/hwmon/peci/Makefile                   |   7 +
 drivers/hwmon/peci/common.h                   |  58 ++
 drivers/hwmon/peci/cputemp.c                  | 591 +++++++++++++++++
 drivers/hwmon/peci/dimmtemp.c                 | 614 ++++++++++++++++++
 drivers/peci/Kconfig                          |  37 ++
 drivers/peci/Makefile                         |  10 +
 drivers/peci/controller/Kconfig               |  16 +
 drivers/peci/controller/Makefile              |   3 +
 drivers/peci/controller/peci-aspeed.c         | 445 +++++++++++++
 drivers/peci/core.c                           | 238 +++++++
 drivers/peci/cpu.c                            | 344 ++++++++++
 drivers/peci/device.c                         | 221 +++++++
 drivers/peci/internal.h                       | 137 ++++
 drivers/peci/request.c                        | 477 ++++++++++++++
 drivers/peci/sysfs.c                          |  82 +++
 include/linux/peci-cpu.h                      |  38 ++
 include/linux/peci.h                          | 110 ++++
 include/linux/x86/cpu.h                       |   9 +
 include/linux/x86/intel-family.h              | 146 +++++
 lib/Kconfig                                   |   4 +
 lib/Makefile                                  |   2 +
 lib/x86/Makefile                              |   3 +
 {arch/x86/lib => lib/x86}/cpu.c               |   2 +-
 48 files changed, 4084 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
 create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
 create mode 100644 Documentation/hwmon/peci-cputemp.rst
 create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst
 create mode 100644 drivers/hwmon/peci/Kconfig
 create mode 100644 drivers/hwmon/peci/Makefile
 create mode 100644 drivers/hwmon/peci/common.h
 create mode 100644 drivers/hwmon/peci/cputemp.c
 create mode 100644 drivers/hwmon/peci/dimmtemp.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/controller/Kconfig
 create mode 100644 drivers/peci/controller/Makefile
 create mode 100644 drivers/peci/controller/peci-aspeed.c
 create mode 100644 drivers/peci/core.c
 create mode 100644 drivers/peci/cpu.c
 create mode 100644 drivers/peci/device.c
 create mode 100644 drivers/peci/internal.h
 create mode 100644 drivers/peci/request.c
 create mode 100644 drivers/peci/sysfs.c
 create mode 100644 include/linux/peci-cpu.h
 create mode 100644 include/linux/peci.h
 create mode 100644 include/linux/x86/cpu.h
 create mode 100644 include/linux/x86/intel-family.h
 create mode 100644 lib/x86/Makefile
 rename {arch/x86/lib => lib/x86}/cpu.c (95%)

-- 
2.31.1


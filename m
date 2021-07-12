Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE373C65EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGLWKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:10:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:57851 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhGLWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:10:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="273894305"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="273894305"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:07:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="492295335"
Received: from jzloch-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.136.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:07:10 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 00/14] Introduce PECI subsystem
Date:   Tue, 13 Jul 2021 00:04:33 +0200
Message-Id: <20210712220447.957418-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: All changes to arch/x86 are contained within patches 01-02.

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

Iwona Winiarska (12):
  x86/cpu: Move intel-family to arch-independent headers
  x86/cpu: Extract cpuid helpers to arch-independent
  dt-bindings: Add generic bindings for PECI
  dt-bindings: Add bindings for peci-aspeed
  ARM: dts: aspeed: Add PECI controller nodes
  peci: Add core infrastructure
  peci: Add device detection
  peci: Add support for PECI device drivers
  peci: Add peci-cpu driver
  hwmon: peci: Add cputemp driver
  hwmon: peci: Add dimmtemp driver
  docs: Add PECI documentation

Jae Hyun Yoo (2):
  peci: Add peci-aspeed controller driver
  docs: hwmon: Document PECI drivers

 .../devicetree/bindings/peci/peci-aspeed.yaml | 111 ++++
 .../bindings/peci/peci-controller.yaml        |  28 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/peci-cputemp.rst          |  93 ++++
 Documentation/hwmon/peci-dimmtemp.rst         |  58 ++
 Documentation/index.rst                       |   1 +
 Documentation/peci/index.rst                  |  16 +
 Documentation/peci/peci.rst                   |  48 ++
 MAINTAINERS                                   |  32 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |  14 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  14 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  14 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/cpu.h                    |   3 -
 arch/x86/include/asm/intel-family.h           | 141 +----
 arch/x86/include/asm/microcode.h              |   2 +-
 arch/x86/kvm/cpuid.h                          |   3 +-
 arch/x86/lib/Makefile                         |   2 +-
 drivers/Kconfig                               |   3 +
 drivers/Makefile                              |   1 +
 drivers/edac/mce_amd.c                        |   3 +-
 drivers/hwmon/Kconfig                         |   2 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/peci/Kconfig                    |  31 ++
 drivers/hwmon/peci/Makefile                   |   7 +
 drivers/hwmon/peci/common.h                   |  46 ++
 drivers/hwmon/peci/cputemp.c                  | 503 +++++++++++++++++
 drivers/hwmon/peci/dimmtemp.c                 | 508 ++++++++++++++++++
 drivers/peci/Kconfig                          |  36 ++
 drivers/peci/Makefile                         |  10 +
 drivers/peci/controller/Kconfig               |  12 +
 drivers/peci/controller/Makefile              |   3 +
 drivers/peci/controller/peci-aspeed.c         | 501 +++++++++++++++++
 drivers/peci/core.c                           | 224 ++++++++
 drivers/peci/cpu.c                            | 347 ++++++++++++
 drivers/peci/device.c                         | 211 ++++++++
 drivers/peci/internal.h                       | 137 +++++
 drivers/peci/request.c                        | 502 +++++++++++++++++
 drivers/peci/sysfs.c                          |  82 +++
 include/linux/peci-cpu.h                      |  38 ++
 include/linux/peci.h                          |  93 ++++
 include/linux/x86/cpu.h                       |   9 +
 include/linux/x86/intel-family.h              | 146 +++++
 lib/Kconfig                                   |   5 +
 lib/Makefile                                  |   2 +
 lib/x86/Makefile                              |   3 +
 {arch/x86/lib => lib/x86}/cpu.c               |   2 +-
 47 files changed, 3902 insertions(+), 149 deletions(-)
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


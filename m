Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC06037F632
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhEMLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:02:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:45133 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhEMLCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:05 -0400
IronPort-SDR: iPd5z1sjoz/NWfFv6woR8ebS86PQm4GSM5diImXJpLW/DSZQs8oXoZ2X3zqvdQT6IY0caXZ/IV
 HO642zwEwDVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048259"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048259"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:54 -0700
IronPort-SDR: VmwV1MGd/rEih1bMybJwDERCCgg8lEtL2TtlG6uU3aPZGLLBrD2m8BTeAqc7x74pIRFERoHXpY
 3DLmRAx+CSNw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625983708"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:52 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
Date:   Thu, 13 May 2021 13:00:26 +0200
Message-Id: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel maintainers,

This submission is a kernel driver to support Intel(R) Gaussian & Neural
Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
available on multiple Intel platforms. AI developers and users can offload
continuous inference workloads to an Intel(R) GNA device in order to free
processor resources and save power. Noise reduction and speech recognition
are the examples of the workloads Intel(R) GNA deals with while its usage
is not limited to the two.

For a list of processors equipped with Intel(R) GNA device, please refer to
this link:
https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_GNA.html

We think contributing this driver to the upstream kernel project is the
best way for developers and users to get the latest Intel(R) GNA support in
a Linux kernel, through the mainline to any Linux distributions installed
on their systems. Upstreaming also enables contribution from developers
around the world to the driver once it is merged.

The driver works with Intel(R) libraries in user space. The Intel(R) driver
exposes a few IOCTL interfaces for use by libraries in user space. The
libraries are open sourced and are available at:
https://github.com/intel/gna

---

Changelogs:

 v1->v2:
 - driver's new layout:
   - driver name: gna -> intel_gna
   - module name: gna -> intel_gna
   - device file name: /dev/gnaN -> /dev/intel_gnaN
   - driver's source directory: drivers/misc/gna/ -> drivers/misc/intel/gna/
   - UAPI: include/uapi/misc/gna.h -> include/uapi/misc/intel/gna.h
   - DOC: Documentation/misc-devices/gna.rst ->
       Documentation/misc-devices/intel/gna.rst
 - 'MISC' device framework used
 - fixes throughout GNA device's PCI management
 - header files' includes and forward declarations cleanup
 - ISR made static
 - unused comments cleanup
 - "_priv_" segment removed from function names
 - tested: v5.11-rc3 -> v5.11
 - number of other/minor fixes

 v2->v3:
 - PCI glue driver part split.
 - GNA probe fail path made fully implicit.
 - 'recovery_timeout' module parameter present under 'CONFIG_DEBUG_INTEL_GNA' flag only.
 - build for X86_32 enabled.
 - module initialization through 'module_pci_driver()'.
 - gna_priv->file_list cleanup.
 - 'gna_' prefix removed from source files' names.
 - power management handling added.
 - tests performed on kernel v5.12
 - number of other/minor fixes

---

Maciej Kwapulinski (4):
  intel_gna: add driver module
  intel_gna: add interrupt handler
  intel_gna: add a 'misc' device
  intel_gna: add power management

Tomasz Jankowski (10):
  intel_gna: add component of hardware operation
  intel_gna: read hardware info in the driver
  intel_gna: add memory handling
  intel_gna: initialize mmu
  intel_gna: add hardware ids
  intel_gna: add request component
  intel_gna: implement scoring
  intel_gna: add a work queue to process scoring requests
  intel_gna: add ioctl handler
  intel_gna: add file operations to a 'misc' device

 Documentation/misc-devices/index.rst          |   1 +
 Documentation/misc-devices/intel/gna.rst      |  48 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/intel/gna/Kbuild                 |   5 +
 drivers/misc/intel/gna/Kconfig                |  13 +
 drivers/misc/intel/gna/device.c               | 350 +++++++++++++
 drivers/misc/intel/gna/device.h               | 106 ++++
 drivers/misc/intel/gna/hw.c                   | 118 +++++
 drivers/misc/intel/gna/hw.h                   | 106 ++++
 drivers/misc/intel/gna/ioctl.c                | 257 ++++++++++
 drivers/misc/intel/gna/ioctl.h                |  11 +
 drivers/misc/intel/gna/mem.c                  | 421 +++++++++++++++
 drivers/misc/intel/gna/mem.h                  | 115 +++++
 drivers/misc/intel/gna/pci.c                  | 149 ++++++
 drivers/misc/intel/gna/pci.h                  |  12 +
 drivers/misc/intel/gna/request.c              | 480 ++++++++++++++++++
 drivers/misc/intel/gna/request.h              |  67 +++
 drivers/misc/intel/gna/score.c                | 291 +++++++++++
 drivers/misc/intel/gna/score.h                |  17 +
 include/uapi/misc/intel/gna.h                 | 153 ++++++
 23 files changed, 2730 insertions(+)
 create mode 100644 Documentation/misc-devices/intel/gna.rst
 create mode 100644 drivers/misc/intel/gna/Kbuild
 create mode 100644 drivers/misc/intel/gna/Kconfig
 create mode 100644 drivers/misc/intel/gna/device.c
 create mode 100644 drivers/misc/intel/gna/device.h
 create mode 100644 drivers/misc/intel/gna/hw.c
 create mode 100644 drivers/misc/intel/gna/hw.h
 create mode 100644 drivers/misc/intel/gna/ioctl.c
 create mode 100644 drivers/misc/intel/gna/ioctl.h
 create mode 100644 drivers/misc/intel/gna/mem.c
 create mode 100644 drivers/misc/intel/gna/mem.h
 create mode 100644 drivers/misc/intel/gna/pci.c
 create mode 100644 drivers/misc/intel/gna/pci.h
 create mode 100644 drivers/misc/intel/gna/request.c
 create mode 100644 drivers/misc/intel/gna/request.h
 create mode 100644 drivers/misc/intel/gna/score.c
 create mode 100644 drivers/misc/intel/gna/score.h
 create mode 100644 include/uapi/misc/intel/gna.h

-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D383480A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhCXSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:17716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237610AbhCXSiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:15 -0400
IronPort-SDR: e83mHhjV3zZjOXyCtjdyXuFMNBa3pSGVdm+HMYCs4NUd3gFsufF8+uSvHrAknDBUbfLIlPLY9Z
 ijYRIpNi5oTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859431"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859431"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:14 -0700
IronPort-SDR: 6AaUuULkHkDixtsgT56jz3ic7ew5kC5JgfR4ptiYINm4RCp9fUPNXDWKFNWeHl/az6QW9MZT/L
 /BxKp0QfWXoQ==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203718"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:12 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: [PATCH v2 00/13] Driver of Intel(R) Gaussian & Neural Accelerator
Date:   Wed, 24 Mar 2021 19:35:57 +0100
Message-Id: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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

---

Maciej Kwapulinski (1):
  intel_gna: add a 'misc' device

Tomasz Jankowski (12):
  intel_gna: add driver module
  intel_gna: add component of hardware operation
  intel_gna: read hardware info in the driver
  intel_gna: add memory handling
  intel_gna: initialize mmu
  intel_gna: add hardware ids
  intel_gna: add request component
  intel_gna: implement scoring
  intel_gna: add a work queue to process scoring requests
  intel_gna: add interrupt handler
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
 drivers/misc/intel/gna/gna_device.c           | 429 ++++++++++++++++
 drivers/misc/intel/gna/gna_device.h           |  89 ++++
 drivers/misc/intel/gna/gna_driver.c           |  43 ++
 drivers/misc/intel/gna/gna_driver.h           |  33 ++
 drivers/misc/intel/gna/gna_hw.c               | 125 +++++
 drivers/misc/intel/gna/gna_hw.h               |  61 +++
 drivers/misc/intel/gna/gna_ioctl.c            | 249 +++++++++
 drivers/misc/intel/gna/gna_ioctl.h            |  11 +
 drivers/misc/intel/gna/gna_mem.c              | 473 ++++++++++++++++++
 drivers/misc/intel/gna/gna_mem.h              | 107 ++++
 drivers/misc/intel/gna/gna_request.c          | 463 +++++++++++++++++
 drivers/misc/intel/gna/gna_request.h          |  62 +++
 drivers/misc/intel/gna/gna_score.c            | 298 +++++++++++
 drivers/misc/intel/gna/gna_score.h            |  18 +
 include/uapi/misc/intel/gna.h                 | 155 ++++++
 23 files changed, 2693 insertions(+)
 create mode 100644 Documentation/misc-devices/intel/gna.rst
 create mode 100644 drivers/misc/intel/gna/Kbuild
 create mode 100644 drivers/misc/intel/gna/Kconfig
 create mode 100644 drivers/misc/intel/gna/gna_device.c
 create mode 100644 drivers/misc/intel/gna/gna_device.h
 create mode 100644 drivers/misc/intel/gna/gna_driver.c
 create mode 100644 drivers/misc/intel/gna/gna_driver.h
 create mode 100644 drivers/misc/intel/gna/gna_hw.c
 create mode 100644 drivers/misc/intel/gna/gna_hw.h
 create mode 100644 drivers/misc/intel/gna/gna_ioctl.c
 create mode 100644 drivers/misc/intel/gna/gna_ioctl.h
 create mode 100644 drivers/misc/intel/gna/gna_mem.c
 create mode 100644 drivers/misc/intel/gna/gna_mem.h
 create mode 100644 drivers/misc/intel/gna/gna_request.c
 create mode 100644 drivers/misc/intel/gna/gna_request.h
 create mode 100644 drivers/misc/intel/gna/gna_score.c
 create mode 100644 drivers/misc/intel/gna/gna_score.h
 create mode 100644 include/uapi/misc/intel/gna.h

-- 
2.28.0


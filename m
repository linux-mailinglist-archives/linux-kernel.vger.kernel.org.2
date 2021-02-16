Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A031CD95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBPQJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:09:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhBPQJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:09:49 -0500
IronPort-SDR: 6rnq8FDP4xCsQRJ2X7HINNgWlCD9uOW89CVIve7oejIX6crBaC7RHPoickIRXI7mjSPVjM6n9E
 vlbhWBe76bfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118365"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:53 -0800
IronPort-SDR: zhYMAY7qLa0tmMp1stdMO+MtcrJm9LbpWWsao7lYXYnqc/ciu8IMeJcvlJuVf7b1RVuRAx7L6a
 rZPll8jtdCJg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336613"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:50 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1 00/12] Driver of Intel(R) Gaussian & Neural Accelerator
Date:   Tue, 16 Feb 2021 17:05:13 +0100
Message-Id: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel maintainers,

This submission is a kernel driver to support Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor available on multiple Intel platforms. AI developers and users can offload continuous inference workloads to an Intel(R) GNA device in order to free processor resources and save power. Noise reduction and speech recognition are the examples of the workloads Intel(R) GNA deals with while its usage is not limited to the two.

For a list of processors equipped with Intel(R) GNA device, please refer to this link:
https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_GNA.html 

We think contributing this driver to the upstream kernel project is the best way for developers and users to get the latest Intel(R) GNA support in a Linux kernel, through the mainline to any Linux distributions installed on their systems. Upstreaming also enables contribution from developers around the world to the driver once it is merged.

The driver works with Intel(R) libraries in user space. The Intel(R) driver exposes a few IOCTL interfaces for use by libraries in user space. The libraries are open sourced and are available at:
https://github.com/intel/gna

Prior to the submission, these items were tested or examined against GNA driver patch series put on top of v5.11-rc3 tag of mainline kernel:

Linux Kernel patch submission checklist
https://www.kernel.org/doc/html/latest/process/submit-checklist.html?highlight=submit%20checklist

1. If you use a facility then #include the file that defines/declares that facility. Don’t depend on other header files pulling in ones that you use.
(Checked)

2. Builds cleanly:
   with applicable or modified CONFIG options =y, =m, and =n. No gcc warnings/errors, no linker warnings/errors.
   Passes allnoconfig, allmodconfig
   Builds successfully when using O=builddir
(Tested by building kernel with Intel(R) GNA driver config set to ‘m’, ‘y’, and ‘n’; allmodconfig, allnoconfig and O=builddir)

3. Builds on multiple CPU architectures by using local cross-compile tools or some other build farm.
(x86_64 architecture tested - this is architecture where GNA is present and validated, please refer to drivers/misc/gna/Kconfig)

4. ppc64 is a good architecture for cross-compilation checking because it tends to use unsigned long for 64-bit quantities.
(x86_64 architecture tested - this is architecture where GNA is present and validated, please refer to drivers/misc/gna/Kconfig)

5. Check your patch for general style as detailed in Documentation/process/coding-style.rst. Check for trivial violations with the patch style checker prior to submission (scripts/checkpatch.pl). You should be able to justify all violations that remain in your patch.
(Checked. Some warnings were in the output. We checked them and feel they can be ignored.)

6. Any new or modified CONFIG options do not muck up the config menu and default to off unless they meet the exception criteria documented in Documentation/kbuild/kconfig-language.rst Menu attributes: default value.
(No explicit default value is provided because Kbuild system sets it off by default.)

7. All new Kconfig options have help text.
(Checked)

8. Has been carefully reviewed with respect to relevant Kconfig combinations. This is very hard to get right with testing – brainpower pays off here.
(Checked)

10. Use make checkstack and fix any problems that it finds.
    Note
    checkstack does not point out problems explicitly, but any one function that uses more than 512 bytes on the stack is a candidate for change.
(Checked)

11. Include kernel-doc to document global kernel APIs. (Not required for static functions, but OK there also.) Use make htmldocs or make pdfdocs to check the kernel-doc and fix any issues.
(Addressed by adding new gna.rst in Documentation; tested with output from ‘make htmldocs’)

12. Has been tested with CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_SLAB, CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_PROVE_RCU and CONFIG_DEBUG_OBJECTS_RCU_HEAD all simultaneously enabled.
(Checked)

13. Has been build- and runtime tested with and without CONFIG_SMP and CONFIG_PREEMPT.
(Checked)

15. All new /proc entries are documented under Documentation/.
(The driver doesn’t introduce any new procs)

16. All new kernel boot parameters are documented in Documentation/admin-guide/kernel-parameters.rst.
(The driver doesn’t add boot parameters)

17. All new module parameters are documented with MODULE_PARM_DESC().
(Checked)

21. Newly-added code has been compiled with gcc -W (use make EXTRA_CFLAGS=-W). This will generate lots of noise, but is good for finding bugs like “warning: comparison between signed.
    and unsigned”.
(Checked)

24. If any ioctl’s are added by the patch, then also update Documentation/userspace-api/ioctl/ioctl-number.rst.
(Updated)

The above results only reflect our understanding of the test and the code referred. Please kindly let us know any issues or different observations from any further tests.

Thanks

Series-reviewed-by: Tony Luck <tony.luck@intel.com>

Tomasz Jankowski (12):
  gna: add driver module
  gna: add component of hardware operation
  gna: read hardware info in the driver
  gna: add memory handling
  gna: initialize mmu
  gna: add hardware ids
  gna: add request component
  gna: implement scoring
  gna: add a work queue to process scoring requests
  gna: add interrupt handler
  gna: add ioctl handler
  gna: add a char device

 Documentation/misc-devices/gna.rst            |  48 ++
 Documentation/misc-devices/index.rst          |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/gna/Kbuild                       |   5 +
 drivers/misc/gna/Kconfig                      |  13 +
 drivers/misc/gna/gna_device.c                 | 451 +++++++++++++++++
 drivers/misc/gna/gna_device.h                 |  87 ++++
 drivers/misc/gna/gna_driver.c                 |  90 ++++
 drivers/misc/gna/gna_driver.h                 |  41 ++
 drivers/misc/gna/gna_hw.c                     | 136 +++++
 drivers/misc/gna/gna_hw.h                     |  85 ++++
 drivers/misc/gna/gna_ioctl.c                  | 249 +++++++++
 drivers/misc/gna/gna_ioctl.h                  |  11 +
 drivers/misc/gna/gna_mem.c                    | 472 ++++++++++++++++++
 drivers/misc/gna/gna_mem.h                    | 107 ++++
 drivers/misc/gna/gna_request.c                | 466 +++++++++++++++++
 drivers/misc/gna/gna_request.h                |  62 +++
 drivers/misc/gna/gna_score.c                  | 299 +++++++++++
 drivers/misc/gna/gna_score.h                  |  20 +
 include/uapi/misc/gna.h                       | 155 ++++++
 23 files changed, 2808 insertions(+)
 create mode 100644 Documentation/misc-devices/gna.rst
 create mode 100644 drivers/misc/gna/Kbuild
 create mode 100644 drivers/misc/gna/Kconfig
 create mode 100644 drivers/misc/gna/gna_device.c
 create mode 100644 drivers/misc/gna/gna_device.h
 create mode 100644 drivers/misc/gna/gna_driver.c
 create mode 100644 drivers/misc/gna/gna_driver.h
 create mode 100644 drivers/misc/gna/gna_hw.c
 create mode 100644 drivers/misc/gna/gna_hw.h
 create mode 100644 drivers/misc/gna/gna_ioctl.c
 create mode 100644 drivers/misc/gna/gna_ioctl.h
 create mode 100644 drivers/misc/gna/gna_mem.c
 create mode 100644 drivers/misc/gna/gna_mem.h
 create mode 100644 drivers/misc/gna/gna_request.c
 create mode 100644 drivers/misc/gna/gna_request.h
 create mode 100644 drivers/misc/gna/gna_score.c
 create mode 100644 drivers/misc/gna/gna_score.h
 create mode 100644 include/uapi/misc/gna.h

-- 
2.28.0


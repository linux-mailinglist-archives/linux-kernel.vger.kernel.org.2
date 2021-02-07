Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75331210B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBGDLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:11:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:55295 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhBGDLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:11:42 -0500
IronPort-SDR: F3r/zs9NxaXXOooGtCR3hPosr37lYb5bdsYdobBLJbGEP2O43se0z9bQ2rZT0YuAhh+Yt3tOZJ
 05/bgLHXF3+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="179020043"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="179020043"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:10:58 -0800
IronPort-SDR: AT6yjRu00s9wfKhzuBf0MCN3oLXYnDMLbpC2qdSmB0B6j4JeokeJ62afeRibdPWgSCesony578
 aUQNrc+o63rQ==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="584618054"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:10:53 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sen Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v9 01/18] docs: acrn: Introduce ACRN
Date:   Sun,  7 Feb 2021 11:10:23 +0800
Message-Id: <20210207031040.49576-2-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210207031040.49576-1-shuo.a.liu@intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

Add documentation on the following aspects of ACRN:

  1) A brief introduction on the architecture of ACRN.
  2) I/O request handling in ACRN.
  3) CPUID functions of ACRN.

To learn more about ACRN, please go to ACRN project website
https://projectacrn.org, or the documentation page
https://projectacrn.github.io/.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sen Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/virt/acrn/cpuid.rst        | 46 +++++++++++
 Documentation/virt/acrn/index.rst        | 12 +++
 Documentation/virt/acrn/introduction.rst | 43 +++++++++++
 Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
 Documentation/virt/index.rst             |  1 +
 MAINTAINERS                              |  7 ++
 6 files changed, 206 insertions(+)
 create mode 100644 Documentation/virt/acrn/cpuid.rst
 create mode 100644 Documentation/virt/acrn/index.rst
 create mode 100644 Documentation/virt/acrn/introduction.rst
 create mode 100644 Documentation/virt/acrn/io-request.rst

diff --git a/Documentation/virt/acrn/cpuid.rst b/Documentation/virt/acrn/cpuid.rst
new file mode 100644
index 000000000000..65fa4b9c1798
--- /dev/null
+++ b/Documentation/virt/acrn/cpuid.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ACRN CPUID bits
+===============
+
+A guest VM running on an ACRN hypervisor can check some of its features using
+CPUID.
+
+ACRN cpuid functions are:
+
+function: 0x40000000
+
+returns::
+
+   eax = 0x40000010
+   ebx = 0x4e524341
+   ecx = 0x4e524341
+   edx = 0x4e524341
+
+Note that this value in ebx, ecx and edx corresponds to the string
+"ACRNACRNACRN". The value in eax corresponds to the maximum cpuid function
+present in this leaf, and will be updated if more functions are added in the
+future.
+
+function: define ACRN_CPUID_FEATURES (0x40000001)
+
+returns::
+
+          ebx, ecx, edx
+          eax = an OR'ed group of (1 << flag)
+
+where ``flag`` is defined as below:
+
+================================= =========== ================================
+flag                              value       meaning
+================================= =========== ================================
+ACRN_FEATURE_PRIVILEGED_VM        0           guest VM is a privileged VM
+================================= =========== ================================
+
+function: 0x40000010
+
+returns::
+
+          ebx, ecx, edx
+          eax = (Virtual) TSC frequency in kHz.
diff --git a/Documentation/virt/acrn/index.rst b/Documentation/virt/acrn/index.rst
new file mode 100644
index 000000000000..b5f793e73df5
--- /dev/null
+++ b/Documentation/virt/acrn/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ACRN Hypervisor
+===============
+
+.. toctree::
+   :maxdepth: 1
+
+   introduction
+   io-request
+   cpuid
diff --git a/Documentation/virt/acrn/introduction.rst b/Documentation/virt/acrn/introduction.rst
new file mode 100644
index 000000000000..f8d081bc084d
--- /dev/null
+++ b/Documentation/virt/acrn/introduction.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+ACRN Hypervisor Introduction
+============================
+
+The ACRN Hypervisor is a Type 1 hypervisor, running directly on bare-metal
+hardware. It has a privileged management VM, called Service VM, to manage User
+VMs and do I/O emulation.
+
+ACRN userspace is an application running in the Service VM that emulates
+devices for a User VM based on command line configurations. ACRN Hypervisor
+Service Module (HSM) is a kernel module in the Service VM which provides
+hypervisor services to the ACRN userspace.
+
+Below figure shows the architecture.
+
+::
+
+                Service VM                    User VM
+      +----------------------------+  |  +------------------+
+      |        +--------------+    |  |  |                  |
+      |        |ACRN userspace|    |  |  |                  |
+      |        +--------------+    |  |  |                  |
+      |-----------------ioctl------|  |  |                  |   ...
+      |kernel space   +----------+ |  |  |                  |
+      |               |   HSM    | |  |  | Drivers          |
+      |               +----------+ |  |  |                  |
+      +--------------------|-------+  |  +------------------+
+  +---------------------hypercall----------------------------------------+
+  |                         ACRN Hypervisor                              |
+  +----------------------------------------------------------------------+
+  |                          Hardware                                    |
+  +----------------------------------------------------------------------+
+
+ACRN userspace allocates memory for the User VM, configures and initializes the
+devices used by the User VM, loads the virtual bootloader, initializes the
+virtual CPU state and handles I/O request accesses from the User VM. It uses
+ioctls to communicate with the HSM. HSM implements hypervisor services by
+interacting with the ACRN Hypervisor via hypercalls. HSM exports a char device
+interface (/dev/acrn_hsm) to userspace.
+
+The ACRN hypervisor is open for contribution from anyone. The source repo is
+available at https://github.com/projectacrn/acrn-hypervisor.
diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
new file mode 100644
index 000000000000..6cc3ea0fa1f5
--- /dev/null
+++ b/Documentation/virt/acrn/io-request.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+I/O request handling
+====================
+
+An I/O request of a User VM, which is constructed by the hypervisor, is
+distributed by the ACRN Hypervisor Service Module to an I/O client
+corresponding to the address range of the I/O request. Details of I/O request
+handling are described in the following sections.
+
+1. I/O request
+--------------
+
+For each User VM, there is a shared 4-KByte memory region used for I/O requests
+communication between the hypervisor and Service VM. An I/O request is a
+256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
+an I/O handler of the hypervisor when a trapped I/O access happens in a User
+VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
+the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
+used as an array of 16 I/O request slots with each I/O request slot being 256
+bytes. This array is indexed by vCPU ID.
+
+2. I/O clients
+--------------
+
+An I/O client is responsible for handling User VM I/O requests whose accessed
+GPA falls in a certain range. Multiple I/O clients can be associated with each
+User VM. There is a special client associated with each User VM, called the
+default client, that handles all I/O requests that do not fit into the range of
+any other clients. The ACRN userspace acts as the default client for each User
+VM.
+
+Below illustration shows the relationship between I/O requests shared buffer,
+I/O requests and I/O clients.
+
+::
+
+     +------------------------------------------------------+
+     |                                       Service VM     |
+     |+--------------------------------------------------+  |
+     ||      +----------------------------------------+  |  |
+     ||      | shared page            ACRN userspace  |  |  |
+     ||      |    +-----------------+  +------------+ |  |  |
+     ||   +----+->| acrn_io_request |<-+  default   | |  |  |
+     ||   |  | |  +-----------------+  | I/O client | |  |  |
+     ||   |  | |  |       ...       |  +------------+ |  |  |
+     ||   |  | |  +-----------------+                 |  |  |
+     ||   |  +-|--------------------------------------+  |  |
+     ||---|----|-----------------------------------------|  |
+     ||   |    |                             kernel      |  |
+     ||   |    |            +----------------------+     |  |
+     ||   |    |            | +-------------+  HSM |     |  |
+     ||   |    +--------------+             |      |     |  |
+     ||   |                 | | I/O clients |      |     |  |
+     ||   |                 | |             |      |     |  |
+     ||   |                 | +-------------+      |     |  |
+     ||   |                 +----------------------+     |  |
+     |+---|----------------------------------------------+  |
+     +----|-------------------------------------------------+
+          |
+     +----|-------------------------------------------------+
+     |  +-+-----------+                                     |
+     |  | I/O handler |              ACRN Hypervisor        |
+     |  +-------------+                                     |
+     +------------------------------------------------------+
+
+3. I/O request state transition
+-------------------------------
+
+The state transitions of an ACRN I/O request are as follows.
+
+::
+
+   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
+
+- FREE: this I/O request slot is empty
+- PENDING: a valid I/O request is pending in this slot
+- PROCESSING: the I/O request is being processed
+- COMPLETE: the I/O request has been processed
+
+An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
+ACRN userspace are in charge of processing the others.
+
+4. Processing flow of I/O requests
+----------------------------------
+
+a. The I/O handler of the hypervisor will fill an I/O request with PENDING
+   state when a trapped I/O access happens in a User VM.
+b. The hypervisor makes an upcall, which is a notification interrupt, to
+   the Service VM.
+c. The upcall handler schedules a worker to dispatch I/O requests.
+d. The worker looks for the PENDING I/O requests, assigns them to different
+   registered clients based on the address of the I/O accesses, updates
+   their state to PROCESSING, and notifies the corresponding client to handle.
+e. The notified client handles the assigned I/O requests.
+f. The HSM updates I/O requests states to COMPLETE and notifies the hypervisor
+   of the completion via hypercalls.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 350f5c869b56..edea7fea95a8 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -12,6 +12,7 @@ Linux Virtualization Support
    paravirt_ops
    guest-halt-polling
    ne_overview
+   acrn/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0737dfca89..3abd0fe60a58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -436,6 +436,13 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACRN HYPERVISOR SERVICE MODULE
+M:	Shuo Liu <shuo.a.liu@intel.com>
+L:	acrn-dev@lists.projectacrn.org
+S:	Supported
+W:	https://projectacrn.org
+F:	Documentation/virt/acrn/
+
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
 S:	Maintained
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F443AEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhJZJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:21:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:51120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234428AbhJZJVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:21:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="290696171"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="290696171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 02:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="635058551"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2021 02:19:01 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH] Documentation/x86: Add documentation for using dynamic XSTATE features
Date:   Tue, 26 Oct 2021 02:11:57 -0700
Message-Id: <20211026091157.16711-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YXXNa4FcvbGfCrxr@zn.tnic>
References: <YXXNa4FcvbGfCrxr@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain how dynamic XSTATE features can be enabled via the
architecture-specific prctl() along with dynamic sigframe size and
first use trap handling.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 Documentation/x86/index.rst  |  1 +
 Documentation/x86/xstate.rst | 66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/x86/xstate.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 383048396336..f498f1d36cd3 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -37,3 +37,4 @@ x86-specific Documentation
    sgx
    features
    elf_auxvec
+   xstate
diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
new file mode 100644
index 000000000000..d02e9f10919e
--- /dev/null
+++ b/Documentation/x86/xstate.rst
@@ -0,0 +1,66 @@
+Using XSTATE features in user space applications
+================================================
+
+The x86 architecture supports floating-point extensions which are
+enumerated via CPUID. Applications consult CPUID and use XGETBV to
+evaluate which features have been enabled by the kernel XCR0.
+
+Up to AVX-512 and PKRU states, these features are automatically enabled by
+the kernel if available. Features like AMX TILE_DATA (XSTATE component 18)
+are enabled by XCR0 as well, but the first use of related instruction is
+trapped by the kernel because by default the required large XSTATE buffers
+are not allocated automatically.
+
+Using dynamically enabled XSTATE features in user space applications
+-------------------------------------------------------------------
+
+The kernel provides an arch_prctl(2) based mechanism for applications to
+request the usage of such features. The arch_prctl(2) options related to
+this are:
+
+-ARCH_GET_XCOMP_SUPP
+
+ arch_prctl(ARCH_GET_XCOMP_SUPP, &features);
+
+ ARCH_GET_XCOMP_SUPP stores the supported features in userspace storage of
+ type uint64_t. The second argument is a pointer to that storage.
+
+-ARCH_GET_XCOMP_PERM
+
+ arch_prctl(ARCH_GET_XCOMP_PERM, &features);
+
+ ARCH_GET_XCOMP_PERM stores the features for which the userspace process
+ has permission in userspace storage of type uint64_t. The second argument
+ is a pointer to that storage.
+
+-ARCH_REQ_XCOMP_PERM
+
+ arch_prctl(ARCH_REQ_XCOMP_PERM, feature_nr);
+
+ ARCH_REQ_XCOMP_PERM allows to request permission for a dynamically enabled
+ feature or a feature set. A feature set can be mapped to a facility, e.g.
+ AMX, and can require one or more XSTATE components to be enabled.
+
+ The feature argument is the number of the highest XSTATE component which
+ is required for a facility to work.
+
+When requesting permission for a feature, the kernel checks the
+availability. The kernel ensures that sigaltstacks in the process's tasks
+are large enough to accommodate the resulting large signal frame. It
+enforces this both during ARCH_REQ_XCOMP_SUPP and during any subsequent
+sigaltstack(2) calls. If an installed sigaltstack is smaller than the
+resulting sigframe size, ARCH_REQ_XCOMP_SUPP results in -ENOSUPP. Also,
+sigaltstack(2) results in -ENOMEM if the requested altstack is too small
+for the permitted features.
+
+Permission, when granted, is valid per process. Permissions are inherited
+on fork(2) and cleared on exec(3).
+
+The first use of an instruction related to a dynamically enabled feature is
+trapped by the kernel. The trap handler checks whether the process has
+permission to use the feature. If the process has no permission then the
+kernel sends SIGILL to the application. If the process has permission then
+the handler allocates a larger xstate buffer for the task so the large
+state can be context switched. In the unlikely cases that the allocation
+fails, the kernel sends SIGSEGV.
+
-- 
2.17.1


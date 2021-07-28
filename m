Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED583D88C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhG1HVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:21:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:40179 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhG1HVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:21:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212590561"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="212590561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 00:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="475591406"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2021 00:21:40 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data sections aligned
Date:   Wed, 28 Jul 2021 15:21:40 +0800
Message-Id: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day has reported many strange performance changes (regression or
improvement), in which there was no obvious relation between the culprit
commit and the benchmark at the first look, and it causes people to doubt
the test itself is wrong.

Upon further check, many of these cases are caused by the change to the
alignment of kernel text or data, as whole text/data of kernel are linked
together, change in one domain can affect alignments of other domains.

To help to quickly identify if the strange performance change is caused
by _data_ alignment. add a debug option to force the data sections from
all .o files aligned on THREAD_SIZE, so that change in one domain won't
affect other modules' data alignment.

We have used this option to check some strange kernel changes [1][2][3],
and those performance changes were gone after enabling it, which proved
they are data alignment related.

Similarly, there is another kernel debug option to check text alignment
related performance changes: CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B,  
which forces all function's start address to be 64 bytes alinged.

This option depends on CONFIG_DYNAMIC_DEBUG==n, as '__dyndbg' subsection
of .data has a hard requirement of ALIGN(8), shown in the 'vmlinux.lds':

"
. = ALIGN(8); __start___dyndbg = .; KEEP(*(__dyndbg)) __stop___dyndbg = .;
"

It contains all pointers to 'struct _ddebug', and dynamic_debug_init()
will "pointer++" to loop accessing these pointers, which will be broken
with this option enabled.

[1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
[2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
[3]. https://lore.kernel.org/lkml/20201112140625.GA21612@xsang-OptiPlex-9020/

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/Kconfig.debug        | 13 +++++++++++++
 arch/x86/kernel/vmlinux.lds.S |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 80b57e7..d04c67e 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -228,6 +228,19 @@ config PUNIT_ATOM_DEBUG
 	  The current power state can be read from
 	  /sys/kernel/debug/punit_atom/dev_power_state
 
+config DEBUG_FORCE_DATA_SECTION_ALIGNED
+	bool "Force all data sections to be THREAD_SIZE aligned"
+	depends on EXPERT && !DYNAMIC_DEBUG
+	help
+	  There are cases that a commit from one kernel domain changes
+	  data sections' alignment of other domains, as they are all
+	  linked together compactly, and cause magic performance bump
+	  (regression or improvement), which is hard to debug. Enable
+	  this option will help to verify if the bump is caused by
+	  data alignment changes.
+
+	  It is mainly for debug and performance tuning use.
+
 choice
 	prompt "Choose kernel unwinder"
 	default UNWINDER_ORC if X86_64
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index efd9e9e..64256d0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,12 @@ SECTIONS
 	X86_ALIGN_RODATA_END
 
 	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET)
+#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
+	/* Use the biggest alignment of below sections */
+	SUBALIGN(THREAD_SIZE)
+#endif
+	{
 		/* Start of data section */
 		_sdata = .;
 
-- 
2.7.4


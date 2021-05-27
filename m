Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8212D3939DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhE1AAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:00:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:65453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233768AbhE0X7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:35 -0400
IronPort-SDR: WrVZIhK5VRfWW9PskhQB8mQ5cfmvgjiB4+mp49lknDKWMjPLPT2jsXtH12PQ4FSgwQK4JMScjC
 jJfGyKim7fAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202864150"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202864150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:41 -0700
IronPort-SDR: WhFUaJMdRoZHktc0K9pH1n1J+PqBSQSOClzMtQtUf/siDr6PqPItak+rH85FtQokhyAvUSdrjv
 h0lCEipzg22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477705335"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2021 16:57:41 -0700
Subject: [PATCH 5/5] selftests/vm/pkeys: exercise x86 XSAVE init state
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:19 -0700
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Message-Id: <20210527235119.9D443084@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

On x86, there is a set of instructions used to save and restore register
state collectively known as the XSAVE architecture.  There are about a
dozen different features managed with XSAVE.  The protection keys
register, PKRU, is one of those features.

The hardware optimizes XSAVE by tracking when the state has not changed
from its initial (init) state.  In this case, it can avoid the cost of
writing state to memory (it would usually just be a bunch of 0's).

When the pkey register is 0x0 the hardware optionally choose to track
the register as being in the init state (optimize away the writes).
AMD CPUs do this more aggressively compared to Intel.

On x86, PKRU is rarely in its (very permissive) init state.  Instead,
the value defaults to something very restrictive.  It is not surprising
that bugs have popped up in the rare cases when PKRU reaches its init
state.

Add a protection key selftest which gets the protection keys register
into its init state in a way that should work on Intel and AMD.  Then,
do a bunch of pkey register reads to watch for inadvertent changes.

This adds "-mxsave" to CFLAGS for all the x86 vm selftests in order
to allow use of the XSAVE instruction __builtin functions.  This will
make the builtins available on all of the vm selftests, but is
expected to be harmless.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

 b/tools/testing/selftests/vm/Makefile          |    4 -
 b/tools/testing/selftests/vm/pkey-x86.h        |    1 
 b/tools/testing/selftests/vm/protection_keys.c |   71 +++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff -puN tools/testing/selftests/vm/Makefile~init-pkru-selftest tools/testing/selftests/vm/Makefile
--- a/tools/testing/selftests/vm/Makefile~init-pkru-selftest	2021-05-27 16:40:28.299705459 -0700
+++ b/tools/testing/selftests/vm/Makefile	2021-05-27 16:40:28.315705459 -0700
@@ -99,7 +99,7 @@ $(1) $(1)_64: $(OUTPUT)/$(1)_64
 endef
 
 ifeq ($(CAN_BUILD_I386),1)
-$(BINARIES_32): CFLAGS += -m32
+$(BINARIES_32): CFLAGS += -m32 -mxsave
 $(BINARIES_32): LDLIBS += -lrt -ldl -lm
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
@@ -107,7 +107,7 @@ $(foreach t,$(TARGETS),$(eval $(call gen
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
-$(BINARIES_64): CFLAGS += -m64
+$(BINARIES_64): CFLAGS += -m64 -mxsave
 $(BINARIES_64): LDLIBS += -lrt -ldl
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
diff -puN tools/testing/selftests/vm/pkey-x86.h~init-pkru-selftest tools/testing/selftests/vm/pkey-x86.h
--- a/tools/testing/selftests/vm/pkey-x86.h~init-pkru-selftest	2021-05-27 16:40:28.301705459 -0700
+++ b/tools/testing/selftests/vm/pkey-x86.h	2021-05-27 16:40:28.315705459 -0700
@@ -126,6 +126,7 @@ static inline u32 pkey_bit_position(int
 
 #define XSTATE_PKEY_BIT	(9)
 #define XSTATE_PKEY	0x200
+#define XSTATE_BV_OFFSET	512
 
 int pkey_reg_xstate_offset(void)
 {
diff -puN tools/testing/selftests/vm/protection_keys.c~init-pkru-selftest tools/testing/selftests/vm/protection_keys.c
--- a/tools/testing/selftests/vm/protection_keys.c~init-pkru-selftest	2021-05-27 16:40:28.303705459 -0700
+++ b/tools/testing/selftests/vm/protection_keys.c	2021-05-27 16:40:28.314705459 -0700
@@ -1278,6 +1278,76 @@ void test_pkey_alloc_exhaust(int *ptr, u
 	}
 }
 
+void arch_force_pkey_reg_init(void)
+{
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	u64 *buf;
+
+	/*
+	 * All keys should be allocated and set to allow reads and
+	 * writes, so the register should be all 0.  If not, just
+	 * skip the test.
+	 */
+	if (read_pkey_reg())
+		return;
+
+	/*
+	 * Just allocate an absurd about of memory rather than
+	 * doing the XSAVE size enumeration dance.
+	 */
+	buf = mmap(NULL, 1*MB, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+
+	/* These __builtins require compiling with -mxsave */
+
+	/* XSAVE to build a valid buffer: */
+	__builtin_ia32_xsave(buf, XSTATE_PKEY);
+	/* Clear XSTATE_BV[PKRU]: */
+	buf[XSTATE_BV_OFFSET/sizeof(u64)] &= ~XSTATE_PKEY;
+	/* XRSTOR will likely get PKRU back to the init state: */
+	__builtin_ia32_xrstor(buf, XSTATE_PKEY);
+
+	munmap(buf, 1*MB);
+#endif
+}
+
+
+/*
+ * This is mostly useless on ppc for now.  But it will not
+ * hurt anything and should give some better coverage as
+ * a long-running test that continually checks the pkey
+ * register.
+ */
+void test_pkey_init_state(int *ptr, u16 pkey)
+{
+	int err;
+	int allocated_pkeys[NR_PKEYS] = {0};
+	int nr_allocated_pkeys = 0;
+	int i;
+
+	for (i = 0; i < NR_PKEYS*3; i++) {
+		int new_pkey = alloc_pkey();
+
+		allocated_pkeys[nr_allocated_pkeys++] = new_pkey;
+	}
+
+	dprintf3("%s()::%d\n", __func__, __LINE__);
+
+	arch_force_pkey_reg_init();
+
+	/*
+	 * Loop for a bit, hoping to get exercise the kernel
+	 * context switch code.
+	 */
+	for (i = 0; i < 1000000; i++)
+		read_pkey_reg();
+
+	for (i = 0; i < nr_allocated_pkeys; i++) {
+		err = sys_pkey_free(allocated_pkeys[i]);
+		pkey_assert(!err);
+		read_pkey_reg(); /* for shadow checking */
+	}
+}
+
 /*
  * pkey 0 is special.  It is allocated by default, so you do not
  * have to call pkey_alloc() to use it first.  Make sure that it
@@ -1502,6 +1572,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey)
 	test_implicit_mprotect_exec_only_memory,
 	test_mprotect_with_pkey_0,
 	test_ptrace_of_child,
+	test_pkey_init_state,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
_

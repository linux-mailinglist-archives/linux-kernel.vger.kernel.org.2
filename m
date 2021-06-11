Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C03A46B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhFKQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:44:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:54683 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhFKQoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:44:01 -0400
IronPort-SDR: Gdz1vdmgFjDjbFZJ6GDROUpIGqFljlHZst49fDg/aFbGj0OwuNfp5Dw9M7QhpS2UFPLnGeiBXd
 z5mpvr260nNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="192872378"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192872378"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:42:02 -0700
IronPort-SDR: jRJbQjuwfx1t2SjicXof0uL+86V0gQ2cRviybXysdyuAWE8PeWQBtmW2B+2FKAvozv7FQI98M8
 NyxVf5lT3sYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="441608132"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2021 09:42:02 -0700
Subject: [PATCH 4/4] selftests/vm/pkeys: Exercise x86 XSAVE init state
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        linuxram@us.ibm.com, sandipan@linux.ibm.com,
        akpm@linux-foundation.org, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, mhocko@kernel.org, msuchanek@suse.de,
        shuah@kernel.org, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:42:02 -0700
References: <20210611164153.91B76FB8@viggo.jf.intel.com>
In-Reply-To: <20210611164153.91B76FB8@viggo.jf.intel.com>
Message-Id: <20210611164202.1849B712@viggo.jf.intel.com>
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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: x86@kernel.org
---

 b/tools/testing/selftests/vm/Makefile          |    4 -
 b/tools/testing/selftests/vm/pkey-x86.h        |    1 
 b/tools/testing/selftests/vm/protection_keys.c |   73 +++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff -puN tools/testing/selftests/vm/Makefile~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1 tools/testing/selftests/vm/Makefile
--- a/tools/testing/selftests/vm/Makefile~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1	2021-06-11 09:41:34.574468058 -0700
+++ b/tools/testing/selftests/vm/Makefile	2021-06-11 09:41:34.588468058 -0700
@@ -100,7 +100,7 @@ $(1) $(1)_64: $(OUTPUT)/$(1)_64
 endef
 
 ifeq ($(CAN_BUILD_I386),1)
-$(BINARIES_32): CFLAGS += -m32
+$(BINARIES_32): CFLAGS += -m32 -mxsave
 $(BINARIES_32): LDLIBS += -lrt -ldl -lm
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
@@ -108,7 +108,7 @@ $(foreach t,$(TARGETS),$(eval $(call gen
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
-$(BINARIES_64): CFLAGS += -m64
+$(BINARIES_64): CFLAGS += -m64 -mxsave
 $(BINARIES_64): LDLIBS += -lrt -ldl
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
diff -puN tools/testing/selftests/vm/pkey-x86.h~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1 tools/testing/selftests/vm/pkey-x86.h
--- a/tools/testing/selftests/vm/pkey-x86.h~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1	2021-06-11 09:41:34.576468058 -0700
+++ b/tools/testing/selftests/vm/pkey-x86.h	2021-06-11 09:41:34.590468058 -0700
@@ -126,6 +126,7 @@ static inline u32 pkey_bit_position(int
 
 #define XSTATE_PKEY_BIT	(9)
 #define XSTATE_PKEY	0x200
+#define XSTATE_BV_OFFSET	512
 
 int pkey_reg_xstate_offset(void)
 {
diff -puN tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1 tools/testing/selftests/vm/protection_keys.c
--- a/tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Exercise_x86_XSAVE_init_state-1	2021-06-11 09:41:34.578468058 -0700
+++ b/tools/testing/selftests/vm/protection_keys.c	2021-06-11 09:41:34.593468058 -0700
@@ -1277,6 +1277,78 @@ void test_pkey_alloc_exhaust(int *ptr, u
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
+	for (i = 0; i < NR_PKEYS; i++) {
+		int new_pkey = alloc_pkey();
+
+		if (new_pkey < 0)
+			continue;
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
@@ -1508,6 +1580,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey)
 	test_implicit_mprotect_exec_only_memory,
 	test_mprotect_with_pkey_0,
 	test_ptrace_of_child,
+	test_pkey_init_state,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
_

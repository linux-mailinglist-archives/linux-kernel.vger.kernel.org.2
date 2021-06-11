Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05EE3A4862
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFKSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:41 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40731 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhFKSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:27 -0400
Received: by mail-wr1-f46.google.com with SMTP id y7so6957522wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8fjHUstUowtnT1ACDTc/G6+11kSe9JpXGqMAE54jmU=;
        b=No6jTF2ycxi58ABayOD1sNxi3W7dzau+fuoIPzBKWi7w4fBiCSoREmWCbK6md/QVGu
         E0d9QB05P7eVa+C+n2nVk8z21yybxDtXUZ9VTEKieXmYP3SC5tcaFGJA8ou1oM7U4RGD
         Umhl1uLc++mwSrrvwxyhd1R2ujZ/9zBP1acs15c5iTmBOuqZU4ResvbdT+Xdd8eGrixp
         9mLRaCeAcW1eja6HppF8DkDNuTEtQElSmGaYFew1ByPgO4YFeHXzTeRWEEC/gZDeYcUV
         IDRvzcBuqjzCWuqbQaaNH+WVrLUqTlwXqTSKUlPFzQXWayHTwjnI8KZf0M4G/0AFgrKf
         pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8fjHUstUowtnT1ACDTc/G6+11kSe9JpXGqMAE54jmU=;
        b=KGngX/wNhXxHl4w0F8WIPV57Iz+mafD7UnB7fNd5I29PsBNoCgIF3rZX4BJF8ICZUS
         BgsXgiuA1KYavDOD1yZvuzj74f32TVFHMF19+ztVZzgy9aapJkUZox9Csetqjz16VpKv
         wj/dMQHpRp7vKv/9xgF/awJfOixru8UqGzQCa9/ZBD5sRmvlIxxSpsWld2XGImW9x31m
         ZrNYflhMpSyLKsQupHsCxwYXxrB7X53snTBH5vzOCuvrt31Lh4Z8qonVhVm1EKhmA2Lm
         dW2eLynWrcC60DupO4RjVlj2d/zPYErmsw2mwyNi0YnGZLubkrqPp9/x/iiHdUdt90xs
         tvIA==
X-Gm-Message-State: AOAM530ygb0NcU7Sj8H6g8uoYb+uQdQO2fGn1pxRqLoC+ER3IdupH9Q2
        fCfg0dvmBBMmxLUDElCWpxW/5d/91kNxGI61
X-Google-Smtp-Source: ABdhPJz7j6mlnhLVdGS2wh1IKGGhgV6qA0Bo8R/q4ye5TAQkqEqrPR/HyE5jSQdQZCOSCwmXs1/16w==
X-Received: by 2002:adf:8bc7:: with SMTP id w7mr5643919wra.198.1623434608644;
        Fri, 11 Jun 2021 11:03:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:28 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 23/23] x86/vdso/selftest: Add a test for unmapping vDSO
Date:   Fri, 11 Jun 2021 19:02:42 +0100
Message-Id: <20210611180242.711399-24-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output for landing on x86:
> [root@localhost ~]# ./test_munmap_vdso_64
>	AT_SYSINFO_EHDR is 0x7fffead9f000
> [NOTE]	unmapping vDSO: [0x7fffead9f000, 0x7fffeada0000]
> [NOTE]	vDSO partial move failed, will try with bigger size
> [NOTE]	unmapping vDSO: [0x7fffead9f000, 0x7fffeada1000]
> [OK]
> [root@localhost ~]# ./test_munmap_vdso_32
>	AT_SYSINFO_EHDR is 0xf7eef000
> [NOTE]	unmapping vDSO: [0xf7eef000, 0xf7ef0000]
> [NOTE]	vDSO partial move failed, will try with bigger size
> [NOTE]	unmapping vDSO: [0xf7eef000, 0xf7ef1000]
> [OK]

The test also can check force_sigsegv(SIGSEGV) in do_fast_syscall_32():
> [root@localhost ~]# ./test_munmap_vdso_32 sysenter
> [NOTE]	Using sysenter after munmap
>	AT_SYSINFO_EHDR is 0xf7efe000
> [NOTE]	unmapping vDSO: [0xf7efe000, 0xf7eff000]
> [NOTE]	vDSO partial move failed, will try with bigger size
> [NOTE]	unmapping vDSO: [0xf7efe000, 0xf7f00000]
> [OK]	32-bit process gets segfault on fast syscall with unmapped vDSO

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/x86/.gitignore        |   1 +
 tools/testing/selftests/x86/Makefile          |  11 +-
 .../testing/selftests/x86/test_munmap_vdso.c  | 151 ++++++++++++++++++
 3 files changed, 158 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/x86/test_munmap_vdso.c

diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
index 1aaef5bf119a..9ce8337e8fa0 100644
--- a/tools/testing/selftests/x86/.gitignore
+++ b/tools/testing/selftests/x86/.gitignore
@@ -6,6 +6,7 @@ sysret_ss_attrs
 syscall_nt
 ptrace_syscall
 test_mremap_vdso
+test_munmap_vdso
 check_initial_reg_state
 sigreturn
 ldt_gdt
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 333980375bc7..43016351ddb3 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -10,12 +10,13 @@ CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
-TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
-			check_initial_reg_state sigreturn iopl ioperm \
-			test_vsyscall mov_ss_trap \
+TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt	\
+			test_mremap_vdso test_munmap_vdso		\
+			check_initial_reg_state sigreturn iopl ioperm	\
+			test_vsyscall mov_ss_trap			\
 			syscall_arg_fault fsgsbase_restore
-TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
-			test_FCMOV test_FCOMI test_FISTTP \
+TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso	\
+			test_FCMOV test_FCOMI test_FISTTP		\
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
 # Some selftests require 32bit support enabled also on 64bit systems
diff --git a/tools/testing/selftests/x86/test_munmap_vdso.c b/tools/testing/selftests/x86/test_munmap_vdso.c
new file mode 100644
index 000000000000..f56433dae279
--- /dev/null
+++ b/tools/testing/selftests/x86/test_munmap_vdso.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * 32/64-bit test to check vDSO munmap.
+ *
+ * Copyright (c) 2021 Dmitry Safonov
+ */
+/*
+ * Can be built statically:
+ * gcc -Os -Wall -static -m32 test_munmap_vdso.c
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <sys/mman.h>
+#include <sys/auxv.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#define PAGE_SIZE	4096
+
+static int try_to_unmap(void *vdso_addr, unsigned long size)
+{
+	int ret;
+
+	printf("[NOTE]\tunmapping vDSO: [%p, %#lx]\n",
+		vdso_addr, (unsigned long)vdso_addr + size);
+	fflush(stdout);
+
+#ifdef __i386__
+	/* vDSO is a landing for fast syscalls - don't use it for munmap() */
+	asm volatile ("int $0x80" : "=a" (ret)
+			: "a" (SYS_munmap),
+			  "b" (vdso_addr),
+			  "c" (size));
+	errno = -ret;
+#else /* __x86_64__ */
+	ret = munmap(vdso_addr, size);
+#endif
+	if (ret) {
+		if (errno == EINVAL) {
+			printf("[NOTE]\tvDSO partial move failed, will try with bigger size\n");
+			return -1; /* Retry with larger */
+		}
+		printf("[FAIL]\tmunmap failed (%d): %m\n", errno);
+		return 1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	pid_t child;
+
+#ifdef __i386__
+	enum syscall_type_t {
+		INT80, SYSCALL32, SYSENTER
+	} syscall_type = INT80;
+
+	if (argc > 1) {
+		if (!strcmp(argv[1], "syscall32")) {
+			syscall_type = SYSCALL32;
+			printf("[NOTE]\tUsing syscall32 after munmap\n");
+		} else if (!strcmp(argv[1], "sysenter")) {
+			syscall_type = SYSENTER;
+			printf("[NOTE]\tUsing sysenter after munmap\n");
+		}
+	}
+#endif
+
+	child = fork();
+	if (child == -1) {
+		printf("[WARN]\tfailed to fork (%d): %m\n", errno);
+		return 1;
+	}
+
+	if (child == 0) {
+		unsigned long vdso_size = PAGE_SIZE;
+		unsigned long auxval;
+		int ret = -1;
+
+		auxval = getauxval(AT_SYSINFO_EHDR);
+		printf("\tAT_SYSINFO_EHDR is %#lx\n", auxval);
+		if (!auxval || auxval == -ENOENT) {
+			printf("[WARN]\tgetauxval failed\n");
+			return 0;
+		}
+
+		/* Simpler than parsing ELF header */
+		while (ret < 0) {
+			ret = try_to_unmap((void *)auxval, vdso_size);
+			vdso_size += PAGE_SIZE;
+		}
+
+		/* Glibc is likely to explode now - exit with raw syscall */
+#ifdef __i386__
+		switch (syscall_type) {
+		case SYSCALL32:
+			asm volatile ("syscall" : : "a" (__NR_exit), "b" (!!ret));
+		case SYSENTER:
+			asm volatile ("sysenter" : : "a" (__NR_exit), "b" (!!ret));
+		default:
+		case INT80:
+			asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+		}
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
+	} else {
+		int status;
+
+		if (waitpid(child, &status, 0) != child) {
+			printf("[FAIL]\tUnexpected child, killing the expected one\n");
+			kill(child, SIGKILL);
+			return 1;
+		}
+
+
+#ifdef __i386__
+		switch (syscall_type) {
+		case SYSCALL32:
+		case SYSENTER:
+			if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+				printf("[OK]\t32-bit process gets segfault on fast syscall with unmapped vDSO\n");
+				return 0;
+			}
+		default:
+		case INT80:
+			/* same as on x86_64 */
+		}
+#endif
+
+		if (!WIFEXITED(status)) {
+			printf("[FAIL]\tmunmap() of the vDSO does not work on this kernel!\n");
+			if (WIFSIGNALED(status))
+				printf("[FAIL]\tprocess crashed with %s\n",
+					strsignal(WTERMSIG(status)));
+			return 1;
+		} else if (WEXITSTATUS(status) != 0) {
+			printf("[FAIL]\tChild failed with %d\n",
+					WEXITSTATUS(status));
+			return 1;
+		}
+		printf("[OK]\n");
+	}
+
+	return 0;
+}
-- 
2.31.1


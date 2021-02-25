Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB3324B57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhBYHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhBYHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E62C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:57 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 201so3047498pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew5ULXh2s3debDfJGELT9nH6Qr39U3zvkA1enkJWaeA=;
        b=onvirPQoLiEDzNesEG2CCzrN3ULqiE3DB2mLthAl4jMogSYLK3XkbcJG1p5ojLSl63
         KeMDMnPQNKt/fYg4GTGw3oc8DJgJJ40yDzAikB0a8WNjRgJz3nMfjUj4vdCqUG6gvPVA
         iGoLvshjoZUe4ePEJC49XUGLUapSIDowlKjRDSwWViktrLxLORKgkoO76zR99isB+5bT
         NAzCZb/jrKW6A7Yf8Psm8jHNxFNU1rkdtGMVb16r20KydB4kILjusiTWNcY2SrZb85Jm
         a/rSBPNHHWK4j7eWAB5zMgmNGTcyUgTXOwlfKpWJikWQVlb060EnO43EQjNBlVhaghg/
         zxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew5ULXh2s3debDfJGELT9nH6Qr39U3zvkA1enkJWaeA=;
        b=lbvFcJTds0LQBax9gSxbIO11bntE+WfSGsAERHUIeEpWAiMsEx6DF/uYrpCAok8029
         c1h1dEj/lSzpLwI/keotYheBaY/dTj8WDZEwrwXGkWCi6Qn8kc3dWkajniFMEl4V5mS+
         /+akYiwQXPIIUrWTaibdV0ZcYV5caRddER3mY8qYr3kf7rr4pFdaWk/78oO6+dqqNfSs
         bbasFmWZzI+K7LUvyVrL00CzhP9EvB4kwvnNHCNfQZS1MJ8OzQ5msSTsoNbj9AtaQ4zX
         o8g7WrBMHx8YWsnQdeiP6Vj6pJX96eJ4RYiGPQcD+H71eJCk31zIz26sFsMx0nUKTcoO
         xEUw==
X-Gm-Message-State: AOAM533mSoMIe/FucFKshxt6xUv5flkwK4jY8wvBkyfQDdbV2zgg/Qma
        PuijixPO5xk+8GkOOXXrQ2c=
X-Google-Smtp-Source: ABdhPJyP/D1mqxF7RjwvOWEtaASpae014BCao/9yEM/ejxJFLMHEY4DszZ17KieyhQx2UezDqsNJrg==
X-Received: by 2002:a63:546:: with SMTP id 67mr1803027pgf.173.1614238436911;
        Wed, 24 Feb 2021 23:33:56 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:56 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [PATCH 6/6] testing/selftest: test vDSO prefetch_page()
Date:   Wed, 24 Feb 2021 23:29:10 -0800
Message-Id: <20210225072910.2811795-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Test prefetch_page() in cases of invalid pointer, file-mmap and
anonymous memory. Partial checks are also done with mincore syscall to
ensure the output of prefetch_page() is consistent with mincore (taking
into account the different semantics of the two).

The tests are not fool-proof as they rely on the behavior of the
page-cache and page reclamation mechanism to get a major page-fault.
They should be robust in the sense of test being skipped if it failed.

There is a question though on how to know how much memory to access in
the test of anonymous memory to force the eviction of a page and trigger
a refault.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_test_prefetch_page.c  | 265 ++++++++++++++++++
 2 files changed, 267 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_prefetch_page.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..dcd1ede8c0f7 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -11,6 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_prefetch_page
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -33,3 +34,4 @@ $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 		vdso_test_correctness.c \
 		-o $@ \
 		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_prefetch_page: vdso_test_prefetch_page.c parse_vdso.c
diff --git a/tools/testing/selftests/vDSO/vdso_test_prefetch_page.c b/tools/testing/selftests/vDSO/vdso_test_prefetch_page.c
new file mode 100644
index 000000000000..35928c3f36ca
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_prefetch_page.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vdso_test_prefetch_page.c: Test vDSO's prefetch_page())
+ */
+
+#define _GNU_SOURCE
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <assert.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "../kselftest.h"
+#include "parse_vdso.h"
+
+const char *version = "LINUX_2.6";
+const char *name = "__vdso_prefetch_page";
+
+struct getcpu_cache;
+typedef long (*prefetch_page_t)(const void *p);
+
+#define MEM_SIZE_K	(9500000ull)
+#define PAGE_SIZE	(4096ull)
+
+#define SKIP_MINCORE_BEFORE	(1 << 0)
+#define SKIP_MINCORE_AFTER	(1 << 1)
+
+static prefetch_page_t prefetch_page;
+
+static const void *ptr_align(const void *p)
+{
+	return (const void *)((unsigned long)p & ~(PAGE_SIZE - 1));
+}
+
+
+static int __test_prefetch(const void *p, bool expected_no_io,
+			   const char *test_name, unsigned int skip_mincore)
+{
+	bool no_io;
+	char vec;
+	long r;
+	uint64_t start;
+
+	p = ptr_align(p);
+
+	/*
+	 * First, run a sanity check to use mincore() to see if the page is in
+	 * memory when we expect it not to be.  We can only trust mincore to
+	 * tell us when a page is already in memory when it should not be.
+	 */
+	if (!(skip_mincore & SKIP_MINCORE_BEFORE)) {
+		if (mincore((void *)p, PAGE_SIZE, &vec)) {
+			printf("[SKIP]\t%s: mincore failed: %s\n", test_name,
+			       strerror(errno));
+			return 0;
+		}
+
+		no_io = vec & 1;
+		if (!skip_mincore && no_io && !expected_no_io) {
+			printf("[SKIP]\t%s: unexpected page state: %s\n",
+			       test_name,
+			       no_io ? "in memory" : "not in memory");
+			return 0;
+		}
+	}
+
+	/*
+	 * Check we got the expected result from prefetch page.
+	 */
+	r = prefetch_page(p);
+
+	no_io = r == 0;
+	if (no_io != expected_no_io) {
+		printf("[FAIL]\t%s: prefetch_page() returned %ld\n",
+			       test_name, r);
+		return KSFT_FAIL;
+	}
+
+	if (skip_mincore & SKIP_MINCORE_AFTER)
+		return 0;
+
+	/*
+	 * Check again using mincore that the page state is as expected.
+	 * A bit racy. Skip the test if mincore fails.
+	 */
+	if (mincore((void *)p, PAGE_SIZE, &vec)) {
+		printf("[SKIP]\t%s: mincore failed: %s\n", test_name,
+		       strerror(errno));
+		return 0;
+	}
+
+	no_io = vec & 1;
+	if (0 && no_io != expected_no_io) {
+		printf("[FAIL]\t%s: mincore reported page is %s\n",
+			       test_name, no_io ? "in memory" : "not in memory");
+		return KSFT_FAIL;
+
+	}
+	return 0;
+}
+
+#define test_prefetch(p, expected_no_io, test_name, skip_mincore)	\
+	do {								\
+		long _r = __test_prefetch(p, expected_no_io,		\
+					  test_name, skip_mincore);	\
+									\
+		if (_r)							\
+			return _r;					\
+	} while (0)
+
+static void wait_for_io_completion(const void *p)
+{
+	char vec;
+	int i;
+
+	/* Wait to allow the I/O to complete */
+	p = ptr_align(p);
+
+	vec = 0;
+
+	/* Wait for 5 seconds and keep probing the page to get it */
+	for (i = 0; i < 5000; i++) {
+		if (mincore((void *)p, PAGE_SIZE, &vec) == 0 && (vec & 1))
+			break;
+		prefetch_page(p);
+		usleep(1000);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr;
+	long ret, i, test_ret = 0;
+	int fd, drop_fd;
+	char *p, vec;
+
+	printf("[RUN]\tTesting vdso_prefetch_page\n");
+
+	sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("[SKIP]\tAT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	prefetch_page = (prefetch_page_t)vdso_sym(version, name);
+	if (!prefetch_page) {
+		printf("[SKIP]\tCould not find %s in vdso\n", name);
+		return KSFT_SKIP;
+	}
+
+	test_prefetch(NULL, false, "NULL access",
+		      SKIP_MINCORE_BEFORE|SKIP_MINCORE_AFTER);
+
+	test_prefetch(name, true, "present", 0);
+
+	p = mmap(0, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap anon");
+		return KSFT_FAIL;
+	}
+
+	/*
+	 * Mincore would not tell us that no I/O is needed to retrieve the page,
+	 * so tell test_prefetch() to skip it.
+	 */
+	test_prefetch(p, true, "anon prefetch", SKIP_MINCORE_BEFORE);
+
+	/* Drop the caches before testing file mmap */
+	drop_fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
+	if (drop_fd < 0) {
+		perror("open /proc/sys/vm/drop_caches");
+		return KSFT_FAIL;
+	}
+
+	sync();
+	ret = write(drop_fd, "3", 1);
+	if (ret != 1) {
+		perror("write to /proc/sys/vm/drop_caches");
+		return KSFT_FAIL;
+	}
+
+	/* close, which would also flush */
+	ret = close(drop_fd);
+	if (ret) {
+		perror("close /proc/sys/vm/drop_caches");
+		return KSFT_FAIL;
+	}
+
+	/* Using /etc/passwd as a file that should alway exist */
+	fd = open("/etc/hosts", O_RDONLY);
+	if (fd < 0) {
+		perror("open /etc/passwd");
+		return KSFT_FAIL;
+	}
+
+	p = mmap(0, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap file");
+		return KSFT_FAIL;
+	}
+
+	test_prefetch(p, false, "Minor-fault (io) file prefetch", 0);
+
+	wait_for_io_completion(p);
+
+	test_prefetch(p, true, "Minor-fault (cached) file prefetch", 0);
+
+	munmap(p, PAGE_SIZE);
+
+	/*
+	 * Try to lock all to avoid unrelated page-faults before we create
+	 * memory pressure to prevent unrelated page-faults.
+	 */
+	mlockall(MCL_CURRENT);
+
+	p = mmap(0, 1024 * MEM_SIZE_K, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap file");
+		return KSFT_FAIL;
+	}
+
+	/*
+	 * Write random value to avoid try to prevent KSM from deduplicating
+	 * this page.
+	 */
+	*(volatile unsigned long *)p = 0x43454659;
+	ret = madvise(p, PAGE_SIZE, MADV_PAGEOUT);
+	if (ret != 0) {
+		perror("madvise(MADV_PAGEOUT)");
+		return KSFT_FAIL;
+	}
+
+	/* Wait to allow the page-out to complete */
+	usleep(2000000);
+
+	/* Cause some memory pressure */
+	for (i = PAGE_SIZE; i < MEM_SIZE_K * 1024; i += PAGE_SIZE)
+		*(volatile unsigned long *)((unsigned long)p + i) = i + 1;
+
+	/* Check if we managed to evict the page */
+	ret = mincore(p, PAGE_SIZE, &vec);
+	if (ret != 0) {
+		perror("mincore");
+		return KSFT_FAIL;
+	}
+
+	test_prefetch(p, false, "Minor-fault (io) anon prefetch", 0);
+	wait_for_io_completion(p);
+
+	test_prefetch(p, true, "Minor-fault (cached) anon prefetch", false);
+
+	printf("[PASS]\tvdso_prefetch_page\n");
+	return 0;
+}
-- 
2.25.1


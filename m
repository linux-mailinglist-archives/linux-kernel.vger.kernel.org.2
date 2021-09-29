Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE7F41D01D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbhI2XnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346536AbhI2Xm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:42:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78587C061768
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:41:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l11-20020a056902072b00b005a776eefb28so5723226ybt.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=nAs4diGKDtFAK12cMvvKORrzgu/SgnuyHpoTrsBgHf0=;
        b=rkewn6O/NTtnG8iBVIuyAV/KNUOigYTEy6zKzajF/GXAKeXSbKz2owq4KfVxBM4iJI
         mdSZIAuD3dfe5z+OyR76kxGM7las2APwhVj+ypximmHWAp736kWQQUZmki8o8z3o485c
         gJdM4xKpTAHfedctxvAschl/FDHgNo53BjFZiMlnsjnnOxp17ZkMmjiYL1KI1ou6W/dA
         Fwt+hxzrf9X9O7lgKtWGAFXxKQhtA1Hthi7xw01WyMpJMautD3pNy1YAm1DyQDXAYIwi
         Fa2E97HywCTs2qBwie5XlYctD53pXAav20tW9VSPkdmLNbUY4NudlGkRPprrnnH+aPCy
         QEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=nAs4diGKDtFAK12cMvvKORrzgu/SgnuyHpoTrsBgHf0=;
        b=HBFIHQ2Dmmm+lYklNi/1Kr4sMV94e7lBmW1/+NxMXZuQFh+iyh95ExTWJAYf+PrbCi
         8I3XYKiV8JYFUuST5oz/S5FGXWeuNzxgCXmr8/pnd8qsD1UNJJm8zdgTbWxWSIqGiv/o
         arE5o5pBKbkTd60dPJnZy+Hlr3fGokgSEw+pgc7cWp+YjCWYoopdu7ZelChekmYP0ahr
         GL6pQx5tVjj0klfEqrwttDy/BTvViraXIcgsNw5+PS4KWPPEzj4G9CpVXpD2SZPX4iGW
         0WRqTk8S51hzPqARPvhjUFNZAMPdLGggN8IHdOwnHHRl5DmcwffAFuhckyItS7iMjfJm
         IyNw==
X-Gm-Message-State: AOAM531iOUXxctBaPiGcLIOSvi/jmmuw6VYi4DAR8VbOblNlEMfmQyeO
        rrVBQ4t7rlQbmIUmB1TkvaqrwnJm6Go=
X-Google-Smtp-Source: ABdhPJzvdrLFMq8dFIXDrn7bAJTwPfp+fXRZRsjWvC1WEwrk0u12e3Ny5QGfdZIPDY8H3hO+UtDqIevOxe0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e777:43b7:f76f:da52])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1504:: with SMTP id
 q4mr3327370ybu.177.1632958875766; Wed, 29 Sep 2021 16:41:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Sep 2021 16:41:12 -0700
Message-Id: <20210929234112.1862848-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] KVM: selftests: Ensure all migrations are performed when test
 is affined
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the CPU selection in the migration worker to ensure the specified
number of migrations are performed when the test iteslf is affined to a
subset of CPUs.  The existing logic skips iterations if the target CPU is
not in the original set of possible CPUs, which causes the test to fail
if too many iterations are skipped.

  ==== Test Assertion Failure ====
  rseq_test.c:228: i > (NR_TASK_MIGRATIONS / 2)
  pid=10127 tid=10127 errno=4 - Interrupted system call
     1  0x00000000004018e5: main at rseq_test.c:227
     2  0x00007fcc8fc66bf6: ?? ??:0
     3  0x0000000000401959: _start at ??:?
  Only performed 4 KVM_RUNs, task stalled too much?

Calculate the min/max possible CPUs as a cheap "best effort" to avoid
high runtimes when the test is affined to a small percentage of CPUs.
Alternatively, a list or xarray of the possible CPUs could be used, but
even in a horrendously inefficient setup, such optimizations are not
needed because the runtime is completely dominated by the cost of
migrating the task, and the absolute runtime is well under a minute in
even truly absurd setups, e.g. running on a subset of vCPUs in a VM that
is heavily overcommited (16 vCPUs per pCPU).

Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 69 +++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index c5e0dd664a7b..4158da0da2bb 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <syscall.h>
 #include <sys/ioctl.h>
+#include <sys/sysinfo.h>
 #include <asm/barrier.h>
 #include <linux/atomic.h>
 #include <linux/rseq.h>
@@ -39,6 +40,7 @@ static __thread volatile struct rseq __rseq = {
 
 static pthread_t migration_thread;
 static cpu_set_t possible_mask;
+static int min_cpu, max_cpu;
 static bool done;
 
 static atomic_t seq_cnt;
@@ -57,20 +59,37 @@ static void sys_rseq(int flags)
 	TEST_ASSERT(!r, "rseq failed, errno = %d (%s)", errno, strerror(errno));
 }
 
+static int next_cpu(int cpu)
+{
+	/*
+	 * Advance to the next CPU, skipping those that weren't in the original
+	 * affinity set.  Sadly, there is no CPU_SET_FOR_EACH, and cpu_set_t's
+	 * data storage is considered as opaque.  Note, if this task is pinned
+	 * to a small set of discontigous CPUs, e.g. 2 and 1023, this loop will
+	 * burn a lot cycles and the test will take longer than normal to
+	 * complete.
+	 */
+	do {
+		cpu++;
+		if (cpu > max_cpu) {
+			cpu = min_cpu;
+			TEST_ASSERT(CPU_ISSET(cpu, &possible_mask),
+				    "Min CPU = %d must always be usable", cpu);
+			break;
+		}
+	} while (!CPU_ISSET(cpu, &possible_mask));
+
+	return cpu;
+}
+
 static void *migration_worker(void *ign)
 {
 	cpu_set_t allowed_mask;
-	int r, i, nr_cpus, cpu;
+	int r, i, cpu;
 
 	CPU_ZERO(&allowed_mask);
 
-	nr_cpus = CPU_COUNT(&possible_mask);
-
-	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
-		cpu = i % nr_cpus;
-		if (!CPU_ISSET(cpu, &possible_mask))
-			continue;
-
+	for (i = 0, cpu = min_cpu; i < NR_TASK_MIGRATIONS; i++, cpu = next_cpu(cpu)) {
 		CPU_SET(cpu, &allowed_mask);
 
 		/*
@@ -154,6 +173,36 @@ static void *migration_worker(void *ign)
 	return NULL;
 }
 
+static int calc_min_max_cpu(void)
+{
+	int i, cnt, nproc;
+
+	if (CPU_COUNT(&possible_mask) < 2)
+		return -EINVAL;
+
+	/*
+	 * CPU_SET doesn't provide a FOR_EACH helper, get the min/max CPU that
+	 * this task is affined to in order to reduce the time spent querying
+	 * unusable CPUs, e.g. if this task is pinned to a small percentage of
+	 * total CPUs.
+	 */
+	nproc = get_nprocs_conf();
+	min_cpu = -1;
+	max_cpu = -1;
+	cnt = 0;
+
+	for (i = 0; i < nproc; i++) {
+		if (!CPU_ISSET(i, &possible_mask))
+			continue;
+		if (min_cpu == -1)
+			min_cpu = i;
+		max_cpu = i;
+		cnt++;
+	}
+
+	return (cnt < 2) ? -EINVAL : 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
@@ -167,8 +216,8 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
 		    strerror(errno));
 
-	if (CPU_COUNT(&possible_mask) < 2) {
-		print_skip("Only one CPU, task migration not possible\n");
+	if (calc_min_max_cpu()) {
+		print_skip("Only one usable CPU, task migration not possible");
 		exit(KSFT_SKIP);
 	}
 
-- 
2.33.0.685.g46640cef36-goog


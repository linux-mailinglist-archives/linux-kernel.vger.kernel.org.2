Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E163F4845
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhHWKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236039AbhHWKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:08:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NA3iOr146951;
        Mon, 23 Aug 2021 06:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=w3R+GoDRAE082LfgQnQ8+39UPDXV7roOv26arMyDOMI=;
 b=qfsPv7zvM2oJQ1YIiYkzEIQ0HwqH/BB5uw6iNsrC8TAOJ2VHzJUo2kmUKc6aXOo1YRhv
 aD/4ZaEaXu8HLYUC1wlVORDRecPtjH29HqfyHrdUBYPz6GbwmbbQWo7RUw8JCOCwmM0S
 IdDivCoOT6K0ljL3btG9Hd4k7oOQa9mopkznI6BK5Sw+NZaHvTD3XYEUIB8sFPjv7Ltl
 DXVCJdOHq+EbioTfbKg5bnAz3c34WMZofaNAldhGny3QjSNB8UNJtRP/ea0SpkhTy5T2
 ladvkMWaAySKugdl5GpJk+B28Pz/IdWKqpas4c0yCaW3iV7mux0mpiAsCha4EXdJtT1N ig== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akefyu5u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 06:08:05 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NA3du8007774;
        Mon, 23 Aug 2021 10:08:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3ajrrhtnnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 10:08:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NA7u9T27263414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:07:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D13D2A4075;
        Mon, 23 Aug 2021 10:07:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3165CA406F;
        Mon, 23 Aug 2021 10:07:56 +0000 (GMT)
Received: from localhost (unknown [9.102.2.197])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 10:07:55 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 2/2] lib/percpu_test: Add extra tests in percpu_test
Date:   Mon, 23 Aug 2021 15:37:46 +0530
Message-Id: <789c7e9e66f465f8b6043973e11fc5aef82e6a7d.1629712557.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f824a9b589be576f5dac9109ca07d65d6b83219a.1629712557.git.riteshh@linux.ibm.com>
References: <f824a9b589be576f5dac9109ca07d65d6b83219a.1629712557.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x8hd24zsBmTtuWkk_xohY2wAvYfE0de7
X-Proofpoint-GUID: x8hd24zsBmTtuWkk_xohY2wAvYfE0de7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging a issue, we needed to stress test the percpu alloc/free
path. Hence added some tests in lib/percpu_test to stress test
percpu subsystem for allocation with different sizes.

This patch keeps the default behavior of insmod module same for default
test. But when given insmod with different option, it can run a
percpu_stressd daemon (percpu_test_num=2) which does a stress test
evey 10secs unless the module is unloaded.

We found this to be helpful in our testing, since with this we could
easily excercise percpu allo/free path. Hence cleaned this up for
inclusion in percpu_test module.

Logs
======
qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=0
[  334.362973] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_verify
[  334.364946] TEST Starts: percpu_verify
[  334.365601] TEST Completed: percpu_verify
insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable

qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=1
[  336.556464] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stress
[  336.558388] TEST Starts: percpu_stress
[  336.560611] TEST Completed: percpu_stress
insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable

qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=2
[  339.164406] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stressd
[  339.165935] TEST Starts: percpu_stressd
[  339.167033] TEST Completed: percpu_stressd
[  339.167082] DAEMON: starts percpu_stressd
[  339.168498] TEST Starts: percpu_stressd: iter (1)
[  339.182530] TEST Completed: percpu_stressd: iter (1)
[  349.341109] TEST Starts: percpu_stressd: iter (2)
[  349.344447] TEST Completed: percpu_stressd: iter (2)
[  359.580829] TEST Starts: percpu_stressd: iter (3)
[  359.584315] TEST Completed: percpu_stressd: iter (3)
[  369.820471] TEST Starts: percpu_stressd: iter (4)
[  369.844402] TEST Completed: percpu_stressd: iter (4)

qemu-> sudo rmmod percpu_test
[  375.001098] percpu_test: EXIT
[qemu][~]

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 lib/percpu_test.c | 240 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 191 insertions(+), 49 deletions(-)

diff --git a/lib/percpu_test.c b/lib/percpu_test.c
index 4a3d70bbc1a0..944d54c57b4b 100644
--- a/lib/percpu_test.c
+++ b/lib/percpu_test.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <linux/cpu.h>
 #include <linux/module.h>
 
 /* validate @native and @pcp counter values match @expected */
@@ -14,10 +17,25 @@
 		     (long long)(expected), (long long)(expected));	\
 	} while (0)
 
-static DEFINE_PER_CPU(long, long_counter);
-static DEFINE_PER_CPU(unsigned long, ulong_counter);
+/* upto max alloc size tests for percpu var */
+static char __percpu *counters[1 << PAGE_SHIFT];
+static struct task_struct *percpu_stressd_thread;
 
-static int __init percpu_test_init(void)
+/* let's not trigger OOM */
+int percpu_alloc_max_size_shift = PAGE_SHIFT - 3;
+module_param(percpu_alloc_max_size_shift, int, 0644);
+MODULE_PARM_DESC(percpu_alloc_max_size_shift, "max size of allocation in stress test will be upto 1 << percpu_alloc_max_size_shift");
+
+static long percpu_stressd_interval = 1 * 10 * HZ;
+module_param(percpu_stressd_interval, long, 0644);
+MODULE_PARM_DESC(percpu_stressd_interval, "percpu_stressd internal");
+
+/* keep the default test same */
+static int percpu_test_num;
+module_param(percpu_test_num, int, 0644);
+MODULE_PARM_DESC(percpu_test_num, "Test number percpu_test_num");
+
+static int percpu_test_verify(void)
 {
 	/*
 	 * volatile prevents compiler from optimizing it uses, otherwise the
@@ -26,109 +44,233 @@ static int __init percpu_test_init(void)
 	volatile unsigned int ui_one = 1;
 	long l = 0;
 	unsigned long ul = 0;
+	long __percpu *long_counter = alloc_percpu(long);
+	unsigned long __percpu *ulong_counter = alloc_percpu(unsigned long);
 
-	pr_info("percpu test start\n");
+	if (!long_counter || !ulong_counter)
+		goto out;
+
+	pr_debug("percpu_test: %s start cpu: %d\n", __func__, smp_processor_id());
 
 	preempt_disable();
 
 	l += -1;
-	__this_cpu_add(long_counter, -1);
-	CHECK(l, long_counter, -1);
+	__this_cpu_add(*long_counter, -1);
+	CHECK(l, *long_counter, -1);
 
 	l += 1;
-	__this_cpu_add(long_counter, 1);
-	CHECK(l, long_counter, 0);
+	__this_cpu_add(*long_counter, 1);
+	CHECK(l, *long_counter, 0);
 
 	ul = 0;
-	__this_cpu_write(ulong_counter, 0);
+	__this_cpu_write(*ulong_counter, 0);
 
 	ul += 1UL;
-	__this_cpu_add(ulong_counter, 1UL);
-	CHECK(ul, ulong_counter, 1);
+	__this_cpu_add(*ulong_counter, 1UL);
+	CHECK(ul, *ulong_counter, 1);
 
 	ul += -1UL;
-	__this_cpu_add(ulong_counter, -1UL);
-	CHECK(ul, ulong_counter, 0);
+	__this_cpu_add(*ulong_counter, -1UL);
+	CHECK(ul, *ulong_counter, 0);
 
 	ul += -(unsigned long)1;
-	__this_cpu_add(ulong_counter, -(unsigned long)1);
-	CHECK(ul, ulong_counter, -1);
+	__this_cpu_add(*ulong_counter, -(unsigned long)1);
+	CHECK(ul, *ulong_counter, -1);
 
 	ul = 0;
-	__this_cpu_write(ulong_counter, 0);
+	__this_cpu_write(*ulong_counter, 0);
 
 	ul -= 1;
-	__this_cpu_dec(ulong_counter);
-	CHECK(ul, ulong_counter, -1);
-	CHECK(ul, ulong_counter, ULONG_MAX);
+	__this_cpu_dec(*ulong_counter);
+	CHECK(ul, *ulong_counter, -1);
+	CHECK(ul, *ulong_counter, ULONG_MAX);
 
 	l += -ui_one;
-	__this_cpu_add(long_counter, -ui_one);
-	CHECK(l, long_counter, 0xffffffff);
+	__this_cpu_add(*long_counter, -ui_one);
+	CHECK(l, *long_counter, 0xffffffff);
 
 	l += ui_one;
-	__this_cpu_add(long_counter, ui_one);
-	CHECK(l, long_counter, (long)0x100000000LL);
+	__this_cpu_add(*long_counter, ui_one);
+	CHECK(l, *long_counter, (long)0x100000000LL);
 
 
 	l = 0;
-	__this_cpu_write(long_counter, 0);
+	__this_cpu_write(*long_counter, 0);
 
 	l -= ui_one;
-	__this_cpu_sub(long_counter, ui_one);
-	CHECK(l, long_counter, -1);
+	__this_cpu_sub(*long_counter, ui_one);
+	CHECK(l, *long_counter, -1);
 
 	l = 0;
-	__this_cpu_write(long_counter, 0);
+	__this_cpu_write(*long_counter, 0);
 
 	l += ui_one;
-	__this_cpu_add(long_counter, ui_one);
-	CHECK(l, long_counter, 1);
+	__this_cpu_add(*long_counter, ui_one);
+	CHECK(l, *long_counter, 1);
 
 	l += -ui_one;
-	__this_cpu_add(long_counter, -ui_one);
-	CHECK(l, long_counter, (long)0x100000000LL);
+	__this_cpu_add(*long_counter, -ui_one);
+	CHECK(l, *long_counter, (long)0x100000000LL);
 
 	l = 0;
-	__this_cpu_write(long_counter, 0);
+	__this_cpu_write(*long_counter, 0);
 
 	l -= ui_one;
-	this_cpu_sub(long_counter, ui_one);
-	CHECK(l, long_counter, -1);
-	CHECK(l, long_counter, ULONG_MAX);
+	this_cpu_sub(*long_counter, ui_one);
+	CHECK(l, *long_counter, -1);
+	CHECK(l, *long_counter, ULONG_MAX);
 
 	ul = 0;
-	__this_cpu_write(ulong_counter, 0);
+	__this_cpu_write(*ulong_counter, 0);
 
 	ul += ui_one;
-	__this_cpu_add(ulong_counter, ui_one);
-	CHECK(ul, ulong_counter, 1);
+	__this_cpu_add(*ulong_counter, ui_one);
+	CHECK(ul, *ulong_counter, 1);
 
 	ul = 0;
-	__this_cpu_write(ulong_counter, 0);
+	__this_cpu_write(*ulong_counter, 0);
 
 	ul -= ui_one;
-	__this_cpu_sub(ulong_counter, ui_one);
-	CHECK(ul, ulong_counter, -1);
-	CHECK(ul, ulong_counter, ULONG_MAX);
+	__this_cpu_sub(*ulong_counter, ui_one);
+	CHECK(ul, *ulong_counter, -1);
+	CHECK(ul, *ulong_counter, ULONG_MAX);
 
 	ul = 3;
-	__this_cpu_write(ulong_counter, 3);
+	__this_cpu_write(*ulong_counter, 3);
 
-	ul = this_cpu_sub_return(ulong_counter, ui_one);
-	CHECK(ul, ulong_counter, 2);
+	ul = this_cpu_sub_return(*ulong_counter, ui_one);
+	CHECK(ul, *ulong_counter, 2);
 
-	ul = __this_cpu_sub_return(ulong_counter, ui_one);
-	CHECK(ul, ulong_counter, 1);
+	ul = __this_cpu_sub_return(*ulong_counter, ui_one);
+	CHECK(ul, *ulong_counter, 1);
 
 	preempt_enable();
 
-	pr_info("percpu test done\n");
-	return -EAGAIN;  /* Fail will directly unload the module */
+out:
+	free_percpu(long_counter);
+	free_percpu(ulong_counter);
+	pr_debug("percpu_test: %s done cpu: %d\n", __func__, smp_processor_id());
+
+	/*
+	 * Keep the default functionality same.
+	 * Fail will directly unload this module.
+	 */
+	return -EAGAIN;
+}
+
+void percpu_test_verify_work(struct work_struct *work)
+{
+	percpu_test_verify();
+}
+
+static int percpu_test_stress(void)
+{
+	int i;
+
+	for (i = 1; i < (1 << percpu_alloc_max_size_shift); i++) {
+		size_t size = i;
+
+		if (size > PCPU_MIN_ALLOC_SIZE)
+			break;
+		counters[i] = (char __percpu *)__alloc_percpu(size, __alignof__(char));
+		if (!counters[i])
+			break;
+		cond_resched();
+	}
+
+	schedule_on_each_cpu(percpu_test_verify_work);
+
+	for (i = 0; i < (1 << percpu_alloc_max_size_shift); i++) {
+		free_percpu(counters[i]);
+		cond_resched();
+	}
+	return -EAGAIN;
+}
+
+static int percpu_stressd(void *v)
+{
+	int iter = 0;
+
+	pr_info("DAEMON: starts %s\n", __func__);
+	do {
+		if (kthread_should_stop())
+			break;
+		iter++;
+		pr_info("TEST Starts: %s: iter (%d)\n", __func__, iter);
+		percpu_test_stress();
+		pr_info("TEST Completed: %s: iter (%d)\n", __func__, iter);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(percpu_stressd_interval);
+	} while (1);
+
+	return 0;
+}
+
+static int percpu_test_stressd(void)
+{
+	percpu_stressd_thread = kthread_run(percpu_stressd, NULL, "percpu_stressd");
+	if (IS_ERR(percpu_stressd_thread))
+		percpu_stressd_thread = NULL;
+	return 0;
+}
+
+enum test_type {
+	PERCPU_VERIFY,
+	PERCPU_STRESS,
+	PERCPU_STRESSD,
+	NR_TESTS,
+};
+
+const char *test_names[NR_TESTS] = {
+	[PERCPU_VERIFY] = "percpu_verify",
+	[PERCPU_STRESS] = "percpu_stress",
+	[PERCPU_STRESSD] = "percpu_stressd",
+};
+
+static int __init percpu_test_init(void)
+{
+	int i, ret = 0;
+	typedef int (*percpu_tests)(void);
+	const percpu_tests test_funcs[NR_TESTS] = {
+		[PERCPU_VERIFY] = percpu_test_verify,
+		[PERCPU_STRESS] = percpu_test_stress,
+		[PERCPU_STRESSD] = percpu_test_stressd,
+	};
+
+	/* sanity checks */
+	if (percpu_alloc_max_size_shift > PAGE_SHIFT)
+		percpu_alloc_max_size_shift = PAGE_SHIFT;
+	if (percpu_test_num > NR_TESTS)
+		percpu_test_num = NR_TESTS;
+
+	pr_info("percpu_test: INIT, interval: %ld, max_shift: %d, run_tests: %s\n",
+			percpu_stressd_interval, percpu_alloc_max_size_shift,
+			percpu_test_num == NR_TESTS ? "run all tests" :
+			test_names[percpu_test_num]);
+
+	/* run a given test */
+	if (percpu_test_num < NR_TESTS) {
+		pr_info("TEST Starts: %s\n", test_names[percpu_test_num]);
+		ret = test_funcs[percpu_test_num]();
+		pr_info("TEST Completed: %s\n", test_names[percpu_test_num]);
+		goto out;
+	}
+
+	for (i = 0; i < NR_TESTS; i++) {
+		pr_info("TEST Starts: %s\n", test_names[i]);
+		test_funcs[i]();
+		pr_info("TEST Completed: %s\n", test_names[i]);
+	}
+out:
+	return ret;
 }
 
 static void __exit percpu_test_exit(void)
 {
+	if (percpu_stressd_thread)
+		kthread_stop(percpu_stressd_thread);
+	pr_info("percpu_test: EXIT\n");
 }
 
 module_init(percpu_test_init)
-- 
2.31.1


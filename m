Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F334439E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhKBXot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:44:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhKBXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:44:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Mw62d018099;
        Tue, 2 Nov 2021 23:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=36cvZLG7nzHy1WDDbHNdPAkMG0X5CWKjGmksL7YL9Ck=;
 b=cdHeWhcWQEx3+OqXNNn1Bq0pXuqN0xSNagsgNji4dM5zc+14KoDBjLvoF8Cli3QK7Rnu
 GLosNY/1p8fmskQVa/r3mxVUU2to5cgrY2xEx70YZ/es+BFJWtfOugEi8bvDEtokJq+1
 dejn/gd6ODGFPiXl1ZWWVLgye7e8K6tbH/ZxVgrbbKhk9CiXmsnhdDwHjbFJGq9ZF4XQ
 YTNpTZ3ZlcPa5jkRDK0RbqeV+5LnyKxBHVMf9X178ApW/9y/sz0g7m2UFz/5xLX9le9s
 5wEHa+S/BZ/tOlJm7rDYBv0LWbksfHe0BPtUAMXbiSKUoZiQI59pg9jlcShCx1WwyQAp 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8jvdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 23:41:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Nfckv139773;
        Tue, 2 Nov 2021 23:41:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3c0v3emhae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 23:41:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1A2NfmIJ140417;
        Tue, 2 Nov 2021 23:41:48 GMT
Received: from bostrovs-us.us.oracle.com (bostrovs-us.us.oracle.com [10.152.12.19])
        by aserp3030.oracle.com with ESMTP id 3c0v3emh9e-1;
        Tue, 02 Nov 2021 23:41:48 +0000
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com,
        boris.ostrovsky@oracle.com
Subject: [PATCH] x86/smp: Factor out parts of native_smp_prepare_cpus()
Date:   Tue,  2 Nov 2021 19:36:36 -0400
Message-Id: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: IfvjVT_LMOgDHkf0XLPcHexo-rinRMka
X-Proofpoint-ORIG-GUID: IfvjVT_LMOgDHkf0XLPcHexo-rinRMka
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66558b730f25 ("sched: Add cluster scheduler level for x86")
introduced cpu_l2c_shared_map mask which is expected to be initialized
by smp_op.smp_prepare_cpus(). That commit only updated
native_smp_prepare_cpus() version but not xen_pv_smp_prepare_cpus().
As result Xen PV guests crash in set_cpu_sibling_map().

While the new mask can be allocated in xen_pv_smp_prepare_cpus() one can
see that both versions of smp_prepare_cpus ops share a number of common
operations that can be factored out. So do that instead.

Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/smpboot.c  | 19 +++++++++++++------
 arch/x86/xen/smp_pv.c      | 11 ++---------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 08b0e90623ad..81a0211a372d 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -126,6 +126,7 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
+void smp_prepare_cpus_common(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8241927addff..d7429198c22f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1350,12 +1350,7 @@ static void __init smp_get_logical_apicid(void)
 		cpu0_logical_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
 }
 
-/*
- * Prepare for SMP bootup.
- * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
- *            for common interface support.
- */
-void __init native_smp_prepare_cpus(unsigned int max_cpus)
+void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
 
@@ -1386,6 +1381,18 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
+}
+
+/*
+ * Prepare for SMP bootup.
+ * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
+ *            for common interface support.
+ */
+void __init native_smp_prepare_cpus(unsigned int max_cpus)
+{
+
+	smp_prepare_cpus_common();
+
 	init_freq_invariance(false, false);
 	smp_sanity_check();
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 9e55bcbfcd33..69e91d0d3ca4 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -238,16 +238,9 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	xen_init_lock_cpu(0);
 
-	smp_store_boot_cpu_info();
-	cpu_data(0).x86_max_cores = 1;
+	smp_prepare_cpus_common();
 
-	for_each_possible_cpu(i) {
-		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
-	}
-	set_cpu_sibling_map(0);
+	cpu_data(0).x86_max_cores = 1;
 
 	speculative_store_bypass_ht_init();
 
-- 
1.8.3.1


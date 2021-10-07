Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF6424C32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 05:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhJGDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhJGDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:19:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72CC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 20:18:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3988371pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRcRjqqBu6vE6e8lhoCbZHnm/EE3afenVrS1GUok9ZQ=;
        b=jXA724ktr05VljmcfTMDGL2QCB//W/vaefw8AQMttvlVmFKYm68SfCrClMBXmaCy4G
         R/8uzR9h7i5GJM0KSbEz+K/ozWA/yKYSoEQmACGd4C1rCPEgxEk78abUFM9teDMzcIUF
         nj3cg0VfkAhXvKcBs9Yxwi6fyboqqtDWK84dYs7Wiowl4NoKejKVaYorWUaGOAwGFCi+
         tTa91nJ+yK/LJuhziwgC8RQiS6FP91fBcTKiZSWy6c0GZDlGC5BRFJaPqPCaMzqrF3Kt
         fUAzKz8fF7HsRecE7RRW7f5qGHOiabv+fvtKzyxgMVL8NGc5d8hznLcEy3rzfSyNHRtu
         I6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRcRjqqBu6vE6e8lhoCbZHnm/EE3afenVrS1GUok9ZQ=;
        b=n3p0rK0pxB2+75q4P8NazjyHlwj6jJl0T4yRbkOqiAcLJg+TtG9NXxR2GZnJIfcVBd
         Emx4ebRk82mWKsyR/uGug+8Evf29TJwbyxpdxZQPCPahNCGHdm/WZg/mw7UpkgTM8pUM
         NzFMT6veQMCaLsVZDKatu1RRQfMPsMbRBM9NLw03KU1eD6wH+bK7JEDQvRR6c1nCnFLq
         LBycOyUZyNBH7/XnnSSSVki9v9Od/g/mUVQO2ZjV9Iub9+0svgr3ICRIH7w7updB9UIR
         u4KAl9P68WfkYzD6oGVkyxQ4NEYw4A2jdqmci2k00xoyPa5mwtGd6PRYLthNnk+h1EGi
         qICA==
X-Gm-Message-State: AOAM531cMNHxTyAo2D55MMMWXkoe06yE9Miz74OaN7bVrXOUFwPNhczY
        qFQyYQw+lIPFmQgY25qGExM=
X-Google-Smtp-Source: ABdhPJyG/PwONaMCVylmdPTiKyp++3lY7/f69VA2n79vg3ieunGnIFfygWQDMDkiEiMeEWv/ynW23g==
X-Received: by 2002:a17:90a:7301:: with SMTP id m1mr2075131pjk.34.1633576681926;
        Wed, 06 Oct 2021 20:18:01 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:d906:ac38:8e9d:2f82])
        by smtp.gmail.com with ESMTPSA id r8sm21986317pgp.30.2021.10.06.20.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:18:00 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
Date:   Wed,  6 Oct 2021 20:17:56 -0700
Message-Id: <20211007031756.345269-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Using per-cpu storage for @x86_cpu_to_logical_apicid
is not optimal.

Broadcast IPI will need at least one cache line
per cpu to access this field.

__x2apic_send_IPI_mask() is using standard bitmask operators.

By converting x86_cpu_to_logical_apicid to an array,
we divide by 16x the number of needed cache lines, because
we find 16 values in one cache line. CPU prefetcher can
kick nicely.

Also move @cluster_masks to READ_MOSTLY section to avoid
possible false sharing.

Tested on a dual socket host with 256 cpus,
average cost for a full broadcast is now 11 usec instead of 33 usec.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/x2apic_cluster.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index f4da9bb69a8859ff10824315388aeb49c2ccfad9..8ba23bfbc91c559e27fefdb8c9d401edd83022b1 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -15,9 +15,14 @@ struct cluster_mask {
 	struct cpumask	mask;
 };
 
-static DEFINE_PER_CPU(u32, x86_cpu_to_logical_apicid);
+/* __x2apic_send_IPI_mask() possibly needs to read
+ * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
+ * Using per cpu variable would cost one cache line per cpu.
+ */
+static u32 x86_cpu_to_logical_apicid[NR_CPUS] __read_mostly;
+
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
-static DEFINE_PER_CPU(struct cluster_mask *, cluster_masks);
+static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;
 
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
@@ -27,7 +32,7 @@ static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 static void x2apic_send_IPI(int cpu, int vector)
 {
-	u32 dest = per_cpu(x86_cpu_to_logical_apicid, cpu);
+	u32 dest = x86_cpu_to_logical_apicid[cpu];
 
 	/* x2apic MSRs are special and need a special fence: */
 	weak_wrmsr_fence();
@@ -58,11 +63,10 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 
 		dest = 0;
 		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
-			dest |= per_cpu(x86_cpu_to_logical_apicid, clustercpu);
+			dest |= x86_cpu_to_logical_apicid[clustercpu];
 
 		if (!dest)
 			continue;
-
 		__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 		/* Remove cluster CPUs from tmpmask */
 		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
@@ -94,7 +98,7 @@ static void x2apic_send_IPI_all(int vector)
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
-	return per_cpu(x86_cpu_to_logical_apicid, cpu);
+	return x86_cpu_to_logical_apicid[cpu];
 }
 
 static void init_x2apic_ldr(void)
@@ -103,7 +107,7 @@ static void init_x2apic_ldr(void)
 	u32 cluster, apicid = apic_read(APIC_LDR);
 	unsigned int cpu;
 
-	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
+	x86_cpu_to_logical_apicid[smp_processor_id()] = apicid;
 
 	if (cmsk)
 		goto update;
-- 
2.33.0.882.g93a45727a2-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51F9425588
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbhJGOh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:37:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1E7C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:36:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so4028765plh.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suBssZKyz31dGqI31WByzZWo+jlX53iGQViQd5BSvdE=;
        b=Me/3SquNkGtIBIhMVosaFd536Awx/KVcEayi1qXmBQXVhAVrNDHkYwMouy70OUw/DF
         dnKa0LM3cxsWjnEqFd9mZKUmMRx55PBD7VvfKbwfHwJ3YiMoZWEAX66Bb+BIgJuh5iqr
         vzGuFlpf+m1ZjcLySvpDqvfQ4BypcyZQZEvvucYtDYNOQ9o6IsY3xAEHtbBdOqzUwlcC
         VGLnLwBI8idfZu2jllm8cde7hKT/+FPmMwC64IwDDOZge7jKztAMSwWRVj7EFN41Kq6P
         RE4KXr/5O+lNu2Kxe/vWLxr8B/MW9wflP28xAeqIKXq4WnYuRjyof6JypMwWHfzRHAxa
         fInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suBssZKyz31dGqI31WByzZWo+jlX53iGQViQd5BSvdE=;
        b=ozib5txNy5cyru0OOUCGkXCqhqj6LQAqIY9t0LZ5T4/lHc6XISRd4ozrQIRMn9B6M5
         C+ZaOWGm2kaDaYbLp8qNbD2q3Ly0XKkG3CSfhDuiZ7TezdP//PEpzpbIXWj4ckurKRae
         d0pKJ/GBbZsvggojk10yWCoXa3f8A07Kk170SIrMegkr4VT1LpWbg2rRqd3dwX8PgfYA
         2OQjOnPOSQ56/Phv1XnI4KX/IlC37KjddAeMT98u4TDtFQod8KzJ384QqkLaHksVg35b
         +8Qrm6Hep5CJsbrg4oWmKNSEXIJmRWB9XS3u8QANSoSixpGXVJkiBOqS2SPqy5URUBXx
         tEUQ==
X-Gm-Message-State: AOAM530NSvcQ2JnpzQ/AYURXZ3CkWklfIrsVXwNGL6PUDTZ5UC3PzY6K
        qjqMYwCoRQQoDvYrOzmfX7M3kZeE3ac=
X-Google-Smtp-Source: ABdhPJy9I7Jq3+3O/uU1XZSjR/cqFbKwuG4iTI2kKaulySFAlOhQnT7aKvReS7dkO7B7hgI2ir19uQ==
X-Received: by 2002:a17:90b:108d:: with SMTP id gj13mr5775436pjb.95.1633617363222;
        Thu, 07 Oct 2021 07:36:03 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:d906:ac38:8e9d:2f82])
        by smtp.gmail.com with ESMTPSA id n202sm7161743pfd.160.2021.10.07.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:36:02 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
Date:   Thu,  7 Oct 2021 07:35:56 -0700
Message-Id: <20211007143556.574911-1-eric.dumazet@gmail.com>
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
we divide by 16x number of needed cache lines, because
we find 16 values per cache line. CPU prefetcher can
kick nicely.

Also move @cluster_masks to READ_MOSTLY section to avoid false sharing.

Tested on a dual socket host with 256 cpus,
cost for a full broadcast is now 11 usec instead of 33 usec.

v2: use a dynamically allocated array, as suggested by Peter.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/x2apic_cluster.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index f4da9bb69a8859ff10824315388aeb49c2ccfad9..e696e22d0531976f7cba72ed17443592eac72c13 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -15,9 +15,15 @@ struct cluster_mask {
 	struct cpumask	mask;
 };
 
-static DEFINE_PER_CPU(u32, x86_cpu_to_logical_apicid);
+/*
+ * __x2apic_send_IPI_mask() possibly needs to read
+ * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
+ * Using per cpu variable would cost one cache line per cpu.
+ */
+static u32 *x86_cpu_to_logical_apicid __read_mostly;
+
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
-static DEFINE_PER_CPU(struct cluster_mask *, cluster_masks);
+static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;
 
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
@@ -27,7 +33,7 @@ static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 static void x2apic_send_IPI(int cpu, int vector)
 {
-	u32 dest = per_cpu(x86_cpu_to_logical_apicid, cpu);
+	u32 dest = x86_cpu_to_logical_apicid[cpu];
 
 	/* x2apic MSRs are special and need a special fence: */
 	weak_wrmsr_fence();
@@ -58,7 +64,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 
 		dest = 0;
 		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
-			dest |= per_cpu(x86_cpu_to_logical_apicid, clustercpu);
+			dest |= x86_cpu_to_logical_apicid[clustercpu];
 
 		if (!dest)
 			continue;
@@ -94,7 +100,7 @@ static void x2apic_send_IPI_all(int vector)
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
-	return per_cpu(x86_cpu_to_logical_apicid, cpu);
+	return x86_cpu_to_logical_apicid[cpu];
 }
 
 static void init_x2apic_ldr(void)
@@ -103,7 +109,7 @@ static void init_x2apic_ldr(void)
 	u32 cluster, apicid = apic_read(APIC_LDR);
 	unsigned int cpu;
 
-	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
+	x86_cpu_to_logical_apicid[smp_processor_id()] = apicid;
 
 	if (cmsk)
 		goto update;
@@ -166,12 +172,21 @@ static int x2apic_dead_cpu(unsigned int dead_cpu)
 
 static int x2apic_cluster_probe(void)
 {
+	u32 slots;
+
 	if (!x2apic_mode)
 		return 0;
 
+	slots = max_t(u32, L1_CACHE_BYTES/sizeof(u32), nr_cpu_ids);
+	x86_cpu_to_logical_apicid = kcalloc(slots, sizeof(u32), GFP_KERNEL);
+	if (!x86_cpu_to_logical_apicid)
+		return 0;
+
 	if (cpuhp_setup_state(CPUHP_X2APIC_PREPARE, "x86/x2apic:prepare",
 			      x2apic_prepare_cpu, x2apic_dead_cpu) < 0) {
 		pr_err("Failed to register X2APIC_PREPARE\n");
+		kfree(x86_cpu_to_logical_apicid);
+		x86_cpu_to_logical_apicid = NULL;
 		return 0;
 	}
 	init_x2apic_ldr();
-- 
2.33.0.882.g93a45727a2-goog


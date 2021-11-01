Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6F4411C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhKABS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39166 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhKABSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:41 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2FXTDgcUzpH3THChTljuF3o+vyXS8ekbi4IHYMQwefk=;
        b=z1TJMbZhrcACsiNWxJRxr/meSI7HDUquBDZI5yrQs4UisusZv9QUC3KKY+Js+rIrJ/JkUt
        R4166KNBF06vbxaMiiVKaqkPqxZltkAGzgyhihZ+/xb+v6G0o75kwcWdawKRmsn+YvvIrY
        tTZLTbOGVs7qqw2COwDVs2SLeDBnpkv9MOKK55pEysdkjcG5WjCNaTlabU/ZCifgri5kib
        v4Qn9bo8aW9Qv5Z/a+MFZJyNePPPHBzE38ClAEvmlIKsPPanIfyRFFcsEJtCu99t4jKGSI
        YWumm9H9r+wnK2WeQclyFts3wWUQZho7nPGxnvguRaYNT9ArrF2Iy4tzBEtrLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2FXTDgcUzpH3THChTljuF3o+vyXS8ekbi4IHYMQwefk=;
        b=HgdPzSXhZgNWA8eh63tV7De5zNtQKIMJW4C1NkyJOH9W7NjmY5jbeepi3+ZQu0LdY9oarv
        ZjYqhaf/g/KbHNCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572865146.3357115.6271807450024716473.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:16:07 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-11=
-01

up to:  cc95a07fef06: x86/apic: Reduce cache line misses in __x2apic_send_IPI=
_mask()


x86/apic related update:

  - A single commit which reduces cacheline misses in
    __x2apic_send_IPI_mask() significantly by converting
    x86_cpu_to_logical_apicid() to an array instead of using per CPU
    storage. This reduces the cost for a full broadcast on a dual socket
    system with 256 CPUs from 33 down to 11 microseconds.


Thanks,

	tglx

------------------>
Eric Dumazet (1):
      x86/apic: Reduce cache line misses in __x2apic_send_IPI_mask()


 arch/x86/kernel/apic/x2apic_cluster.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2a=
pic_cluster.c
index f4da9bb69a88..e696e22d0531 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -15,9 +15,15 @@ struct cluster_mask {
 	struct cpumask	mask;
 };
=20
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
=20
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
@@ -27,7 +33,7 @@ static int x2apic_acpi_madt_oem_check(char *oem_id, char *o=
em_table_id)
=20
 static void x2apic_send_IPI(int cpu, int vector)
 {
-	u32 dest =3D per_cpu(x86_cpu_to_logical_apicid, cpu);
+	u32 dest =3D x86_cpu_to_logical_apicid[cpu];
=20
 	/* x2apic MSRs are special and need a special fence: */
 	weak_wrmsr_fence();
@@ -58,7 +64,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vect=
or, int apic_dest)
=20
 		dest =3D 0;
 		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
-			dest |=3D per_cpu(x86_cpu_to_logical_apicid, clustercpu);
+			dest |=3D x86_cpu_to_logical_apicid[clustercpu];
=20
 		if (!dest)
 			continue;
@@ -94,7 +100,7 @@ static void x2apic_send_IPI_all(int vector)
=20
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
-	return per_cpu(x86_cpu_to_logical_apicid, cpu);
+	return x86_cpu_to_logical_apicid[cpu];
 }
=20
 static void init_x2apic_ldr(void)
@@ -103,7 +109,7 @@ static void init_x2apic_ldr(void)
 	u32 cluster, apicid =3D apic_read(APIC_LDR);
 	unsigned int cpu;
=20
-	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
+	x86_cpu_to_logical_apicid[smp_processor_id()] =3D apicid;
=20
 	if (cmsk)
 		goto update;
@@ -166,12 +172,21 @@ static int x2apic_dead_cpu(unsigned int dead_cpu)
=20
 static int x2apic_cluster_probe(void)
 {
+	u32 slots;
+
 	if (!x2apic_mode)
 		return 0;
=20
+	slots =3D max_t(u32, L1_CACHE_BYTES/sizeof(u32), nr_cpu_ids);
+	x86_cpu_to_logical_apicid =3D kcalloc(slots, sizeof(u32), GFP_KERNEL);
+	if (!x86_cpu_to_logical_apicid)
+		return 0;
+
 	if (cpuhp_setup_state(CPUHP_X2APIC_PREPARE, "x86/x2apic:prepare",
 			      x2apic_prepare_cpu, x2apic_dead_cpu) < 0) {
 		pr_err("Failed to register X2APIC_PREPARE\n");
+		kfree(x86_cpu_to_logical_apicid);
+		x86_cpu_to_logical_apicid =3D NULL;
 		return 0;
 	}
 	init_x2apic_ldr();


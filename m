Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB283A4EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFLMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:50:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:48:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so9681946wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s8a7mfWFvs6eC15ym/j9QuskAkF0kKv6MAdi4OI7cqY=;
        b=ZItJ93J1TRTOKVaIoVXtfxa3v/NAZIFDXHy377cPGr73f9LxpXFD4qTSaIpZjzits6
         /G9Dk/pnP6bv3/aFTtHbV+fhYrNwmObHMlHJzjH3XtpnqMpm0jHorsN1RW3NbVrRSgjS
         3Abcb3xiG6ed+RYOk1a1YG3PfGRiv/W6/53dSefZpCqRhWQngo6HJCEuQVuEBsWT6vTY
         xKiqdf8StcZLgV0Il90U3+0hM031wV/U9GrS7lU/D4kbvLiKuP6x5WtMSN6C6BWPpTiV
         agbIUIiYhMNR+7B3IotUmIeGNC0TJZEKSI3CsGZlOjChHvyMU3/EvgVqvqRopRX58D6L
         aXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=s8a7mfWFvs6eC15ym/j9QuskAkF0kKv6MAdi4OI7cqY=;
        b=ij9P/2Xuogq/XUwgVqJffE5uNvSZf91iLPDgqTi08C33m9C1BfuI++O3DTRaQKYabw
         wZrpCt8Cd+SmzNGp9j2haque9XvnAzqQPR5UZd+/la6qNujbKQ9eTw3AAIogrZfRsZJi
         2uUBJoXWaKtTILyvFaU+zIYOU2VUcjZmO/QpVwZEN2pW+w38c72cozzl+zRILx3WyuIU
         f7WauhaPEUo2C5n059f1TZpqH56wtYC2iiVdCoCy6mQ6ZVhfBIdXM2VhlHhOyIm8ke91
         IfNTB4eUYGL+yFwRhtQwQNLXqoEbc1T+xZIDZXGE/S8THFbMQnnp4IbgH8Rnb9/HzH+d
         cU9g==
X-Gm-Message-State: AOAM53302ncmIeODahczEZ2VOlT4evBSn+M7swUp678K3yx/wtqhwEh+
        +M6Kj+PQkO7/LJrgsOEA2Is=
X-Google-Smtp-Source: ABdhPJy8cIIwzoIqBFYhGtW1eo80sNvdBFWPcQjwF2A4u2g6O70a7rznPtCKjqeUAOyBAn9GrD6FdA==
X-Received: by 2002:a1c:4b12:: with SMTP id y18mr8213536wma.70.1623502098004;
        Sat, 12 Jun 2021 05:48:18 -0700 (PDT)
Received: from gmail.com (77-234-80-172.pool.digikabel.hu. [77.234.80.172])
        by smtp.gmail.com with ESMTPSA id k82sm16126524wmf.11.2021.06.12.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:48:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 12 Jun 2021 14:48:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <YMStDxqWUUZTxiz4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-12

   # HEAD: a8383dfb2138742a1bb77b481ada047aededa2ba x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel CPUs

Misc fixes:

 - Fix the NMI watchdog on ancient Intel CPUs

 - Remove a misguided, NMI-unsafe KASAN callback
   from the NMI-safe irq_work path used by perf.

 - Fix uncore events on Ice Lake servers.

 - Someone booted maxcpus=1 on an SNB-EP, and the
   uncore driver emitted warnings and was probably
   buggy. Fix it.

 - KCSAN found a genuine data race in the core perf
   code. Somewhat ironically the bug was introduced
   through a recent race fix. :-/ In our defense, the
   new race window was much more narrow. Fix it.

 Thanks,

	Ingo

------------------>
CodyYao-oc (1):
      x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel CPUs

Kan Liang (2):
      perf/x86/intel/uncore: Fix a kernel WARNING triggered by maxcpus=1
      perf/x86/intel/uncore: Fix M2M event umask for Ice Lake server

Marco Elver (1):
      perf: Fix data race between pin_count increment/decrement

Peter Zijlstra (1):
      irq_work: Make irq_work_queue() NMI-safe again


 arch/x86/events/intel/uncore_snbep.c   | 9 ++++++---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 4 ++--
 kernel/events/core.c                   | 2 ++
 kernel/irq_work.c                      | 3 ---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 63f097289a84..3a75a2c601c2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1406,6 +1406,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 						die_id = i;
 					else
 						die_id = topology_phys_to_logical_pkg(i);
+					if (die_id < 0)
+						die_id = -ENODEV;
 					map->pbus_to_dieid[bus] = die_id;
 					break;
 				}
@@ -1452,14 +1454,14 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			i = -1;
 			if (reverse) {
 				for (bus = 255; bus >= 0; bus--) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
 				}
 			} else {
 				for (bus = 0; bus <= 255; bus++) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
@@ -5097,9 +5099,10 @@ static struct intel_uncore_type icx_uncore_m2m = {
 	.perf_ctr	= SNR_M2M_PCI_PMON_CTR0,
 	.event_ctl	= SNR_M2M_PCI_PMON_CTL0,
 	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext	= SNR_M2M_PCI_PMON_UMASK_EXT,
 	.box_ctl	= SNR_M2M_PCI_PMON_BOX_CTL,
 	.ops		= &snr_m2m_uncore_pci_ops,
-	.format_group	= &skx_uncore_format_group,
+	.format_group	= &snr_m2m_uncore_format_group,
 };
 
 static struct attribute *icx_upi_uncore_formats_attr[] = {
diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index 3ef5868ac588..7aecb2fc3186 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,7 +63,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -96,7 +96,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..fe88d6eea3c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4609,7 +4609,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		ctx = &cpuctx->ctx;
 		get_ctx(ctx);
+		raw_spin_lock_irqsave(&ctx->lock, flags);
 		++ctx->pin_count;
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		return ctx;
 	}
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 23a7a0ba1388..db8c248ebc8c 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,9 +70,6 @@ bool irq_work_queue(struct irq_work *work)
 	if (!irq_work_claim(work))
 		return false;
 
-	/*record irq_work call stack in order to print it in KASAN reports*/
-	kasan_record_aux_stack(work);
-
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 	__irq_work_queue_local(work);

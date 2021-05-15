Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23833816A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhEOHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhEOHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:52:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7BC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:50:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k10so1852429ejj.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9sqvBsgHTmtDigZLFVgNZgTgUIqzxoevzD/YnZLFz94=;
        b=E2RJpw/SgDWJi8eLafqhx/nwtQJizlS/risVSP5Nb3lmLwZtjDgNMKUfy9V+W8RHPD
         pvW7YcdsdGrgM3yrni6RweTH4THasnGamA2gEaCZ6RF8H6+sDrfBT7xieYz985S2KMlF
         I9GorgM8Pj/YsCCMVefFERkxG5FFYfp62BWoMTw4lVfcuOI/rFCngNT0z+sS3u8/F1QN
         0aeNT/ucuCXhYQN2qmuDb7SQ2RQ31mM0lV4g8OMxt/nJ4A19lB40dolnBfdCt5zRdRDq
         gVMS1uoB94rQ/iuyv/vAMg/pJkTZQAW5Nj1SI118NVIhdG4YObN0XMZxxRnTTErf4UAj
         6/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=9sqvBsgHTmtDigZLFVgNZgTgUIqzxoevzD/YnZLFz94=;
        b=DWSqkNWj1ENl0eo5LOejjgJQXYDl0matrXhM0rw3psC/EEYUsct2MCKPjHZjE+dqWy
         3pSqFkfbsT5eQu3V88E7eaC823nJQvsQD+RPI7mhiz7CG8Ejx0vrhVpHYIoDFq9RZaXK
         TP3dT6nqiexQQFjmOaaynFskKrWKFul00oLfsm+sevWLBc99GK7htv+F7xz954uCd/vL
         fSIyWoB5YsVUKzI0cUcr5ZjTSX7IAw55pAfThec4mJkLysKsCoJBPn/ME1zaW1KOjAPx
         NPOX9fzj4TLzUPMEHfVTj2DLl+hRb6fEyMiAKH8B7OmItzYpfK/cF7Zn1PSUU43cm8aE
         6huQ==
X-Gm-Message-State: AOAM531fC+feP9jXvoek+nbNMk4PFPaJDHqZQ8TwbFOK5lSX/GkoStkc
        OcIpJKjGyC0nAlz9gTwr7oA=
X-Google-Smtp-Source: ABdhPJwfVuq5ngz9buqpN0hUGa8yxs7/wDsqGq/FH8oZ0KrKZ3CHJ0hFzPpo4SDopPHjn1bKAtUpSQ==
X-Received: by 2002:a17:907:2855:: with SMTP id el21mr3472195ejc.153.1621065045420;
        Sat, 15 May 2021 00:50:45 -0700 (PDT)
Received: from gmail.com (178-164-188-54.pool.digikabel.hu. [178.164.188.54])
        by smtp.gmail.com with ESMTPSA id bn5sm4889570ejb.97.2021.05.15.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:50:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 15 May 2021 09:50:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, juri@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20210515075041.GA201049@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-15

   # HEAD: 3743d55b289c203d8f77b7cd47c24926b9d186ae x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations

Fix an idle CPU selection bug, and an AMD Ryzen maximum frequency enumeration bug.

 Thanks,

	Ingo

------------------>
Gautham R. Shenoy (1):
      sched/fair: Fix clearing of has_idle_cores flag in select_idle_cpu()

Huang Rui (1):
      x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations


 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 16 ++++++++++++++++
 arch/x86/kernel/smpboot.c        |  2 +-
 drivers/cpufreq/acpi-cpufreq.c   |  6 +++++-
 kernel/sched/fair.c              |  2 +-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 154321d29050..556b2b17c3e2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -787,8 +787,10 @@ DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
+extern u32 amd_get_highest_perf(void);
 #else
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
+static inline u32 amd_get_highest_perf(void)		{ return 0; }
 #endif
 
 static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384dc9ab..6d7b3b3ea80b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1165,3 +1165,19 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+u32 amd_get_highest_perf(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
+			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
+		return 166;
+
+	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
+			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
+		return 166;
+
+	return 255;
+}
+EXPORT_SYMBOL_GPL(amd_get_highest_perf);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0ad5214f598a..7770245cc7fa 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2043,7 +2043,7 @@ static bool amd_set_max_freq_ratio(void)
 		return false;
 	}
 
-	highest_perf = perf_caps.highest_perf;
+	highest_perf = amd_get_highest_perf();
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!highest_perf || !nominal_perf) {
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d1bbc16fba4b..7e7450453714 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -646,7 +646,11 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 		return 0;
 	}
 
-	highest_perf = perf_caps.highest_perf;
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		highest_perf = amd_get_highest_perf();
+	else
+		highest_perf = perf_caps.highest_perf;
+
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!highest_perf || !nominal_perf) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20aa234ffe04..3248e24a90b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6217,7 +6217,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	}
 
 	if (has_idle_core)
-		set_idle_cores(this, false);
+		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;

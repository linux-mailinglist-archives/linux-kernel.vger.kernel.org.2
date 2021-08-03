Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272E93DF003
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhHCORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbhHCORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28708C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:09 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1+QaFT3UycYD/xp/akolBv+hh3k13vcfDdpl0mYK1Q=;
        b=xn8G2QHbby2dNo8w6b8BKYnFSmh29C0l+HudmlgY5H6MscbucWT18raRMeW0lgGX/NuNyg
        1pDUrYsNa3gDI0q4+snfEtvwu8T7cjQtu2H0lSi6vzKzz/cXIySS5dOO2iMyox368mPfeJ
        sf5YqEJnjba3hph4vI+OFQyp0HYh0NpMBocq00ujUpzuG2p2OFluNnnUdi27LN2Zwqj3xv
        pXQ/C412Yk4/8jggAZV8JcrZXZB5buXlnAcKsOve15VQNSoqr1aAXfLGkkLOeJezD1rthp
        FkEP2qrolSu0faXwY1i19KcLn6VBrxaBjb2QkuEA4jZ1y7ZDe5Yc0vifhOsCUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1+QaFT3UycYD/xp/akolBv+hh3k13vcfDdpl0mYK1Q=;
        b=B5o8NJrpMVLD5Xw+VhpAEecfD6ydU+ds51ILHnmNjiyPZOBm4GmGcdhj1UtqLHL2Ew4ieh
        Wk7drciCFDJM2NDg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 10/38] perf/x86/intel: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:53 +0200
Message-Id: <20210803141621.780504-11-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/events/intel/core.c | 8 ++++----
 arch/x86/events/intel/pt.c   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fca7a6e2242fe..a7b04c8ae4f69 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5026,9 +5026,9 @@ static ssize_t freeze_on_smi_store(struct device *cde=
v,
=20
 	x86_pmu.attr_freeze_on_smi =3D val;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(flip_smm_bit, &val, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 done:
 	mutex_unlock(&freeze_on_smi_mutex);
=20
@@ -5071,9 +5071,9 @@ static ssize_t set_sysctl_tfa(struct device *cdev,
=20
 	allow_tsx_force_abort =3D val;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(update_tfa_sched, NULL, 1);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return count;
 }
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 915847655c065..0369a238cdfb1 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1708,7 +1708,7 @@ static __init int pt_init(void)
 	if (!boot_cpu_has(X86_FEATURE_INTEL_PT))
 		return -ENODEV;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		u64 ctl;
=20
@@ -1716,7 +1716,7 @@ static __init int pt_init(void)
 		if (!ret && (ctl & RTIT_CTL_TRACEEN))
 			prior_warn++;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (prior_warn) {
 		x86_add_exclusive(x86_lbr_exclusive_pt);
--=20
2.32.0


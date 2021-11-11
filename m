Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7329544D372
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhKKIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhKKIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0340C06127A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z65-20020a256544000000b005c21b35717dso8295054ybb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UY5ZmEP2nwLXwsMnLizVHzfWA4j3j7aREVkSOdMYM+c=;
        b=b7kjq8ecMFxPi3TkMMAIVQlD8bZ+b9mdEuL/LSIqLx607X9B8scUQ35rtGuNzdrqlq
         f2S2OZXsjBXi3uvElely/5WH6NDwj2ah40/Hnyy0OIFWKJ6wuvqXy/WRmBRaUcn4+/hr
         s8pMbBC4elXFtbnjyKgKOTdq5KQhS0RdJWVIjAQwzQz/ND3VDoGP/kw5Ku8GVwcB6lZK
         2wZGoiNw0DOpaKuDxMbjB8XaTJZwQz7E3GTvHtifHW01oahSViCb3MLgtoMb/OZ1JGaU
         fkQphGT8oiuYfjdMcNhun2wVtI7UN79qTP+DgzO8pUbD6qionouUJ+r+0SF2waK94ppr
         munQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UY5ZmEP2nwLXwsMnLizVHzfWA4j3j7aREVkSOdMYM+c=;
        b=VrCT38QIDdEu9RKHbkjA4zwIojAsmbm9QoNRy0yh6PPsTJwddk1PTZDCZE516slgIk
         Z+HRnv+cEhCHCQhukm/yuzhWNLMeIh1BoGrGAFXXZVB2fhvlLnN8M3AFDQKdiDgZ5iFP
         D6CrdUSEGf1zDwziZ6kMvvqXLtRB9C4rIMLIPtuQ1XKVWm7bzWPPkdms7pM107aECOgb
         LoyOVq9Pbd2/2R8YbPukmHQ1vv+ksuWFdqvb6NVFIaPO8Z2lu0TDpfmkAgCsYq/Tpwwf
         JfOaRGY3p999U+4UrCW9Fr3jORWBL0AWaB74OmvJWowbrw8SPaLWwNiubtCE1VC/kYl0
         1W4Q==
X-Gm-Message-State: AOAM530kzF9LDxH4MTzeAjHg8RnEftOPwGxhDrclm/u9udvRJ/Ml+tE+
        svhz9HWjR878246+1kmkY1FgDz7WOjTtdrrqvOeyIbBFyxER9PPIxJnh6YlHvGQTLLaXvz6Z4ol
        42AskQm/Moi+4QS7gCtbu9P5wyomMcQfxqXvOY+Ts138ifQnvR94pgr6lCX4jf858MN4LO+6I
X-Google-Smtp-Source: ABdhPJwBL/DcSDGtKhr8k3DbQmuyy2EF1jiwRcelTlcum6yqzH2pMMfo2L/bjpOJvRggKYOCzd8Iuj1NIRiN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:71d5:: with SMTP id
 m204mr6041698ybc.374.1636620695052; Thu, 11 Nov 2021 00:51:35 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:11 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-10-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 09/13] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before
entering low power and re-enabled (if was active) when returning from low
power. Otherwise, the NMI interrupt may be held up for too long and cause
problems. Stopping BRS will cause the NMI to be delivered if it was held up.

The patch defines a perf_amd_brs_lopwr_cb() callback to stop/restart BRS.
The callback is protected by a jump label which is enabled only when AMD BRS
is detected. In all other cases, the callback is never called.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c         | 32 +++++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c        |  4 ++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h | 21 ++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 771c4248979e..09697e0f6dc0 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -7,6 +7,7 @@
  * Contributed by Stephane Eranian <eranian@google.com>
  */
 #include <linux/kernel.h>
+#include <linux/jump_label.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 
@@ -315,3 +316,34 @@ void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
 	if (sched_in)
 		amd_brs_poison_buffer();
 }
+
+DEFINE_STATIC_KEY_FALSE(perf_lopwr_needed);
+
+/*
+ * called from ACPI processor_idle.c or acpi_pad.c
+ * with interrupts disabled
+ */
+void perf_amd_brs_lopwr_cb(bool lopwr_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union amd_debug_extn_cfg cfg;
+
+	/*
+	 * on mwait in, we may end up in non C0 state.
+	 * we must disable branch sampling to avoid holding the NMI
+	 * for too long. We disable it in hardware but we
+	 * keep the state in cpuc, so we can re-enable.
+	 *
+	 * The hardware will deliver the NMI if needed when brsmen cleared
+	 */
+	if (cpuc->brs_active) {
+		cfg.val = get_debug_extn_cfg();
+		cfg.brsmen = !lopwr_in;
+		set_debug_extn_cfg(cfg.val);
+	}
+}
+
+void __init amd_brs_lopwr_init(void)
+{
+	static_branch_enable(&perf_lopwr_needed);
+}
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d47cc2c6d85c..8f2bf25d34e2 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/perf_event.h>
+#include <linux/jump_label.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -1193,6 +1194,9 @@ static int __init amd_core_pmu_init(void)
 			 * The put_event_constraints callback is shared with
 			 * Fam17h, set above
 			 */
+
+			/* branch sampling must be stopped when entering low power */
+			amd_brs_lopwr_init();
 		}
 	}
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f8dc8faed584..c129aaacfb3d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1219,6 +1219,7 @@ int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
 void amd_brs_drain(void);
+void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
 int amd_brs_setup_filter(struct perf_event *event);
 void amd_brs_reset(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc1b5003713..e405847ccb56 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -513,6 +513,27 @@ static inline void intel_pt_handle_vmx(int on)
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
  extern void amd_pmu_enable_virt(void);
  extern void amd_pmu_disable_virt(void);
+
+#if defined(CONFIG_PERF_EVENTS_AMD_BRS)
+
+#define PERF_NEEDS_LOPWR_CB 1
+
+/*
+ * architectural low power callback impacts
+ * drivers/acpi/processor_idle.c
+ * drivers/acpi/acpi_pad.c
+ */
+extern void perf_amd_brs_lopwr_cb(bool lopwr_in);
+DECLARE_STATIC_KEY_FALSE(perf_lopwr_needed);
+
+static inline void perf_lopwr_cb(bool mode)
+{
+	/* key enabled only when BRS is available */
+	if (static_branch_unlikely(&perf_lopwr_needed))
+		perf_amd_brs_lopwr_cb(mode);
+}
+#endif /* PERF_NEEDS_LOPWR_CB */
+
 #else
  static inline void amd_pmu_enable_virt(void) { }
  static inline void amd_pmu_disable_virt(void) { }
-- 
2.34.0.rc0.344.g81b53c2807-goog


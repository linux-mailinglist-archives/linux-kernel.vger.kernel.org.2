Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC20373317
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEEA25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhEEA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:28:51 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E6C06138A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:27:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z5-20020a05622a0285b02901b943be06b5so4708155qtw.17
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=SfWc48+ZNOApnJRY/spQcgTuKI/wNOhy/7yw1UF2NV8=;
        b=BO/aiJAc6tdUvLuW9QftVeltD62ugVH9EmGKi3YkWDdYHrrK7ZnpORhGAdrIB09iP6
         NbtxXECjPN8wePDHkQ2LAQIlWCUpaQRGJ1o68PMkD1X/gd9p1dp+Ti7pnVwU2DWBqoKo
         PWID2FF/hQcrUfSffEuKAZ+x60keZ98KDODLwGn1M8JVBq8Oy3rVyxCSbpx1Ock1MQ/n
         WC0qtRA83Mn6EM/57AAvYP1mGvqnYCGMDsXbAIfFr3pDCsylzpFHIRRvqXac73XlJoJB
         +cxFkn6RYMYVfq28JPyriZvvSrS4IgXUT4RcEpwJK7N2ppC1dvtHiu9l90TMtzCTE3aN
         lGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=SfWc48+ZNOApnJRY/spQcgTuKI/wNOhy/7yw1UF2NV8=;
        b=ungGY2b0jBefTf9VFLFq+jYbK+m5xHXpXsYnl6rbJtMD/7wNW2y1bA/Rlg2s4o/q+C
         URaoc2uzn+WVKV7QF+WoQLcTzCFzaZptVb6cLbg3pY5mRvJ23CR2TwUBuaKyZw7qvccV
         7Utf9TZVMz8XhP6cIDABTN5LDEdgncZN/hJZk5qu+Ggx4Aqbf8AFFESf8zIip7hIlYUV
         DO7pEcAofr1GA14evcZYQMRnWxPBnLb1sx11xPLbDieXJulQ3vYWG+HLtcYSAiB8e7HK
         LSSBGO+vY3hdjUT+0kturmfSuAMAWrOrKzwqMs3EnCyui5czoCLYec/hn0y13EKWzVjB
         lmBw==
X-Gm-Message-State: AOAM532aW/yXKvGlOEFprzeNfz7jcOsQkNzXLYwRyQ5MF/7fRNGRXcu+
        lQXNgs9LwmocHYwT1OI2un6mEgCwZpc=
X-Google-Smtp-Source: ABdhPJwAMJPTQOgUCgSW4eJSjKgwzc379NTiF4vEoX+eQGUARH/I0B0Hu9pOSde5QVZ3gcOMToGCuG+vFRE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a0c:fec8:: with SMTP id z8mr28951786qvs.58.1620174473799;
 Tue, 04 May 2021 17:27:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 17:27:31 -0700
In-Reply-To: <20210505002735.1684165-1-seanjc@google.com>
Message-Id: <20210505002735.1684165-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210505002735.1684165-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 4/8] sched/vtime: Move vtime accounting external
 declarations above inlines
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the blob of external declarations (and their stubs) above the set of
inline definitions (and their stubs) for vtime accounting.  This will
allow a future patch to bring in more inline definitions without also
having to shuffle large chunks of code.

No functional change intended.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/vtime.h | 94 +++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 041d6524d144..6a4317560539 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -10,53 +10,6 @@
 
 struct task_struct;
 
-/*
- * vtime_accounting_enabled_this_cpu() definitions/declarations
- */
-#if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
-
-static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
-extern void vtime_task_switch(struct task_struct *prev);
-
-#elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
-
-/*
- * Checks if vtime is enabled on some CPU. Cputime readers want to be careful
- * in that case and compute the tickless cputime.
- * For now vtime state is tied to context tracking. We might want to decouple
- * those later if necessary.
- */
-static inline bool vtime_accounting_enabled(void)
-{
-	return context_tracking_enabled();
-}
-
-static inline bool vtime_accounting_enabled_cpu(int cpu)
-{
-	return context_tracking_enabled_cpu(cpu);
-}
-
-static inline bool vtime_accounting_enabled_this_cpu(void)
-{
-	return context_tracking_enabled_this_cpu();
-}
-
-extern void vtime_task_switch_generic(struct task_struct *prev);
-
-static inline void vtime_task_switch(struct task_struct *prev)
-{
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_task_switch_generic(prev);
-}
-
-#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
-
-static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
-static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
-static inline void vtime_task_switch(struct task_struct *prev) { }
-
-#endif
-
 /*
  * Common vtime APIs
  */
@@ -94,6 +47,53 @@ static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
+/*
+ * vtime_accounting_enabled_this_cpu() definitions/declarations
+ */
+#if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
+
+static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
+extern void vtime_task_switch(struct task_struct *prev);
+
+#elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
+
+/*
+ * Checks if vtime is enabled on some CPU. Cputime readers want to be careful
+ * in that case and compute the tickless cputime.
+ * For now vtime state is tied to context tracking. We might want to decouple
+ * those later if necessary.
+ */
+static inline bool vtime_accounting_enabled(void)
+{
+	return context_tracking_enabled();
+}
+
+static inline bool vtime_accounting_enabled_cpu(int cpu)
+{
+	return context_tracking_enabled_cpu(cpu);
+}
+
+static inline bool vtime_accounting_enabled_this_cpu(void)
+{
+	return context_tracking_enabled_this_cpu();
+}
+
+extern void vtime_task_switch_generic(struct task_struct *prev);
+
+static inline void vtime_task_switch(struct task_struct *prev)
+{
+	if (vtime_accounting_enabled_this_cpu())
+		vtime_task_switch_generic(prev);
+}
+
+#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
+
+static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
+static inline void vtime_task_switch(struct task_struct *prev) { }
+
+#endif
+
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
-- 
2.31.1.527.g47e6f16901-goog


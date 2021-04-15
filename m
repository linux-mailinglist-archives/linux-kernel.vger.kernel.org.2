Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2B36155B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhDOWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhDOWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o17-20020ac869910000b02901a7c59f1c14so4954000qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ejNz6/mRycQ/8a4gZzvJd7025j920aJ4l8YEJ/7oL7w=;
        b=ex93+VhLDEnZyrU3fa14LC/l+d4QG+7TX3kkWOj6bc2ImObzfFwIA0H3Ej6OsaJ25/
         bXuSwIJLlLOWYitYmKqt6QfIfi4S55+UeHd6P/lXrdZqzvAFESJQrDcATMLmaeFyu/bJ
         V0IszkhtV/E8vmxCdhqRdF6h9PDRJHpPfOe+QryANb8Fwh5Gi8f8IZF+VpBy7KqNY7qV
         3h/Om4MO5KMZyf5Il785WcYyhTzZo/B/Uqxzh3/fzQJYfDdAUpzb50KLrFkzjYHgFWsA
         rhzCNKhQfbSItqxPNuB+B4tUE0G0MBCvwwAUYHlxRPE8XatqhsPf7AjfuNmKVeH5BjxK
         Xyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ejNz6/mRycQ/8a4gZzvJd7025j920aJ4l8YEJ/7oL7w=;
        b=NOe0PMRrFKGQWVRupbHsAQK/w8oGZVFOrSuOkdq/HZgc2r0Yxo0jn87KABkJv7O9XK
         fi0ZjaJcO1UwNmf6XpDMl90jQu7y0Rg6nE6JtUImniS9ckvzJgITNLnQRI/UutoBPqsd
         VxNfJOGN04BWDJvkvETKc/8umrlnOk9mJJFmuY9iqJ7x3gqIYuZysYl5mVbMaj4ho4TL
         m6hslSxD4QmePHh+QTXk/m3ES0yOtUWdOoN8YMx8/1qh18oVIZH4yhRNeuKN7MhH/K+6
         kn8Qp8qxzr9RP0ZTjis7OqOw9OhKO+/xruBkQcWYGbsTKRvPgST9zSdyItBlATttyj0k
         YMVQ==
X-Gm-Message-State: AOAM530x/2En+3x7XnsfWSbTZTW2D6Sq/C0vGrBpv6r6JiMZEgii8shl
        s1iEZbXj9NriedavlXg3zM/8SGKZ7y8=
X-Google-Smtp-Source: ABdhPJzf+ldPvj6Fg4gh6aAz/cRIuHFFV6MjRkz9wisPDwSyKPmpjYPOqJcN0ic3Jp8qnjnXL7/Vcfx6ldE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:ad4:4f84:: with SMTP id em4mr5435608qvb.26.1618525282494;
 Thu, 15 Apr 2021 15:21:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:21:01 -0700
In-Reply-To: <20210415222106.1643837-1-seanjc@google.com>
Message-Id: <20210415222106.1643837-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210415222106.1643837-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 4/9] sched/vtime: Move vtime accounting external
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
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the blob of external declarations (and their stubs) above the set of
inline definitions (and their stubs) for vtime accounting.  This will
allow a future patch to bring in more inline definitions without also
having to shuffle large chunks of code.

No functional change intended.

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
2.31.1.368.gbe11c130af-goog


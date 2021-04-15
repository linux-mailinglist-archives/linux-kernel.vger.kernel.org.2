Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A1361561
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhDOWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhDOWVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A72C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e187so3961170yba.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GxVp+ryze51SPBwC3MTXA+xy9qBEqXXT0EKwo/t1PP8=;
        b=FfHMOfr4Q3Myap3t2mwmp1oRd7b57KdkfdzZDDLFiAyG4mWLRZ4cIjmr7JpMPhg9Ad
         TyAQWEXgFiD3k2RYMGxRkZ3OatJQwIH9Grt6VHWA1kkb9kI/sz3dUMFv8Mv0JDgN3pUk
         ZHZMOXha6V3X5iMGJxDeNzgP5e4nomVqXO5PMpAQyH4uOaQTk5BgS877mSycz9vH+XcA
         0vjLrFAKPizs/JHbpGX2IENWOJMGz5vAp8DD3ywh2xKBE3/VlV8KorPLiDUkQdEKqZ9s
         KDyltpcE81/KElbpgmWkVMT8u01t4/p1/4fbBHUFENaSsgywO4IPTGoqM2d7g4riOxFM
         zytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GxVp+ryze51SPBwC3MTXA+xy9qBEqXXT0EKwo/t1PP8=;
        b=UGbEgY1Kewn27jLczjuwc1FSEdFXJqyUMhoOjL0BHfLEkH6Adju1nkdnCgxRmSGAiG
         r3o8zuYRXhAsRJu7su37di/1ZlJsPNPbKrlLAZYJ1YDVHTllpCZSLdlAWSN0AjyzzzMl
         2JrJpPqWA0ghL1kF6QW45A4oyr8Kej9poXQxYDMUd0nK/yyqagOrVCANV95lOF13DhzF
         H4s0JOPQLzyDl7EDW1s9eHpPNawwMvmwc6V5gh0PGNXTl5tUEm0q6ACYAtu2/L+X/Ewz
         HqlyAePMQqBN4BDk8xF/R7TsS781jIU1ZvG0djzTjcjbSDKWGVR1EM1z6Bmlu5tvCEVP
         ihFA==
X-Gm-Message-State: AOAM531EH5/NDJ6/Crh3vyIxq7+5b83E7QAB1Z3KJ+5mNXJm+DnpCz/D
        9VmXWN/ELdMK7GZtIIEh3cuEbgN1rE4=
X-Google-Smtp-Source: ABdhPJy13lXczJDkYzHt9Br8KeDanZBPTQtGMChtFt9J9YcQr5yvscDjY6/LGh4Ti4U7Y9aMDQCI1NIGrnM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:a25:818f:: with SMTP id p15mr7234120ybk.135.1618525287170;
 Thu, 15 Apr 2021 15:21:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:21:03 -0700
In-Reply-To: <20210415222106.1643837-1-seanjc@google.com>
Message-Id: <20210415222106.1643837-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210415222106.1643837-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 6/9] context_tracking: Consolidate guest enter/exit wrappers
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

Consolidate the guest enter/exit wrappers, providing and tweaking stubs
as needed.  This will allow moving the wrappers under KVM without having
to bleed #ifdefs into the soon-to-be KVM code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 65 ++++++++++++--------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 1c05035396ad..e172a547b2d0 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -71,6 +71,19 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 	}
 }
 
+static __always_inline bool context_tracking_guest_enter_irqoff(void)
+{
+	if (context_tracking_enabled())
+		__context_tracking_enter(CONTEXT_GUEST);
+
+	return context_tracking_enabled_this_cpu();
+}
+
+static __always_inline void context_tracking_guest_exit_irqoff(void)
+{
+	if (context_tracking_enabled())
+		__context_tracking_exit(CONTEXT_GUEST);
+}
 
 /**
  * ct_state() - return the current context tracking state if known
@@ -92,6 +105,9 @@ static inline void user_exit_irqoff(void) { }
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
+static inline bool context_tracking_guest_enter_irqoff(void) { return false; }
+static inline void context_tracking_guest_exit_irqoff(void) { }
+
 #endif /* !CONFIG_CONTEXT_TRACKING */
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
@@ -102,74 +118,41 @@ extern void context_tracking_init(void);
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_FORCE */
 
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 /* must be called with irqs disabled */
 static __always_inline void guest_enter_irqoff(void)
 {
+	/*
+	 * This is running in ioctl context so its safe to assume that it's the
+	 * stime pending cputime to flush.
+	 */
 	instrumentation_begin();
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_guest_enter(current);
-	else
-		current->flags |= PF_VCPU;
+	vtime_account_guest_enter();
 	instrumentation_end();
 
-	if (context_tracking_enabled())
-		__context_tracking_enter(CONTEXT_GUEST);
-
-	/* KVM does not hold any references to rcu protected data when it
+	/*
+	 * KVM does not hold any references to rcu protected data when it
 	 * switches CPU into a guest mode. In fact switching to a guest mode
 	 * is very similar to exiting to userspace from rcu point of view. In
 	 * addition CPU may stay in a guest mode for quite a long time (up to
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_enabled_this_cpu()) {
+	if (!context_tracking_guest_enter_irqoff()) {
 		instrumentation_begin();
 		rcu_virt_note_context_switch(smp_processor_id());
 		instrumentation_end();
 	}
 }
 
-static __always_inline void context_tracking_guest_exit_irqoff(void)
-{
-	if (context_tracking_enabled())
-		__context_tracking_exit(CONTEXT_GUEST);
-}
-
 static __always_inline void guest_exit_irqoff(void)
 {
 	context_tracking_guest_exit_irqoff();
 
-	instrumentation_begin();
-	vtime_account_guest_exit();
-	instrumentation_end();
-}
-
-#else
-static __always_inline void guest_enter_irqoff(void)
-{
-	/*
-	 * This is running in ioctl context so its safe
-	 * to assume that it's the stime pending cputime
-	 * to flush.
-	 */
-	instrumentation_begin();
-	vtime_account_guest_enter();
-	rcu_virt_note_context_switch(smp_processor_id());
-	instrumentation_end();
-}
-
-static __always_inline void context_tracking_guest_exit_irqoff(void) { }
-
-static __always_inline void guest_exit_irqoff(void)
-{
 	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
 	vtime_account_guest_exit();
 	instrumentation_end();
 }
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
 static inline void guest_exit(void)
 {
-- 
2.31.1.368.gbe11c130af-goog


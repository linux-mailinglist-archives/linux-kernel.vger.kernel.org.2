Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2C35E66B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347824AbhDMSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347778AbhDMSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:30:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:29:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t9so6562360ybd.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=AhK+PdPT0LRbakoGPPXo/hynrvPFe53sqM1A79hFvVA=;
        b=QsrzaSyiEiTWFirkcNGK9TJrojxXCLaN/e7xs774HbN2WOrLyoP6OKOrPFl7JAHwrP
         hHX6XDaVdzgeIh7IIKCFi05cekPZrhoMhzvt8bRYabcQIWLn14p08OXNq5kCbDLNjJ5I
         Al6XeuqqogCeFQS8QQgKSNhjv/2x37QTT381MvINIA2vgK8awxT0DFgu1fqZKdOh4nZ8
         nU0w+f3UPdFrn/0ZiMFAfGs6a1D0/OCaxzxY5F2qyPCX7xyt3F9zM4k5zKK1RNFDXQJh
         s9K859eLgXhDIIr7pDD2oLvAyQTyHsbRssJRDgv4RR21Na376L2i4vksVNoM/J9c27IH
         f6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=AhK+PdPT0LRbakoGPPXo/hynrvPFe53sqM1A79hFvVA=;
        b=SHkHnh+XBykjsXDDH2SN4hnN+8T2LpzEjmhF7pEUd/UvMeI4yDNLqx9wXMvsc89nRE
         Izm850V93Ww7c3xGEVpj2E84/eev+3qtF/0BunKcAEYaYCqESSd3UBVxzaryZnr4Ca5j
         GUpMYHYg/5zh8L6CvOUR6sWDxNvN2CA88NNIuwO+yuLmFp1yDYq/ZXHKgAo3sq7GDbqG
         +7NarNbypRSxP87qANGLR1HaPf38dyz3Fe8L14EQaOKIGPw1W8PvWaA2fd/nu1z9iUGx
         BDDuMZ0TIJagmJhnN8Q5mG0hQRrfn0xnSuJVkvJxw/Yo1XH1u0M1GhkfI1K+datA0z4d
         o8QQ==
X-Gm-Message-State: AOAM531JqtlVAcwDDL01iI81vRwOjJzbGCy5z8Q9qbwybBbP6HYTVptS
        9dN4m/sv50Tkn7UTJQsuCqUu2ZgMH0M=
X-Google-Smtp-Source: ABdhPJwvR1+cpyxhL5YKp5jJoNNdVmTT+kVymEazBfx+83t2uMh2pzzpWf4WT350QSUJynWww11fBJSHo7k=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f031:9c1c:56c7:c3bf])
 (user=seanjc job=sendgmr) by 2002:a25:8a83:: with SMTP id h3mr40519051ybl.354.1618338589262;
 Tue, 13 Apr 2021 11:29:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Apr 2021 11:29:30 -0700
In-Reply-To: <20210413182933.1046389-1-seanjc@google.com>
Message-Id: <20210413182933.1046389-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210413182933.1046389-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [RFC PATCH 4/7] context_tracking: KVM: Move guest enter/exit wrappers
 to KVM's domain
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the guest enter/exit wrappers to kvm_host.h so that KVM can manage
its context tracking vs. vtime accounting without bleeding too many KVM
details into the context tracking code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 45 --------------------------------
 include/linux/kvm_host.h         | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index ded56aed539a..2f4538380a8d 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -126,49 +126,4 @@ extern void context_tracking_init(void);
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_FORCE */
 
-/* must be called with irqs disabled */
-static __always_inline void guest_enter_irqoff(void)
-{
-	/*
-	 * This is running in ioctl context so its safe to assume that it's the
-	 * stime pending cputime to flush.
-	 */
-	instrumentation_begin();
-	vtime_account_guest_enter();
-	instrumentation_end();
-
-	/*
-	 * KVM does not hold any references to rcu protected data when it
-	 * switches CPU into a guest mode. In fact switching to a guest mode
-	 * is very similar to exiting to userspace from rcu point of view. In
-	 * addition CPU may stay in a guest mode for quite a long time (up to
-	 * one time slice). Lets treat guest mode as quiescent state, just like
-	 * we do with user-mode execution.
-	 */
-	if (!context_tracking_guest_enter_irqoff()) {
-		instrumentation_begin();
-		rcu_virt_note_context_switch(smp_processor_id());
-		instrumentation_end();
-	}
-}
-
-static __always_inline void guest_exit_irqoff(void)
-{
-	context_tracking_guest_exit_irqoff();
-
-	instrumentation_begin();
-	/* Flush the guest cputime we spent on the guest */
-	vtime_account_guest_exit();
-	instrumentation_end();
-}
-
-static inline void guest_exit(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_exit_irqoff();
-	local_irq_restore(flags);
-}
-
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b06d12ec37e..444d5f0225cb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -332,6 +332,51 @@ struct kvm_vcpu {
 	struct kvm_dirty_ring dirty_ring;
 };
 
+/* must be called with irqs disabled */
+static __always_inline void guest_enter_irqoff(void)
+{
+	/*
+	 * This is running in ioctl context so its safe to assume that it's the
+	 * stime pending cputime to flush.
+	 */
+	instrumentation_begin();
+	vtime_account_guest_enter();
+	instrumentation_end();
+
+	/*
+	 * KVM does not hold any references to rcu protected data when it
+	 * switches CPU into a guest mode. In fact switching to a guest mode
+	 * is very similar to exiting to userspace from rcu point of view. In
+	 * addition CPU may stay in a guest mode for quite a long time (up to
+	 * one time slice). Lets treat guest mode as quiescent state, just like
+	 * we do with user-mode execution.
+	 */
+	if (!context_tracking_guest_enter_irqoff()) {
+		instrumentation_begin();
+		rcu_virt_note_context_switch(smp_processor_id());
+		instrumentation_end();
+	}
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit_irqoff();
+
+	instrumentation_begin();
+	/* Flush the guest cputime we spent on the guest */
+	vtime_account_guest_exit();
+	instrumentation_end();
+}
+
+static inline void guest_exit(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	guest_exit_irqoff();
+	local_irq_restore(flags);
+}
+
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.31.1.295.g9ea45b61b8-goog


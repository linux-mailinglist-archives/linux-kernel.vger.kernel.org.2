Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A13F91B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbhH0A7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbhH0A7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 20:59:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFAC0611DD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 17:57:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z8-20020a25ad88000000b0059a94ada16fso4886530ybi.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=O3P/C2+r50j2qd2oZl4HIFqUJ1Gm6eQIurE1pthLu88=;
        b=KoGI0t2ANmOACIY8bQhuBH4FJbrSHsRwhYJXWmn01ufiEJZVk4tPOEhaZ6T1MAQL+U
         jhUGDn7yZArl2k29+8gFqfCF2DSg2n6fTQ6je+tOvHWwtuk6IOGhYE1XQmYmAQV0Z6yb
         UcRXDhGukzYa0e3OogJgHIniy20AUzkgcDYnuJ9TMbdSfPm19k9DAbSEVKXLmzcP7bku
         dkqNoqFL3rJ6iAJ27Dy3HXfxWITTJ68h7TnziapcFth9ZxiSCsQJGqvRdjvidglqsZgx
         4yCjuWco92qzMYV8AJs3vnXk8sqdZ/Z/v4yFDjKSCTqWPBnhz4PL5zWola/ctdZ9nHLd
         axcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=O3P/C2+r50j2qd2oZl4HIFqUJ1Gm6eQIurE1pthLu88=;
        b=LqLpO6qTkTi7Mu87uLSOhuw2HTmSGNrHidWY1dALWn0YWUS/emcfDsuFvEmXl9NHc4
         a80zDd5opM6oe8SkK/P1IpD198h492ovL/W01zaLDFWynkbNmkGafx1es+LbiRZxLIsR
         jHmEpUfstSRfvEPzWEXN0f0PfLIf7AeArtpzihZUZKCwBKyEv96/nZnS1INlF+f+HHnW
         7NQQZhQCyUknqgbme54P9H/FaxpleaNzGywcA2UJXPoZhhsJBgI4+gOKMUBRT+L+YSx1
         p1AFDMMSQTinC+vg/J4I9rsJXhp+molrAo7S8NgRzSm0pSgQ19KP2bKRbNejEOTWTAw9
         ghSQ==
X-Gm-Message-State: AOAM532R71Umw8QW4FdD9ot+tp6mfMxfAz7WDyAE4PID6VRY5VJZQ1yS
        DgKlV6uI+iuU89BQDtAxALzBJi7bZEc=
X-Google-Smtp-Source: ABdhPJyKjk6geoVg3b6/+yDfPSeW/L1PMiXY41SolyC47I84TPxrPvrL+bKgY05p4LEuynGQ+EFAFv5UkSk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:c16c:db05:96b2:1475])
 (user=seanjc job=sendgmr) by 2002:a25:dcd3:: with SMTP id y202mr2039489ybe.161.1630025876285;
 Thu, 26 Aug 2021 17:57:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 Aug 2021 17:57:15 -0700
In-Reply-To: <20210827005718.585190-1-seanjc@google.com>
Message-Id: <20210827005718.585190-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210827005718.585190-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 12/15] KVM: arm64: Convert to the generic perf callbacks
From:   Sean Christopherson <seanjc@google.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.  Implement the "get ip"
hook as needed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  6 +----
 arch/arm64/kvm/arm.c              |  5 ++++
 arch/arm64/kvm/perf.c             | 38 -------------------------------
 3 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 007c38d77fd9..12e8d789e1ac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -673,11 +673,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 void kvm_perf_init(void);
 
 #ifdef CONFIG_PERF_EVENTS
-void kvm_register_perf_callbacks(void);
-static inline void kvm_unregister_perf_callbacks(void)
-{
-	__perf_unregister_guest_info_callbacks();
-}
+#define __KVM_WANT_PERF_CALLBACKS
 #else
 static inline void kvm_register_perf_callbacks(void) {}
 static inline void kvm_unregister_perf_callbacks(void) {}
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ec386971030d..dfc8078dd4f9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -503,6 +503,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return *vcpu_pc(vcpu);
+}
+
 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
 {
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 2556b0a3b096..ad9fdc2f2f70 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,44 +13,6 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-#ifdef CONFIG_PERF_EVENTS
-static int kvm_is_in_guest(void)
-{
-	return true;
-}
-
-static int kvm_is_user_mode(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return !vcpu_mode_priv(vcpu);
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.is_in_guest	= kvm_is_in_guest,
-	.is_user_mode	= kvm_is_user_mode,
-	.get_guest_ip	= kvm_get_guest_ip,
-};
-
-void kvm_register_perf_callbacks(void)
-{
-	__perf_register_guest_info_callbacks(&kvm_guest_cbs);
-}
-#endif /* CONFIG_PERF_EVENTS*/
-
 void kvm_perf_init(void)
 {
 	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
-- 
2.33.0.259.gc128427fd7-goog


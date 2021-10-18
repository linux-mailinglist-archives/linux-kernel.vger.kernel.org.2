Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877E74326A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhJRSlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhJRSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:41:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC1C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:39:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s66-20020a252c45000000b005ba35261459so21322815ybs.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xJ6bOC6+dkGsJ3j2V7sZv/DU6sH36ZrUZumqDR62OZE=;
        b=FaZnE8H8vUfl8ErnKEFD4qvfiEMu04m+9tzw8d6A4KAuYX3Igfz3D7yQcGcfq97A6x
         w2SeBKvMFVqvEc2GYukdMFExWQLaoA1HHSHsnGbOJTIL71EqNhdkDypxFleGEhRhDYIL
         HuVbolklgOJ1BIUqbHGYWKo9k7uH0/JsqwJkz7LQ7cqNVam5cjnAKXU9ewupa/mkoFmz
         3jNtielCRqHvPCDYpD/4dTnL/qiLg8Y9bNO+jPRXJe+Q1JBThEyeMtsLzEJqjlk89wOk
         l0kf2wdzTWztZqVMfN+/za3KFdBK8i/2yLKkPjFpZyEx0Ah+ykUUYuk5WuPrZ3SOfHUX
         gcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xJ6bOC6+dkGsJ3j2V7sZv/DU6sH36ZrUZumqDR62OZE=;
        b=0VDGk8PfTCbCLIxro7Qs5Wr3pHDvXIAwX2gB3S9eXd+MFWuI/xWlssG7w2PpChEQwo
         OePNa86Ln2wY5Wg1/tBez8SUn1zqHEYbdqIb6F9mPcQoTxxhNnM+QraRmu3oOJ0IYMMF
         xRjcR0T8XF8pZQcsVXrrWLOmLiiFeAYhkyaM1BpJok/GEsw4ABYGI0RjViobP821e9yY
         V4c5ntgBqXzP1SwkUQ2YUycQ5Y3EDjYfVOi85h4aDctpxpAQ9ZD7Vv787SvsDvIXr3Sa
         dHc0jy4oLP2Ak6G4/ZP7hF32ljWz+wLz1qsGryfMjyXRNQ799Vd9D0KOMkkDeb1UvZzG
         JNCQ==
X-Gm-Message-State: AOAM533PyOjEImzBCOo8I939q6EDT3Q10njg5TFuEfrWYR1Kl5qjMwX8
        WExii+GHdNkjNe8+ufrzvERsYWJhjbc=
X-Google-Smtp-Source: ABdhPJzAllsGzJkf60lOe/OLLfAZF+iFqaC3WabMjStGcpYVWN04TmGVUFE1SIzqonfXgco+YQg0Gyk6IZM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ae71:c4e5:5609:3546])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154f:: with SMTP id
 r15mr34984760ybu.379.1634582377007; Mon, 18 Oct 2021 11:39:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 18 Oct 2021 11:39:28 -0700
In-Reply-To: <20211018183929.897461-1-seanjc@google.com>
Message-Id: <20211018183929.897461-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211018183929.897461-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/2] KVM: x86: Add vendor name to kvm_x86_ops, use it for
 error messages
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul pointed out the error messages when KVM fails to load are unhelpful
in understanding exactly what went wrong if userspace probes the "wrong"
module.

Add a mandatory kvm_x86_ops field to track vendor module names, kvm_intel
and kvm_amd, and use the name for relevant error message when KVM fails
to load so that the user knows which module failed to load.

Opportunistically tweak the "disabled by bios" error message to clarify
that _support_ was disabled, not that the module itself was magically
disabled by BIOS.

Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/svm/svm.c          | 2 ++
 arch/x86/kvm/vmx/vmx.c          | 2 ++
 arch/x86/kvm/x86.c              | 8 +++++---
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 80f4b8a9233c..b05bfcc72042 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1302,6 +1302,8 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 }
 
 struct kvm_x86_ops {
+	const char *name;
+
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
 	void (*hardware_unsetup)(void);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 89077160d463..cee4915d2ce3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4580,6 +4580,8 @@ static int svm_vm_init(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops svm_x86_ops __initdata = {
+	.name = "kvm_amd",
+
 	.hardware_unsetup = svm_hardware_teardown,
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1c8b2b6e7ed9..c147438eaafc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7568,6 +7568,8 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 }
 
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
+	.name = "kvm_intel",
+
 	.hardware_unsetup = hardware_unsetup,
 
 	.hardware_enable = hardware_enable,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c59b63c56af9..e966e9cdd805 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8539,18 +8539,20 @@ int kvm_arch_init(void *opaque)
 	int r;
 
 	if (kvm_x86_ops.hardware_enable) {
-		printk(KERN_ERR "kvm: already loaded the other module\n");
+		pr_err("kvm: already loaded vendor module '%s'\n", kvm_x86_ops.name);
 		r = -EEXIST;
 		goto out;
 	}
 
 	if (!ops->cpu_has_kvm_support()) {
-		pr_err_ratelimited("kvm: no hardware support\n");
+		pr_err_ratelimited("kvm: no hardware support for '%s'\n",
+				   ops->runtime_ops->name);
 		r = -EOPNOTSUPP;
 		goto out;
 	}
 	if (ops->disabled_by_bios()) {
-		pr_err_ratelimited("kvm: disabled by bios\n");
+		pr_err_ratelimited("kvm: support for '%s' disabled by bios\n",
+				   ops->runtime_ops->name);
 		r = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.33.0.1079.g6e70778dc9-goog


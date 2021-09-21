Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A01412B34
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbhIUCKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbhIUB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B182C06B673
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:17 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso74037149qvf.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=lnMsVbgXZSmhXWrHP7wqt1Q9KdoJ86/a0TU5NI0dZL0=;
        b=JdXsaOwAegsIRMFsfIK/aHqzKCXpZOjtCdyN1pLzgkzbwKV7ceMhrO0Ryl66L95Juo
         5+RkUx10rZgWGEheJP7alH/Uuuk4J6AaMx+6I4JwDoNHuLZ/LkrxWHigIGF4geaSR1Yz
         +aUXvE6Uws6s8xHGKyvBZ6nl9LmibGkzbU8g0SltqT77dqxBOivyJea0OB9rH7NjRfa4
         qkO//3qmd8k77fQcCxg6DDcdTTVcp1vfpd8u0pAJCJoijinyKaNzqn6+DXrICjs8fRH9
         /p0UYJ1x03EmpuW1otBKMrceoZ0eAG/iEjsD++uJ3unXEYjIw9ckv9r2oaiwTtMyucUi
         hxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=lnMsVbgXZSmhXWrHP7wqt1Q9KdoJ86/a0TU5NI0dZL0=;
        b=XhpwOgO1OYq1YwZbjZZQjXvPb4vPZd0FNmmxOFnyhdFggQxb5/qpV+I1xepuH25oM+
         O05VYgbpvs2g/OQP+AviocnH5HdtLeHACq4Ab19iu93JVDK+rJ/49d2i3xSUVF/4owZs
         /u4Hn6p/TJnW5PGiYKFLHJiOEnjskdmUNb/FsT05GQ4qTj5oyW3GgIDfGjWTBbhm5Wkx
         uNC3is2DzwlA68m4TtYha0ULkzaCGzM4pYaVjcNv4rVRmsoSKsG0KGVqApO+zVNZ+1IO
         QspYIlH4yXy50v85t//Z79zLoEadVJ5ExB/ea46auTuRlxeuEwFF6nVbgR/VzDELqsAx
         Ffaw==
X-Gm-Message-State: AOAM5324JMN/7vr3NVPwcddg8o7UP7r1JY4xQ6UoZUnxNXhxsymeT6pF
        hkfn56gi8lcI5OlPW0y9y38h7uU1dss=
X-Google-Smtp-Source: ABdhPJwhQVNoU3h+SyfxzcrLIxnFSQuy7EH7U+fsu80SneGkLGciUzHOcKWaKFNCwJ3atvSZMYgYve8HpNo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e430:8766:b902:5ee3])
 (user=seanjc job=sendgmr) by 2002:a25:9d89:: with SMTP id v9mr35514584ybp.8.1632182596734;
 Mon, 20 Sep 2021 17:03:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 20 Sep 2021 17:02:58 -0700
In-Reply-To: <20210921000303.400537-1-seanjc@google.com>
Message-Id: <20210921000303.400537-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210921000303.400537-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 05/10] KVM: x86: Remove defunct setting of XCR0 for guest
 during vCPU create
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop code to initialize XCR0 during fx_init(), a.k.a. vCPU creation, as
XCR0 has been initialized during kvm_vcpu_reset() (for RESET) since
commit a554d207dc46 ("KVM: X86: Processor States following Reset or INIT").

Back when XCR0 support was added by commit 2acf923e38fb ("KVM: VMX:
Enable XSAVE/XRSTOR for guest"), KVM didn't differentiate between RESET
and INIT.  Ignoring the fact that calling fx_init() for INIT is obviously
wrong, e.g. FPU state after INIT is not the same as after RESET, setting
XCR0 in fx_init() was correct.

Eventually fx_init() got moved to kvm_arch_vcpu_init(), a.k.a. vCPU
creation (ignore the terrible name) by commit 0ee6a5172573 ("x86/fpu,
kvm: Simplify fx_init()").  Finally, commit 95a0d01eef7a ("KVM: x86: Move
all vcpu init code into kvm_arch_vcpu_create()") killed off
kvm_arch_vcpu_init(), leaving behind the oddity of redundant setting of
guest state during vCPU creation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0bff5473813..6fd3fe21863e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -993,7 +993,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 	/*
 	 * Do not allow the guest to set bits that we do not support
 	 * saving.  However, xcr0 bit 0 is always set, even if the
-	 * emulated CPU does not support XSAVE (see fx_init).
+	 * emulated CPU does not support XSAVE (see kvm_vcpu_reset()).
 	 */
 	valid_bits = vcpu->arch.guest_supported_xcr0 | XFEATURE_MASK_FP;
 	if (xcr0 & ~valid_bits)
@@ -10623,11 +10623,6 @@ static void fx_init(struct kvm_vcpu *vcpu)
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		vcpu->arch.guest_fpu->state.xsave.header.xcomp_bv =
 			host_xcr0 | XSTATE_COMPACTION_ENABLED;
-
-	/*
-	 * Ensure guest xcr0 is valid for loading
-	 */
-	vcpu->arch.xcr0 = XFEATURE_MASK_FP;
 }
 
 void kvm_free_guest_fpu(struct kvm_vcpu *vcpu)
-- 
2.33.0.464.g1972c5931b-goog


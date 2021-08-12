Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8B3E9DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhHLE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhHLE4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:56:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B94C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:56:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo13-20020a05621414adb029035561c68664so2661207qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=qanCpgG6K85LtNMV/pCVVA2s8D8zJvxN6mc+87zshdI=;
        b=o5zN41efKx806Jn7dtKlx4vQuz7KW0nR6lpqWhcBhYLL8JH7DK2RSoIuDgxsMa45da
         faKc9y9iEm0czZ4VgYcEAKFOO+QKCxGJRXtn2Iyo60ydQebd8xwXGs1z5JGQrFi0V/Jt
         cpzoKYeB1hFJ4/CsG+V53GYNX9nJqZKaUIACW0myQ7vpPeDF30OBW0zs57rDq0G/wn0z
         BPcNsjqj9wpKrz88IL4mBDUTSy1cADU1GpwFTVpzUo0qmo344JGtlhUm0pjJyCIT3tqd
         1h9X2/A1NJueGpanbKdKEFLqPbJ4T1q1Qbmm764qSAz06/+jEKz+Q82iOhCI/jnYZjko
         EPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=qanCpgG6K85LtNMV/pCVVA2s8D8zJvxN6mc+87zshdI=;
        b=U2BX7RMz4FvElAWLdKyup7aqC3uxsQLLPUojNu2eoMJW9Y4W2BxBj8I4qNtk69e0nG
         0TrjGVp9fMYwn3j7/MNU7KwgnXmS68/eb5+TzLCrdgyX1A1xwYoIEMJrJJM9ybzZzjDY
         7lbLYhfiGgOnQsA0Lapdo8qJHy9x4WvNV560/lcPd1fzbJVtTtlfTZozuILIJhAdjK8g
         YA3lWY9T3sgPTAKGd8dKzZu9OoHOr9Lw4FDmG4Y/WF0jPw8kgFHGorrqlT3hRcncNMS7
         oemDLQYNVrYZ8uMNvU83YlSM5idjdC4DM/3zGmBal/fkYpEyNNuYGH7rNU6ha+pcXelm
         EKJQ==
X-Gm-Message-State: AOAM531cvOTrDhhaLg+iog6r42EknHwETJGdAK0S/ai0yO6lZ6lGUy5Y
        jzAyoGZ/5hnwLMB9yx2S8WQDFfPEJJc=
X-Google-Smtp-Source: ABdhPJzkgLj6qwyYzeVoo/P1gKsjQtvMJImXKFL6Pf4wPg7ocSsPdlTAZezWiJFVjnfGiU/oEMFunsTOs+s=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f150:c3bd:5e7f:59bf])
 (user=seanjc job=sendgmr) by 2002:a05:6214:285:: with SMTP id
 l5mr2089662qvv.24.1628744182096; Wed, 11 Aug 2021 21:56:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 Aug 2021 21:56:15 -0700
Message-Id: <20210812045615.3167686-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] KVM: nVMX: Use vmx_need_pf_intercept() when deciding if L0
 wants a #PF
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vmx_need_pf_intercept() when determining if L0 wants to handle a #PF
in L2 or if the VM-Exit should be forwarded to L1.  The current logic fails
to account for the case where #PF is intercepted to handle
guest.MAXPHYADDR < host.MAXPHYADDR and ends up reflecting all #PFs into
L1.  At best, L1 will complain and inject the #PF back into L2.  At
worst, L1 will eat the unexpected fault and cause L2 to hang on infinite
page faults.

Note, while the bug was technically introduced by the commit that added
support for the MAXPHYADDR madness, the shame is all on commit
a0c134347baf ("KVM: VMX: introduce vmx_need_pf_intercept").

Fixes: 1dbf5d68af6f ("KVM: VMX: Add guest physical address check in EPT violation and misconfig")
Cc: stable@vger.kernel.org
Cc: Peter Shier <pshier@google.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bc6327950657..8bcbe57b560f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5830,7 +5830,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 		if (is_nmi(intr_info))
 			return true;
 		else if (is_page_fault(intr_info))
-			return vcpu->arch.apf.host_apf_flags || !enable_ept;
+			return vcpu->arch.apf.host_apf_flags ||
+			       vmx_need_pf_intercept(vcpu);
 		else if (is_debug(intr_info) &&
 			 vcpu->guest_debug &
 			 (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
-- 
2.33.0.rc1.237.g0d66db33f3-goog


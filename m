Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686134F760
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhCaDUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhCaDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:19:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:19:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c17so822614ybs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=3Xa1OKEIcZ5edRwAMZLibB+Ad1pcD0ADTTrJiSO76FU=;
        b=U0dDAMw5AWHxlOqCtiXJpoymuGVxzLFXL1A4mlfI9uLaMbLLGk45tLAgKX1qjOccmR
         cTevpLRzVJqNmfwPQFzh9m2DRDgvyV3sxKLBL7DGw0tBxNZU1FmmCrBGRaxm+XeF9GhC
         Hwe2L+EpDVfyH3o2QCwSMd12qVhUUklccyj9paEDibFrU+0bp42pkhunV4PyqQJqGCCY
         lDKuGej38L4ReQUgV+4kMcPpL8C5+/EMh7xgg98CsQBhDcKL9WWhhvb8H9cbfufK/VfC
         IkdR/BrdtTxnTKbkHjjcbWTKDtDWNRmft5OnlBUgBnLeNFPVsA6t6+1wUWKw4E/Jv7Wj
         rXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=3Xa1OKEIcZ5edRwAMZLibB+Ad1pcD0ADTTrJiSO76FU=;
        b=l0rQRiRmQ96OaBlqGggh4Ig2ldjRQ28zA2R9d57XIL5NnfcA6of+Za5FJ975LuXWqi
         fU7X8y22Y7wssGQMFFTTSR5X5BPyAX6bDBylWMdLydnEKB+PNLBzg3C51w4UBgGPAe5K
         NitX142pkXXMIe3s4nGqNip/bpUzn1QpmxGp0r/Mu6N573xh3jht7L2Vjd++oeUiErWI
         eOc6MwRaFAe1mMmIrz+h+QdN/zW3tL6rr0p4N5EN6zSXvVvsiL7F6YvVSegx5t6+PVpX
         pF2+ykLk8rfmvCTuBS3Cfc/G1/7MIQvMEdXw1yoS/EQ6ae2u4n8O+OiJKEex4Mz0A6zB
         gUUw==
X-Gm-Message-State: AOAM530nQGz86pgSEdgXMrA3Izm75mUJbLVTpch2p2NYyYjrkETVcAZM
        s66X6zKC3S6HEYOhnu8HgZ5wUdOuFGQ=
X-Google-Smtp-Source: ABdhPJzBx7uD+67poCDf2QYRxAznyzYMGF0Hynxyll63eq1q/oZtnzx23zwvh/FRi1trMJENU/uX+ZtWzOA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c6b:5d63:9b3b:4a77])
 (user=seanjc job=sendgmr) by 2002:a25:268e:: with SMTP id m136mr1876235ybm.220.1617160789338;
 Tue, 30 Mar 2021 20:19:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Mar 2021 20:19:36 -0700
In-Reply-To: <20210331031936.2495277-1-seanjc@google.com>
Message-Id: <20210331031936.2495277-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210331031936.2495277-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 3/3] KVM: SVM: Do not allow SEV/SEV-ES initialization after
 vCPUs are created
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject KVM_SEV_INIT and KVM_SEV_ES_INIT if they are attempted after one
or more vCPUs have been created.  KVM assumes a VM is tagged SEV/SEV-ES
prior to vCPU creation, e.g. init_vmcb() needs to mark the VMCB as SEV
enabled, and svm_create_vcpu() needs to allocate the VMSA.  At best,
creating vCPUs before SEV/SEV-ES init will lead to unexpected errors
and/or behavior, and at worst it will crash the host, e.g.
sev_launch_update_vmsa() will dereference a null svm->vmsa pointer.

Fixes: 1654efcbc431 ("KVM: SVM: Add KVM_SEV_INIT command")
Fixes: ad73109ae7ec ("KVM: SVM: Provide support to launch and run an SEV-ES guest")
Cc: stable@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 97d42a007b86..824bc7d22e77 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -182,6 +182,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	bool es_active = argp->id == KVM_SEV_ES_INIT;
 	int asid, ret;
 
+	if (kvm->created_vcpus)
+		return -EINVAL;
+
 	ret = -EBUSY;
 	if (unlikely(sev->active))
 		return ret;
-- 
2.31.0.291.g576ba9dcdaf-goog


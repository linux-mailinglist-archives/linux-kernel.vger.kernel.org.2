Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69214070F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhIJSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhIJSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:33:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:32:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso3557120ybq.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BpS4yRoua78uKf+TYKOiUUv6QuQHXhubiioVBA8nCQo=;
        b=KJlkpanmfvYJW1Yhgn/za09vfEebPfPxU2SzO/psUbCosl17Img3mIIFLy3J+pdT6h
         w0tSojRDn38/Eg9HrUmwwRS82TOK9quZYndWZw6S58pRsGhADod72pXbmMAdhPY2Ttb0
         blInNBtJHWRU5WNNIYjD0SShBbXi3xaiOKeETbGBvu8GpiVppPHNAggX621AesFy6yIG
         8mR25PdIxiXlyb99lT6iYIje+OGXAwP/s3ybjt11FTJDByQpCCItR37M0ILgE0o1ehyC
         lEn28wMU8BQ1BE4/24aLVXXb3LJ8K8O+Yhf+e+LtpU5QrHiRz6xBYd+FxC4oy/ohnoiw
         cAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BpS4yRoua78uKf+TYKOiUUv6QuQHXhubiioVBA8nCQo=;
        b=7MdQkUp9trl6XdvhoyMY8ibDrdQLkeBW3s1Ev5g5dmzzEDKIeZY5JpAt2DNh6cL2zv
         Zujs3nwkOHMjIvYJsmDoxlUhm4CpdTa6JbIHFwyydoPOTzAT2IG95LQa4vPclge9lM6j
         SjMFDf4bJHz5U7IUIoxF8bMnprYaaDnkxughnZma2wN+cbfEud7ZNkLrEX+Hv+l2yf6B
         l69Mr94KacVooVP493U8fEhv17LaJ3U8UOrh2OWrZTAZ2Fk3u5X4epvMPnj3jF8edr4E
         SKzvU7mVY9jXX0EAHBQAooae0eC/06zYVdmW4ZMbDwNM1NjN5qc80udWhPtEOPCLlLm+
         iGeg==
X-Gm-Message-State: AOAM530cSk8vsAU4N13DaCEoCwmNk3Pd63LKo9UsoohyrbkN+7/MKahk
        GO4hTuEto6c71q12ocP46KQmDkxVwSc=
X-Google-Smtp-Source: ABdhPJxm2mcfigiu3P42M+5DYgiEUd1/wdQui/picbFpUwqJCgDKG91fPKZGY3yyRL3nonS5ufiLzZ/F84M=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:d1d5:efd6:dd3d:4420])
 (user=seanjc job=sendgmr) by 2002:a25:5246:: with SMTP id g67mr11846626ybb.56.1631298744906;
 Fri, 10 Sep 2021 11:32:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Sep 2021 11:32:19 -0700
In-Reply-To: <20210910183220.2397812-1-seanjc@google.com>
Message-Id: <20210910183220.2397812-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210910183220.2397812-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/2] KVM: x86: Query vcpu->vcpu_idx directly and drop its accessor
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read vcpu->vcpu_idx directly instead of bouncing through the one-line
wrapper, kvm_vcpu_get_idx(), and drop the wrapper.  The wrapper is a
remnant of the original implementation and serves no purpose; remove it
before it gains more users.

Back when kvm_vcpu_get_idx() was added by commit 497d72d80a78 ("KVM: Add
kvm_vcpu_get_idx to get vcpu index in kvm->vcpus"), the implementation
was more than just a simple wrapper as vcpu->vcpu_idx did not exist and
retrieving the index meant walking over the vCPU array to find the given
vCPU.

When vcpu_idx was introduced by commit 8750e72a79dd ("KVM: remember
position in kvm->vcpus array"), the helper was left behind, likely to
avoid extra thrash (but even then there were only two users, the original
arm usage having been removed at some point in the past).

No functional change intended.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c    | 7 +++----
 arch/x86/kvm/hyperv.h    | 2 +-
 include/linux/kvm_host.h | 5 -----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fe4a02715266..04dbc001f4fc 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -939,7 +939,7 @@ static int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
 		stimer_init(&hv_vcpu->stimer[i], i);
 
-	hv_vcpu->vp_index = kvm_vcpu_get_idx(vcpu);
+	hv_vcpu->vp_index = vcpu->vcpu_idx;
 
 	return 0;
 }
@@ -1444,7 +1444,6 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX: {
 		struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
-		int vcpu_idx = kvm_vcpu_get_idx(vcpu);
 		u32 new_vp_index = (u32)data;
 
 		if (!host || new_vp_index >= KVM_MAX_VCPUS)
@@ -1459,9 +1458,9 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		 * VP index is changing, adjust num_mismatched_vp_indexes if
 		 * it now matches or no longer matches vcpu_idx.
 		 */
-		if (hv_vcpu->vp_index == vcpu_idx)
+		if (hv_vcpu->vp_index == vcpu->vcpu_idx)
 			atomic_inc(&hv->num_mismatched_vp_indexes);
-		else if (new_vp_index == vcpu_idx)
+		else if (new_vp_index == vcpu->vcpu_idx)
 			atomic_dec(&hv->num_mismatched_vp_indexes);
 
 		hv_vcpu->vp_index = new_vp_index;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 730da8537d05..ed1c4e546d04 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -83,7 +83,7 @@ static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	return hv_vcpu ? hv_vcpu->vp_index : kvm_vcpu_get_idx(vcpu);
+	return hv_vcpu ? hv_vcpu->vp_index : vcpu->vcpu_idx;
 }
 
 int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e4d712e9f760..31071ad821e2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,11 +721,6 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	return NULL;
 }
 
-static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
-{
-	return vcpu->vcpu_idx;
-}
-
 #define kvm_for_each_memslot(memslot, slots)				\
 	for (memslot = &slots->memslots[0];				\
 	     memslot < slots->memslots + slots->used_slots; memslot++)	\
-- 
2.33.0.309.g3052b89438-goog


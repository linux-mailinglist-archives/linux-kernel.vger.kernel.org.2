Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CE457B95
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhKTE4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbhKTEyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BFC061792
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y6-20020a17090322c600b001428ab3f888so5706814plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EXMkO/azkMS9cv9+FE+S8Q0mGKj+jNbEHX6PldUlmAw=;
        b=UGbcmcUCQ/us5EAwL49t8Jb/biSpBlTVRhbevdWuXUazt60vEgdjj43Fc7YY06no4y
         GxopNFYDo4iSopgTETA2Vi2HpqjwB2Ria29CLRgcYEh4n4VorjZG0OCXZP68AACCeA/H
         9wge6VeeWLjkVvMqWiScXBcOJUGMcYBKu7JSX5yFdErX5R+0xmGj21h1AJKrb0R22kv8
         QHJifpqPBIK20ouFzFKE726kTm+6Gr1UKuCoV4Gn1fAB1lNjsmUjtijrDuWIWoNz4myF
         xYdDw/AXRGNGnG1Ci/0S7fQS7MVFZBD1DF7B8Krcr9bEuYmXfx6XWC7zbpfkWnywSY6+
         Z0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EXMkO/azkMS9cv9+FE+S8Q0mGKj+jNbEHX6PldUlmAw=;
        b=Wwh9hg7qhpa+/zwe3VmuKoW4+GjSFqVB/Y7lmPzAKGMEbJH75GUp+tuJ3HwiNi4p33
         +TJadRXPbqnUCQ7pgLznAV4dmE4hd7Hzyvz3hxRngpdKP4Vj8wVmGaYO+0D5PUQOrbxe
         jyB3WUjH9dworMaoxuhL1bDou673vUOTVGgw1DYI5GywDjT34maToQKtxkEV1P4Pbd51
         uttVi2YsUW9y8RdZJ82HlMCzAhJpzer1QiB0ppWB57y19tz47YDn4uNTmkgEUecyuivB
         c88GGYHnoosmaLwN8W1HMBAJNalz2ZQXJtFjPxMl+6agNlNR/NKdcYzRKavjFc9AOs4M
         Nolw==
X-Gm-Message-State: AOAM530TIHvcELDMNk/yltmDxcGMUzOOQBuFR89o80kU6XfUswQUmN7c
        /hbs6RF68iNGdYWaSsn87uGNyl3ze+M=
X-Google-Smtp-Source: ABdhPJxN3GRde+enEToNYDwz/KxrT0vAPq9B51mgr8ABzigdW0vdMUcEk3ghkt6oGHSUogdi72pJ2fyMQmg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:b89:b0:49f:f600:658f with SMTP id
 g9-20020a056a000b8900b0049ff600658fmr28869856pfj.71.1637383868465; Fri, 19
 Nov 2021 20:51:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:27 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-10-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 09/28] KVM: x86/mmu: Require mmu_lock be held for write in
 unyielding root iter
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that mmu_lock is held for write by users of the yield-unfriendly
TDP iterator.  The nature of a shared walk means that the caller needs to
play nice with other tasks modifying the page tables, which is more or
less the same thing as playing nice with yielding.  Theoretically, KVM
could gain a flow where it could legitimately take mmu_lock for read in
a non-preemptible context, but that's highly unlikely and any such case
should be viewed with a fair amount of scrutiny.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 12a28afce73f..3086c6dc74fb 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -159,11 +159,17 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
 		} else
 
-#define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
-	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,		\
-				lockdep_is_held_type(&kvm->mmu_lock, 0) ||	\
-				lockdep_is_held(&kvm->arch.tdp_mmu_pages_lock))	\
+/*
+ * Iterate over all valid TDP MMU roots.  Requires that mmu_lock be held for
+ * write, the implication being that any flow that holds mmu_lock for read is
+ * inherently yield-friendly and should use the yielf-safe variant above.
+ * Holding mmu_lock for write obviates the need for RCU protection as the list
+ * is guaranteed to be stable.
+ */
+#define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
+	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)	\
 		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
+			lockdep_assert_held_write(&(_kvm)->mmu_lock);	\
 		} else
 
 static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
@@ -1063,6 +1069,8 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
 	struct tdp_iter iter;
 	bool ret = false;
 
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	rcu_read_lock();
 
 	/*
-- 
2.34.0.rc2.393.gf8c9666880-goog


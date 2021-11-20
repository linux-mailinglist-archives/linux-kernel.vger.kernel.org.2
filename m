Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B723457B91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhKTE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhKTEyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E0C061398
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l14-20020a170903120e00b00143cc292bc3so5720337plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=k4NHpd3E7FQzbwVOtcdF5b2uNcYEHobxgRNhAQdrHYQ=;
        b=R+xGNzJ/vyiSC7Df9o413MvDVFxJTTeMRZeyITgFauzdVqZSc6VXOc17nRygs8c2+b
         /4/A+WUHuA7gcYI5tI+HIGS/YB/HhNmaFIPsk7vzx/9DVa3kvR4vgQH2w9gGlrTRdUQs
         kiVX+LK8amz1r6Il5upaLUMyr5YfL1fZK+HlKlmzIk6IoIS5XgMgp4p+FjBSx9IAXCSb
         JlvdZMI1kg1bf1usOJtVa0X/mZWXVdZmTdgHMafPKv6IyVvZWgecT4d0D+jZK5rchKZH
         z6SP6HrbxbXZHG36efuvIXr4JBaBbnEl9YyBe+n5DWMFo9wMzEQ6VfDLEyF+M98y0PAP
         kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=k4NHpd3E7FQzbwVOtcdF5b2uNcYEHobxgRNhAQdrHYQ=;
        b=1OPyhCqWIyx9O3dgxllZ9Fw38buH147T9sUjWj2NK4h791EURjYOUCTMqtBLMIaLys
         ZeKvic4s01ZhsV2RaYfNweMeuaW8IXlS68Z2Zjurz+kUG5z/C7BNcuvgv9wg4uI/BZwP
         WkFoaRk9Hlw4CNjkYg5bji/lq/gGGgRPVXhhEB9d2gBZHCXWhKDdRz0owolruvjvZl80
         LevMTHHkUhFmzrdlZB7VpoCwfX1iiCy8EikcAkNd2s06dg1DUv5G3BkGBEyLXTSAXmoq
         mPmM6hKwp0z1T4U8IouWGcREwb6kwHqf9LnThrZWLOEVB3EcZnFx+McGItBy/gNbw7ms
         34jQ==
X-Gm-Message-State: AOAM53154hjMMWTmSTumsyLOihRYnyPwnVMZxlKJrWfMLTOgAiO4v0vg
        JvO0E2Mcg8MBT98jViTg8L8kW6Pcdv4=
X-Google-Smtp-Source: ABdhPJwgT/yEVp7NlXrsEHaMuqvEPid69UudN0pRgbth0GHzfVfKZ1tPqnrZWw18DWTXLnGL3vO8zi+am/E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:9215:0:b0:49f:e38b:d043 with SMTP id
 o21-20020a629215000000b0049fe38bd043mr28037702pfd.86.1637383874643; Fri, 19
 Nov 2021 20:51:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:31 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-14-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 13/28] KVM: x86/mmu: Drop RCU after processing each root in
 MMU notifier hooks
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

Drop RCU protection after processing each root when handling MMU notifier
hooks that aren't the "unmap" path, i.e. aren't zapping.  Temporarily
drop RCU to let RCU do its thing between roots, and to make it clear that
there's no special behavior that relies on holding RCU across all roots.

Currently, the RCU protection is completely superficial, it's necessary
only to make rcu_dereference() of SPTE pointers happy.  A future patch
will rely on holding RCU as a proxy for vCPUs in the guest, e.g. to
ensure shadow pages aren't freed before all vCPUs do a TLB flush (or
rather, acknowledge the need for a flush), but in that case RCU needs to
be held until the flush is complete if and only if the flush is needed
because a shadow page may have been removed.  And except for the "unmap"
path, MMU notifier events cannot remove SPs (don't toggle PRESENT bit,
and can't change the PFN for a SP).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 06b500fab248..3ff7b4cd7d0e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1079,18 +1079,19 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	rcu_read_lock();
-
 	/*
 	 * Don't support rescheduling, none of the MMU notifiers that funnel
 	 * into this helper allow blocking; it'd be dead, wasteful code.
 	 */
 	for_each_tdp_mmu_root(kvm, root, range->slot->as_id) {
+		rcu_read_lock();
+
 		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
 			ret |= handler(kvm, &iter, range);
+
+		rcu_read_unlock();
 	}
 
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog


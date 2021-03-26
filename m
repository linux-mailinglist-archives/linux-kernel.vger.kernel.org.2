Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1B349FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCZCVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhCZCUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:20:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB1C0613E1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:20:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so8298708ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0E8BZ2STvuQIfso3dI+9aBVCstinNIkBYfQ3J4yTTGQ=;
        b=Sztl/h9sZx/7ZaVx5hMPtB6lSzMSX4Gb28dHAMSquYqz7s8WUCP4uEoziz/kmtJK81
         nfHzKFWV1WxfgApX8gx58e7JjhfWPaIW2HaXmQD7uuslC9BLVCHh4zkCoObl+QZ1dwPn
         M+RVORS2wr6AeKLyKhtXnmkQmsacfxPFnoUqFW8APJAZRs8ZHxHOdTP5b/rKvbWd8T08
         yeKRG0ZDrzCkkFO0+/kQKjyEP3OG8uUow+HKiNA9869LBY07Rkk4cdhbCro3XK38sXPM
         CCkn5lXwZLRr5xUwqO5ob7s5/KEANR2XTByUOGreIF+7GYhUmFMMjzPbXWIu1eQORSa3
         d2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0E8BZ2STvuQIfso3dI+9aBVCstinNIkBYfQ3J4yTTGQ=;
        b=JllwjTCd9bJYTj5S4Wvd+QnoFXgFn/DwXNe5e+0gOZr7mYDXvQgQw6pYwGOqoAx4LZ
         JvdUsItaauuyPsIK//YVOtqA5jp6cUCMK83EuQGcHRkHG0VZdrnCAwP5NrarZr1aZ/zl
         ThYRxtn8g5kDMffO1B/P9JhdyLyR0G8uMAAgQPJk1uamJq3RfqFLhygMIfQL3P8KIqEd
         EY2kBea3qlziVk2csnEwkKTdT+TEXO6Q1OX2DEfrKk5Vok/WFUu1EiZA61PyesYHPsAj
         h/sz7amdVFi3TPLjh8Os8LIG/AHKABVavmUajtXW5i2y+rIKusB4qWNq+l8udKaDAt9w
         1qSg==
X-Gm-Message-State: AOAM530wXeyyIObMuOej6pY01CxqCoDRSIjoqivdqw9R3ICQbCDafpJ5
        gCMSBIhxtSwG27hdcrx08Zhgvqr4Fj0=
X-Google-Smtp-Source: ABdhPJzjEvSTUhG+uwIMtVfAPxRaQx8jIsDxAh63UurjJl6mHiAwbP0z55eNCAdH4rIDehEW/UWXRCNq+K0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b1bb:fab2:7ef5:fc7d])
 (user=seanjc job=sendgmr) by 2002:a25:be8d:: with SMTP id i13mr16186788ybk.320.1616725249585;
 Thu, 25 Mar 2021 19:20:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Mar 2021 19:19:56 -0700
In-Reply-To: <20210326021957.1424875-1-seanjc@google.com>
Message-Id: <20210326021957.1424875-18-seanjc@google.com>
Mime-Version: 1.0
References: <20210326021957.1424875-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 17/18] KVM: x86/mmu: Allow yielding during MMU notifier
 unmap/zap, if possible
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the TDP MMU yield when unmapping a range in response to a MMU
notification, if yielding is allowed by said notification.  There is no
reason to disallow yielding in this case, and in theory the range being
invalidated could be quite large.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f6a82230baa5..21bb8b68a553 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -885,7 +885,7 @@ bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 
 	for_each_tdp_mmu_root(kvm, root, range->slot->as_id)
 		flush |= zap_gfn_range(kvm, root, range->start, range->end,
-				       false, flush);
+				       range->may_block, flush);
 
 	return flush;
 }
@@ -903,6 +903,10 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
 
 	rcu_read_lock();
 
+	/*
+	 * Don't support rescheduling, none of the MMU notifiers that funnel
+	 * into this helper allow blocking; it'd be dead, wasteful code.
+	 */
 	for_each_tdp_mmu_root(kvm, root, range->slot->as_id) {
 		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
 			ret |= handler(kvm, &iter, range);
-- 
2.31.0.291.g576ba9dcdaf-goog


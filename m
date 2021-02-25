Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3D325833
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBYU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhBYUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:49:57 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8CAC06121E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:20 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u8so5228540qvm.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hmkVhLp1GC7NIyuf9NPmUl90mCViucnjMMJ9e8WzMHo=;
        b=dUYOs8ob4aIG9pQFtyyXzH3bzJ8rsFLrxxUirvqk6GDqVEdmKd6dCmw4myHH+sjNYc
         6B5GbjL3IAlA3gXpv6nY52kevEkoZtwUDCNGGYV90DL6f3uP9sQzi2K219qXf64aH5Tx
         +c1Cq1S2rr1TbFIeNLDSiXCUgK5keT4DONM+65FFVqqBubgKeyulZj4DrXU9y77PaYW6
         7vZuPRPktSaomGM7NSWI0iHJtPgTWbn3amdZsmoKKakaqBTkQw818B2ZPRAX2d2Tle9F
         ftnDWHPiDP+tN6S877e49DPrjHuFv1NxrdWtjaBWNCHpfniEfi10b/DEiotfkwUFWt63
         KJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hmkVhLp1GC7NIyuf9NPmUl90mCViucnjMMJ9e8WzMHo=;
        b=QXkKi+ICidK6+CzkHLFyoHuUqd38e+dNkhuf21/1nqMVxs+JGD4POjWk/QbW1yI8Sm
         7PUj8X6yNVX6W+p6TD6bvJFkHzOyaQEQZlrhZjZOlBllHub/Whw0M/1jQnoPQPZ3WbAD
         X/grcGrwHx+zIlsxCfQt+4V4hl25P1xgBoDbgPsXB9UkvfCciKxK5sD9KduXmZS6rHEd
         hmRek0VxuSAXOaznQeuIG4NFeELuBRzp9VJhQOMl6GZsHRlHj2mLyFeeNQykyoKKGOWA
         n/AziLNGsfPwOD6nfGBUMCwOUqsyteAqezOTPKDOrbC8dmTphyLx+QR5EOBTq/3CpRN0
         GDfQ==
X-Gm-Message-State: AOAM530dkWlYxwvgwMgSMjxkrJm7cGlkFKcLMj6N5fqvdSiS6hBxqW+a
        xxyLKXTY8S9W6iykAorEdQeqhZb5IGc=
X-Google-Smtp-Source: ABdhPJwsArN9RBH6GJNh6qdRsI1Sg9jrkAfcEjBj31C2XnPtrMZuIAoQMw2x/HhJKBeQUdH5kqOVRVtWaNE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a05:6214:d6d:: with SMTP id
 13mr4706063qvs.60.1614286099247; Thu, 25 Feb 2021 12:48:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:33 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 08/24] KVM: x86/mmu: Drop redundant trace_kvm_mmu_set_spte()
 in the TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove TDP MMU's call to trace_kvm_mmu_set_spte() that is done for both
shadow-present SPTEs and MMIO SPTEs.  It's fully redundant for the
former, and unnecessary for the latter.  This aligns TDP MMU tracing
behavior with that of the legacy MMU.

Fixes: 33dd3574f5fe ("kvm: x86/mmu: Add existing trace points to TDP MMU")
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f46972892a2d..782cae1eb5e1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -773,12 +773,11 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu, int write,
 		trace_mark_mmio_spte(rcu_dereference(iter->sptep), iter->gfn,
 				     new_spte);
 		ret = RET_PF_EMULATE;
-	} else
+	} else {
 		trace_kvm_mmu_set_spte(iter->level, iter->gfn,
 				       rcu_dereference(iter->sptep));
+	}
 
-	trace_kvm_mmu_set_spte(iter->level, iter->gfn,
-			       rcu_dereference(iter->sptep));
 	if (!prefault)
 		vcpu->stat.pf_fixed++;
 
-- 
2.30.1.766.gb4fecdf3b7-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4D3B0C11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhFVSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhFVSBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:01:16 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187CC061146
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:33 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f11-20020a056214164bb029026bc7adaae8so12450104qvw.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Y3DE/+nhI8hKRcsxwDWqTYPTqmeZA0ewM302/K5Or18=;
        b=RriloTVjS0q2o8MofR6Z5JpZFWZqk9SNDGq+/q+gYKgWnUcyxLds9wPSZMEe6q2Zv6
         ItgXMx8wuuMFTdlxLX72BVxjjGua+jUQpPnsKAwRLXWvICPby/Iq4zR+NcuFzC7GORFv
         rpCtVtBbCdQ+kf5leTycfLI6hKmJXwgpAg07Xd2oTJ3fUtvAHuYFstzyOaOv2DjDFzqu
         T7m4LfJ0MVQRPHM8YPv813/6aRfBQzUbvaIrVN5gGl7J1ioeYUGoL/JIvbnjGx1+Iols
         YMv0+QjLxr4LtHsCtxSxEdFYnf1QEaRgcLoebJYBz6pg3FZMhVBIRHArW2XZxBpU5KOO
         td3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Y3DE/+nhI8hKRcsxwDWqTYPTqmeZA0ewM302/K5Or18=;
        b=rjulVIlOwyAWnR5ys4IRixDg32rap9eNcHRgzdr4prfpcEiZs1Ezr6Iewq3MmoPmFO
         Jl4HbmRrEKfb8suKGgWu/LvbEIiOuBblnm3tD9XlfcvHq8P7LbQcZy0GLRWL40MKIYXr
         4Ls4ZJ53PpG35KeypTEWPMGY5oRnzJDIY7UpWomrVmLkqYHV0dmgyds8+xbqGrR/tVG8
         HnORtWDBmDIwOMQUbY1a7rR9K1IGQ4hq5WK3a9w46KJiZi8wH6XlRrBsh0J9MTf7AqPO
         EAKbed5b1muk9Q6+QNJnlyodgWgAuTS7U8UN2tslx2hVsAa6JPxhOW/rA96aEYGXtClY
         L7cA==
X-Gm-Message-State: AOAM531lMOZUAMwePQtQg//BEiD5ycYDSLJDbQAfVR1P0oGd0029vDBV
        LQzbrroUwcf4+60SJcydTaMl4xmnIsc=
X-Google-Smtp-Source: ABdhPJxcVCQqF7FQn2ehTESyLdt547B54miRpQMhwIhU+T5Ne0xJSZ3XwmqlpeJZUZNic62udaw/IBdvjM4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a5b:c:: with SMTP id a12mr6524009ybp.123.1624384712819;
 Tue, 22 Jun 2021 10:58:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:01 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-17-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 16/54] KVM: x86/mmu: Drop smep_andnot_wp check from "uses NX"
 for shadow MMUs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the smep_andnot_wp role check from the "uses NX" calculation now
that all non-nested shadow MMUs treat NX as used via the !TDP check.

The shadow MMU for nested NPT, which shares the helper, does not need to
deal with SMEP (or WP) as NPT walks are always "user" accesses and WP is
explicitly noted as being ignored:

  Table walks for guest page tables are always treated as user writes at
  the nested page table level.

  A table walk for the guest page itself is always treated as a user
  access at the nested page table level

  The host hCR0.WP bit is ignored under nested paging.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 96c16a6e0044..ca7680d1ea24 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4223,8 +4223,7 @@ reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 	 * NX can be used by any non-nested shadow MMU to avoid having to reset
 	 * MMU contexts.  Note, KVM forces EFER.NX=1 when TDP is disabled.
 	 */
-	bool uses_nx = context->nx || !tdp_enabled ||
-		context->mmu_role.base.smep_andnot_wp;
+	bool uses_nx = context->nx || !tdp_enabled;
 	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
-- 
2.32.0.288.g62a8d224e6-goog


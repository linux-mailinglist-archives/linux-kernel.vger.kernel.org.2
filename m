Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1663A8683
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFOQbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFOQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:31:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:29:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q63-20020a25d9420000b0290532e824f77cso20717569ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=BqMhVGwGdPs1vVNGZdNQGbFGvAB3o8/QDK+Em5NGJQ4=;
        b=DlpB6KGTch0dP7bG9NbH4d7cdmOYPKFaKI1i2bNyCzusIKUAMd4hzuwMEypEj9jruJ
         2IAXeZFGanjcG6VNc5yIYf/nBI2xaAvWC9ljxPFReS5iLQIFvZ4ojLMusw2H9hnrYeRB
         h0+cLoIH8NkrZbSthgxZg+X4F+iqidefR2+8op1B0i2jKmREo2LWSSb0U9Zt8Ohmrvr5
         qKw3NXilTXmpPu/qau9qt+PiWPgJHTu13vRQrOtd/sCozh8PwHAvY3NgvJn8fSE5pli/
         qocQQZIcwjdclzRcmSpZZ93d5R9C8NlXFwMLAAJ/bjkudHJ6q/WmQ9M53VDyyxq0nvbw
         Gqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=BqMhVGwGdPs1vVNGZdNQGbFGvAB3o8/QDK+Em5NGJQ4=;
        b=KmTn8c02UFlxB08+2DoP32zXWAx0j+C7M+/Tf6m2ossoQISC+7Zt/p4f80ppcXVYZ+
         gWWAoIe1EmEUZJc3GgXL63HoKk1OLDsw/dnBT2VDACF1ERgO6ck0DzTlr42bO3ci2pIF
         09TRj60BF8Y/A3DCQry6kZkmZvn/bM3qGrcTkqrKCParCH7xaEmIjtcKv17bPc6ZTIwx
         y4EqMREMzqpH8Z8nIWgaPSL36tkP5pcX+r1LB0rH65LkdG1ZG9dBQUm8qXnVddkNzsDF
         YSGlZwt0iX2O9BZaCz0FL6vdI25zLKCxs2+nGKerKxMBmug5g9tj+wmcpC9+93Xwct0Z
         V9rA==
X-Gm-Message-State: AOAM531L1AeKLnXGuFcxiB6c1cedQiPOssV1VU9iwuqETciv/sY2675d
        e1qCS9QZJHVB5wMgDoZt8GWkaslAG6o=
X-Google-Smtp-Source: ABdhPJz9C0vQXeCctY8YoylreZqfG4txJ9hThQc+122bpb1TKJoLDJ7pe6agDPoozs94JZTqpfOXZz027r8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:13fc:a8bd:9d6b:e5])
 (user=seanjc job=sendgmr) by 2002:a25:bec6:: with SMTP id k6mr35017110ybm.187.1623774548423;
 Tue, 15 Jun 2021 09:29:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Jun 2021 09:29:05 -0700
Message-Id: <20210615162905.2132937-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] KVM: x86/mmu: Grab nx_lpage_splits as an unsigned long before division
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

Snapshot kvm->stats.nx_lpage_splits into a local unsigned long to avoid
64-bit division on 32-bit kernels.  Casting to an unsigned long is safe
because the maximum number of shadow pages, n_max_mmu_pages, is also an
unsigned long, i.e. KVM will start recycling shadow pages before the
number of splits can exceed a 32-bit value.

  ERROR: modpost: "__udivdi3" [arch/x86/kvm/kvm.ko] undefined!

Fixes: 7ee093d4f3f5 ("KVM: switch per-VM stats to u64")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 720ceb0a1f5c..7d3e57678d34 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6043,6 +6043,7 @@ static int set_nx_huge_pages_recovery_ratio(const char *val, const struct kernel
 
 static void kvm_recover_nx_lpages(struct kvm *kvm)
 {
+	unsigned long nx_lpage_splits = kvm->stat.nx_lpage_splits;
 	int rcu_idx;
 	struct kvm_mmu_page *sp;
 	unsigned int ratio;
@@ -6054,7 +6055,7 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
 	write_lock(&kvm->mmu_lock);
 
 	ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
-	to_zap = ratio ? DIV_ROUND_UP(kvm->stat.nx_lpage_splits, ratio) : 0;
+	to_zap = ratio ? DIV_ROUND_UP(nx_lpage_splits, ratio) : 0;
 	for ( ; to_zap; --to_zap) {
 		if (list_empty(&kvm->arch.lpage_disallowed_mmu_pages))
 			break;
-- 
2.32.0.272.g935e593368-goog


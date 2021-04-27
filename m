Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9636CEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbhD0Whi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbhD0Whe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:37:34 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54522C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:36:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a7-20020a62bd070000b029025434d5ead4so21548933pff.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dtfxclLFIBm6xVbo9OSqpPdh4KZCVh7xSZdF1u0sKXc=;
        b=eTO7SN1Gt4G354q/wrJKcHjRQS9pdTQywJzItPU2gesfRRbz0NV1NLuLguHnL54ljX
         VQwKBJ+WMYwKFZz7quFU1558YIGkHdw+ODQ/LAWrSNlxbd8Txsg5FR+Cjad3SoSM2WbV
         lpjXQDRYn6oDIKe1hfvdcxhqFkQjeCWmid8tS7oqOxqEZhbv8UFvEi2sHouTLgm9dHSq
         aoXTY/wxRPoi3Vin2stzZkptZC6pAZRHfwODV1YNU0U/Um2nYcUnDZjFoVA0T7Corg9W
         LYwoKgPdKmaUZ18xF5XsOMzPW5qSTetg4CbYD3iuN9tkMkl79iuVXq1va9vho25oVFmI
         mnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dtfxclLFIBm6xVbo9OSqpPdh4KZCVh7xSZdF1u0sKXc=;
        b=Fu6ZmoX49qn+Y1tJXYBRtU15e07utBdqdVXO7nECHJGLRb6WCL9fxkDzBnZpx/k0Eo
         cmMhGvS4JNQzA7gBdA8bE8j2wRK41kyLDJnp9E+2FGHLWqh/DtueFGyIzupbIJ1E2PaI
         nAaz8lmnIQDKbVeC1F0D6TpY6Mji5B3QDkjeqlHOb/PS7ch9prq3Btw0YsrzHOkjgEEH
         4EVX6iVViHawrqyL3Y3Na7qhF/GWYXllV0F0hCIvfEmIwz90bm9CDsC4TLqrOWlAITh6
         tcJ9vf+Z2//EMZxO9LBCNCVbRXfW/142ZkC6cH5DkApqqk5gc2Pqqj1vWqoCsIeiTg6O
         C9sA==
X-Gm-Message-State: AOAM532jKWfsNzHNErBu5LbmTCxWb/+OPYGWts9aL2GHRprnFKtptkEr
        SqpI6iUD1v8koQmTX3GbWW6XVg5jKE5bQIo+eSYtM9HicpVhg+dURSo+vRm4IwlH/5d04pml92M
        3rpMXP8QF3fgTtldxNaQ9Xb7ooHutiAM5YG7L4mQeRIwE3JWSlxF0Z1/1G3nyeg8SzT89bx9O
X-Google-Smtp-Source: ABdhPJwkKEJR2YImyKXGXiLxtnPy1zYqJmYxDX+MkuJ+PbPovvbvJVTuQikpN4iWhxlo+YFxHFyUrNaLNAhF
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:d0b5:c590:c6b:bd9c])
 (user=bgardon job=sendgmr) by 2002:a62:1b4d:0:b029:253:ccef:409d with SMTP id
 b74-20020a621b4d0000b0290253ccef409dmr25212067pfb.4.1619563008656; Tue, 27
 Apr 2021 15:36:48 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:36:33 -0700
In-Reply-To: <20210427223635.2711774-1-bgardon@google.com>
Message-Id: <20210427223635.2711774-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210427223635.2711774-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 4/6] KVM: x86/mmu: Factor out allocating memslot rmap
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small refactor to facilitate allocating rmaps for all memslots at once.

No functional change expected.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5bcf07465c47..fc32a7dbe4c4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10842,10 +10842,37 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	kvm_page_track_free_memslot(slot);
 }
 
+static int alloc_memslot_rmap(struct kvm_memory_slot *slot,
+			      unsigned long npages)
+{
+	int i;
+
+	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
+		int lpages;
+		int level = i + 1;
+
+		lpages = gfn_to_index(slot->base_gfn + npages - 1,
+				      slot->base_gfn, level) + 1;
+
+		slot->arch.rmap[i] =
+			kvcalloc(lpages, sizeof(*slot->arch.rmap[i]),
+				 GFP_KERNEL_ACCOUNT);
+		if (!slot->arch.rmap[i])
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	free_memslot_rmap(slot);
+	return -ENOMEM;
+}
+
 static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 				      unsigned long npages)
 {
 	int i;
+	int r;
 
 	/*
 	 * Clear out the previous array pointers for the KVM_MR_MOVE case.  The
@@ -10854,7 +10881,11 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 	 */
 	memset(&slot->arch, 0, sizeof(slot->arch));
 
-	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
+	r = alloc_memslot_rmap(slot, npages);
+	if (r)
+		return r;
+
+	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		struct kvm_lpage_info *linfo;
 		unsigned long ugfn;
 		int lpages;
@@ -10863,14 +10894,6 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 		lpages = gfn_to_index(slot->base_gfn + npages - 1,
 				      slot->base_gfn, level) + 1;
 
-		slot->arch.rmap[i] =
-			kvcalloc(lpages, sizeof(*slot->arch.rmap[i]),
-				 GFP_KERNEL_ACCOUNT);
-		if (!slot->arch.rmap[i])
-			goto out_free;
-		if (i == 0)
-			continue;
-
 		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
 			goto out_free;
-- 
2.31.1.498.g6c1eba8ee3d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD337ACE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhEKRRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEKRR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:17:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A62C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:16:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so24395943ybp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vLNj1cIP+oKa6jMGIXslJ5VeKEsicN8EXBa0wVTEUbA=;
        b=JziDELrLzdPOVVFcZt2LMfBLwE9wYJJcgRtPq6LalRlVGfBlCaSSNjjpuJIqS5rTcu
         sLAB7kj4PyVss+KydeFzAeZnMpNz/V6TxaUCA+RxL5Sz+r3xoh06AWMEAGJAFF9KqacO
         jqLsqECetEMpiMlkqx/Hv4Qo8mOgv6wb5BqTycYEeQlAfBFWuO7MJzG3V3ZsTTSOC2Fv
         QNS3RPjEpYxd0zeEiBP0q476wg0dgxjtwASw9JIkp/5rzWVACO7gB5WRZuOBq9L1iJ6z
         iswhbKnSgZw6GLV/o5GXW4ehBFwvXDuxQuSexDPHvHngpExYnnzwoaOdGKQco3pnSeaG
         l9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vLNj1cIP+oKa6jMGIXslJ5VeKEsicN8EXBa0wVTEUbA=;
        b=ffnK4EBSUmddHWWM+qt6kZhcUBwRF7iHIVeUXPkkRrCcPFyF9OoEXeg/FMNqIiB2W/
         nGArpqB2LSQ8RIB7kBQhh5FIiJAxc68Ctwxe9bO8jvCf7VKE3QjjBSe5hfosdnM30iw0
         iSRQbl89v1/NuMiF3EGanMQESeIDcxebmaQmfQ9cIfQxItrIRLFSoTKFUqGcGfgdCC3q
         pHyhSK77fqQGnwsHmV1iBXZXW2qBZug6GKi9oIFYmvjXV0IYdv+N2gEduD6sl4zBuXul
         gU6dxVbOfbg9LgmW7B5K52uigvvf2QuCzI555YZJozjBG6Eert6IaYQRlAmlCPe2x5a8
         ZeOQ==
X-Gm-Message-State: AOAM532oOMVbKoBFVDwtHQ1A6pzXSru+wafZbEbG/nnDlpA5+uzH/F0b
        tfRFsvqV3jYCPldMLn/cWkOugVXH8h1N515RKLQWKEb9DQV9JKRkPfHaQxhwUZ8sjNr2qyyZMQg
        hrlLb3x2NGhEu6ZI3OnMcXFhhlUjbicnAs0EhaoXvzhqXyS9Ih8kd9TjxOaIR9skdpxrHKqGX
X-Google-Smtp-Source: ABdhPJxgNIAXOzKJ8wv3a2gXn/nIkxP7cWrxaAtVlTZnD/aTfsAIBISZGToEaZZ3Zw9x0odikRFmHGSjcm2m
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:e050:3342:9ea6:6859])
 (user=bgardon job=sendgmr) by 2002:a25:4c5:: with SMTP id 188mr22654430ybe.299.1620753378555;
 Tue, 11 May 2021 10:16:18 -0700 (PDT)
Date:   Tue, 11 May 2021 10:16:04 -0700
In-Reply-To: <20210511171610.170160-1-bgardon@google.com>
Message-Id: <20210511171610.170160-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210511171610.170160-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v4 1/7] KVM: x86/mmu: Deduplicate rmap freeing
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small code deduplication. No functional change expected.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5bd550eaf683..1e1f4f31e586 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10887,17 +10887,23 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_hv_destroy_vm(kvm);
 }
 
-void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
+static void memslot_rmap_free(struct kvm_memory_slot *slot)
 {
 	int i;
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.rmap[i]);
 		slot->arch.rmap[i] = NULL;
+	}
+}
 
-		if (i == 0)
-			continue;
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	int i;
+
+	memslot_rmap_free(slot);
 
+	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
@@ -10963,12 +10969,9 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 	return 0;
 
 out_free:
-	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
-		kvfree(slot->arch.rmap[i]);
-		slot->arch.rmap[i] = NULL;
-		if (i == 0)
-			continue;
+	memslot_rmap_free(slot);
 
+	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
-- 
2.31.1.607.g51e8a6a459-goog


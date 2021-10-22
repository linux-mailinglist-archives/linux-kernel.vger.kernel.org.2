Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6B436F39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhJVBCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhJVBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:02:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9CC061766
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:00:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a25aa07000000b005bfb84d2315so2377964ybi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uP76BeEeyXiZDzx4DIrX06PdaoPoy0ZNNySRA0QIYsU=;
        b=WqKQiYLyxfWi42AoyORk0WwzfZ5dxrdBbQL/FYgz2YnvU1o38Kt+qzjesKjE70PuuI
         zcuwvcvgvDTJVzpEjcRGYz0OkbWtB6eccqUQ6HAeWDZvU/KvwTqfwwQsLTgWebBfYDsN
         YSuK8r8rkeRJm10mlN02jSPJ+BV43n6OHcY8X4y4lMd4QwfU1v8VCzqZa8v3Tg3jXTLh
         bkftO6e56jg6u0a6UXQ3f8q339wUW5jHrJG3/zFBZStyRDh1N52xHMk8GWB5wzA3vIPO
         ztOROz6NDjLyAbHyQ9/+v3rfd8aRDkW+/kNaHXRBjAVo7IeuXX6vk7VxhO644Pnbzr5i
         joRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uP76BeEeyXiZDzx4DIrX06PdaoPoy0ZNNySRA0QIYsU=;
        b=B1TP1l7TCPj86mVE8QzLvjCxCr7m6mLYqm3NFu1K9Xl0g8NrsK2a/h+rpbTSrWDuKn
         VrA6oj1PjFoSISTvLVmwXPTFYbyfA39DNsTRZPEaKMUXR6HAeLgkP5gJ5hXgAgRpkqKd
         B7Ng8BLVjxL23ysr1PGJ3aw2f75V0CFpwoRwKYPNFjhWCgDsN6LxdlKUkk+q5dwfUxZ/
         Z8Eh6hy27nedsmUyahHVdeYFpk8rKiMxoq/XQrlmYauvl/sXSVXofUsRlZHSSgRT71cg
         4QyiDCXcgLESGAnWpgL7eh9xHqmxikoAWMDIZxhKSyZ6HOuxJyxzdXtPGa+F+rW/QVtf
         f4fg==
X-Gm-Message-State: AOAM5313/LsqymWpiw060EHRHH97BxYkTajQjVfdGnyAfiYH+6i2ucix
        zV+4JatSTPOQ852kxMh1FFtYPmXa15U=
X-Google-Smtp-Source: ABdhPJzAJQDqCQs20zjnyfOitNCdEJd9CehByjoCIBNad13zC1kmmiA4SDp1lQtSLi6L0W3lpUGu2A9cBm8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:db63:c8c0:4e69:449d])
 (user=seanjc job=sendgmr) by 2002:a25:9248:: with SMTP id e8mr9995072ybo.373.1634864414814;
 Thu, 21 Oct 2021 18:00:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Oct 2021 18:00:05 -0700
In-Reply-To: <20211022010005.1454978-1-seanjc@google.com>
Message-Id: <20211022010005.1454978-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211022010005.1454978-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 3/3] KVM: x86/mmu: Extract zapping of rmaps for gfn range to
 separate helper
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the zapping of rmaps, a.k.a. legacy MMU, for a gfn range to a
separate helper to clean up the unholy mess that kvm_zap_gfn_range() has
become.  In addition to deep nesting, the rmaps zapping spreads out the
declaration of several variables and is generally a mess.  Clean up the
mess now so that future work to improve the memslots implementation
doesn't need to deal with it.

Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e8b8a665e2e9..182d35a216d4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5667,40 +5667,48 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 	kvm_mmu_uninit_tdp_mmu(kvm);
 }
 
+static bool __kvm_zap_rmaps(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
+{
+	const struct kvm_memory_slot *memslot;
+	struct kvm_memslots *slots;
+	bool flush = false;
+	gfn_t start, end;
+	int i;
+
+	if (!kvm_memslots_have_rmaps(kvm))
+		return flush;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot(memslot, slots) {
+			start = max(gfn_start, memslot->base_gfn);
+			end = min(gfn_end, memslot->base_gfn + memslot->npages);
+			if (start >= end)
+				continue;
+
+			flush = slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
+							PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
+							start, end - 1, true, flush);
+		}
+	}
+
+	return flush;
+}
+
 /*
  * Invalidate (zap) SPTEs that cover GFNs from gfn_start and up to gfn_end
  * (not including it)
  */
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 {
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *memslot;
+	bool flush;
 	int i;
-	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
 
 	kvm_inc_notifier_count(kvm, gfn_start, gfn_end);
 
-	if (kvm_memslots_have_rmaps(kvm)) {
-		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-			slots = __kvm_memslots(kvm, i);
-			kvm_for_each_memslot(memslot, slots) {
-				gfn_t start, end;
-
-				start = max(gfn_start, memslot->base_gfn);
-				end = min(gfn_end, memslot->base_gfn + memslot->npages);
-				if (start >= end)
-					continue;
-
-				flush = slot_handle_level_range(kvm,
-						(const struct kvm_memory_slot *) memslot,
-						kvm_zap_rmapp, PG_LEVEL_4K,
-						KVM_MAX_HUGEPAGE_LEVEL, start,
-						end - 1, true, flush);
-			}
-		}
-	}
+	flush = __kvm_zap_rmaps(kvm, gfn_start, gfn_end);
 
 	if (is_tdp_mmu_enabled(kvm)) {
 		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
-- 
2.33.0.1079.g6e70778dc9-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836230CACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhBBTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhBBS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:58:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51961C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c18so12601090pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JmOMIXWttp6i62xS7cuIM/ozODaFpac3D3d4bnLpAU8=;
        b=euAu6Opvq1y1VpidLQ8Oq09e/TrLgb/rbhNuIy2MmJdEzB5ZqUlxB1H8xT8zfEB6Vj
         3/BJsYUUVr/lDP04W+4nMyvJpPCOq38UjhDo51soy8LwSenYDFUqqpXnCT7SpBTbwtjY
         cbCcJh8qRfoDvwUktyeGxopGlmq167RyyhBBmzRG6lINudxDvwgHgItf/N1LJFQFjct/
         eibxVR8YJ95nhps7dxooxnJCCQlGca8uynQ1L9GlG9zvottVYQRO8M3aWUqgl6K84I6A
         OkPyluEoHxW6iVYkDeYqPK34PiUT4fA07x9XVkUuWgbmQu7E/m8Cj7PTnbNdgLKB8L7j
         tkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JmOMIXWttp6i62xS7cuIM/ozODaFpac3D3d4bnLpAU8=;
        b=l2BN2bBNNf0lTszqgR7KhTsFubZRM9P0ZJSgSvXveAnvLoWzoQKPI8fJVZJbdVqUf8
         JiK0ck9cSl5+sOgX2lG22Rr8BRDLx6ukKUQb+rpfvplT2q90MNSaoxC/PF6UBHT8lcgY
         ESmazMpvJAcUD19dLy8aumh/KwkdjKQYI5Nhpo5dD3gAfacECu+/3pjCKqcAJzLOZgcS
         UyCfED4nVfxeUtgCUvTl3dzNOCPcIHGfLzNH6xuGTLljMIboMpXnCCFrXrw8m0kAWCSG
         iN+qaKu2ag2lvkjMw58x2ssWF9z/t7bSFIntU4cKBKrDzOaiC+u99LKtfoJ2LwOEvugz
         04rw==
X-Gm-Message-State: AOAM530mGb0O8X6PvCIdKTqju3ABoBZUAGZKHRi0VUQsanFonHKKgc7V
        eeOxEOsrmXgBGxXVwl5xBkHC6lwD8AV/V7xO3iIC9uQ8aIc56nuyp1u4FGxbRcTCZEsWMUKt7lr
        VaZfUI+Aaq4a/J7sAS43q228MNnxZ5TKXAenhy+tObm/sp1fajNa3o2HBK4m1dEiQ1YT8MXit
X-Google-Smtp-Source: ABdhPJyALatEZ01ixKvjEw/9drTlyjjz5b4Lp2A/W9XIayTqqPdwvUTu2WeQErsecDzxzztrUEokK56l18Hf
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:2b8:b029:1b8:a114:f81f with SMTP
 id q24-20020a056a0002b8b02901b8a114f81fmr22719715pfs.19.1612292260621; Tue,
 02 Feb 2021 10:57:40 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:07 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 01/28] KVM: x86/mmu: change TDP MMU yield function returns
 to match cond_resched
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
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

Currently the TDP MMU yield / cond_resched functions either return
nothing or return true if the TLBs were not flushed. These are confusing
semantics, especially when making control flow decisions in calling
functions.

To clean things up, change both functions to have the same
return value semantics as cond_resched: true if the thread yielded,
false if it did not. If the function yielded in the _flush_ version,
then the TLBs will have been flushed.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 39 ++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 2ef8615f9dba..e9f9ff81a38e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -413,8 +413,15 @@ static inline void tdp_mmu_set_spte_no_dirty_log(struct kvm *kvm,
 			 _mmu->shadow_root_level, _start, _end)
 
 /*
- * Flush the TLB if the process should drop kvm->mmu_lock.
- * Return whether the caller still needs to flush the tlb.
+ * Flush the TLB and yield if the MMU lock is contended or this thread needs to
+ * return control to the scheduler.
+ *
+ * If this function yields, it will also reset the tdp_iter's walk over the
+ * paging structure and the calling function should allow the iterator to
+ * continue its traversal from the paging structure root.
+ *
+ * Return true if this function yielded, the TLBs were flushed, and the
+ * iterator's traversal was reset. Return false if a yield was not needed.
  */
 static bool tdp_mmu_iter_flush_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
 {
@@ -422,18 +429,32 @@ static bool tdp_mmu_iter_flush_cond_resched(struct kvm *kvm, struct tdp_iter *it
 		kvm_flush_remote_tlbs(kvm);
 		cond_resched_lock(&kvm->mmu_lock);
 		tdp_iter_refresh_walk(iter);
-		return false;
-	} else {
 		return true;
 	}
+
+	return false;
 }
 
-static void tdp_mmu_iter_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
+/*
+ * Yield if the MMU lock is contended or this thread needs to return control
+ * to the scheduler.
+ *
+ * If this function yields, it will also reset the tdp_iter's walk over the
+ * paging structure and the calling function should allow the iterator to
+ * continue its traversal from the paging structure root.
+ *
+ * Return true if this function yielded and the iterator's traversal was reset.
+ * Return false if a yield was not needed.
+ */
+static bool tdp_mmu_iter_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
 {
 	if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 		cond_resched_lock(&kvm->mmu_lock);
 		tdp_iter_refresh_walk(iter);
+		return true;
 	}
+
+	return false;
 }
 
 /*
@@ -469,10 +490,8 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
 
-		if (can_yield)
-			flush_needed = tdp_mmu_iter_flush_cond_resched(kvm, &iter);
-		else
-			flush_needed = true;
+		flush_needed = !can_yield ||
+			       !tdp_mmu_iter_flush_cond_resched(kvm, &iter);
 	}
 	return flush_needed;
 }
@@ -1072,7 +1091,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
 
-		spte_set = tdp_mmu_iter_flush_cond_resched(kvm, &iter);
+		spte_set = !tdp_mmu_iter_flush_cond_resched(kvm, &iter);
 	}
 
 	if (spte_set)
-- 
2.30.0.365.g02bc693789-goog


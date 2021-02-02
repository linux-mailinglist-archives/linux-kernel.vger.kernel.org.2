Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2CB30CADD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhBBTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbhBBTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:00:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFABC06121F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:58:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11so24051441ybl.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r9zf4JapqsUbKkhg3MdDCwfnvpgINJBQ+t3m5xFJi3A=;
        b=BthiZkDKRBnfpRaHuUlcedzUCwp0gA+v6ZySt9zENYUU17VUhTMuRiinMwXBUIHTjd
         y3QZQ1WBGtOmWvL6Aj0QltfBQTI76nX0dBd2Ix+RKTL+xEvstYKw9QMZl40BFs/kZk+5
         UE33gnArZmtCj9VVelChvI5iAbLvWWsrlBrXBXaaVFv6aF9HE1KvnJ2TIr/fscZO+sz7
         ttyPCQv1jd2vZ3wNHcrjRvYb2R6nYRXAfR40/dw6asH+JqVU1+hQTciR1Tismk0qSMEX
         qUtOjcVm3Y6B2eLG8uXGBRHU7WhJdvvmfGfpUXEhgpI0PZVTjl6deS3zXgV1EsVaVBv5
         0xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r9zf4JapqsUbKkhg3MdDCwfnvpgINJBQ+t3m5xFJi3A=;
        b=PeZ1DrRne1VODk5R2PvwC23V/HwK1p1RE9lI1VFXu4i/6vi+mmM22OBjA9Jp9qvLfF
         UwHRDiKgIcQMAK84RLXzZ858L4F1ncJ6n/qVUHUllgOapgs7/Jq3cfVFXxK0Ok+DLNfU
         rJMJZthGxe1db1itBa8W799cQLspOropL5rpoVqNNT9ehR84/vfYHap9psP3RsLNmfNp
         7TdEZxwxLc1QDPXL7Y3aMM/N+qunl54vQ7o9OnLSLj/E4XRqhHw2n5gbyVm2XgQ0tiNj
         +kNomc8KRqTfMAcUmjATIHevEPsHVJof6GJRFa7OqZj+cAyw7BxrYWGsWhBl3kNulzmU
         bGLA==
X-Gm-Message-State: AOAM5314dRMGdzVLF7C14CeQp9wGNLuElikmMzE6Sg3xs6lPMkIFg5O7
        hAXiKCN25gk+bqfTpUNkLKpdZynMtYzDp+HMFvniWULprDBChWxwr+n1THfu7QloKI/t9B3o/fF
        Rte9hrFbIC00a3AIU68CJ5y8sXtGBifbSERgFeZJt3sup9nZjtzUSltvcfz9/TbdF3KUK2GEx
X-Google-Smtp-Source: ABdhPJwpXiHO1n0Vvt+COE83RSFbSRP15c1huQEKtMuIA/E3dznJXAwBdC2hdQ7te4BbpK/5Bw26Ax7AsXT4
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a25:be13:: with SMTP id
 h19mr33995134ybk.53.1612292279737; Tue, 02 Feb 2021 10:57:59 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:18 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-13-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 12/28] KVM: x86/mmu: Rename goal_gfn to next_last_level_gfn
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

The goal_gfn field in tdp_iter can be misleading as it implies that it
is the iterator's final goal. It is really a taget for the lowest gfn
mapped by the leaf level SPTE the iterator will traverse towards. Change
the field's name to be more precise.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.c | 20 ++++++++++----------
 arch/x86/kvm/mmu/tdp_iter.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 87b7e16911db..9917c55b7d24 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -22,21 +22,21 @@ static gfn_t round_gfn_for_level(gfn_t gfn, int level)
 
 /*
  * Sets a TDP iterator to walk a pre-order traversal of the paging structure
- * rooted at root_pt, starting with the walk to translate goal_gfn.
+ * rooted at root_pt, starting with the walk to translate next_last_level_gfn.
  */
 void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
-		    int min_level, gfn_t goal_gfn)
+		    int min_level, gfn_t next_last_level_gfn)
 {
 	WARN_ON(root_level < 1);
 	WARN_ON(root_level > PT64_ROOT_MAX_LEVEL);
 
-	iter->goal_gfn = goal_gfn;
+	iter->next_last_level_gfn = next_last_level_gfn;
 	iter->root_level = root_level;
 	iter->min_level = min_level;
 	iter->level = root_level;
 	iter->pt_path[iter->level - 1] = root_pt;
 
-	iter->gfn = round_gfn_for_level(iter->goal_gfn, iter->level);
+	iter->gfn = round_gfn_for_level(iter->next_last_level_gfn, iter->level);
 	tdp_iter_refresh_sptep(iter);
 
 	iter->valid = true;
@@ -82,7 +82,7 @@ static bool try_step_down(struct tdp_iter *iter)
 
 	iter->level--;
 	iter->pt_path[iter->level - 1] = child_pt;
-	iter->gfn = round_gfn_for_level(iter->goal_gfn, iter->level);
+	iter->gfn = round_gfn_for_level(iter->next_last_level_gfn, iter->level);
 	tdp_iter_refresh_sptep(iter);
 
 	return true;
@@ -106,7 +106,7 @@ static bool try_step_side(struct tdp_iter *iter)
 		return false;
 
 	iter->gfn += KVM_PAGES_PER_HPAGE(iter->level);
-	iter->goal_gfn = iter->gfn;
+	iter->next_last_level_gfn = iter->gfn;
 	iter->sptep++;
 	iter->old_spte = READ_ONCE(*iter->sptep);
 
@@ -166,13 +166,13 @@ void tdp_iter_next(struct tdp_iter *iter)
  */
 void tdp_iter_refresh_walk(struct tdp_iter *iter)
 {
-	gfn_t goal_gfn = iter->goal_gfn;
+	gfn_t next_last_level_gfn = iter->next_last_level_gfn;
 
-	if (iter->gfn > goal_gfn)
-		goal_gfn = iter->gfn;
+	if (iter->gfn > next_last_level_gfn)
+		next_last_level_gfn = iter->gfn;
 
 	tdp_iter_start(iter, iter->pt_path[iter->root_level - 1],
-		       iter->root_level, iter->min_level, goal_gfn);
+		       iter->root_level, iter->min_level, next_last_level_gfn);
 }
 
 u64 *tdp_iter_root_pt(struct tdp_iter *iter)
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 47170d0dc98e..b2dd269c631f 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -15,7 +15,7 @@ struct tdp_iter {
 	 * The iterator will traverse the paging structure towards the mapping
 	 * for this GFN.
 	 */
-	gfn_t goal_gfn;
+	gfn_t next_last_level_gfn;
 	/* Pointers to the page tables traversed to reach the current SPTE */
 	u64 *pt_path[PT64_ROOT_MAX_LEVEL];
 	/* A pointer to the current SPTE */
@@ -52,7 +52,7 @@ struct tdp_iter {
 u64 *spte_to_child_pt(u64 pte, int level);
 
 void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
-		    int min_level, gfn_t goal_gfn);
+		    int min_level, gfn_t next_last_level_gfn);
 void tdp_iter_next(struct tdp_iter *iter);
 void tdp_iter_refresh_walk(struct tdp_iter *iter);
 u64 *tdp_iter_root_pt(struct tdp_iter *iter);
-- 
2.30.0.365.g02bc693789-goog


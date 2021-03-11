Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF8338158
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhCKXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhCKXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:17:58 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D3C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:17:58 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id d137so1540805qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X0XCjVCvhvbH3OrIFQ9hEGpj4aufRJMFYEYVKUCG4/0=;
        b=jaohzeDkuOwcE3EF4dC2nlQr6YB7AOxQAW6yv0QPXuwHIEKT31GPNUY5QzqbfzSZLU
         qsM0eGg6zfWB4hCf3pLWWiRql57bj9a5jh5/xPjgXvSukVffonIEw+/b2dBAEx4Vtl9+
         IMY8J3d6Ae1HZEPe8KZ6g4vVZ/5JzA6chnBx3dbN73EofcqiR8Yiyam6ottkgPT6BzyJ
         7UzDtuOP4doOoXaEZcmT+UQBtTq+CRsdokizdZ+BXELdpV9f9nBFr11CDEx0BYJUjVdu
         Nx7h1A0LM5+M6A+wifAIljzIYvfBQU0TFxhZg8eygX9TlHu6t9IeOMcHeqr/qoNq3UQa
         zeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X0XCjVCvhvbH3OrIFQ9hEGpj4aufRJMFYEYVKUCG4/0=;
        b=LysR1TTvY7waOzhlvh0LrqWfK05o8i/ajSlOpTgVOqclRW06s4NrW7Dr6+RpwpoScN
         xRKtWm/ESRtEO/Qj9Ckt663xtGLICVytC0NnQCogp0/2gBQomgnPJEG/t1138D3pW9vc
         0DoaR1Jabwb+Ux6DhV7/Cy6kipMptrc2V0atNQrdwqrgejYUKUsfeaS6zz1hkec7BeSf
         dsVnJN+Cjp6u6GoGWr3Sdu5N8rXe24gmfpq7oCJMTrNcUq8dxva342gAVB3OD8SvcnTW
         kPXwwtnqO8p85gk9vXe/33cQWhPyrg8SoFl9LpAuKPGcithtkyIDsVWMXo9ncAshOxSi
         Ak0Q==
X-Gm-Message-State: AOAM531h4iLEHfDoE8LYWZcTqycsqMioJ6EEGHLByj3nSiluxPmQ3ndA
        61eSTKIKd0fFUSDq7WPTTKxlMAk5qWD9gfmU8w2kOOI1ZPLknmantH5a3OprPiejA9hsNijm9NR
        yc2pNOY1TwGJQ8pBDu7S7Ob3E9GwxAiP4LkvtbCPoHIadhip6zfxfwiNACaa5USvz0MWnCOSQ
X-Google-Smtp-Source: ABdhPJxVeaYlfCoROC02zZsOcBw7+wpEjU4aMS5KaUJBvId7WfS0464ppBBqk4LJBqITGOksKsxW/67djgGx
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b4d4:7253:76fa:9c42])
 (user=bgardon job=sendgmr) by 2002:ad4:5c87:: with SMTP id
 o7mr9772773qvh.31.1615504677316; Thu, 11 Mar 2021 15:17:57 -0800 (PST)
Date:   Thu, 11 Mar 2021 15:16:58 -0800
In-Reply-To: <20210311231658.1243953-1-bgardon@google.com>
Message-Id: <20210311231658.1243953-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210311231658.1243953-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 4/4] KVM: x86/mmu: Factor out tdp_iter_return_to_root
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tdp_mmu_iter_cond_resched there is a call to tdp_iter_start which
causes the iterator to continue its walk over the paging structure from
the root. This is needed after a yield as paging structure could have
been freed in the interim.

The tdp_iter_start call is not very clear and something of a hack. It
requires exposing tdp_iter fields not used elsewhere in tdp_mmu.c and
the effect is not obvious from the function name. Factor a more aptly
named function out of tdp_iter_start and call it from
tdp_mmu_iter_cond_resched and tdp_iter_start.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.c | 24 +++++++++++++++++-------
 arch/x86/kvm/mmu/tdp_iter.h |  1 +
 arch/x86/kvm/mmu/tdp_mmu.c  |  4 +---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 8e2c053533b6..bbf53b98cc65 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -20,6 +20,21 @@ static gfn_t round_gfn_for_level(gfn_t gfn, int level)
 	return gfn & -KVM_PAGES_PER_HPAGE(level);
 }
 
+/*
+ * Return the TDP iterator to the root PT and allow it to continue its
+ * traversal over the paging structure from there.
+ */
+void tdp_iter_return_to_root(struct tdp_iter *iter)
+{
+	iter->yielded_gfn = iter->next_last_level_gfn;
+	iter->level = iter->root_level;
+
+	iter->gfn = round_gfn_for_level(iter->next_last_level_gfn, iter->level);
+	tdp_iter_refresh_sptep(iter);
+
+	iter->valid = true;
+}
+
 /*
  * Sets a TDP iterator to walk a pre-order traversal of the paging structure
  * rooted at root_pt, starting with the walk to translate next_last_level_gfn.
@@ -31,16 +46,11 @@ void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
 	WARN_ON(root_level > PT64_ROOT_MAX_LEVEL);
 
 	iter->next_last_level_gfn = next_last_level_gfn;
-	iter->yielded_gfn = iter->next_last_level_gfn;
 	iter->root_level = root_level;
 	iter->min_level = min_level;
-	iter->level = root_level;
-	iter->pt_path[iter->level - 1] = (tdp_ptep_t)root_pt;
+	iter->pt_path[iter->root_level - 1] = (tdp_ptep_t)root_pt;
 
-	iter->gfn = round_gfn_for_level(iter->next_last_level_gfn, iter->level);
-	tdp_iter_refresh_sptep(iter);
-
-	iter->valid = true;
+	tdp_iter_return_to_root(iter);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 5a47c57810ab..2ecc48e78526 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -63,5 +63,6 @@ void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
 		    int min_level, gfn_t next_last_level_gfn);
 void tdp_iter_next(struct tdp_iter *iter);
 u64 *tdp_iter_root_pt(struct tdp_iter *iter);
+void tdp_iter_return_to_root(struct tdp_iter *iter);
 
 #endif /* __KVM_X86_MMU_TDP_ITER_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a8fdccf4fd06..941e9d11c7ed 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -653,9 +653,7 @@ static inline bool tdp_mmu_iter_cond_resched(struct kvm *kvm,
 
 		WARN_ON(iter->gfn > iter->next_last_level_gfn);
 
-		tdp_iter_start(iter, tdp_iter_root_pt(iter),
-			       iter->root_level, iter->min_level,
-			       iter->next_last_level_gfn);
+		tdp_iter_return_to_root(iter);
 
 		return true;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog


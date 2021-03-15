Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25C33C599
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhCOS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhCOS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:27:07 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E6C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:27:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6so14577577qvu.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EKob6tlP8lBjDbv9XP0X/EBXxf5qoM5NvDApjzhDeLw=;
        b=qIxHH+3i2D7PNeGJC3Wruim3zEj1MDgDvkZZzXY+pHWwAtNmGgwLhZjQc9yyTJId1a
         6gqc18J9p7NmH54ZStew8XMiJlLLaDXkOt1Bvbs70dfzfyNj5bVHJopRXw8/y9Z4ZJFP
         66iq1veO96DphXblNTphGfgta/p6RsdVMgk/9r5YqinzRvz2vsc80PJZdyr37OQ+padx
         L122UH0b8zhy1naRpVakJAyRflF/cuzL1chxOr/LlfIQVsg+6LhCg38NpMUS1iqJvJm7
         T+t/N/1jXIHwcLqnf2VR/Ny/ve/QlmD8mYvhTOVaw5jvqZ5JO2eVtKFdfMiSCo/nenXq
         CYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKob6tlP8lBjDbv9XP0X/EBXxf5qoM5NvDApjzhDeLw=;
        b=FBjs3Or3OtJSuhbHQiz2wu9g1ff/0Z0pH+uNBwiemBYwHXfLHm/OpsdE01di6ETgWN
         kNn7mBlJ32/BLvnSP9B/vyGviW6ojUbLYnMf0zyY8nO4oF8B1CGWmAsGNVIjJo8KmKlK
         cUxIiAezP42ipHZRN1JGaOwK0wAj1/k0nzKwjTph1ckw38XSGUuDfV4wT4dEzWrFbE7p
         tMWdxXGKdiMtRkcoL35uy2JyS6D9CKp29m3OTqFx94ho9twOuGWcPlVtXFtc/QFjQ1ST
         86TfIP7h61cpawA7b7Lgg4u8f3GnQv++3rEjCl2aCxZb7hO27JdrOIoEPZmYWTYNKizY
         09sg==
X-Gm-Message-State: AOAM530toBb+jjffBxQ2dTvJUoq9ijRf7N6VZUfpdbDY5Pjdmfv/gcqH
        7dUaKTo44+m11tInahvkoCw8LVCkqMhGdWWoNeI4kEd/oWxyOZt0MAer3dBXeLE7u2wXYlGbFmc
        I0il98doQaVMSaZSAaV+nIDGzXbik3fDfOzKaPqixJ0RmKHMXB4S85iHqXw1etuZNYjqihQt/
X-Google-Smtp-Source: ABdhPJxV6f2d8sp2lRsUZqtou2HPYkHQ/27qulx/IXNINjzP/jaq5BzIiuGb1hM4wbTTS0ozjfS4L5gNztBf
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:888a:4e22:67:844a])
 (user=bgardon job=sendgmr) by 2002:a05:6214:88:: with SMTP id
 n8mr12426191qvr.22.1615832826469; Mon, 15 Mar 2021 11:27:06 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:26:42 -0700
In-Reply-To: <20210315182643.2437374-1-bgardon@google.com>
Message-Id: <20210315182643.2437374-4-bgardon@google.com>
Mime-Version: 1.0
References: <20210315182643.2437374-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 3/4] KVM: x86/mmu: Factor out tdp_iter_return_to_root
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
index e5f148106e20..f7f94ea65243 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -20,6 +20,21 @@ static gfn_t round_gfn_for_level(gfn_t gfn, int level)
 	return gfn & -KVM_PAGES_PER_HPAGE(level);
 }
 
+/*
+ * Return the TDP iterator to the root PT and allow it to continue its
+ * traversal over the paging structure from there.
+ */
+void tdp_iter_restart(struct tdp_iter *iter)
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
+	tdp_iter_restart(iter);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 4cc177d75c4a..8eb424d17c91 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -63,5 +63,6 @@ void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
 		    int min_level, gfn_t next_last_level_gfn);
 void tdp_iter_next(struct tdp_iter *iter);
 tdp_ptep_t tdp_iter_root_pt(struct tdp_iter *iter);
+void tdp_iter_restart(struct tdp_iter *iter);
 
 #endif /* __KVM_X86_MMU_TDP_ITER_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 946da74e069c..38b6b6936171 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -664,9 +664,7 @@ static inline bool tdp_mmu_iter_cond_resched(struct kvm *kvm,
 
 		WARN_ON(iter->gfn > iter->next_last_level_gfn);
 
-		tdp_iter_start(iter, iter->pt_path[iter->root_level - 1],
-			       iter->root_level, iter->min_level,
-			       iter->next_last_level_gfn);
+		tdp_iter_restart(iter);
 
 		return true;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog


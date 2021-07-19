Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA33CD2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhGSKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhGSKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so14314631qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hd3eXFI12/cSmrxyxLEWCVWM4Lg6AoDwKdvReeRGEGk=;
        b=HGOnJdXy3Mnr4dlmP09v+4kaA2VwsExFHRqk7q43R4drwSHPnf1kYry4Wl5kKwf0Ee
         q/AgvmFXPCqnse7moGoX/peLgHs08Z53JM0cUkTPG1e+mtiHg1mJ2gYMZZUr8eQckACF
         wPuNxnbctRGG/p9PXW+RIQz859Ea6UKp0pNoSz1H4BUNYSpYklqGDGeZKmZm2FHM5kEr
         vGVayYqJLFtEQKuIrH7lDHglKIh66lQcveE6hfwNqQ1Tdyg10vEx/33yvUTrcxgKd8UJ
         LivnrEnDoNFECAWWZ+T5aV5YpgdGclh8bF5DU/PHmR1fk5vvK3XCxKeOwUm2PcqyFwgY
         tglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hd3eXFI12/cSmrxyxLEWCVWM4Lg6AoDwKdvReeRGEGk=;
        b=kpTkzPxvLip45IU1Zuw/C7rJmwv9OVv0BDTmnQGpSzusUqY0DU6ZEL5sgzA0fzSPvu
         M2rhsUci3fA8ecLx4yBWgE1aQOZnHu0SFdW3gz4ldxzSNr6mI+i7rHWuq/LDt5V/bjOw
         ssx/TlieuE7hZP8NrMpqeKUojVIivtkpP4mnKsqzgTzvrsLBlo54winX07Dft3tCqjod
         JnSGV8ZxpWhuhCg+8j22sUff0N41o7tnyc4egRx79eJvtDwSI5ZpEgzYpK8jzr0Fmvlm
         UKfkjH0qzpS1XIu4WZNAZf+kcDMzvKdkafIfiUvhP5NO1iwKSdwXwgg7HleHC+8BB4dV
         ct3Q==
X-Gm-Message-State: AOAM533ElUIT+D4VUd0qHpyw+w6DVm9+LLBP8s4DeKnhgEeA01XxDw3t
        2G+Exbsk4QOSV3FfCUpr9uYcFmi7dkt+
X-Google-Smtp-Source: ABdhPJymJx2U/vPY7h8AjNJlQB0JopARk77JVivMgxwS6x59HR1TE3wCFjBaR7svOiHcbbVPqjLfxnY80gtQ
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a0c:c350:: with SMTP id
 j16mr24060301qvi.51.1626691663046; Mon, 19 Jul 2021 03:47:43 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:22 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-2-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 01/14] KVM: arm64: Provide the host_stage2_try() helper macro
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently unmap all MMIO mappings from the host stage-2 to recycle
the pages whenever we run out. In order to make this pattern easy to
re-use from other places, factor the logic out into a dedicated macro.
While at it, apply the macro for the kvm_pgtable_stage2_set_owner()
calls. They're currently only called early on and are guaranteed to
succeed, but making them robust to the -ENOMEM case doesn't hurt and
will avoid painful debugging sessions later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 38 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..56f2117c877b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -208,6 +208,23 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
 				      prot, &host_s2_pool);
 }
 
+/*
+ * The pool has been provided with enough pages to cover all of memory with
+ * page granularity, but it is difficult to know how much of the MMIO range
+ * we will need to cover upfront, so we may need to 'recycle' the pages if we
+ * run out.
+ */
+#define host_stage2_try(fn, ...)					\
+	({								\
+		int __ret = fn(__VA_ARGS__);				\
+		if (__ret == -ENOMEM) {					\
+			__ret = host_stage2_unmap_dev_all();		\
+			if (!__ret)					\
+				__ret = fn(__VA_ARGS__);		\
+		}							\
+		__ret;							\
+	 })
+
 static int host_stage2_idmap(u64 addr)
 {
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
@@ -223,22 +240,7 @@ static int host_stage2_idmap(u64 addr)
 	if (ret)
 		goto unlock;
 
-	ret = __host_stage2_idmap(range.start, range.end, prot);
-	if (ret != -ENOMEM)
-		goto unlock;
-
-	/*
-	 * The pool has been provided with enough pages to cover all of memory
-	 * with page granularity, but it is difficult to know how much of the
-	 * MMIO range we will need to cover upfront, so we may need to 'recycle'
-	 * the pages if we run out.
-	 */
-	ret = host_stage2_unmap_dev_all();
-	if (ret)
-		goto unlock;
-
-	ret = __host_stage2_idmap(range.start, range.end, prot);
-
+	ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
 unlock:
 	hyp_spin_unlock(&host_kvm.lock);
 
@@ -257,8 +259,8 @@ int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
 		return -EINVAL;
 
 	hyp_spin_lock(&host_kvm.lock);
-	ret = kvm_pgtable_stage2_set_owner(&host_kvm.pgt, start, end - start,
-					   &host_s2_pool, pkvm_hyp_id);
+	ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
+			      start, end - start, &host_s2_pool, pkvm_hyp_id);
 	hyp_spin_unlock(&host_kvm.lock);
 
 	return ret != -EAGAIN ? ret : 0;
-- 
2.32.0.402.g57bb445576-goog


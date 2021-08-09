Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B73E48A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhHIPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhHIPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:19 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DBEC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:24:58 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id o4-20020a5d47c40000b0290154ad228388so5424801wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g0Tec8zCIIV6B7UFt/na0xdI02dI+qYcG36GmUIxQNs=;
        b=u/8T1pZALwA4/sFdX62scy5dCtljsLkrBi8I1Wo5YlC53+ou/YjrvDL8JNsEIB71bE
         LRivkMFVgCH0BtjYzhigCs/bBsZnzm1aZdrrbJrAhXN2dDwjESl94VxP5qszcWj4CCEd
         kb6ZNqQAPWs3owfE5gBV3uIxdOads4TKkeSBC+CEa86jU1FkSsXByuLM+TGmtl+JwI1s
         V5+s+6x3trNBHDLQF9LXi2sMfrQr2qHgz74SlBLo1h0tqRcsn8LkQJbmZFl6TVJkfNSa
         l+1c8KgXcM3JN+xcOybD93Qo/Y8JcdC1KdNJjrp98+bqF+lnmdb8LFXpm1F/xsbnlAZG
         wATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g0Tec8zCIIV6B7UFt/na0xdI02dI+qYcG36GmUIxQNs=;
        b=PRfJiKWn3YQ1SqAJeMxjghiLPx1Fma+vL6n98Brkh9XgwmkshMUtoJtP3t6vDRSoZY
         OZmlVrGy9wMcEPH8L11PHp3tQ7/pZUen6ww2rVVlUl+D3vtqiqv3B8pLpZCKdnKu8OKx
         RXNw2Yfuq/JEldKYLgEs4v1Eeh0vJmFlGit0iU8z5thCqSdxrt3M5vU7oUxE/PosFLIg
         NFf7vCMGMeopALXqPCrfuxHLca3BWKa1KRSJ5hGNK1cBGcbmU1BKVma5CZ/sjO4eha4j
         xnhUiGJOL9NpxLAYjrdDA+hA3rlJNuWtk0XClNtApL4q7PGPv/2sZBfGjF026pcEIf46
         LGWw==
X-Gm-Message-State: AOAM533WymISQHTtM1sIE3VGrxI5lM55E9tjS/d4QU/s66cOG+DisHuD
        ybsp16sr2cPPfl/wRobjRmscHZ0zjUcT
X-Google-Smtp-Source: ABdhPJwdhbneOWgiW5/bK5oKtxthf7W2lS34xOPxnKsvszEVciXZLPa8/F4hD9ZjXEHPO3uTXXdiY7U47vX5
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6000:232:: with SMTP id
 l18mr25664566wrz.24.1628522697474; Mon, 09 Aug 2021 08:24:57 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:30 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-4-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 03/21] KVM: arm64: Provide the host_stage2_try() helper macro
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
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

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 40 +++++++++++++++------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..74280a753efb 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -208,6 +208,25 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
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
+		int __ret;						\
+		hyp_assert_lock_held(&host_kvm.lock);			\
+		__ret = fn(__VA_ARGS__);				\
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
@@ -223,22 +242,7 @@ static int host_stage2_idmap(u64 addr)
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
 
@@ -257,8 +261,8 @@ int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
 		return -EINVAL;
 
 	hyp_spin_lock(&host_kvm.lock);
-	ret = kvm_pgtable_stage2_set_owner(&host_kvm.pgt, start, end - start,
-					   &host_s2_pool, pkvm_hyp_id);
+	ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
+			      start, end - start, &host_s2_pool, pkvm_hyp_id);
 	hyp_spin_unlock(&host_kvm.lock);
 
 	return ret != -EAGAIN ? ret : 0;
-- 
2.32.0.605.g8dce9f2422-goog


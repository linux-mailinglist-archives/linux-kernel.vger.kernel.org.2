Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A903D568E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhGZIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhGZIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46660C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v19-20020ad455530000b029032620cab853so6146145qvy.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SklhMqwq/2h4UO2xk/TmhlS4/BSmhG4vZDkK4FOF1kk=;
        b=LcLE/Jxwj2rOGbqgdQiy58nAwXiFuJnR0+9TqiIE8hs+Iyxf9iUvWeng8nwkqOFgWB
         BuOc+xFO+Gucu5aszLn/tMe2JBUDM0tc2WMztZaRwSiTi0Z4dI7WRe4nF1DGw2Ada5mQ
         EJsy1NU9tzqDQEMIt0kQYVRgSEktTdB91LYl0+Z47z30mnDwuEWgGlbsuqbVEr+rmgwo
         WUV8b9MRyYMu/8EWYGeJZ2scufoqME6mhLaF+TJYVQIj6VnxRKpweuJnPiv8LSh/Uy7l
         v+NIhechSjHyaVP7EIEbLZpQNJ+rJ7CFadROzDvvnI3yU16amLsOWHV/8yMYGz9H3HUz
         fFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SklhMqwq/2h4UO2xk/TmhlS4/BSmhG4vZDkK4FOF1kk=;
        b=kq29ta5bd25eLtmi8LhBRcwDPcI45UXAJKunWpiHBuDmGkRXPjt/j5z3Jj/bzLU5S0
         S9mHIPtceD52+osxzaP6j4rpX7bsV6DXz5pPbW4fCwz3ypKcwBdGoKZyjFH0MVmKp70m
         WIIEMyOB7RjZfVdwJJcUemlMMF/Rm7J8VwdNYiS+QPdChZIgGdvEDFLdHccWHS2OoicW
         zNIz0+tKTtGIpd5BNtYbVpkn132I6RVtxKF9qvfAB1Jh9rEE6GX0+oNHUWW7YHW20mnH
         kOEhgO2j6sjajifWXjoBP0AFeHgoM+3LM2tNaMI5GCkUXS9zlTrJJI+cM4lCr1BJQU7c
         NzdQ==
X-Gm-Message-State: AOAM530CTg8Nd916UiMI6HWfd/Hk7/8/DxTlOq3+nfp1AJXPXAoFv641
        XFGk3o51FBk2bddEiguW5G7Mo3wsPip3
X-Google-Smtp-Source: ABdhPJyogngKNGamlr33/F+qdMicL+YqDoeMIdDoBqR2/1/6VaABd58xqeW5MV1R2hLXiW7ahS2yx7ibByaj
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:ca5:: with SMTP id
 s5mr16960121qvs.58.1627291755454; Mon, 26 Jul 2021 02:29:15 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:51 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-3-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 02/16] KVM: arm64: Provide the host_stage2_try() helper macro
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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 40 +++++++++++++++------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..871149246f5f 100644
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
+ *
+ * Must be called with host_kvm.lock held.
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
2.32.0.432.gabb21c7263-goog


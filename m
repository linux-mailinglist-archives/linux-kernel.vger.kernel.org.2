Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF43DA420
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhG2N2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbhG2N2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F2C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w10-20020a0cfc4a0000b0290335dd22451dso1791970qvp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ATiyLC5m+9bmdBYcDBkPgetNyCcHjVe1BNbOPK3Xa6Q=;
        b=OqRh2DivWRwS1PBtKegpyfDBYkMloX5jagqHe1vyeZJWSLQKdZRgp2d+xwx0GJIkQW
         QZ2QSanSfxgy9Wce9m9rmjL3UA1sTmhe2tgCos0VPpCxjlLtM0IGduNpJprR59Tu2CT+
         cIR1sequ0SyiSX6FhZl8dyIBIA11l5qUpOPwKsxeuIYoU2ZpHynVwaJOe+G3r8ykGWFo
         gdbjk7UlL1nYQ6wR9CGXdTP8kBswWWKumbD5kUNfvKtWm1So6t8OXteOZkdFy5HrMy0A
         3WECcSIO9ofZeH5sX4UUWEpcnFCrYOUdZwNbYRPL2dxux0HVY+y7WPY5DaUP47qFAmP6
         yjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ATiyLC5m+9bmdBYcDBkPgetNyCcHjVe1BNbOPK3Xa6Q=;
        b=nK7U4jInE/vMUeFLxzgYr98xmuWBeXtnkqysnUpDqUJXmKoOYOohKu1E20qYgS7Zzz
         eAT8p4iRb8bqiP1BawglP9EDJ8MsMLBfsnD2QGLLLFWan5vVwQp3y7MRsA6Tem65c+Im
         1rUh73bbYR7XxEsJtLkRn8+aV3rCdSYYhFLbeMJVuG7+REOzFvxDWwW4NHRYRA9Bx7kn
         +XDTa8yjNlNmOqDiUMySUzGzNkCcvMxgnvDF8Ayx+EMKkpq89Pf8eOTWtTqS7/03HgrZ
         jmK1h7R2p7xKB/Ttujq9ItbgmWRajza/7W4PfxXXtLKlikELV/J5vuURFUTtmJeZ75Fr
         SNSw==
X-Gm-Message-State: AOAM531pnyxrvqHMJYcXRlDyAiz7WMSTCZGKNN7Oj8zZ7312Y/OrBW4a
        ZB6FGdzcWqgF5OsTHYEkoBguAmCu1Cop
X-Google-Smtp-Source: ABdhPJyvj7S5X1fDRFz1PU5wtUnJrRchL+QMKuVeP46VjzReAMKnCpUDVjPlF/qwJy6z74GCRKY+6nq3HeHT
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:501d:: with SMTP id
 jo29mr5191775qvb.43.1627565309560; Thu, 29 Jul 2021 06:28:29 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:00 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-4-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 03/21] KVM: arm64: Provide the host_stage2_try() helper macro
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
2.32.0.432.gabb21c7263-goog


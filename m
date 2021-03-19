Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5134195E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCSKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCSKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:49 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:49 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id p15so21380828wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mHH8Es+4fAlRYM4Ijk/d6yzRk425uhOb6R/MTFLjwSk=;
        b=vr1Infv0oafAKH5dGXpB2sE2KyY8fi5gKOdK/ZDQg7n6l7HYp1znPMsJ1FmWo/94JK
         Q5NROR6jLJt3VR5aSfrkA1bQgIaRMhSdmz+NnIsMQwE2dBMh+UmTvRoPHnfiQhfcFwfO
         z9G0L1zluGyUR3P2Y9Us278BSXQV9tvHCSMCUC7U9+Dz8+NCRrqR7VDXPTIy2SikDRtA
         MShb5pSNk0hjVysWrq0h3cQfJ3IkNYccRfdAT0wp2B/IxAsv0xmB3VFa01XInBM+pLas
         yrCIq+xqSV7/tjVFcM7LpFeCigsmwChqVLgHmV6PzL80NVLVOsm0q6iR9o2iafDyHt49
         XRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mHH8Es+4fAlRYM4Ijk/d6yzRk425uhOb6R/MTFLjwSk=;
        b=C7ELkbw86JVgX10S+rTX3Uh9/1/2l7BYl62gR2fpEXg8wf815TehckllF3oAWdrEqj
         FEML8T8Fr4N3ANO/dO0zhn4Gtpq54dJ71UJyZTTvEjEqYm0M5JjAPA3spPzadeexvCUd
         PQOh5TPmVKOl9O+7+DDgWIdg6tPctjv6NWnG1YgeneicWeuES6QqP1j2IFLAm7QtTE6V
         6oXBhC7SDJLMLRVDxv24Xb7WUaNu1cuO5vZmSNfWvUc6R3dqd1mVCLiTx+YtY4Ti5/rI
         qCpQZfTiWiLl8rk4u8bIcZko360Et0fi8jX2Qh+YfwlLGTLzAm+63WK5i9D15HFb6pAB
         BvQA==
X-Gm-Message-State: AOAM533GfGsd9bZ5LaN4A65urWpeEOOjEtsqUIdP/81pPMPSgVderjL6
        FP1cJkBayXgJJfhiGA3eceWLw+hE9ZhP
X-Google-Smtp-Source: ABdhPJzSR52Pj+HsbOVVMC9NAbeAqKThSCb8Keh7yqOgsfK429inen/RmXXGyNghUdwdJ/4G7ZtObPiBgE+k
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:b70b:: with SMTP id
 h11mr2955172wmf.10.1616148167410; Fri, 19 Mar 2021 03:02:47 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:35 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-28-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 27/38] KVM: arm64: Sort the hypervisor memblocks
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to check if a Physical Address belongs to a memblock
at EL2, so make sure to sort them so this can be done efficiently.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/reserved_mem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index fd42705a3c26..83ca23ac259b 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -6,6 +6,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/memblock.h>
+#include <linux/sort.h>
 
 #include <asm/kvm_host.h>
 
@@ -18,6 +19,23 @@ static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
 phys_addr_t hyp_mem_base;
 phys_addr_t hyp_mem_size;
 
+static int cmp_hyp_memblock(const void *p1, const void *p2)
+{
+	const struct memblock_region *r1 = p1;
+	const struct memblock_region *r2 = p2;
+
+	return r1->base < r2->base ? -1 : (r1->base > r2->base);
+}
+
+static void __init sort_memblock_regions(void)
+{
+	sort(hyp_memory,
+	     *hyp_memblock_nr_ptr,
+	     sizeof(struct memblock_region),
+	     cmp_hyp_memblock,
+	     NULL);
+}
+
 static int __init register_memblock_regions(void)
 {
 	struct memblock_region *reg;
@@ -29,6 +47,7 @@ static int __init register_memblock_regions(void)
 		hyp_memory[*hyp_memblock_nr_ptr] = *reg;
 		(*hyp_memblock_nr_ptr)++;
 	}
+	sort_memblock_regions();
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog


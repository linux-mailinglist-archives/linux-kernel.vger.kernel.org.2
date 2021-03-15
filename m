Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC233BEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhCOOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhCOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:49 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9CC0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:37 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id i14so8253990wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mHH8Es+4fAlRYM4Ijk/d6yzRk425uhOb6R/MTFLjwSk=;
        b=Beq9EHGg6u02WrMXoXiha76AJgeGR2zQYFWI3RMPQJ8SJPiBDvDJ2xvMRIKmzcyAPJ
         UdkFex3yHx9cFx5yrKJXLWNvnHoy/uBfu1nZrSwaDmXrLFXBxW6+W5ed22sngMc58syG
         np+9HkZ/7pbZEUpi4AtJa4M/Z2Me18qVCq1BStpWKDzWbRrAaeBTPVklx9FMlcr7Laoy
         MRBsVtZpcer8oyNqQ3cLKBt61n9YmSymtcE8XlwMe2yekPSUedzYitLSMS7CtpGMrvpB
         /GpMCQWS/OSbMjUqtSIatqCAg86kF5c+5NCA5VM56v/rAF6/dNyEi2smxz9rtCg3Ot4Y
         0pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mHH8Es+4fAlRYM4Ijk/d6yzRk425uhOb6R/MTFLjwSk=;
        b=lzIpqiTqOVYC+gCIO/e0Vy/YFidI/FAxHAeAMmByAoAMxu2gXCgZUcCl1N8g45XdWX
         iXQ7KDmaFcrx0dlrT/NrM1CcgKChgK2blLT/mFevv2i/10WLZqT0uasAUt66lPpJWl+0
         +8tJFnUCgRa6Jhtu6MKPCczD5RcuyahR/sMdAVBsLj8UsLKu//G+mr5dl/+3kqphSdb+
         8eWquZ2FU104be5ArELjks1xXS8EyLOzELk4RZ7JX1kAoIbXq/nVLov8Tm49ZVMByI9G
         xYEf22PfEgHUcDB9dXmwqdyRSipC3e1055WObvV2cxIvbR97Nv5Z5x3RQw2rqp46hb5A
         HgzQ==
X-Gm-Message-State: AOAM533k4BOsyil1QmSqYYAvmhd2FphjPuKAH/weubJGYIDBUCk+9zn1
        vg/KJ+mnopHmtT+n5bFNoOcDEP7AFU2c
X-Google-Smtp-Source: ABdhPJy/rlP2MoLwwsRH3zKIividik0vk4TUyDoTo37xUZHzbmBcrMY6wwSXCy8hyEXmtWB85Uy6Tkpm2kEw
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6000:191:: with SMTP id
 p17mr20999wrx.154.1615818996079; Mon, 15 Mar 2021 07:36:36 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:27 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-28-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 27/36] KVM: arm64: Sort the hypervisor memblocks
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC942219D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJEJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhJEJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:04:57 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA79C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:03:06 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so1800252wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zg+gUiu3ox2wHV7TW+7r/xAJBwKqffZp8cWRWiJTXrY=;
        b=ethTiy3lTzcSneIbLwawi+5olik16z23jgqCFT9E6S+igJ69OtJ1TPMCM3LUeMuDWh
         kwcRJn93q32+YoPQuqYwcmM2DdY9Fe9IYJKgK+GXLbcXpWzMDJRW3LbNqRmKiJUsc6DC
         CebD0o+l0nqeRevVQD1bAdXZQHBHCWfG8Rcoy58tJcFsFAxUPA0SJI81RMitxFI9xF+C
         YxiAvhisoF3VIur01ICFsq3MrvN2eqrXvL8fZNMl/vG0AqdzcjPWDTaTqFZDJuk+h9ab
         QCMcSvBsSTabymd8vvOKuV6YemDU3oBdSpPn6xfZo8O6vSq3YJh46dvt7fuELrY2dzVh
         x/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zg+gUiu3ox2wHV7TW+7r/xAJBwKqffZp8cWRWiJTXrY=;
        b=YpZrlqusGBxxtbiJaym5EQXFrwrgVWqpDU0J9sjs4d2F+SEnPWrxXSLHyz3sCyyocU
         5qJYCNS2qkAHRFQCPsu2jdDs6XSkkVI4dNTgRa3u++yskgSDQXM9S41IoURw0SrytVc4
         CZlatdgH41+wqv/TNc8cVY0rGllp/vT9X5hklF0EEguhMS+WtsOvXYMfMjB4T59VcKb/
         NoxinSDULAgSud2InIkWU5i3PruWvkwYFxxbihcfOCKNZ5iMzoTgDqVb79x+eyMXiDvS
         2F1mcXqqlPxCu29oiCBIDd9lb+Wrm9uVqr/WVBLfshyCs2V9DZZwnFUKvD9TpylBhdCs
         p3mw==
X-Gm-Message-State: AOAM5338zEcHbvCj7lYnDGS962DR6/pVgXUx9vShc0dmrIsc5ADxnWJ6
        eKgK1Saoj5v0/95PhaKe8w+CmtGAG9vU
X-Google-Smtp-Source: ABdhPJxUSKr1FTBsupYcr01qanV2kSzxpxGMspE323G2ZVQjyutuN9ik2CBJcXODTdTUv+X78VCL5yV8AtM/
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:adf:a45e:: with SMTP id
 e30mr18268872wra.269.1633424585068; Tue, 05 Oct 2021 02:03:05 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:41 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-5-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 1/2] KVM: arm64: Fix host stage-2 PGD refcount
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM page-table library refcounts the pages of concatenated stage-2
PGDs individually. However, when running KVM in protected mode, the
host's stage-2 PGD is currently managed by EL2 as a single high-order
compound page, which can cause the refcount of the tail pages to reach 0
when they shouldn't, hence corrupting the page-table.

Fix this by introducing a new hyp_split_page() helper in the EL2 page
allocator (matching the kernel's split_page() function), and make use of
it from host_s2_zalloc_pages_exact().

Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
Acked-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 13 ++++++++++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index fb0f523d1492..0a048dc06a7d 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -24,6 +24,7 @@ struct hyp_pool {
 
 /* Allocation */
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
+void hyp_split_page(struct hyp_page *page);
 void hyp_get_page(struct hyp_pool *pool, void *addr);
 void hyp_put_page(struct hyp_pool *pool, void *addr);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bacd493a4eac..34eeb524b686 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -35,7 +35,18 @@ const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
-	return hyp_alloc_pages(&host_s2_pool, get_order(size));
+	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
+
+	hyp_split_page(hyp_virt_to_page(addr));
+
+	/*
+	 * The size of concatenated PGDs is always a power of two of PAGE_SIZE,
+	 * so there should be no need to free any of the tail pages to make the
+	 * allocation exact.
+	 */
+	WARN_ON(size != (PAGE_SIZE << get_order(size)));
+
+	return addr;
 }
 
 static void *host_s2_zalloc_page(void *pool)
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 41fc25bdfb34..a6e874e61a40 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -193,6 +193,20 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
 	hyp_spin_unlock(&pool->lock);
 }
 
+void hyp_split_page(struct hyp_page *p)
+{
+	unsigned short order = p->order;
+	unsigned int i;
+
+	p->order = 0;
+	for (i = 1; i < (1 << order); i++) {
+		struct hyp_page *tail = p + i;
+
+		tail->order = 0;
+		hyp_set_page_refcounted(tail);
+	}
+}
+
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
 {
 	unsigned short i = order;
-- 
2.33.0.800.g4c38ced690-goog


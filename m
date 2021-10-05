Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46CD422197
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhJEJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhJEJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:04:09 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78DC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:02:19 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso5474345wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tHk4fNmSvcmkrUgevYD4U41Hr/4Newl1f8mzt2RPUWc=;
        b=miKQfMbrmMeNk1nN5Us0pRryucqshdMsoMrRtD78bnN0xpMXDyebUIGBm2N9+RsrjS
         UXs1cSibDRvi2j5buA7f3EAJmJVPTQXbPoOTBYvIY/gj/8Pk4xMg9LHmvDqHKoPbzWhj
         CKw2r5ZL72icTM4eRY5uiI5Cmba4u3bLD6i7BCUh0Di04EY+fYYHfezaua/ZlZ0xG3CC
         XzkqJunDQFO8KNIKYFbmJHYzFqBlmK9kO4mzgbotS+atB5CwSM97GuY5iOwp7Apy6CUd
         9TDvI6JR/UrYgq52ZKMtEgOdcvtnUbgVt8CZhlFNzrhTdHOzXm/mu3rdOcnC9ZxCdibz
         l0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tHk4fNmSvcmkrUgevYD4U41Hr/4Newl1f8mzt2RPUWc=;
        b=3YeR5alWTBnPLdYerjfN0aJ9CFU06013ib8ueYOrEgtuayp5Pqr+8NS/hl93Z2Ah94
         clrnKzElw4Agv+kP/bgHDNmo7Us5wtm2P7hAkEeexTDGzuTbNLlotaY9oBuUX1zm60It
         HdUG9tKhXapwqTktR08M32XPhlI4Y2YZtArEsb3ri4WTJQ+ptjjU3ObRpi/AUBBi2vLt
         NQ24bzhk5fToCPlp4w7aT5asDMd3yvjpjWy/RFb+yP3bERn8u3eaI66WuXjvIbFK3e7U
         LFaShrZ2gWTILpWNJpGvy8W7pUx7r5YDaJLZL1DL4IWW/lKmFSU1TiyR54nZWNc0Zqd9
         EjDQ==
X-Gm-Message-State: AOAM532+8C/i41zbImqs3AZ2pu04u7oIylwxZ+smJRpUfbxvTtb6ZpyC
        yFatPmTDlnFJDRSMrzp85zwT7HuFMTBg
X-Google-Smtp-Source: ABdhPJwGSCqnQhZEyqfA74Q3qEcGbDWSwK0xwXi4KbcWnIWu2bbm4tNiHp9f0/QTwusKaq+9TcjstDkn7Ba3
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:a5d:4b50:: with SMTP id
 w16mr19856776wrs.71.1633424538044; Tue, 05 Oct 2021 02:02:18 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:38 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-2-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 1/2] KVM: arm64: Fix host stage-2 PGD refcount
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
PGDs individually. However, the host's stage-2 PGD is currently managed
by EL2 as a single high-order compound page, which can cause the
refcount of the tail pages to reach 0 when they really shouldn't, hence
corrupting the page-table.

Fix this by introducing a new hyp_split_page() helper in the EL2 page
allocator (matching EL1's split_page() function), and make use of it
from host_s2_zalloc_page().

Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 +++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

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
index bacd493a4eac..93a79736c283 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -35,7 +35,11 @@ const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
-	return hyp_alloc_pages(&host_s2_pool, get_order(size));
+	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
+
+	hyp_split_page(hyp_virt_to_page(addr));
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


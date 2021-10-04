Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC10C4207CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhJDJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:05:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A6C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 02:03:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l18-20020a056214039200b0037e4da8b408so17781476qvy.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tHk4fNmSvcmkrUgevYD4U41Hr/4Newl1f8mzt2RPUWc=;
        b=myW/CpAigjPZ2o/T9HjLhLXbZVJxyS9JodGVVoxwHVcl/oDBQWttTnf0/LE1PwwT89
         gKHppZ/CIgxO5msodZmnUfQBvJdqFUxdYc2bpazuwiq6sHG2QRGBrRuLvZr9ama7hWIy
         ZMJVyyU+o0d18Ju2reVMrpwo7YeU6Ga9AixILWDG8AnRm/y8T+cOnFt3lc+f0kCaWJdY
         pnU5kjI5gSCdVuPAbJjWYsFQ5TkKHM5RnmPP8Cax+hFd8/qzWgC9yJEvhQaq+CaYCveL
         mPuIgKFgnPJ9kaD32mXvPB1nryO78HAjInlK0UW7Z7MGbp2HyWIXaRHkD94LZXB0c6Xr
         UHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tHk4fNmSvcmkrUgevYD4U41Hr/4Newl1f8mzt2RPUWc=;
        b=daaK9mIciUquFRY/OzUESo8hEMSWABTlOGkqnrqU8v9yHUzyprgYH/q4QqEFxMJLNG
         7nMv0wK9KkABVO7X70FDhLVdSDpgwPGSRcJWO0EqImBzTie67IQEBqtmHVxeFIQfUPuW
         MQQSK8e15bOGO9EH/bPTOOgh1Y/kWxuKab551YvFg4pVKuU09vY4vA4LCy82PmFcQRqh
         w4XQ3TxsWmVA63ST1q9pkKyCtzEUrt5O0dhNYAe66JXSjWWjfCt7g6P1M6gle6a1G/yE
         CnwRfV6Pw/q3t/g0FbrKN81PzVTpsVeWTFkbONZ3xvndyuYBmCcbXc6hSI4H8C9BGCAJ
         ZkPA==
X-Gm-Message-State: AOAM533lp82ZI+D1PS8FZnyMPgrr6wytJ0qgSAvKffkd3HXnmCdXQ9jo
        O9YUwMX0kO3noTvtwe6E1EHAqyhfnYqI
X-Google-Smtp-Source: ABdhPJycEaMXqOovXmHOEABw2fHm7gyvxCA3r77eIjHFoIIvQP3KmydvfcyBUYygJRYLqZ5CcnPGaqUsZunc
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:669b:5b16:60b7:a3d4])
 (user=qperret job=sendgmr) by 2002:a05:6214:c47:: with SMTP id
 r7mr4515752qvj.12.1633338238007; Mon, 04 Oct 2021 02:03:58 -0700 (PDT)
Date:   Mon,  4 Oct 2021 10:03:13 +0100
In-Reply-To: <20211004090328.540941-1-qperret@google.com>
Message-Id: <20211004090328.540941-2-qperret@google.com>
Mime-Version: 1.0
References: <20211004090328.540941-1-qperret@google.com>
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


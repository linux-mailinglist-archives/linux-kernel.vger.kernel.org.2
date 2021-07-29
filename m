Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E13DA445
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhG2N3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbhG2N3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:00 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50EAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:55 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b6-20020a0cbf460000b02902dbb4e0a8f2so3931685qvj.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RPFJCEtaWTMugcF+NjceDUD4B85Vp1oeldRispcGqoY=;
        b=bCde7WqPKlxY/xHp5JNTJjJWBNhOJVIwYFfYXuBL6y9hVFcJKQjvu1Mgb3V+PuXsnX
         mqBCCgRgi/wqWG8KCgA+CMGVirqrgoaOVCFuzncfBsxc8XcDVkSloOQL2ifClKz0If3Y
         1wGjcqXn9IBvEFZrjB/A6wvBdmg9otbA4SPJIe1YnoJj2Zoifvf6c0fZu36QDT+x1w2U
         MwG1JN/XJryBjI4GbZ9IGY2pInQUGfILqs/7RNeTqPYGYAb8DyV5wZCuO40ax1atjGrB
         w8RvMOQRQqGwRk0P2fFmfVIf+LG2HiF0+IJYdhgVjWw3xx+9XsPAm+vszSyUj/0eUuYl
         Xufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RPFJCEtaWTMugcF+NjceDUD4B85Vp1oeldRispcGqoY=;
        b=Qr/B7AbX6mBxQ9OQ6JNOFGd4Ecf2GminuCDyawkZp9opKZcn33IDrOICc7S1ZK3666
         SFMaN3ASTuf5E4t1RIzSET1DFrqb3DuaR8CwLXcnn+fmW5XhK229dYgdgt4O8IBTgXQa
         RIsWYbHBhXldWLBZVZlruU2KV5trNPV+6CO4f57v4Ra1sh8NERc0THb2+SNCHtD6dFfe
         R2OYPgf0zIfLgtvz9fo2JZXdt3qCIJKLed4w2nTZXSIumDUAHwzP5SVqQWpCuV5RXm7J
         5bI5bkmVlD9s6Syl0xVa3kePrU6AJAORRKYS5AgBYAnq+bJ0xMAMD5vVssmOF1jIwP8F
         qy2g==
X-Gm-Message-State: AOAM531WuDNg5OcSpc9Ql3f4GGGdIfmdAn6CNkteU7yoKFtdsYcBGM7j
        cRZtz2lteqgRrcdPBXBPglXSuLK7x7ZM
X-Google-Smtp-Source: ABdhPJxO1maZxYuMOOkc4lCtsFIycuYzMEuf8no7IwacnRivc5nMk/nvcqWV/4Hs90Z3Rs5fFhvpcPIxnoD0
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:ad4:4a8c:: with SMTP id
 h12mr5181240qvx.62.1627565334836; Thu, 29 Jul 2021 06:28:54 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:11 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-15-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 14/21] KVM: arm64: Expose pkvm_hyp_id
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

Allow references to the hypervisor's owner id from outside
mem_protect.c.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 2 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 47c2a0c51612..cc86598654b9 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -46,6 +46,8 @@ struct host_kvm {
 };
 extern struct host_kvm host_kvm;
 
+extern const u8 pkvm_hyp_id;
+
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a7f6134789e0..bb18940c3d12 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -31,7 +31,7 @@ static struct hyp_pool host_s2_pool;
 u64 id_aa64mmfr0_el1_sys_val;
 u64 id_aa64mmfr1_el1_sys_val;
 
-static const u8 pkvm_hyp_id = 1;
+const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
-- 
2.32.0.432.gabb21c7263-goog


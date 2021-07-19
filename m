Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0D3CD2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhGSKHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhGSKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:36 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80489C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:56:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h22-20020a05620a13f6b02903b94aaa0909so3737630qkl.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+nFhosBzSZV7qNAcnaziksYJNq5Oy+qXrjjFGFJtf38=;
        b=NVj8E5o746nTD4LMKyEjLfcN0+iNKd4Q3+ARDYWcQq2Bc1tygxtGoghORVPHuz55fr
         6XRVVKrCybVPnQoQ1dqIiRNFFsZO8Z9BJgYIHQDMxMPYPfrqI4GGFGxB1LTirahtqKgF
         xAKvcu5plneJQWJFaJ2c5xabR1g5t5l+kwW/aZ2D/8oPbSsqYoKBcR7AgbnOKB7FMw3S
         X7XC0MCHbF0+T/+/kcIrOaIFYgnutjaITulomfUfEJjKZS9PqaUiCF++55pWMzZV9q2E
         BJsPLP9JbGxG1U4PRz6OPrAsYUQlxu7PGOUlltDvQ/zsstSFZALQC40mm9bEPB4ctH8U
         aEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+nFhosBzSZV7qNAcnaziksYJNq5Oy+qXrjjFGFJtf38=;
        b=XHuZxyKETcFpmz7rCwbmMXzDvBDfvsiR6rovaSojpXaWPhKra/eSzFzp3+cefWDTaZ
         SU86Pw6hIgOmMbmTM+7RP/oKIOVGWpgogWjw1PRApxJ04CrwIPqTmzUIRw9SNuX/JUnx
         ZdDjvVHmjP5sxlKqpykHUPt5fYRHIou+GYHBWdx5811MyemyGvRFQOmBlel96RbX/1r1
         CmucJCm7qjzqcZBul0oe+h+hKafF7qS0kpY5iY6wYd3YxbMqaPUAAWQpK0gC68olamjn
         5ikOStWFmRbg7bN4IkENeCNekIKe9/WIy47KWH4JhVsjEuOQflzUVTrRBSESL5A4snTj
         z4CQ==
X-Gm-Message-State: AOAM531Dzpsj4Qr0DdMymWDUjpq6zBov40jhFkLmGuJ36oCL8gWiQnTt
        6z1K3EspirXyvIx02vEy0vwzW+TUtH9+
X-Google-Smtp-Source: ABdhPJwNiWUH69H9j/rg7cEvViy/uJINohR7ix2A2F0PALIs2gR1NMlLOsKLwVie0SGTwrZNmWFRI0oB0D9I
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a0c:e313:: with SMTP id
 s19mr23719350qvl.26.1626691686389; Mon, 19 Jul 2021 03:48:06 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:32 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-12-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 11/14] KVM: arm64: Expose kvm_pte_valid() helper
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

The KVM pgtable API exposes the kvm_pgtable_walk() function to allow
the definition of walkers outside of pgtable.c. However, it is not easy
to implement any of those walkers without some of the low-level helpers,
such as kvm_pte_valid(). Make it static inline, and move it to the
header file to allow its re-use in other places.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 7 +++++++
 arch/arm64/kvm/hyp/pgtable.c         | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 1aa49d6aabb7..8240c881ae1e 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -25,6 +25,13 @@ static inline u64 kvm_get_parange(u64 mmfr0)
 
 typedef u64 kvm_pte_t;
 
+#define KVM_PTE_VALID			BIT(0)
+
+static inline bool kvm_pte_valid(kvm_pte_t pte)
+{
+	return pte & KVM_PTE_VALID;
+}
+
 /**
  * struct kvm_pgtable_mm_ops - Memory management callbacks.
  * @zalloc_page:		Allocate a single zeroed memory page.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c7120797404a..e0ae57dca827 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -11,7 +11,6 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-#define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_TYPE			BIT(1)
 #define KVM_PTE_TYPE_BLOCK		0
@@ -135,11 +134,6 @@ static u32 kvm_pgd_pages(u32 ia_bits, u32 start_level)
 	return __kvm_pgd_page_idx(&pgt, -1ULL) + 1;
 }
 
-static bool kvm_pte_valid(kvm_pte_t pte)
-{
-	return pte & KVM_PTE_VALID;
-}
-
 static bool kvm_pte_table(kvm_pte_t pte, u32 level)
 {
 	if (level == KVM_PGTABLE_MAX_LEVELS - 1)
-- 
2.32.0.402.g57bb445576-goog


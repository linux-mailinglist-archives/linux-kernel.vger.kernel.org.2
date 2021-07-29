Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9D3DA440
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhG2N3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbhG2N2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:55 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0AAC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:52 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 132-20020a1c018a0000b029025005348905so1997772wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H72uhE5VGkDx1jb1MVcWxLaZfSQPWlRzbrWGol5Bg8o=;
        b=HTncpCcFrfYqsq+B0XVUZSJV3OsWsCbXAq0Nsc6wlmDYOhwALGBrA3jJ41pZG0qqMI
         BUp7QdvrQdj2zE8BkjdDej0plVEuMnXHWUQxTorC7+RLWrL1Cl5SNZOzSPQYcIPsiBfy
         PrIxNokt9gtSQCGyTC4CeE1TIB4Vpi45IPhQSXcZ31S+u0qfhpB+xXZJnFGTLgqBW/FK
         8j7S1I+GtzmzNFPDXkOtQ4OpR5EBk196h65xM3EPu3FNApwn8htU1h7pYOsraR/C0MHV
         Et3C8vRAcLob23EWSpeVAA0PxgEvB3ZxKyeGA3rhHcr1KBj7OXeo6C86lTupLKh5WO3I
         vGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H72uhE5VGkDx1jb1MVcWxLaZfSQPWlRzbrWGol5Bg8o=;
        b=FZVF8xalg4cjxhPApNvihEO+UHnAP+cq2s3m8gh/4YVnybIDjW1HmvMmQqg3pkL0Zt
         UhJE2HctTt+eCJztT1RXa2QAv4Kfshp0nF0WmXYhYxlAwBBWFkV1QKGE9YK5tK5ofkXc
         pPru4rdbKNdKu9Sv8lHxpCq/j4l8S2m6z3OTGixRqggd0m/q6YIzQIKgG/u3HwfPpKPg
         Sype3sFBcBVRaDKV+ETZntMtfCT5dDat7XtNveeuZ7jjB6UGp47zLRqRImCHMRzrAmcq
         KpdeQWeTWYkOKvfE8amzUemi5dY+V8xcbuqdA+Cf3PfHK9fhcWg4ABpFLZ3HjF8hbBhJ
         75oA==
X-Gm-Message-State: AOAM531bFF7YBJb8rwu1cfNO3sXQZ/IkXX6EnyOc3PoGEC8DNQqLWKpI
        is3gbX2MaDMb6Bl5w1hPO2MFKaGuIrW7
X-Google-Smtp-Source: ABdhPJzn1rlmoNXXKLmPJSHjhbkDAjV7ZnprHUg6PgSi5S1PmeBEhPufv9qLwdFykhgetYoUfULvmrtzd+sc
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a1c:a78a:: with SMTP id
 q132mr4804653wme.76.1627565330622; Thu, 29 Jul 2021 06:28:50 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:09 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-13-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 12/21] KVM: arm64: Add helpers to tag shared pages in SW bits
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

We will soon start annotating shared pages in page-tables in nVHE
protected mode. Define all the states in which a page can be (owned,
shared and owned, shared and borrowed), and provide helpers allowing to
convert this into SW bits annotations using the matching prot
attributes.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..ae355bfd8c01 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -12,6 +12,32 @@
 #include <asm/virt.h>
 #include <nvhe/spinlock.h>
 
+/*
+ * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ *   00: The page is owned solely by the page-table owner.
+ *   01: The page is owned by the page-table owner, but is shared
+ *       with another entity.
+ *   10: The page is shared with, but not owned by the page-table owner.
+ *   11: Reserved for future use (lending).
+ */
+enum pkvm_page_state {
+	PKVM_PAGE_OWNED			= 0ULL,
+	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
+	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
+};
+
+#define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
+static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
+						 enum pkvm_page_state state)
+{
+	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
+}
+
+static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
+{
+	return prot & PKVM_PAGE_STATE_PROT_MASK;
+}
+
 struct host_kvm {
 	struct kvm_arch arch;
 	struct kvm_pgtable pgt;
-- 
2.32.0.432.gabb21c7263-goog


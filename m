Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1A3DA423
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhG2N2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhG2N2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:36 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B0C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:33 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id j204-20020a1c23d50000b029024e75a15714so2024788wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gjf1jLwbr60oU/lDUo56+HNoAVcvWGbxZryQe2MxgVI=;
        b=liAJ/B9k752zaUtEr2dNmyI6PNIq95D2uxyTofIPP2Y9x50NOXw4/JT8oVxsLvIkmc
         P7ulUWGLvyLx+t+fWD8rdAsH4RvIVZHUhm9AOhec5RvozMBkX+zZj7nLaIAXqPqIyTGm
         qMSgBtOd1z4GkgAg8Aq2iTh9+h3RRsOREBBjibJ8VnR4P30ZOtFv7y65TudPffgn0bRg
         RznpmwquKro9JhqASPV8OQxONr9moaG80DsU8VJsjXcHn5Yyqn3qHvtX9DT4MJ6bUy36
         iuW7lgbeDizByaPiTm3DcjyGsmrR4gr7L+ezKHNRzsImGGj1FE1SjSaaY2EcjvFz2eYA
         lr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gjf1jLwbr60oU/lDUo56+HNoAVcvWGbxZryQe2MxgVI=;
        b=ntGQsegZTHsWXxx5nvlsQ+vWyNJ4EQpvN75+j5lanXWn6XsfKtFtKNtIAJhjU/l7dr
         iQhmhxz4UiPIF/LBWw2LJanR4N5IZbk1MXvzIl8qqF5iwUVbq3W9UpYpQG5UywspkqQ6
         SpYX8r4jvgmqITzyQPzGJ58ftsHhs/W2qM/es8Sdq5SyYC/lKTz7Ksy0FSX1Xu2CVGYw
         PLawXKe3Z8Nxs1oiP3t2hxp96x9ll2HGwlJ92R8VW1iaWefCoC//rVTPVTXvCHkQU3wH
         XpiNo86sPvUDM2cSE/7t40sBHdYbV9/9bGUpKKav3j6EUP+Ab8bOAm+db1Yx5ktushyG
         XvkA==
X-Gm-Message-State: AOAM531yNDyZ/Ejr0HCa/aVLFSEmq3jrINB38uE23J6H9RubxE4F4Eea
        Bod4zsInwUr0WwIsDK+zWFucVf6NLt4m
X-Google-Smtp-Source: ABdhPJyC7oJeo9hm9rZKLPbAlJuErb6lfSMGOtMtJPYFP3+ud7lcAhFVhw7sxxXnSC8c2pWtkaZZ9KzshhQh
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a7b:c147:: with SMTP id
 z7mr4842725wmi.10.1627565311894; Thu, 29 Jul 2021 06:28:31 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:01 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-5-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 04/21] KVM: arm64: Introduce helper to retrieve a PTE and
 its level
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

From: Marc Zyngier <maz@kernel.org>

It is becoming a common need to fetch the PTE for a given address
together with its level. Add such a helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 19 ++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 39 ++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index f004c0115d89..082b9d65f40b 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -432,6 +432,25 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
 int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		     struct kvm_pgtable_walker *walker);
 
+/**
+ * kvm_pgtable_get_leaf() - Walk a page-table and retrieve the leaf entry
+ *			    with its level.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
+ * @addr:	Input address for the start of the walk.
+ * @ptep:	Pointer to storage for the retrieved PTE.
+ * @level:	Pointer to storage for the level of the retrieved PTE.
+ *
+ * The offset of @addr within a page is ignored.
+ *
+ * The walker will walk the page-table entries corresponding to the input
+ * address specified, retrieving the leaf corresponding to this address.
+ * Invalid entries are treated as leaf entries.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
+			 kvm_pte_t *ptep, u32 *level);
+
 /**
  * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
  *				     Addresses with compatible permission
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 05321f4165e3..78f36bd5df6c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -326,6 +326,45 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	return _kvm_pgtable_walk(&walk_data);
 }
 
+struct leaf_walk_data {
+	kvm_pte_t	pte;
+	u32		level;
+};
+
+static int leaf_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+		       enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	struct leaf_walk_data *data = arg;
+
+	data->pte   = *ptep;
+	data->level = level;
+
+	return 0;
+}
+
+int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
+			 kvm_pte_t *ptep, u32 *level)
+{
+	struct leaf_walk_data data;
+	struct kvm_pgtable_walker walker = {
+		.cb	= leaf_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.arg	= &data,
+	};
+	int ret;
+
+	ret = kvm_pgtable_walk(pgt, ALIGN_DOWN(addr, PAGE_SIZE),
+			       PAGE_SIZE, &walker);
+	if (!ret) {
+		if (ptep)
+			*ptep  = data.pte;
+		if (level)
+			*level = data.level;
+	}
+
+	return ret;
+}
+
 struct hyp_map_data {
 	u64				phys;
 	kvm_pte_t			attr;
-- 
2.32.0.432.gabb21c7263-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA83D5682
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhGZIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhGZIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j13-20020a0cf30d0000b029032dd803a7edso1907661qvl.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gjf1jLwbr60oU/lDUo56+HNoAVcvWGbxZryQe2MxgVI=;
        b=DUXlt4CIx1Jj1CbDy7cdGv8bTdi62I2RYHsrT/s+KJOvTfJ/fwZsR6eGvk7It8rJcN
         bBoWcqIo5xKqnQFtfIFlQBaEBPm+SOq7Xuyw31L0WnzSfdn2t6kbbMQIZzXB0MUUPX8Q
         wxW+8/zX7bGrdM87rM65vxKXgcwv/bXY77icyCnicQZ+mAEy26wCuFtcvS96nYsEpGkg
         0z8vJbr77sREiu6d0IOmXfqa+VIbetUENBqdqiS0fCh4TnmOc6+k33nLzzQDzu0GsDiL
         pmQlhJkSyvFpULMaSDUptBv+CZ5WsBH34jLy6q57bE4W63AjjHdbQf7QAxbCShWBSI8V
         MdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gjf1jLwbr60oU/lDUo56+HNoAVcvWGbxZryQe2MxgVI=;
        b=HiVwUD+hwRgogj99z76rQMBDiSoVPCAYonePiRnHxB0hDAAIzJG2vX4/7TJY3Gfhmf
         /Ex+X1wutRSXBUswCXp1SvB+idW9satrxVPPY68Go9Otvvk42qe5/0YymeOb4LlLyBZ3
         lv/js+ABdimGhnxtVh4TFYu8kKu4ujZhbcAIPxeXJh370dlVpqOd3uCROFc8c3gB4dx7
         gfuA1To9t/HtuAyupitU1sXYuzwhtjWv4oEj1Hg6pQslepttDROQJQGR5wjQBj/Dk2ED
         sq5g9cTFggi4TffmjtzImtk81R6sYiMrhg7AvXVn+l+pwpmQ3QKTYRl3+tsBturJ5STg
         3a7w==
X-Gm-Message-State: AOAM530T74etE7WHopxKy2JwROqBNuwT7g1g0ZYzdj4WdMuGBC9oNK2E
        q9OLDSs61WQKSnwA8DBanE9DXSpHqhyw
X-Google-Smtp-Source: ABdhPJwsdWxD5Vpv+7zklcHUJYq1XgMklZukeoIEPoWdSvMcON5nO372Kxs1TISOnicfY2UxNWOoh5v1fVJj
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:dce:: with SMTP id
 14mr16478055qvt.40.1627291753422; Mon, 26 Jul 2021 02:29:13 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:50 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-2-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 01/16] KVM: arm64: Introduce helper to retrieve a PTE and
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


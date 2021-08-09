Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13E33E48A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhHIPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhHIPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:22 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62681C06179A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:01 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v11-20020a056402348bb02903be68e116adso1181746edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GMZNfzuPpqQplgJREqrbVT8SGjVRH/ICHDZ3APociKw=;
        b=UHGjFJ88t++uDbi+ho+q/XdFtIa+W/7vj7rOtKa5ztsftv96V3hJF8oNqfWIZeOQaL
         aUP+VWMsxv/Ww6yCE/11VKrtsrFRo4r1jE9zZCcHCxeW4QTXs3Hf0eg59+DEpi0AsG9+
         pQpwB2Zfd62iUZFWqRr7WkBLq6/W/YQO57q79BUO2PTtMUj5uiQIu4UTW0GFsdzup9UE
         9v9sMuWxhogJDOCknqN7ch+GClEeK3D78t6XMjW2bjoowOIRZuE8PbSwxbSu3F3AkfXj
         J5a/V4E7m6hSw9dq9XYFJeT/AzeYnLZo6tEmPEs60tS9JdK639KAKwpr/ZkQ/mj98px6
         3hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GMZNfzuPpqQplgJREqrbVT8SGjVRH/ICHDZ3APociKw=;
        b=mNhd46Qs5vGvpAv9zAZrIDOxMZ1GqJ0lhsVbLMJBkGmmiHCDyTk6l45Sr0ggwHRbu/
         tx1qZv6g2heyQZwdaHSOrrQpCsAoUpAYhW70h7Fj3A+bkVgmECo0obuj6hhraf4fhB9d
         dxT+9bKVQ2dwoNmmedoj5QNsEvaLBkv24ioXKeZvchUr8A1CcBHVl/SoeACpkf7jS5zd
         S9pmmxMf+cGKwIzZirOFlEdnxLkL9mMsmNM+vrjlcmlp4ps8aJvvYgOXcJhg8Vc5bQh5
         T5WlYxexri4o0zIOd6akJDwDFZX06jzZNDDaGmz0xJ5KJDcM4aQg1TEzI9P7baQJSX74
         eTOg==
X-Gm-Message-State: AOAM533impNoMjaZQNUGTkMeUqta3LWXRchUiq5//gRlAuwIHT9+FG63
        Bl1Aii0iqt4HtqEQqiPKSvJ8LxoUobCy
X-Google-Smtp-Source: ABdhPJyqzY0L1dCaL3AwOH4Fm7LMkYjK+OM+7knyOMrkv2ibGaXiqJGzChD13pqf4rXPj/gIvGULi/3nex3K
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:aa7:d899:: with SMTP id
 u25mr30548023edq.151.1628522699812; Mon, 09 Aug 2021 08:24:59 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:31 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-5-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 04/21] KVM: arm64: Introduce helper to retrieve a PTE and
 its level
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
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
2.32.0.605.g8dce9f2422-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7673E48BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhHIPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbhHIPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:41 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB5C06179F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:18 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo13-20020a05621414adb029035561c68664so980010qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8jz2lJsOdyZcDtlCHC3Dvx0yZKTs2N3b55wAk/v95ow=;
        b=BDFa2yN6cmKJG3x9zJSFyiSyGXrWwbQI3EkRXEyAoiDsNiZxnCuM7yr8Oa4sS4dxId
         5eKr+FKgGlQq97sho5QfjNNpY4QVEgOwGe4qnto8+PH1sPYKxvsSFFEWd/WmFfbdUvkD
         c3sroI1akznW1wvpagXKal01dux4IP23CQRoyQzKlB2Hq7vZwlRmeuzMiiGUULtM74EO
         vqk/PboQA93VAnMy1vjV9PrMoZNR67MMoGR8eoMC8skkuWKBSfLRX65XrYlx1k9PzQEL
         B4Vu9eiDVi86Co2QUmAnVC43oq9HYU5EMtVUKZQVLmLRE/lJ3PSGixyaFvXfy8rmzq2H
         k/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8jz2lJsOdyZcDtlCHC3Dvx0yZKTs2N3b55wAk/v95ow=;
        b=iRf+GwY0x7x3yVKbP9EURw/3Y4qeC0P37rUG31x9lz5sFJLzdRRQyfjguzSs2/OjRU
         GHKbXg9Sx2d/m8tiHWuckFDu0AQMSfOZCbpJNEcnb4CrEXsWEW7WSKDyg+ZFtqWonngB
         MJO6fSAShhDtQm+yNWFR2rmG2cyOkii+XY/ef8yNegTf9J345eRJwUeQWCTSgVCT3fNJ
         u0hhrafzPvHHZT3UFt74qF2XDjexh3ioRps8l+3Zg0XSVrFGJSsqbJHQHWr4s7k4pVDr
         BrLP4szbc+GaKUbBnWEWpmutZHHycmLFP6tiSXzKWUEINFAQVQH06ARZ/X5fULfrUfZN
         D5Yw==
X-Gm-Message-State: AOAM532oMBY/zJ/ODcNUMgrjN2QcvjkrUu8ob93gdybjZA+ahpQT0Mn5
        n1/1iVAZRVB+wXNKrdPIkcBwdKf2E+Db
X-Google-Smtp-Source: ABdhPJz2l1NOBwMrE26TsCA7occvb2o9beTqoSppx2h3dHXwe0dIzSOg5MwgreJKvwJvtlmSCeojgXOCjH28
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr24445444qvs.58.1628522717738; Mon, 09 Aug 2021 08:25:17 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:39 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-13-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 12/21] KVM: arm64: Add helpers to tag shared pages in SW bits
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

We will soon start annotating shared pages in page-tables in nVHE
protected mode. Define all the states in which a page can be (owned,
shared and owned, shared and borrowed), and provide helpers allowing to
convert this into SW bits annotations using the matching prot
attributes.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..87b1690c439f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -12,6 +12,32 @@
 #include <asm/virt.h>
 #include <nvhe/spinlock.h>
 
+/*
+ * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ *   00: The page is owned exclusively by the page-table owner.
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
2.32.0.605.g8dce9f2422-goog


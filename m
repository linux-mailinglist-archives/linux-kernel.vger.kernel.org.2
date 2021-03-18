Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6A340EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhCRUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRUQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:16:23 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:16:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g20so577986qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwlxfvthq/1vHaMmSvOZKn6TJVtbivDqUpi4VUsVm28=;
        b=fitz4YgC2FPrUR+Ja2KlQmePnPnEFZK+hjb1R20cidOYCTY4wAclhl+ux10ORPZvFd
         HGVSAutuMvzoZQUV4Cb7Ke4Ne6wy4cPQT4RTN+bhc5PWf82QUbh0Z1inx+01zytLfUpn
         U2wBshgo3M3jlsiWvQhtdhrXcz3G1NdtceTbBYsoR+0iTmbWylv1aUpam503SkC8t30L
         7MUxS7rgFH+8Hh68x81rXuwQK5EDu8svQWpXUsiK/NGHqiwrvMsibFSVnzQ8xBWtQ3KM
         07PK+0uRcILYk0cY8CxfVji0/zFiUve9w0WFpOrHugEAazpFCdA+HETD4blQcUqEW1/k
         yDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwlxfvthq/1vHaMmSvOZKn6TJVtbivDqUpi4VUsVm28=;
        b=ovJkeTovuEwtfPlYgTZ05Agk6qZoOXco4knlmY+M7iprp/KQMHTMdSAEDop7AygVzc
         oYKCtLHbwQ8lBuOzpt8AEZDorLmTU4YeBaN9cdwGRy1DQM5mPMicOm2lGyHmJNKZLBbm
         2C5iVhFKBRycJL/H+/VowfCJ3fu4UJTpfzkH1C03aly+zwWDEn9uMLfK4ewyXJoP+Zzx
         t4pE9SiwiQfvfQEUztQ98tGJpSSgzT0VvecW2ubbVrz06VzqrrY/BM/svP8Pn5elj9yV
         x12SHVIiZnnrPb8WdtpECOAfluBJ1OLlDBSLXdU+pQ6ubnGuhYEl8M6Ok5AD4263nebO
         kX/Q==
X-Gm-Message-State: AOAM5312jJeSfJ5iGbjrHyzBytc5UHt4TWDRsoiHAhi17zUm7UlYb1DG
        9pwrjRbC3QfBgZGJ44VQukVfY/VOABNcvDYs
X-Google-Smtp-Source: ABdhPJxnWhT7ATcAED5i33RqoRy0jI35Ep0xCpBhpSTPTLwcunmrjRUQVygqIAnWrUc4BWbZleRFXQ==
X-Received: by 2002:a37:b07:: with SMTP id 7mr5949853qkl.437.1616098581894;
        Thu, 18 Mar 2021 13:16:21 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id i9sm2619607qko.69.2021.03.18.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:16:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, peterz@infradead.org,
        tsbogend@alpha.franken.de, unixbhaskar@gmail.com,
        maobibo@loongson.cn, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] mm: Few spelling fixes
Date:   Fri, 19 Mar 2021 01:44:04 +0530
Message-Id: <20210318201404.6380-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes from V1:
  Mentioned suggestion incorporated.

 include/linux/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5e772392a379..b58f20226bb9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -426,7 +426,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres

 /*
  * On some architectures hardware does not set page access bit when accessing
- * memory page, it is responsibilty of software setting this bit. It brings
+ * memory page, it is responsibility of software setting this bit. It brings
  * out extra page fault penalty to track page access bit. For optimization page
  * access bit can be set during all page fault flow on these arches.
  * To be differentiate with macro pte_mkyoung, this macro is used on platforms
@@ -519,7 +519,7 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 /*
  * This is an implementation of pmdp_establish() that is only suitable for an
  * architecture that doesn't have hardware dirty/accessed bits. In this case we
- * can't race with CPU which sets these bits and non-atomic aproach is fine.
+ * can't race with CPU which sets these bits and non-atomic approach is fine.
  */
 static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
@@ -852,7 +852,7 @@ static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
  * updates, but to prevent any updates it may make from being lost.
  *
  * This does not protect against other software modifications of the
- * pte; the appropriate pte lock must be held over the transation.
+ * pte; the appropriate pte lock must be held over the transaction.
  *
  * Note that this interface is intended to be batchable, meaning that
  * ptep_modify_prot_commit may not actually update the pte, but merely
@@ -1269,13 +1269,13 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 	 *
 	 * The complete check uses is_pmd_migration_entry() in linux/swapops.h
 	 * But using that requires moving current function and pmd_trans_unstable()
-	 * to linux/swapops.h to resovle dependency, which is too much code move.
+	 * to linux/swapops.h to resolve dependency, which is too much code move.
 	 *
 	 * !pmd_present() is equivalent to is_pmd_migration_entry() currently,
 	 * because !pmd_present() pages can only be under migration not swapped
 	 * out.
 	 *
-	 * pmd_none() is preseved for future condition checks on pmd migration
+	 * pmd_none() is preserved for future condition checks on pmd migration
 	 * entries and not confusing with this function name, although it is
 	 * redundant with !pmd_present().
 	 */
--
2.26.2


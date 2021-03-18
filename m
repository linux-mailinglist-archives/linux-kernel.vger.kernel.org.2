Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA45533FFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCRG7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:58:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:58:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d20so1059498qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K86WwfiSy0FoywGKIwEAWKxktqSRMshrkEG8V3Fgnts=;
        b=JHDtfCzUtoQqnEjr4FLxHzXdVNOqXnyUKX05/a4Q6Ud/3p1KhsEl2sBVP4Fqg5UUYT
         Zh1mXNOiVejhsE/Iz7J2uStLx3+gBzkw11m11VMVN0ZsDbBWZWDqUM1+RvO6divisiuR
         E0w0PA9i10Pj8RjpY6eTHMJM63WPHVsR9TSoZG8V9xaH6GVgaRtefC4fmaqm91WTBz+h
         +aUAaWXOhQrUZyZAvh1jX6QpGWxc6l5vDAp+ynfxiQQ66kkAZeTHF9HTXd1QgWad/zUb
         BtBLB918MUA870nU89yv42WrnljFL3xciYmYgNcH5NI3xukFWx4MhHxRKJJvVLX+lz4C
         1MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K86WwfiSy0FoywGKIwEAWKxktqSRMshrkEG8V3Fgnts=;
        b=IKB9gngrR3gsYPHDYj+Q2TR9V+eheK5M4POF5CWq1pIahmBe1zpWAvKy5AtZSgzAMb
         AST2+jhw/JEJ4z3A2gN/bDKpJcXWnvyX6qjbV4gDK0vfYs/WoY5EtbGWx3JHZx1mPygx
         h4pvK8zYQfAhK3YGQC2uYvtE33HMVnv1sATKDP0220CiD6TxR/EHs6m/WVewmsxlrATv
         b1KQGCDtmxgR5KZYa3TQ6SVkOhqYvbQQM8CZN1p5iRX3ncpz59dq6kSsvrbthM31u641
         OVjJyfuOWqpOV1DEj9AxUXbMTxUoGFZZLuj4CD3dq7iMlOrD3iZBxUU7NjBftIO/CIVG
         rrbQ==
X-Gm-Message-State: AOAM533SFsN4j+G4d1MhnYZhFQLwP3rZB/XmHBaGvAHCwA906rELGOOr
        7NPYC+YGzkTyVPp3+O46zXg=
X-Google-Smtp-Source: ABdhPJxuQNAkqZk5HcNJ8AXAXXOiY5+GodutYG90wnoxgbMcH1ezfak4asxUancw89vqAG33HjRVwg==
X-Received: by 2002:a05:620a:214a:: with SMTP id m10mr3097245qkm.372.1616050723634;
        Wed, 17 Mar 2021 23:58:43 -0700 (PDT)
Received: from Slackware.localdomain ([37.19.198.143])
        by smtp.gmail.com with ESMTPSA id f9sm851886qto.46.2021.03.17.23.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:58:43 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, peterz@infradead.org,
        tsbogend@alpha.franken.de, will@kernel.org, maobibo@loongson.cn,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] mm: Few spelling fixes
Date:   Thu, 18 Mar 2021 12:28:31 +0530
Message-Id: <20210318065831.9601-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Few spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5e772392a379..4fcefd553a5c 100644
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
+ * pte; the appropriate pte lock must be held over the transition.
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
2.30.1


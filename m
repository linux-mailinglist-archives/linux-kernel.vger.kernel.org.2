Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9C35ED69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbhDNGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346445AbhDNGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BCC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aqL2XPmlMRZxLZPdbWIiaspy2SPvOqGTVqAYONWsbKA=; b=VfTLL0lOCOriKGVvA6eCq2/yRj
        VL88mlPO4NJTvhbF+Mx2GdlGzwCdTgy3DByo6LP4nt+n0Dpphxs9MN7yfshqC+7VxlpL/SXaigpOH
        i3Ag+R0+YlVvasnPr7KwLRu/pnH29Wmnbin3jL/IC/Z8Jr+/XgEPhCjcx4OGN6rgGJ7pNxLc2NbZg
        LobGFIDAWbcY/by3xNwD0VQPL0ktewzDPoJTtzOvsXhmqXBoye7awtrrIfI1Y7pHZnX5akSqrGzqK
        dzljZRVSmr9vB2TERxDSAI4TKhoCPRyLCul4dXHvjE2eOhXM1qbeeoa6HER3WFkSBTRJJUQHzCtoP
        UYWAcCqA==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZFl-00BiGB-5W; Wed, 14 Apr 2021 06:43:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 1/3] um: pgtable.h: fix W=1 warning for empty body in 'do' statement
Date:   Tue, 13 Apr 2021 23:43:48 -0700
Message-Id: <20210414064350.3923-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414064350.3923-1-rdunlap@infradead.org>
References: <20210414064350.3923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common kernel style to eliminate a warning:

./arch/um/include/asm/pgtable.h:305:47: warning: suggest braces around empty body in ‘do’ statement [-Wempty-body]
 #define update_mmu_cache(vma,address,ptep) do ; while (0)
                                               ^
mm/filemap.c:3212:3: note: in expansion of macro ‘update_mmu_cache’
   update_mmu_cache(vma, addr, vmf->pte);
   ^~~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210413.orig/arch/um/include/asm/pgtable.h
+++ linux-next-20210413/arch/um/include/asm/pgtable.h
@@ -302,7 +302,7 @@ static inline pte_t pte_modify(pte_t pte
 struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
-#define update_mmu_cache(vma,address,ptep) do ; while (0)
+#define update_mmu_cache(vma,address,ptep) do {} while (0)
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 5) & 0x1f)

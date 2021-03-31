Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19E73504C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhCaQis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhCaQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2908C60FE3;
        Wed, 31 Mar 2021 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617208703;
        bh=bxB0Ud41u9B2MEvliIrFV6bKHAPL7ftJFAR825oCHvA=;
        h=From:To:Cc:Subject:Date:From;
        b=PFm9x8SDLSRQw7xGxo2iaHmt9zkAfwdefTS/SPd23h0yZyAE66BQgO+MqAfeKfPLA
         gckFk6SCLCZI/wao5LgfFbe6mWAyvtkD50EVxNr1hhhPaw5mVoOWI073nHyANjjNw9
         YwjQeLAm62tWQCwmveJoh/ug8D9li8smDEbvvaS7cTvrC0OBXsehNkW4/hp7mROpGB
         5H3QvI01aStdV5ml7VWWJ4WhyXHnwd6oTC6k3IO0KrpP3WXoiNczBJh5E0m9gdYq13
         Lq1xELArE4t7OQRMtHHjkj1i13SeVfJ5/x9Kxaus1RNgQh83cRUI3C5tb0sgEceJ5R
         I/neJ+7mrOOwQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugeltb: fix renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
Date:   Wed, 31 Mar 2021 19:38:16 +0300
Message-Id: <20210331163816.11517-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN missed one occurrence
in mm/hugetlb.c which causes build error:

  CC      mm/hugetlb.o
mm/hugetlb.c: In function ‘dequeue_huge_page_node_exact’:
mm/hugetlb.c:1081:33: error: ‘PF_MEMALLOC_NOCMA’ undeclared (first use in this function); did you mean ‘PF_MEMALLOC_NOFS’?
  bool pin = !!(current->flags & PF_MEMALLOC_NOCMA);
                                 ^~~~~~~~~~~~~~~~~
                                 PF_MEMALLOC_NOFS
mm/hugetlb.c:1081:33: note: each undeclared identifier is reported only once for each function it appears in
scripts/Makefile.build:273: recipe for target 'mm/hugetlb.o' failed
make[2]: *** [mm/hugetlb.o] Error 1

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a5236c2f7bb2..c22111f3da20 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1078,7 +1078,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
-	bool pin = !!(current->flags & PF_MEMALLOC_NOCMA);
+	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	lockdep_assert_held(&hugetlb_lock);
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-- 
2.28.0


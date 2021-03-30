Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617D234F02B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhC3Rvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232292AbhC3Rvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A77B619CF;
        Tue, 30 Mar 2021 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617126692;
        bh=vH41Kssp0RaYEeKpGb5b46LRTKi8xAs+POHymbemXd8=;
        h=From:To:Cc:Subject:Date:From;
        b=po0B30taUe5XpZJC2Az5xXpgelji6O7EJa1/Wp5yi4Xp7IRBkUradL0YHGUX1NcHO
         YDpO9qK4MGDdbB2lKW6Pbbh2lZwVDEkyt/bnQzfLJBfjrd1AJZ+9ppNGpHy8KyGTCx
         NVqA3sYobm5EMjLkR1kIdtV4EDp8Gk2mqUp0MwVG8XYoXzZ57/rOK7picZEg4n8442
         mthrvg2sdc+/nzSbJMGkIlS7m+1sPjurthlxnHY+TX7QLeU3eH1dA4cPeFAyN2g2kE
         QfV9Um64jc6HFuaN1eYnZDTKuJqBwCQ7nfBmPUG25oKE96S23TILORUoq8qtKbR2IA
         ATzUeTrf3gPJw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] nds32: flush_dcache_page: use page_mapping_file to avoid races with swapoff
Date:   Tue, 30 Mar 2021 20:51:26 +0300
Message-Id: <20210330175126.26500-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Commit cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
updated flush_dcache_page implementations on several architectures to use
page_mapping_file() in order to avoid races between page_mapping() and
swapoff().

This update missed arch/nds32 and there is a possibility of a race there.

Replace page_mapping() with page_mapping_file() in nds32 implementation of
flush_dcache_page().

Fixes: cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/mm/cacheflush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 6eb98a7ad27d..ad5344ef5d33 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -238,7 +238,7 @@ void flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping;
 
-	mapping = page_mapping(page);
+	mapping = page_mapping_file(page);
 	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else {
-- 
2.28.0


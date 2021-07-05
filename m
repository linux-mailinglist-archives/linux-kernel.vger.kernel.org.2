Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77EB3BC2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGESgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhGESgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 788186196A;
        Mon,  5 Jul 2021 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625510020;
        bh=0U7hZgPxK+V3aSy8+i4BDfGVZnwS/5p/8xyX8R0PyAo=;
        h=From:To:Cc:Subject:Date:From;
        b=U/dHkhRIP114pjZGL3oE1D02XBCEVFMcbo+7KjzI7fQpT2yzKzNjdfXLriB/ZwA12
         wy5FsGzVC3l2WAYiLsDDj4PYKORS3MBFOgSeFtYOwZO1zA4LneE+nMbNxKW/JLqfgj
         zNvZoZRHX9GgfDdYRSnM0phBOul84xb4Irbn6ftfAZ1UsGxy9YOhZM7WtuLtaN0jn9
         tKY0j9L0LpnlI0H9Ki/9kVAVd2rCV+Qh7xJeWbPF5lmVQgSQ/T9okejqsGih0Jfiqe
         FtDdk3dcyAZf4bFjUQoCNKKOwPIedvJMNN+xB9v3Ai05mbBHA9O4EcF+5gaP3Auz22
         sK2vZxwjisiaQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
Subject: [PATCH 1/2] erofs: better comment z_erofs_readahead()
Date:   Tue,  6 Jul 2021 02:32:52 +0800
Message-Id: <20210705183253.14833-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some words about the traversal order and its pagepool usage.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/zdata.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cb4d0889eca9..054b9839e9db 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1424,6 +1424,16 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
+	/*
+	 * All pages are locked in the forward order in advance, so directly
+	 * traverse pages in the reverse order since:
+	 *  1) more effective to get each extent start offset, calculate partial
+	 *     decompressed length w/o knowing the full extent length (which is
+	 *     more metadata costly). If traversing in the normal order, it's
+	 *     mandatory to get full extent length one-by-one.
+	 *  2) submission chain can be then in the forward order since
+	 *     pclusters are all inserted at head.
+	 */
 	while ((page = readahead_page(rac))) {
 		prefetchw(&page->flags);
 
@@ -1460,7 +1470,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
-	/* clean up the remaining free pages */
+	/* drain the on-stack pagepool with unused non-LRU temporary pages */
 	put_pages_list(&pagepool);
 }
 
-- 
2.20.1


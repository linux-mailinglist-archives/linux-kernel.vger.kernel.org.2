Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADF32C401
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378023AbhCDAKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391223AbhCCW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B02C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 14:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZcoL2mr1lmoxyY9eSUa9jIixayUOxgwcpOf1ShYSpb0=; b=E5TG6jFxttCVB6e+wzuYFhkdR+
        gL3AggMlJ4rbmx96hJg3BqFeVvkwvbMCxQCldHZdyHTdK94wEw7Cw1E4irEl3sVBAAwmOSO/QrrME
        bpb0YIBSHGZiHxA+1pqtotJ5evOvxiHr4w2gvIDClmwLRUBlS8pgCx/tNs+Q9596JJF87jex3iwrX
        dPSoP7yZ6dPCk/AkBVB5dfTkzt8PD2Se4KJvrW8UUzTEFtlzSKxjI9MSYoiu4no94abEJdr9tCBpN
        s2+QIjNLOXKj33rsksEw9Gg9PiMovjqC53GAQdYxtuZPKl8TT8Y55TbMs79tCbZQtU61njZC38KuX
        o63GXTdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHZwE-004Qxk-Go; Wed, 03 Mar 2021 22:25:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm/filemap: Drop check for truncated page after I/O
Date:   Wed,  3 Mar 2021 22:25:47 +0000
Message-Id: <20210303222547.1056428-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the I/O completed successfully, the page will remain Uptodate,
even if it is subsequently truncated.  If the I/O completed with an error,
this check would cause us to retry the I/O if the page were truncated
before we woke up.  There is no need to retry the I/O; the I/O to fill
the page failed, so we can legitimately just return -EIO.

This code was originally added by commit 56f0d5fe6851 ("[PATCH]
readpage-vs-invalidate fix") in 2005 (this commit ID is from the
linux-fullhistory tree; it is also commit ba1f08f14b52 in tglx-history).

At the time, truncate_complete_page() called ClearPageUptodate(), and
so this was fixing a real bug.  In 2008, commit 84209e02de48
("mm: dont clear PG_uptodate on truncate/invalidate") removed the
call to ClearPageUptodate, and this check has been unnecessary ever
since.

It doesn't do any real harm, but there's no need to keep it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8d3e0daed7c9..3d1635d3be3e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2238,8 +2238,6 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 		return error;
 	if (PageUptodate(page))
 		return 0;
-	if (!page->mapping)	/* page truncated */
-		return AOP_TRUNCATED_PAGE;
 	shrink_readahead_size_eio(&file->f_ra);
 	return -EIO;
 }
-- 
2.30.0


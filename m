Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66776413106
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhIUKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231450AbhIUKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632218397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7wr6CVD5DKL365HEcceHQplZ6k+a+KRstCK2VbExPq4=;
        b=HoyG0dBbgnlercMCwywqc38E/30JAIe+hgOPEnj3+bULCAriidHzG5hK8kogDjdRiXBOtw
        QI5TYLKxL4SHu6KziabzrL9TZoEPC1cxjEhQHjVJJd+UDpYisoTmfhnoO7Yzcew4qFKBcM
        XOp0uPq9Tq9deGDPooOTfByeY7heC/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-EKj7olJmPC6WzwA-cUnHpA-1; Tue, 21 Sep 2021 05:59:54 -0400
X-MC-Unique: EKj7olJmPC6WzwA-cUnHpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11D1019057A2;
        Tue, 21 Sep 2021 09:59:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA67C10013D7;
        Tue, 21 Sep 2021 09:59:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2] afs: Fix afs_launder_page() to set correct start file
 position
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Sep 2021 10:59:50 +0100
Message-ID: <163221839087.3143591.14278359695763025231.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_launder_page() to set the starting position of the StoreData RPC at
the offset into the page at which the modified data starts instead of at
the beginning of the page (the iov_iter is correctly offset).

The offset got lost during the conversion to passing an iov_iter into
afs_store_data().

Changes:
ver #2:
 - Use page_offset() rather than manually calculating it[1].

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162937512409.1449272.18441473411207824084.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk/
---

 fs/afs/write.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 2dfe3b3a53d6..f24370f5c774 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -974,8 +974,7 @@ int afs_launder_page(struct page *page)
 		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
-				     true);
+		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);



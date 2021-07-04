Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415CA3BAFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhGDXDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 19:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGDXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 19:03:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57539C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BsjaVVnlc7BGHkveFcSINgUymOR3I5TCVJhUMezkykc=; b=Qp7kYzulFeLOyXMSSBL+isdREF
        J6X3l7wIqzGtHWMA5t5gpCo865ormumL3/irSYU0GpEFx1Iok170/MBciJk5X7LCZDHSQiSvOI4Xv
        tZ6A11S6JSCsPmFrgdp3MOqo241irpDnIu3ZcKdG+ipNz1T0ICiDgG+DywsgnJE+oyce8t2GkXzRz
        bvM65VXyJbod9dJw6Tla/AWgWyXYUHbBySZypzZPfoTiqwnBWjsToEmPuRz9tSskHmQNxgoOgcZpE
        SdXPIGXDZ/twiDfQf25371e5y++w0EppOmIO1Iz1r2bSBDK0XEAT7la6H2D8ldQavkmTrAw9JpH75
        nHzhB71Q==;
Received: from [2601:1c0:6280:3f0:7629:afff:fe72:e49d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0B6y-006sB3-Gh; Sun, 04 Jul 2021 23:01:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: try_to_unmap() is now void
Date:   Sun,  4 Jul 2021 16:01:15 -0700
Message-Id: <20210704230115.27694-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the "CONFIG_MMU is not set" case of converting
try_to_unmap() from bool to void.

In file included from ../mm/vmscan.c:33:
../mm/vmscan.c: In function 'shrink_page_list':
../include/linux/rmap.h:294:34: warning: statement with no effect [-Wunused-value]
  294 | #define try_to_unmap(page, refs) false
      |                                  ^~~~~
../mm/vmscan.c:1508:4: note: in expansion of macro 'try_to_unmap'
 1508 |    try_to_unmap(page, flags);
      |    ^~~~~~~~~~~~

Fixes: 1fb08ac63bee ("mm: rmap: make try_to_unmap() void function")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/rmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210701.orig/include/linux/rmap.h
+++ linux-next-20210701/include/linux/rmap.h
@@ -291,7 +291,7 @@ static inline int page_referenced(struct
 	return 0;
 }
 
-#define try_to_unmap(page, refs) false
+#define try_to_unmap(page, refs) do {} while (0)
 
 static inline int page_mkclean(struct page *page)
 {

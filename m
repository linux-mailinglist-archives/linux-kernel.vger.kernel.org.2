Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2087B3F5AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhHXJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhHXJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:18:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9EAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ti5A/ILf1WJ2CVbEVdaMaP5K64yHTjJmYJcdIRgT4r8=; b=cmMZmmlzsKVAb1WsZzJmBctNta
        JElthLUHejS1Bk9uTGAQL/8RXsl4qvXXFQz0fkLmojyKfUwfIDrYIsBISrk46s5gpb49mqvxOsbmG
        romH7HFI+3GBB35QTyFwg/Ic5S3qnFsKUygkxrmZns/TSzTdgst4VLSsW4aHOEuQH6332YiaedSZP
        o6Cug3YfZRVkYxVPgYPlOZeWMcAvscK4WiaCeAbIodrumWhWUMrBYgpK2i3PInK8hQnBZ8J/q0fGk
        hKQyDyLeaGi4mhLxBUHYA9N0XKOD7wnILJlLvQ0DhcsQJSy9QT+Z/49CuKETjybBiRnA3bQmNgXLD
        j4466HSA==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISXM-00Aq2J-7b; Tue, 24 Aug 2021 09:16:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: don't allow executable ioremap mappings
Date:   Tue, 24 Aug 2021 11:12:59 +0200
Message-Id: <20210824091259.1324527-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824091259.1324527-1-hch@lst.de>
References: <20210824091259.1324527-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to execute from iomem (and most platforms it is
impossible anyway), so add the pgprot_nx() call similar to vmap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e44983fb2d15..3055f04b486b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -316,7 +316,7 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
 {
 	int err;
 
-	err = vmap_range_noflush(addr, end, phys_addr, prot,
+	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
 	return err;
-- 
2.30.2


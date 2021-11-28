Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C550446069E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357812AbhK1ODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 09:03:46 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:55878 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357953AbhK1OBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 09:01:45 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id rKhHm0tRPTdRTrKhIm5ZFp; Sun, 28 Nov 2021 14:58:28 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 28 Nov 2021 14:58:28 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dhowells@redhat.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] watch_queue: Use the bitmap API when applicable
Date:   Sun, 28 Nov 2021 14:58:26 +0100
Message-Id: <ce45fdcf1f0fd06e425f700fe53ee38a5a0f66b6.1638107850.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'bitmap_malloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

While at it, use 'bitmap_fill()' to avoid an explicit 'memset()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/watch_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 9c9eb20dd2c5..41ea30948c57 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -219,7 +219,6 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	struct page **pages;
 	unsigned long *bitmap;
 	unsigned long user_bufs;
-	unsigned int bmsize;
 	int ret, i, nr_pages;
 
 	if (!wqueue)
@@ -258,13 +257,11 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
-	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
-	bmsize *= sizeof(unsigned long);
-	bitmap = kmalloc(bmsize, GFP_KERNEL);
+	bitmap = bitmap_alloc(nr_notes, GFP_KERNEL);
 	if (!bitmap)
 		goto error_p;
 
-	memset(bitmap, 0xff, bmsize);
+	bitmap_fill(bitmap, nr_notes);
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-- 
2.30.2


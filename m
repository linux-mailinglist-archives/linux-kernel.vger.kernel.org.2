Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1CA32763D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 03:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhCAC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 21:56:33 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:43918 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCAC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 21:56:31 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1725E1B4054;
        Mon,  1 Mar 2021 11:55:50 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 1212tmMT592252
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 11:55:49 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 1212tmqN3158241
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 11:55:48 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 1212thr03158236;
        Mon, 1 Mar 2021 11:55:43 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] Fix zero_user_segments() with start > end
Date:   Mon, 01 Mar 2021 11:55:43 +0900
Message-ID: <87v9ab60r4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zero_user_segments() is used from __block_write_begin_int(), for
example like the following

	zero_user_segments(page, 4096, 1024, 512, 918)

But new zero_user_segments() implements for HIGMEM + TRANSPARENT_HUGEPAGE 
doesn't handle "start > end" case correctly, and hits BUG_ON(). (we
can fix __block_write_begin_int() instead though, it is the old and
multiple usage)

Also it calls kmap_atomic() unnecessary while start == end == 0.

Fixes: 0060ef3b4e6d ("mm: support THPs in zero_user_segments")
Cc: <stable@vger.kernel.org>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 mm/highmem.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 874b732..86f2b94 100644
--- a/mm/highmem.c	2021-02-20 12:56:49.037165666 +0900
+++ b/mm/highmem.c	2021-02-20 22:03:08.369361223 +0900
@@ -368,20 +368,24 @@ void zero_user_segments(struct page *pag
 
 	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
 
+	if (start1 >= end1)
+		start1 = end1 = 0;
+	if (start2 >= end2)
+		start2 = end2 = 0;
+
 	for (i = 0; i < compound_nr(page); i++) {
 		void *kaddr = NULL;
 
-		if (start1 < PAGE_SIZE || start2 < PAGE_SIZE)
-			kaddr = kmap_atomic(page + i);
-
 		if (start1 >= PAGE_SIZE) {
 			start1 -= PAGE_SIZE;
 			end1 -= PAGE_SIZE;
 		} else {
 			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
 
-			if (end1 > start1)
+			if (end1 > start1) {
+				kaddr = kmap_atomic(page + i);
 				memset(kaddr + start1, 0, this_end - start1);
+			}
 			end1 -= this_end;
 			start1 = 0;
 		}
@@ -392,8 +396,11 @@ void zero_user_segments(struct page *pag
 		} else {
 			unsigned this_end = min_t(unsigned, end2, PAGE_SIZE);
 
-			if (end2 > start2)
+			if (end2 > start2) {
+				if (!kaddr)
+					kaddr = kmap_atomic(page + i);
 				memset(kaddr + start2, 0, this_end - start2);
+			}
 			end2 -= this_end;
 			start2 = 0;
 		}
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

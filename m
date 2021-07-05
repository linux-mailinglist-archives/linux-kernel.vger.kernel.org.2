Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02A3BB6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGEFY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhGEFY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:24:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95FCA613E2;
        Mon,  5 Jul 2021 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625462539;
        bh=vZYGv/E1tXW+mr7nAYMJFnoN1LWBW/rm/2P3TYvvKZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YAPSQ4s6aUeWp+YHgh//SLHpLvV6IAKmTv6J8UBd0+XopqffpHHNu64ujbhwrJSDq
         dAsJP+mw/oB0xMPRpm17y5dyuwcqB0DIRchjgSKPibmSNwfiRrUVU/dOM2+H6/e/Yc
         qQIOUMVK5vRnhlaPATR9spHrDe2Oa9aUV7XBj2SH1+FlzyrnEZcRuX21HDB4gH6A4a
         ffrLUb6gXvtB0SVJ666m8RGUW+Ap/G+7WmsSDKlotq8Z3NTC15I0LIBcYV3UV+3wn2
         zx7OpPkOTRI8L7jqWSVZgcPQZ5hWJ1r1E1zDG/L2IfWU2PD3J66IdL28XXFrbfgJh6
         NHCvh0gYA0yog==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: initialize page->private when using for our internal use
Date:   Sun,  4 Jul 2021 22:22:16 -0700
Message-Id: <20210705052216.831989-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
operations.

Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 fs/f2fs/f2fs.h | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a01a1b50104..d2cf48c5a2e4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3819,6 +3819,8 @@ int f2fs_migrate_page(struct address_space *mapping,
 		get_page(newpage);
 	}
 
+	/* guarantee to start from no stale private field */
+	set_page_private(newpage, 0);
 	if (PagePrivate(page)) {
 		set_page_private(newpage, page_private(page));
 		SetPagePrivate(newpage);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65befc68d88e..ee8eb33e2c25 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1331,7 +1331,8 @@ enum {
 #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool page_private_##name(struct page *page) \
 { \
-	return test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
+	return PagePrivate(page) && \
+		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
 		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 
@@ -1341,6 +1342,7 @@ static inline void set_page_private_##name(struct page *page) \
 	if (!PagePrivate(page)) { \
 		get_page(page); \
 		SetPagePrivate(page); \
+		set_page_private(page, 0); \
 	} \
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
@@ -1392,6 +1394,7 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
 	if (!PagePrivate(page)) {
 		get_page(page);
 		SetPagePrivate(page);
+		set_page_private(page, 0);
 	}
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
 	page_private(page) |= data << PAGE_PRIVATE_MAX;
-- 
2.32.0.93.g670b81a890-goog


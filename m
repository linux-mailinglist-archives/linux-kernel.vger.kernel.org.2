Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810B23FC035
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbhHaAyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhHaAym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 767A260FE6;
        Tue, 31 Aug 2021 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630371228;
        bh=ooTDUto4Y8X1OmuC8lpldPc6v/zwqtRT620l+46tx0c=;
        h=From:To:Cc:Subject:Date:From;
        b=asjTqDVPpZEmoBXOBj1lHhcouEn9iDwA4r5DOw8i0HfIcKsq5N/baZc2n19KOMziG
         ppoP9V4ey2IqQoOmsJqNSdRV84vibU70KO6vy13o+fCqeKD3cD6e/BiGGg7CuBjvQY
         IOHvVluo0KhZ6t33ysLfjRUoT/2IVAIQ+UG53G2T2CNTBdt/omBPgf88GAyBwSjFTC
         UXOLBHIdhqF0B0mhUJr4eAz28PZi2V3VxILSkCRVPq12dp/zc+Kxl00DUCuePFXv7z
         25tWMz00qIZzedzbHRAZVb7yZpeVp4ZY9yezFG8wKwYKoLLTwgSbGBbHOStWGyuJck
         UK48Duvrcf4YQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: deallocate compressed pages when error happens
Date:   Mon, 30 Aug 2021 17:53:45 -0700
Message-Id: <20210831005346.118701-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_write_multi_pages(), f2fs_compress_pages() allocates pages for
compression work in cc->cpages[]. Then, f2fs_write_compressed_pages() initiates
bio submission. But, if there's any error before submitting the IOs like early
f2fs_cp_error(), previously it didn't free cpages by f2fs_compress_free_page().
Let's fix memory leak by putting that just before deallocating cc->cpages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ec70a0a32327..c1bf9ad4c220 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1394,12 +1394,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	for (--i; i >= 0; i--)
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
-	for (i = 0; i < cc->nr_cpages; i++) {
-		if (!cc->cpages[i])
-			continue;
-		f2fs_compress_free_page(cc->cpages[i]);
-		cc->cpages[i] = NULL;
-	}
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
@@ -1410,6 +1404,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	else
 		f2fs_unlock_op(sbi);
 out_free:
+	for (i = 0; i < cc->nr_cpages; i++) {
+		if (!cc->cpages[i])
+			continue;
+		f2fs_compress_free_page(cc->cpages[i]);
+		cc->cpages[i] = NULL;
+	}
 	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 	return -EAGAIN;
-- 
2.33.0.259.gc128427fd7-goog


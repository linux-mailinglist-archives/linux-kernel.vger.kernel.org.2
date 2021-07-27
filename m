Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766B3D7052
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhG0HVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhG0HVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:21:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38DEC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:21:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt6so16541735pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=;
        b=BlZ5TORrVdsM9UZVYF5dKWbkiMboKGpufIwg1C75LjfOOb7lIoe3q6V4VvFYc9XTtk
         NcRF87bFeF4VJ7zXEVQJQmmHN3gobfIUIL4aaoPDFmN1nwFaGC6tUxIKUKqFpYGD25QK
         JAXbmhqDkNEsqh0B2Wev0F7nMfdAGUAFxsDUeJMbed0BdD0is7DjXuaZhsOpIfq6IdUv
         yySBMvr4iA1e/mKfIoQovIU+xrSLWcJGNcN/mCPCaMUHNPowZD0+wddp5tNEGFodZNWr
         6e/+oYZpH5YdxxYUsHwn+nrU7qZVOPM/LzLc/ICbmM7aX2OOKPa/okT7EnhUsVVZcPk7
         9SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=;
        b=gVwm3w+Ol7i+WtIajPyrdybtyq7jmQYIA0fbQPiVHbZ/PHFO06NowQBX4fUhbzcagO
         6Bk04G6QAr1fzvZx1cFazcBwGZG/X9Bh4xg6+1+zkjMrKleUgisO6+Sk5lou1/+Burkd
         EYA7vdsJN2u4LpPa2l6J25dgEkuy8z0O4CU18ZRrUvvXpkr8vsQT0Zcvx09hsEDI83wM
         KRp8ku7muetgWFz8xEVGoSlRRRLPHgexuvlz8ZPoydNjp80LwnjZn1PZf99mRTcsqB/V
         GNnOwjtnUtV/P6apheHaxeG91uzWPhTJtZfK59l270lM/stU2WFOfb1EGaDP7iJLauEi
         uerA==
X-Gm-Message-State: AOAM530TNtYkOlV2JeGhbur1wo1a2yM1S18KqhPD/2ODT2WwdlPcTbrV
        c7cyZzZwWtbDW8bU8P9B3I7Iz6L5HkY=
X-Google-Smtp-Source: ABdhPJzUuPYQD1B0AlAlfTtrC8HkKd4tBpdE0l0mIajeEL4KJT2dcV8zw/Dam7WiO49htKf2Hyzvlg==
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr21566079pjv.139.1627370464741;
        Tue, 27 Jul 2021 00:21:04 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:669a:4d59:379d:fe44])
        by smtp.gmail.com with ESMTPSA id k25sm2394974pfa.213.2021.07.27.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:21:04 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Youngjin Gil <youngjin.gil@samsung.com>,
        Hyeong Jun Kim <hj514.kim@samsung.com>
Subject: [PATCH] f2fs: turn back remapped address in compressed page endio
Date:   Tue, 27 Jul 2021 00:21:00 -0700
Message-Id: <20210727072100.2246422-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Turned back the remmaped sector address to the address in the partition,
when ending io, for compress cache to work properly.

Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache
compressed blocks")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Hyeong Jun Kim <hj514.kim@samsung.com>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a716c3b5457..53e71e1bb673 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -228,7 +228,13 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	bool all_compressed = true;
-	block_t blkaddr = SECTOR_TO_BLOCK(ctx->bio->bi_iter.bi_sector);
+	sector_t sector = ctx->bio->bi_iter.bi_sector;
+	block_t blkaddr;
+
+	if (bio_flagged(ctx->bio, BIO_REMAPPED))
+		sector -= ctx->bio->bi_bdev->bd_start_sect;
+
+	blkaddr = SECTOR_TO_BLOCK(sector);
 
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
-- 
2.32.0.432.gabb21c7263-goog


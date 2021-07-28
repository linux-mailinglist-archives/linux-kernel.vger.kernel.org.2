Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599E3D961C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhG1TiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1TiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:38:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AAEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:38:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z3so2656060plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=;
        b=CrSdY90uBzF24xeu3OTgmcLWve+jUYrMlNJ4pwYP60/pqYnSZlLCjbZy4fJ436pel7
         1eeArlZinJDCKmvV2pLG9KfR35XAvwTKKlO8jKBURucrFRQsgAbVor+FGIZqDWvfxmFn
         zc3079U073CAKhYx7tWqaCRN8ZoK9/q7k8E0wsgGNlb2RoOPb3pwJCXmTYEIQbUb2tYa
         IJS7PlbpuK4QjjNf4OsvtjjniphEMQWZbAkqmpHP3CyjUdg1cgNVW0Q99/g98kyV9nmE
         E9AhaEt02gWF0kPRrmCiZY3FKu3LFv/6N3YWXjqr+oPHLEmabIk6ssOftnj4cl0DWXCn
         HC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=;
        b=pXLRbr9EbDfa9iRss3pUSJFqkt+FC2mjhH60UEhttD8mTv0KlJsI6MC3kSO8v4NPQh
         OZtbL9qpRZpPzz/cQCc1Ed24E3iEOLJyacD4P1apBxIDK7UpJa/kwgOpfvlngqbAeRQh
         z9FQSIOoj98yUOhsSQVGCd/Qq808D8RcXVlylanfdc/EkgZgaeYeNJ35EtXxShvgiLuA
         YezCWvSgdlqukwGqychRDL1gDg8KYHEHl5fFaoSbVPJiXPcc8mbzhLlRPeHe5yexf4oX
         8abltKYeJsiV8Z/cSDPjS+fz+n8jN7b4y6apGCfK4xinZbS2Q+2ZHESypBhHB+I0jM2m
         EfEg==
X-Gm-Message-State: AOAM533KUYTMSplUkWJ6xbdI4NlJuuisVgGYQT0DzDOI734gl+N2oRae
        1oIu7EGQW0fAd0+AOIqDxp7SKHAk0cI=
X-Google-Smtp-Source: ABdhPJzcK0bRqvyQAbSL+jz9O1uSmP/wYuUfB/OvZ5Nckb6iT9r8Ad8dFxdTwltQ7k9N56yA3R2lng==
X-Received: by 2002:a62:c501:0:b029:32a:dfe9:8648 with SMTP id j1-20020a62c5010000b029032adfe98648mr1440975pfg.28.1627501096217;
        Wed, 28 Jul 2021 12:38:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:6456:ee63:e147:5ea])
        by smtp.gmail.com with ESMTPSA id n56sm820113pfv.65.2021.07.28.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:38:15 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Youngjin Gil <youngjin.gil@samsung.com>,
        Hyeong Jun Kim <hj514.kim@samsung.com>
Subject: [PATCH v2] f2fs: turn back remapped address in compressed page endio
Date:   Wed, 28 Jul 2021 12:38:11 -0700
Message-Id: <20210728193811.2519412-1-daeho43@gmail.com>
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
v2: avoid knowing too much about lower structures
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a716c3b5457..0ec5950949fb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -116,6 +116,7 @@ struct bio_post_read_ctx {
 	struct f2fs_sb_info *sbi;
 	struct work_struct work;
 	unsigned int enabled_steps;
+	block_t fs_blkaddr;
 };
 
 static void f2fs_finish_read_bio(struct bio *bio)
@@ -228,7 +229,7 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	bool all_compressed = true;
-	block_t blkaddr = SECTOR_TO_BLOCK(ctx->bio->bi_iter.bi_sector);
+	block_t blkaddr = ctx->fs_blkaddr;
 
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
@@ -1003,6 +1004,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		ctx->bio = bio;
 		ctx->sbi = sbi;
 		ctx->enabled_steps = post_read_steps;
+		ctx->fs_blkaddr = blkaddr;
 		bio->bi_private = ctx;
 	}
 
-- 
2.32.0.432.gabb21c7263-goog


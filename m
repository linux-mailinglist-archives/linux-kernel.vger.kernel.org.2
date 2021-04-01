Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE056350D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhDADaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233427AbhDADaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:30:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50A91610D2;
        Thu,  1 Apr 2021 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617247815;
        bh=QEUBS2zczij3ArtTdghjLRfheNOhvp84S+Ht6X8gywM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH4G9nIv93zRV3ciwcmNXinfPXtcE+6uD6mBMwLHmuhMX7PDfSscq2+hq20okXjq2
         Ets5ds9Q7aKvMMwvR8TpHSk4po54iaf6Kah3RemTNBLfEyZK87JCpV3kBQPINe3bP7
         qH+ymFKaeuHP/MpztC9gqZapSzShBmm0/RHCMJ2BsqdTJZkitv2fzVF8+l95QwWd9E
         QX48rWX95ltT8JwLFhVJWAeeS7vHgZXL1k4ktYMsrjVEvoPOWNwwXZgr9VKL8IsoFJ
         Fb0W/ywAuKYzY4c9StnNGXqO4KisY5eBsCNK0jQsgsVZa21KxWjPj+6MiDi0meJQSX
         L4ZhlXVAuJI0Q==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 06/10] erofs: adjust per-CPU buffers according to max_pclusterblks
Date:   Thu,  1 Apr 2021 11:29:50 +0800
Message-Id: <20210401032954.20555-7-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Adjust per-CPU buffers on demand since big pcluster definition is
available. Also, bail out unsupported pcluster size according to
Z_EROFS_PCLUSTER_MAX_SIZE.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 16 ++++++++++++----
 fs/erofs/internal.h     |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index fb4838c0f0df..5d9f9dbd3681 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -32,6 +32,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int size)
 {
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	u16 distance;
 
 	if (lz4) {
@@ -40,16 +41,23 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			return -EINVAL;
 		}
 		distance = le16_to_cpu(lz4->max_distance);
+
+		sbi->lz4.max_pclusterblks = le16_to_cpu(lz4->max_pclusterblks);
+		if (sbi->lz4.max_pclusterblks >
+		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+			erofs_err(sb, "too large lz4 pcluster blocks %u",
+				  sbi->lz4.max_pclusterblks);
+			return -EINVAL;
+		}
 	} else {
 		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		sbi->lz4.max_pclusterblks = 1;
 	}
 
-	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
+	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-
-	/* TODO: use max pclusterblks after bigpcluster is enabled */
-	return erofs_pcpubuf_growsize(1);
+	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c4b3938a7e56..f1305af50f67 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -63,6 +63,8 @@ struct erofs_fs_context {
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
 	u16 max_distance_pages;
+	/* maximum possible blocks for pclusters in the filesystem */
+	u16 max_pclusterblks;
 };
 
 struct erofs_sb_info {
-- 
2.20.1


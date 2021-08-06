Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432463E1FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhHFAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhHFAFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE7A61052;
        Fri,  6 Aug 2021 00:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628208287;
        bh=QykvfTGAsHjcJkODsRfvQvK4CqPrbWy32hloEXfurhA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y6qZbVIX80Alj2b+SBYn7CXmak3lj4TsKPuetxF5dGtOz1p9mv7w6SibFxSdYky4A
         Vonx9jUmNt/EFzErXVflU3lwlkfx+SmniN5KjyN9ncs+xn4XuHOYVAVLMpPqbZxtx0
         fbHbp3GgpGSq6WsGRvWk9JpdXgFe6kkTO/xRX6jPASuFFyZT8aQLwCirfkzZ4fPKag
         MKaDDRMc+GW2RGGCK1MXm7KDSO63vS9E2e2xbs3ooaGmEDfyNFmD+X7+ailEOYDgoa
         aZVSf7l7vlscBMFN20mVNUUBvjlGSdJATKNZ2spC40XI6Y3Vc9kg1AXzVQHirE7a9U
         LNI4j5UfwXSTg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>, stable@kernel.org
Subject: [PATCH] f2fs: fix to do sanity check for sb/cp fields correctly
Date:   Fri,  6 Aug 2021 08:04:37 +0800
Message-Id: <20210806000437.39917-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below problems of sb/cp sanity check:
- in sanity_check_raw_superi(), it missed to consider log header
blocks while cp_payload check.
- in f2fs_sanity_check_ckpt(), it missed to check nat_bits_blocks.

Cc: <stable@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 84cd085020cd..9e0e3c998142 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3264,11 +3264,13 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
-	if (le32_to_cpu(raw_super->cp_payload) >
-				(blocks_per_seg - F2FS_CP_PACKS)) {
-		f2fs_info(sbi, "Insane cp_payload (%u > %u)",
+	if (le32_to_cpu(raw_super->cp_payload) >=
+				(blocks_per_seg - F2FS_CP_PACKS -
+				NR_CURSEG_PERSIST_TYPE)) {
+		f2fs_info(sbi, "Insane cp_payload (%u >= %u)",
 			  le32_to_cpu(raw_super->cp_payload),
-			  blocks_per_seg - F2FS_CP_PACKS);
+			  blocks_per_seg - F2FS_CP_PACKS -
+			  NR_CURSEG_PERSIST_TYPE);
 		return -EFSCORRUPTED;
 	}
 
@@ -3304,6 +3306,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int cp_pack_start_sum, cp_payload;
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
+	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3434,6 +3437,17 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	nat_blocks = nat_segs << log_blocks_per_seg;
+	nat_bits_bytes = nat_blocks / BITS_PER_BYTE;
+	nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
+	if (__is_set_ckpt_flags(ckpt, CP_NAT_BITS_FLAG) &&
+		(cp_payload + F2FS_CP_PACKS +
+		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
+		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
+			  cp_payload, nat_bits_blocks);
+		return -EFSCORRUPTED;
+	}
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_err(sbi, "A bug case: need to run fsck");
 		return 1;
-- 
2.22.1


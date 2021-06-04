Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22339B225
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFDFwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhFDFwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA7D261413;
        Fri,  4 Jun 2021 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622785830;
        bh=nvNiQiEeAOrNdwTJPiUo/5yXO8Aoan+R2K1B6RWArRc=;
        h=From:To:Cc:Subject:Date:From;
        b=WUQyaw1nGhDZGPANPzpznarwuftVm5HhoN7n9p9Seupfa6bEOhOwLDUKbCx+soCpS
         cSNHL6voHfkkbsKohOlFp9NHgmNp6pPUb9HQFAGmIAIF3ZepAnnXr3JSA0u1lZgAbj
         c1ha1IUsUqdzMD8lvomYgUS+KXuMvqKVVcZIftF5ilzHmt1YDymgZWD/Ic/P9CRHor
         uBACxiiHsPVcYudIw/HiUJJfhbBMFS6Yw4lz79rLxybV3ir2KqkUrM2dNnHivjAVAJ
         Vhee53K/4xHZ1EOZP9Ut5cSLAw4ZPbJjI9ecysIB2Uf1AvKLauDvVbATtL6ymyR10K
         GD8x2+ADlYoAg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add pin_file in feature list
Date:   Thu,  3 Jun 2021 22:50:26 -0700
Message-Id: <20210604055026.2482208-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing pin_file feature supported by kernel.

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2a76c959a7b4..a1d3ba75c753 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -743,6 +743,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
+F2FS_FEATURE_RO_ATTR(pin_file);
 
 /* For ATGC */
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
@@ -856,6 +857,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
+	ATTR_LIST(pin_file),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.32.0.rc1.229.g3e70b5a671-goog


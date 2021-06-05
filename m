Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780B39C472
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 02:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFEAeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 20:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhFEAeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 20:34:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 110F3613D8;
        Sat,  5 Jun 2021 00:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622853137;
        bh=hnj4YdZSKapllVOA4ACyYPr0+WwJm/RSY5vJAduBcmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Drcs8VOdy4l7ev9LFryG94KmJnmCwF3oLFuqzx163jFdm6nby5k1mhZx0lSSeFoek
         VpWGFGT8mN7lHDsN48La3zJP5Slpk3NzG/Thg1O9b0dewrN7uXxqUZ+NBWtn64OYbP
         M8m1TgSnHIa2Qd63IxaTuF8YrJLX7kNynQMQBWnDL+WCVJdC+eDsdl9aa6EkrR+nfa
         B/Jz+HZYq4WH61n8GutZVxEEjSO5o7UL2eUbB0lOvPkfxQltb+Y1tc0+LwUVmDr1Sv
         oSKchH4n3Z4/UbIBmqpQeZ2//u0hm6CBpEct1uHZFlhIxosKWnvp6cXPnxy/q/ztc1
         dwIbjdOdfLBlw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: add pin_file in feature list
Date:   Fri,  4 Jun 2021 17:32:09 -0700
Message-Id: <20210605003210.856458-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210605003210.856458-1-jaegeuk@kernel.org>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
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
index 4daa6aeb200b..e4d5090b7cb3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -740,6 +740,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
+F2FS_FEATURE_RO_ATTR(pin_file);
 
 /* For ATGC */
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
@@ -853,6 +854,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
+	ATTR_LIST(pin_file),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.32.0.rc1.229.g3e70b5a671-goog


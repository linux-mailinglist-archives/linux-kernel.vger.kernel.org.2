Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E032A164
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574439AbhCBF5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:57:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:47270 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574718AbhCBDtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oq+Cg
        DdXTh0L6Ng1KJPpYnex8FwfPpkQyx18g3Kiy2A=; b=IFCjYZiUBbdsbC+Nu+0VN
        nFuJL8gm3g3n3+zTQZqL2SFyzWoP+VtVA/yxbP61zD9UghcD1f7Q06r2ELRt/hud
        COHxOkg4ppS+1LPuiuwnuSHHEQMSlXw1ouwYD4iBIq6odh7jixCa8EoxH8FUNpQC
        9lcCXht/12W11x9B8EzCyM=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowADHzyOUtT1gQOcAnQ--.8383S2;
        Tue, 02 Mar 2021 11:48:37 +0800 (CST)
From:   dingsenjie@163.com
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] fs: fat: fix spelling typo of values
Date:   Tue,  2 Mar 2021 11:48:17 +0800
Message-Id: <20210302034817.30384-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADHzyOUtT1gQOcAnQ--.8383S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rtrWDZw4DWr1rZF43KFg_yoW3WFg_Za
        9ayayDurW0q34fAan2vw4YqrZ7Zry8Gr4UXFW2ga4xG3y5Zr48J34Dua92y3W7XF4DWryD
        Cr95Kr1ft342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0xb1UUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRRVJyFPAKQ8TlwAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

vaules -> values

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 fs/fat/fatent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f7e3304..860e884 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -771,7 +771,7 @@ int fat_trim_fs(struct inode *inode, struct fstrim_range *range)
 	/*
 	 * FAT data is organized as clusters, trim at the granulary of cluster.
 	 *
-	 * fstrim_range is in byte, convert vaules to cluster index.
+	 * fstrim_range is in byte, convert values to cluster index.
 	 * Treat sectors before data region as all used, not to trim them.
 	 */
 	ent_start = max_t(u64, range->start>>sbi->cluster_bits, FAT_START_ENT);
-- 
1.9.1



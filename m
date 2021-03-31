Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5A34FCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhCaJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:25:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15122 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhCaJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:25:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9LTB6xRBz1BFhW;
        Wed, 31 Mar 2021 17:23:10 +0800 (CST)
Received: from ubuntu.huawei.com (10.67.174.117) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:25:08 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Wang Weiyang" <wangweiyang2@huawei.com>
Subject: [PATCH -next] erofs: Clean up spelling mistakes found in fs/erofs
Date:   Wed, 31 Mar 2021 05:39:20 -0400
Message-ID: <20210331093920.31923-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zmap.c:  s/correspoinding/corresponding
zdata.c: s/endding/ending

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 fs/erofs/zdata.c | 2 +-
 fs/erofs/zmap.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cd9b76216925..4226f4115981 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -933,7 +933,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				 }, pagepool);
 
 out:
-	/* must handle all compressed pages before endding pages */
+	/* must handle all compressed pages before ending pages */
 	for (i = 0; i < clusterpages; ++i) {
 		page = compressed_pages[i];
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14d2de35110c..b384f546d368 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -443,7 +443,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		m.delta[0] = 1;
 		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		/* get the correspoinding first chunk */
+		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto unmap_out;
-- 
2.17.1


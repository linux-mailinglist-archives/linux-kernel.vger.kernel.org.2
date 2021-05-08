Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0A377101
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhEHJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:45:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17161 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhEHJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:45:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fcj43523nzncCk;
        Sat,  8 May 2021 17:40:51 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 17:44:02 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ntfs: Remove several unneeded semicolons
Date:   Sat, 8 May 2021 17:43:56 +0800
Message-ID: <20210508094356.2836-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon immediately following '}' is unneeded.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/ntfs/lcnalloc.c | 2 +-
 fs/ntfs/super.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index eda9972e61599ab..66c2b29e09ddb0c 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c931..a45e06fa8a73baa 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ static bool load_and_init_upcase(ntfs_volume *vol)
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.26.0.106.g9fadedd



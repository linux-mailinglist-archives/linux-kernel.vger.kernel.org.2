Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36836671A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhDUIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:40:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16609 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhDUIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:40:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FQDT04nV0z17RLn;
        Wed, 21 Apr 2021 16:37:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 16:39:52 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: remove unneed check condition
Date:   Wed, 21 Apr 2021 16:39:41 +0800
Message-ID: <20210421083941.66371-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
has checked SBI_POR_DOING condition, and also cluster_may_compress()
has checked CP_ERROR_FLAG condition, so remove redundant check condition
in __cluster_may_compress() for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3c9d797dbdd6..532c311e3a89 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
 
 		f2fs_bug_on(sbi, !page);
 
-		if (unlikely(f2fs_cp_error(sbi)))
-			return false;
-		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-			return false;
-
 		/* beyond EOF */
 		if (page->index >= nr_pages)
 			return false;
-- 
2.29.2


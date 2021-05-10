Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC108377F66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhEJJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:31:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2751 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhEJJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:31:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwgX42RmzqV1w;
        Mon, 10 May 2021 17:27:20 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:30:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: compress: fix to call f2fs_put_dnode() paired with f2fs_get_block()
Date:   Mon, 10 May 2021 17:30:30 +0800
Message-ID: <20210510093032.35466-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_get_block() and f2fs_put_dnode() should be called as a pair,
add missing f2fs_put_dnode() in prepare_compress_overwrite().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c208563eac28..d5cb0ba9a0e1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1088,6 +1088,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		for (i = cc->cluster_size - 1; i > 0; i--) {
 			ret = f2fs_get_block(&dn, start_idx + i);
+			f2fs_put_dnode(&dn);
 			if (ret) {
 				i = cc->cluster_size;
 				break;
-- 
2.29.2


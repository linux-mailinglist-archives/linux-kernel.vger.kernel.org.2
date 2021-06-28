Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA83B5CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhF1LJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:09:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13023 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhF1LJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:09:39 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GD4Vb2st5zZkbp;
        Mon, 28 Jun 2021 19:04:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 28 Jun 2021 19:07:11 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>, <adas@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] gfs2: Fix error handling in init_statfs()
Date:   Mon, 28 Jun 2021 19:14:50 +0800
Message-ID: <20210628111450.194262-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an error path of init_statfs(), it calls iput to put pn which has been
put. Jump to correct label to fix it.

Fixes: 97fd734ba17e ("gfs2: lookup local statfs inodes prior to journal recovery")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 fs/gfs2/ops_fstype.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 826f77d9cff5..e9ebab1af62f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -692,7 +692,8 @@ static int init_statfs(struct gfs2_sbd *sdp)
 				   &sdp->sd_sc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
-		goto free_local;
+		free_local_statfs_inodes(sdp);
+		goto put_statfs;
 	}
 	return 0;
 
-- 
2.26.0.106.g9fadedd


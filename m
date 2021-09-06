Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E16401D29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbhIFOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:39:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15243 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbhIFOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:39:00 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H39vy0yv8z1DGjk;
        Mon,  6 Sep 2021 22:37:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 22:37:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 4/6] ext4: avoid to re-read mmp check data get from page cache
Date:   Mon, 6 Sep 2021 22:47:52 +0800
Message-ID: <20210906144754.2601607-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906144754.2601607-1-yebin10@huawei.com>
References: <20210906144754.2601607-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As call read_mmp_block pass bh_check which value is NULL, then call
sb_getblk to get buffer_head. But mmp_block's buffer_head is already exist
 which also is uptodate. Lead to compare the same data.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 0fe7b9ac9db6..2a1473e4a9de 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -213,10 +213,7 @@ static int kmmpd(void *data)
 		 * we need to check if the MMP block is as we write it.
 		 */
 		if (jiffies - last_check_time > mmp_check_interval * HZ) {
-			struct buffer_head *bh_check = NULL;
-			struct mmp_struct *mmp_check;
-
-			retval = read_mmp_block(sb, &bh_check, mmp_block);
+			retval = read_mmp_block(sb, &bh, mmp_block);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -224,20 +221,18 @@ static int kmmpd(void *data)
 				goto wait_to_exit;
 			}
 
-			mmp_check = (struct mmp_struct *)(bh_check->b_data);
-			if (seq != mmp_check->mmp_seq ||
-			    memcmp(nodename, mmp_check->mmp_nodename,
-				   sizeof(mmp->mmp_nodename))) {
-				dump_mmp_msg(sb, mmp_check,
+			mmp = (struct mmp_struct *)(bh->b_data);
+			if (seq != le32_to_cpu(mmp->mmp_seq) ||
+			    memcmp(nodename, mmp->mmp_nodename,
+				    sizeof(nodename))) {
+				dump_mmp_msg(sb, mmp,
 					     "Error while updating MMP info. "
 					     "The filesystem seems to have been"
 					     " multiply mounted.");
 				ext4_error_err(sb, EBUSY, "abort");
-				put_bh(bh_check);
 				retval = -EBUSY;
 				goto wait_to_exit;
 			}
-			put_bh(bh_check);
 			last_check_time = jiffies;
 		}
 
-- 
2.31.1


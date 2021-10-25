Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5F438DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhJYDbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:31:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14855 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhJYDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:30:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hd0lw2hSYz90PV;
        Mon, 25 Oct 2021 11:28:28 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 11:28:25 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 25
 Oct 2021 11:28:24 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH 04/11] ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
Date:   Mon, 25 Oct 2021 11:41:09 +0800
Message-ID: <20211025034116.3544321-5-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025034116.3544321-1-chengzhihao1@huawei.com>
References: <20211025034116.3544321-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whiteout inode should be put when do_tmpfile() failed if inode has been
initialized. Otherwise we will get following warning during umount:
  UBIFS error (ubi0:0 pid 1494): ubifs_assert_failed [ubifs]: UBIFS
  assert failed: c->bi.dd_growth == 0, in fs/ubifs/super.c:1930
  VFS: Busy inodes after unmount of ubifs. Self-destruct in 5 seconds.

Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2735ad1affed..6503e6857f6e 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1334,6 +1334,8 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 		err = do_tmpfile(old_dir, old_dentry, S_IFCHR | WHITEOUT_MODE, &whiteout);
 		if (err) {
+			if (whiteout)
+				iput(whiteout);
 			kfree(dev);
 			goto out_release;
 		}
-- 
2.31.1


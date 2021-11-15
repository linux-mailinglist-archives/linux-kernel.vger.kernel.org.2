Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5B44FCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhKOBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:23:06 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27131 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhKOBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:22:30 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hsrrh40bpz1DJLW;
        Mon, 15 Nov 2021 09:17:08 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 09:19:25 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 15 Nov
 2021 09:19:25 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next 3/3] ubifs: read-only if LEB may always be taken in ubifs_garbage_collect
Date:   Mon, 15 Nov 2021 09:31:44 +0800
Message-ID: <20211115013144.2479319-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115013144.2479319-1-libaokun1@huawei.com>
References: <20211115013144.2479319-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ubifs_garbage_collect_leb() returns -EAGAIN and ubifs_return_leb
returns error, a LEB will always has a "taken" flag. In this case,
set the ubifs to read-only to prevent a worse situation.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ubifs/gc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 1f74a127fe3a..3134d070fcc0 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -756,8 +756,17 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 				 * caller instead of the original '-EAGAIN'.
 				 */
 				err = ubifs_return_leb(c, lp.lnum);
-				if (err)
+				if (err) {
 					ret = err;
+					/*
+					 * An LEB may always be "taken",
+					 * so setting ubifs to read-only,
+					 * and then executing sync wbuf will
+					 * return -EROFS and enter the "out"
+					 * error branch.
+					 */
+					ubifs_ro_mode(c, ret);
+				}
 				/*  Maybe double return LEB if goto out */
 				lp.lnum = -1;
 				break;
-- 
2.31.1


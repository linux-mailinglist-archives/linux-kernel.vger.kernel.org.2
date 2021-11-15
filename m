Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E276544FCB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhKOBWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:22:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15822 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhKOBWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:22:25 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hsrv10lWJz9129;
        Mon, 15 Nov 2021 09:19:09 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 09:19:23 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 15 Nov
 2021 09:19:23 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next 2/3] ubifs: fix double return leb in ubifs_garbage_collect
Date:   Mon, 15 Nov 2021 09:31:43 +0800
Message-ID: <20211115013144.2479319-3-libaokun1@huawei.com>
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

If ubifs_garbage_collect_leb() returns -EAGAIN and enters the "out"
branch, ubifs_return_leb will execute twice on the same lnum. This
can cause data loss in concurrency situations.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ubifs/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 05e1eeae8457..1f74a127fe3a 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -758,6 +758,8 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 				err = ubifs_return_leb(c, lp.lnum);
 				if (err)
 					ret = err;
+				/*  Maybe double return LEB if goto out */
+				lp.lnum = -1;
 				break;
 			}
 			goto out;
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCF3E392A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhHHGWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 02:22:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13401 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 02:22:10 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gj8Cm0gMJzck54;
        Sun,  8 Aug 2021 14:18:12 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 8 Aug 2021 14:21:48 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Huang Jianan <huangjianan@oppo.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
Date:   Sun, 8 Aug 2021 06:33:43 +0000
Message-ID: <20210808063343.255817-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

fs/erofs/data.c:150:24: warning:
 symbol 'erofs_iomap_ops' was not declared. Should it be static?

This symbol is not used outside of data.c, so marks it static.

Fixes: 3e9ce908c114 ("erofs: iomap support for non-tailpacking DIO")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 4ea10b31790c..b2a22aabc9bc 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -147,7 +147,7 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
-const struct iomap_ops erofs_iomap_ops = {
+static const struct iomap_ops erofs_iomap_ops = {
 	.iomap_begin = erofs_iomap_begin,
 	.iomap_end = erofs_iomap_end,
 };


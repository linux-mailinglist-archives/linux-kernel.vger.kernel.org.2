Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36D232CCEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhCDGiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:38:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13468 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhCDGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:37:54 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Drh295s9czjW5g;
        Thu,  4 Mar 2021 14:35:29 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 14:37:03 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mtd: parsers: ofpart: make symbol 'bcm4908_partitions_quirks' static
Date:   Thu, 4 Mar 2021 06:46:00 +0000
Message-ID: <20210304064600.3279138-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

drivers/mtd/parsers/ofpart_core.c:25:32: warning:
 symbol 'bcm4908_partitions_quirks' was not declared. Should it be static?

This symbol is not used outside of ofpart_core.c, so this
commit marks it static.

Fixes: 457da931b608 ("mtd: parsers: ofpart: support BCM4908 fixed partitions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mtd/parsers/ofpart_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index 258c06a42283..e9cb9ca28813 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -22,7 +22,7 @@ struct fixed_partitions_quirks {
 	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
 };
 
-struct fixed_partitions_quirks bcm4908_partitions_quirks = {
+static struct fixed_partitions_quirks bcm4908_partitions_quirks = {
 	.post_parse = bcm4908_partitions_post_parse,
 };
 


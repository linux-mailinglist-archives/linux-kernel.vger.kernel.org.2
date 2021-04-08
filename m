Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15DA3584B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhDHNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:30:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16052 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhDHNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:30:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGMW16Qz9zPnwL;
        Thu,  8 Apr 2021 21:27:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:29:49 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <joern@lazybastard.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH V2] mtd: phram: Fix error return code in phram_setup()
Date:   Thu, 8 Apr 2021 21:38:12 +0800
Message-ID: <20210408133812.1209798-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210408144610.0c0686ae@xps13>
References: <20210408144610.0c0686ae@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/mtd/devices/phram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 5b04ae6c3057..6ed6c51fac69 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -270,6 +270,7 @@ static int phram_setup(const char *val)
 	if (len == 0 || erasesize == 0 || erasesize > len
 	    || erasesize > UINT_MAX || rem) {
 		parse_err("illegal erasesize or len\n");
+		ret = -EINVAL;
 		goto error;
 	}
 
-- 
2.25.4


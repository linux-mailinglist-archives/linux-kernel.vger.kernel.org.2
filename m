Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A838038F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhENGPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:15:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2916 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:15:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhJ7b3TB9zBv0n;
        Fri, 14 May 2021 14:11:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 14:13:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <laforge@gnumonks.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <akpm@osdl.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] char: pcmcia: remove set but not used variable 'uc'
Date:   Fri, 14 May 2021 14:21:31 +0800
Message-ID: <20210514062131.3533460-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/char/pcmcia/cm4040_cs.c:224:16: warning: variable ‘uc’
set but not used [-Wunused-but-set-variable]

It is never used and so can be removed.

Fixes: 77c44ab1d8e9 ("[PATCH] New Omnikey Cardman 4040 driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/char/pcmcia/cm4040_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index d5e43606339c..827711911da4 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -221,7 +221,6 @@ static ssize_t cm4040_read(struct file *filp, char __user *buf,
 	unsigned long i;
 	size_t min_bytes_to_read;
 	int rc;
-	unsigned char uc;
 
 	DEBUGP(2, dev, "-> cm4040_read(%s,%d)\n", current->comm, current->pid);
 
@@ -308,7 +307,7 @@ static ssize_t cm4040_read(struct file *filp, char __user *buf,
 			return -EIO;
 	}
 
-	uc = xinb(iobase + REG_OFFSET_BULK_IN);
+	xinb(iobase + REG_OFFSET_BULK_IN);
 
 	DEBUGP(2, dev, "<- cm4040_read (successfully)\n");
 	return min_bytes_to_read;
-- 
2.25.4


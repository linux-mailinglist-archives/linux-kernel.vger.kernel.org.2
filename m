Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EBB380391
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhENGPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:15:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2656 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:15:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhJ754w5HzQnDv;
        Fri, 14 May 2021 14:10:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 14:14:16 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <laforge@gnumonks.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <akpm@osdl.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] char: pcmcia: remove set but not used variable 'tmp'
Date:   Fri, 14 May 2021 14:21:50 +0800
Message-ID: <20210514062150.3533786-1-yukuai3@huawei.com>
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

drivers/char/pcmcia/cm4000_cs.c:1053:16: warning: variable ‘tmp’
set but not used [-Wunused-but-set-variable]

It is never used and so can be removed.

Fixes: c1986ee9bea3 ("[PATCH] New Omnikey Cardman 4000 driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f07bc78..9ec25735425d 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1050,7 +1050,6 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	struct cm4000_dev *dev = filp->private_data;
 	unsigned int iobase = dev->p_dev->resource[0]->start;
 	unsigned short s;
-	unsigned char tmp;
 	unsigned char infolen;
 	unsigned char sendT0;
 	unsigned short nsend;
@@ -1148,7 +1147,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	set_cardparameter(dev);
 
 	/* dummy read, reset flag procedure received */
-	tmp = inb(REG_FLAGS1(iobase));
+	inb(REG_FLAGS1(iobase));
 
 	dev->flags1 = 0x20	/* T_Active */
 	    | (sendT0)
-- 
2.25.4


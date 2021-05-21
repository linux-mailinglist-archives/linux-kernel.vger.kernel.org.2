Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651B38C43A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhEUKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:00:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3467 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhEUJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:58:56 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fmhm35jJWzCsGb;
        Fri, 21 May 2021 17:54:43 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:57:31 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 17:57:31 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <laforge@gnumonks.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <akpm@osdl.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] char: pcmcia: fix possible array index out of bounds in set_protocol()
Date:   Fri, 21 May 2021 18:07:05 +0800
Message-ID: <20210521100705.28234-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of array 'pts_reply' is 4, and the loop in set_protocol()
will access array element from 0 to num_bytes_read - 1. Thus if
io_read_num_rec_bytes() gets 'num_bytes_read' more than 4, it will
cause index out of bounds errors.

Fixes: c1986ee9bea3 ("[PATCH] New Omnikey Cardman 4000 driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f07bc78..86b7c8e44198 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -564,16 +564,15 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
 
 	/* Read PPS reply */
 	DEBUGP(5, dev, "Read PPS reply\n");
-	for (i = 0; i < num_bytes_read; i++) {
+	for (i = 0; i < 4; i++) {
 		xoutb(i, REG_BUF_ADDR(iobase));
 		pts_reply[i] = inb(REG_BUF_DATA(iobase));
 	}
 
 #ifdef CM4000_DEBUG
 	DEBUGP(2, dev, "PTSreply: ");
-	for (i = 0; i < num_bytes_read; i++) {
+	for (i = 0; i < 4; i++)
 		pr_debug("0x%.2x ", pts_reply[i]);
-	}
 	pr_debug("\n");
 #endif	/* CM4000_DEBUG */
 
-- 
2.25.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A929635998B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhDIJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:43:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16507 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhDIJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtR46CzZzPpTF;
        Fri,  9 Apr 2021 17:40:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:10 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] char: xilinx_hwicap: use DEFINE_MUTEX() for mutex lock
Date:   Fri, 9 Apr 2021 17:51:36 +0800
Message-ID: <20210409095136.2293754-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 067396bedf22..4d586233dfa4 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -111,7 +111,7 @@
 /* An array, which is set to true when the device is registered. */
 static DEFINE_MUTEX(hwicap_mutex);
 static bool probed_devices[HWICAP_DEVICES];
-static struct mutex icap_sem;
+static DEFINE_MUTEX(icap_sem);
 
 static struct class *icap_class;
 
@@ -857,7 +857,6 @@ static int __init hwicap_module_init(void)
 	int retval;
 
 	icap_class = class_create(THIS_MODULE, "xilinx_config");
-	mutex_init(&icap_sem);
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
 	retval = register_chrdev_region(devt,


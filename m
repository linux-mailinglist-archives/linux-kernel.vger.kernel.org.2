Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEF437219
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhJVGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:50:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51966 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229609AbhJVGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:50:11 -0400
X-UUID: 20354e85a0004b9fb8d70903f573a057-20211022
X-UUID: 20354e85a0004b9fb8d70903f573a057-20211022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1306938713; Fri, 22 Oct 2021 14:47:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 14:47:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Oct 2021 14:47:50 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tequila.yuang@mediatek.com>,
        <yj.chiang@mediatek.com>, <mark-pk.tsai@mediatek.com>
Subject: [PATCH] dm: add module parameter bdev_wait
Date:   Fri, 22 Oct 2021 14:47:47 +0800
Message-ID: <20211022064748.30136-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_early_create() fail if the target block device not found in
the late init stage.
The block device is created in mmc_rescan() which kernel do
it async by queue it into system_freezable_wq.
Add module param bdev_wait to support waiting the block device
ready before dm_early_create() like prepare_namespace() does.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/md/dm-init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..a3d24cafa4f4 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -8,11 +8,13 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/device-mapper.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
+#include <linux/mount.h>
 
 #define DM_MSG_PREFIX "init"
 #define DM_MAX_DEVICES 256
@@ -20,6 +22,7 @@
 #define DM_MAX_STR_SIZE 4096
 
 static char *create;
+static char *bdev_wait;
 
 /*
  * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
@@ -286,6 +289,12 @@ static int __init dm_init_init(void)
 	DMINFO("waiting for all devices to be available before creating mapped devices");
 	wait_for_device_probe();
 
+	if (bdev_wait) {
+		DMINFO("Waiting for block device %s...", bdev_wait);
+		while (!name_to_dev_t(bdev_wait))
+			msleep(5);
+	}
+
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
 				    dev->target_args_array))
@@ -301,3 +310,5 @@ late_initcall(dm_init_init);
 
 module_param(create, charp, 0);
 MODULE_PARM_DESC(create, "Create a mapped device in early boot");
+module_param(bdev_wait, charp, 0);
+MODULE_PARM_DESC(bdev_wait, "Wait until the block device ready before dm_early_create");
-- 
2.18.0


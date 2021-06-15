Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F93A7736
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFOGm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:42:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4782 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:42:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3z8J0jrbzXg4G;
        Tue, 15 Jun 2021 14:35:12 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:40:09 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:40:08 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <valentina.manea.m@gmail.com>, <shuah@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] usbip: tools: Convert list_for_each to entry variant
Date:   Tue, 15 Jun 2021 14:58:39 +0800
Message-ID: <1623740319-15988-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/usb/usbip/libsrc/usbip_host_common.c | 4 +---
 tools/usb/usbip/src/usbipd.c               | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index ca78aa3..80f16f0 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -267,12 +267,10 @@ int usbip_export_device(struct usbip_exported_device *edev, int sockfd)
 struct usbip_exported_device *usbip_generic_get_device(
 		struct usbip_host_driver *hdriver, int num)
 {
-	struct list_head *i;
 	struct usbip_exported_device *edev;
 	int cnt = 0;
 
-	list_for_each(i, &hdriver->edev_list) {
-		edev = list_entry(i, struct usbip_exported_device, node);
+	list_for_each_entry(edev, &hdriver->edev_list, node) {
 		if (num == cnt)
 			return edev;
 		cnt++;
diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index 48398a7..438346e 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -93,7 +93,6 @@ static int recv_request_import(int sockfd)
 	struct op_import_request req;
 	struct usbip_exported_device *edev;
 	struct usbip_usb_device pdu_udev;
-	struct list_head *i;
 	int found = 0;
 	int status = ST_OK;
 	int rc;
@@ -107,8 +106,7 @@ static int recv_request_import(int sockfd)
 	}
 	PACK_OP_IMPORT_REQUEST(0, &req);
 
-	list_for_each(i, &driver->edev_list) {
-		edev = list_entry(i, struct usbip_exported_device, node);
+	list_for_each_entry(edev, &driver->edev_list, node) {
 		if (!strncmp(req.busid, edev->udev.busid, SYSFS_BUS_ID_SIZE)) {
 			info("found requested device: %s", req.busid);
 			found = 1;
@@ -160,7 +158,6 @@ static int send_reply_devlist(int connfd)
 	struct usbip_usb_device pdu_udev;
 	struct usbip_usb_interface pdu_uinf;
 	struct op_devlist_reply reply;
-	struct list_head *j;
 	int rc, i;
 
 	/*
@@ -174,8 +171,7 @@ static int send_reply_devlist(int connfd)
 
 	reply.ndev = 0;
 	/* number of exported devices */
-	list_for_each(j, &driver->edev_list) {
-		edev = list_entry(j, struct usbip_exported_device, node);
+	list_for_each_entry(edev, &driver->edev_list, node) {
 		if (edev->status != SDEV_ST_USED)
 			reply.ndev += 1;
 	}
-- 
2.6.2


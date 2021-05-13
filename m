Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7237F273
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEME6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:58:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3739 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEME6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:58:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgfSB6FQ9zpdqc;
        Thu, 13 May 2021 12:53:30 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 12:56:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>
CC:     <b.zolnierkie@samsung.com>
Subject: [PATCH -next] fbdev: chipsfb: chips_init() can be static
Date:   Thu, 13 May 2021 12:59:17 +0800
Message-ID: <20210513045917.622849-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chips_init() only used within this file. It should be static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/chipsfb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 998067b701fa..81198faf8159 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -66,11 +66,6 @@
 	inb(0x3da); read_ind(num, var, 0x3c0, 0x3c1); \
 } while (0)
 
-/*
- * Exported functions
- */
-int chips_init(void);
-
 static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *);
 static int chipsfb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
@@ -498,7 +493,7 @@ static struct pci_driver chipsfb_driver = {
 #endif
 };
 
-int __init chips_init(void)
+static int __init chips_init(void)
 {
 	if (fb_get_options("chipsfb", NULL))
 		return -ENODEV;
-- 
2.25.1


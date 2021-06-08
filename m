Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61D239F629
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhFHMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:16:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3799 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhFHMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:16:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzpv80J0FzWsdF;
        Tue,  8 Jun 2021 20:09:24 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:14:14 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:14:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <daniel.vetter@ffwll.ch>, <penguin-kernel@i-love.sakura.ne.jp>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] fbdev: convert list_for_each to entry variant
Date:   Tue, 8 Jun 2021 20:32:49 +0800
Message-ID: <1623155569-61744-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/video/fbdev/core/fbsysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 65dae05..753ecc8 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -130,14 +130,12 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 	struct fb_var_screeninfo var;
 	struct fb_modelist *modelist;
 	struct fb_videomode *mode;
-	struct list_head *pos;
 	size_t i;
 	int err;
 
 	memset(&var, 0, sizeof(var));
 
-	list_for_each(pos, &fb_info->modelist) {
-		modelist = list_entry(pos, struct fb_modelist, list);
+	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
@@ -198,13 +196,11 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	unsigned int i;
-	struct list_head *pos;
 	struct fb_modelist *modelist;
 	const struct fb_videomode *mode;
 
 	i = 0;
-	list_for_each(pos, &fb_info->modelist) {
-		modelist = list_entry(pos, struct fb_modelist, list);
+	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, i, mode);
 	}
-- 
2.6.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8C353445
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhDCOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:08:17 -0400
Received: from m12-17.163.com ([220.181.12.17]:47969 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhDCOIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0qy/X
        xSv0LvNeE6/iJrXLwqgtsytvrqCk+LelXNA+8A=; b=juQBfyb6LR0uiWeYhXg9X
        eeQkYhDLjxSAGy9ydw4poGmUUwQOvgt8s43/ypWzR2qlPip6TJmmHBKzZOSUwEgc
        xhNRtxOHsmqWfKqjcP3fxBxtMiVG35QU9CdUEXn1FfRAK96Rst9T2Yx447S6tE18
        axN1W0NhTmkNPszFMkb+a8=
Received: from localhost.localdomain (unknown [120.229.64.251])
        by smtp13 (Coremail) with SMTP id EcCowAA31Hihdmhgd8zhtQ--.8258S2;
        Sat, 03 Apr 2021 22:07:30 +0800 (CST)
From:   Carlis <llyz108@163.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@yulong.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: convert sysfs snprintf to sysfs_emit
Date:   Sat,  3 Apr 2021 14:07:22 +0000
Message-Id: <20210403140722.169623-1-llyz108@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAA31Hihdmhgd8zhtQ--.8258S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWUKr1DJFyDCF4xCF4Uurg_yoWfZrb_Ar
        10vr1Sg3y0kryIyryFkF1Sva4IvF4fZF4vg3y3t393Za15uw4rJrWUuw1ktrZIgF4xZFyf
        Ars7XryrKr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8NVy7UUUUU==
X-Originating-IP: [120.229.64.251]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiWwJphVSIpiU-DgAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Fix the following coccicheck warning:
drivers/staging/fbtft//fbtft-sysfs.c:202:8-16: 
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
 drivers/staging/fbtft/fbtft-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 26e52cc2d..39e8d2806 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -199,7 +199,7 @@ static ssize_t show_debug(struct device *device,
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fbtft_par *par = fb_info->par;
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", par->debug);
+	return sysfs_emit(buf, "%lu\n", par->debug);
 }
 
 static struct device_attribute debug_device_attr =
-- 
2.25.1



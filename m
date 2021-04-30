Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5A36F7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhD3JXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:23:48 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52852 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhD3JXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:23:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UXFoP0B_1619774554;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXFoP0B_1619774554)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Apr 2021 17:22:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     airlied@redhat.com
Cc:     tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/mgag200: Remove redundant assignment to status and clock
Date:   Fri, 30 Apr 2021 17:22:32 +0800
Message-Id: <1619774552-118157-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable status is set to zero but this value is never read as
it is overwritten with a new value later on,clock is being assigned
a value from a calculation however the variable is never read,hence
these are redundant assignments that can be removed.

Clean up the following clang-analyzer warning:

drivers/gpu/drm/mgag200/mgag200_mode.c:284:3: warning: Value stored to
'clock' is never read [clang-analyzer-deadcode.DeadStores].

drivers/gpu/drm/mgag200/mgag200_mode.c:98:2: warning: Value stored to
'status' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index cece3e5..c4d5be8 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -95,7 +95,6 @@ static inline void mga_wait_vsync(struct mga_device *mdev)
 		status = RREG32(MGAREG_Status);
 	} while ((status & 0x08) && time_before(jiffies, timeout));
 	timeout = jiffies + HZ/10;
-	status = 0;
 	do {
 		status = RREG32(MGAREG_Status);
 	} while (!(status & 0x08) && time_before(jiffies, timeout));
@@ -280,8 +279,6 @@ static int mga_g200se_set_plls(struct mga_device *mdev, long clock)
 
 		p |= (fvv << 4);
 		m |= 0x80;
-
-		clock = clock / 2;
 	}
 
 	if (delta > permitteddelta) {
-- 
1.8.3.1


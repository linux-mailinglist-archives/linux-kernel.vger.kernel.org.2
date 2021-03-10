Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515E333361C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCJHFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:05:00 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41470 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhCJHEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:04:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UREgc7n_1615359875;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UREgc7n_1615359875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 15:04:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: fix warning comparing pointer to 0
Date:   Wed, 10 Mar 2021 15:04:34 +0800
Message-Id: <1615359874-14817-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c:76:14-15: WARNING
comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index c6a1cd8..69211f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -73,7 +73,7 @@ static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
 		TABLE_CASE(420, 12, min);
 	}
 
-	if (table == 0)
+	if (!table)
 		return;
 
 	index = (bpp - table[0].bpp) * 2;
-- 
1.8.3.1


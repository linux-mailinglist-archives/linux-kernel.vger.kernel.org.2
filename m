Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F513604C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDOIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:47:35 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42913 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbhDOIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:47:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UVdGEaf_1618476423;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdGEaf_1618476423)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:47:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hjc@rock-chips.com
Cc:     heiko@sntech.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/rockchip: remove unused function
Date:   Thu, 15 Apr 2021 16:47:01 +0800
Message-Id: <1618476421-114429-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:320:20: warning: unused
function 'dsi_set' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 24a7109..60d64a1 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -317,11 +317,6 @@ static inline u32 dsi_read(struct dw_mipi_dsi_rockchip *dsi, u32 reg)
 	return readl(dsi->base + reg);
 }
 
-static inline void dsi_set(struct dw_mipi_dsi_rockchip *dsi, u32 reg, u32 mask)
-{
-	dsi_write(dsi, reg, dsi_read(dsi, reg) | mask);
-}
-
 static inline void dsi_update_bits(struct dw_mipi_dsi_rockchip *dsi, u32 reg,
 				   u32 mask, u32 val)
 {
-- 
1.8.3.1


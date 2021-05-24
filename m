Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7919D38E447
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEXKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:44:25 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58772 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232575AbhEXKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:44:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UZvuWZG_1621852956;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZvuWZG_1621852956)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 18:42:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm: bridge: cdns-mhdp8546: Fix inconsistent indenting
Date:   Mon, 24 May 2021 18:42:33 +0800
Message-Id: <1621852953-51325-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:2143
cdns_mhdp_bridge_atomic_reset() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 0cd8f40..82619db 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2140,7 +2140,7 @@ static void cdns_mhdp_detach(struct drm_bridge *bridge)
 	if (!cdns_mhdp_state)
 		return NULL;
 
-	 __drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
 
 	return &cdns_mhdp_state->base;
 }
-- 
1.8.3.1


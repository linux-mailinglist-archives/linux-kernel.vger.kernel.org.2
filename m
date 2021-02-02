Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1130BDBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBBMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:08:45 -0500
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:37188 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBBMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:08:33 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id E79955403BA;
        Tue,  2 Feb 2021 19:57:19 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bernard Zhao <bernard@vivo.com>, Joe Perches <joe@perches.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drm/bridge/analogix: remove redundant when devm_kzalloc failed
Date:   Tue,  2 Feb 2021 03:56:59 -0800
Message-Id: <20210202115707.14410-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkhCSUpJQ09OSR9KVkpNSklJTUxLT0tJTkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6FBw*FD8REzYIST8THjUW
        NygKCyNVSlVKTUpJSU1MS09LTU1KVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSU5OTDcG
X-HM-Tid: 0a77629aadc4d995kuwse79955403ba
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 1590 DRM_ERROR is redundant because devm_kzalloc() already
prints an error.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index aa1bb86293fd..8f6258eb9960 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1586,10 +1586,8 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 	int ret;
 
 	bridge = devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge) {
-		DRM_ERROR("failed to allocate for drm bridge\n");
+	if (!bridge)
 		return -ENOMEM;
-	}
 
 	dp->bridge = bridge;
 
-- 
2.29.0


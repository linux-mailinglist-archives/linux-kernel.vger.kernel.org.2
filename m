Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D908930BDD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBBMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:12:04 -0500
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:48152 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhBBMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:11:35 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id B83F75402D9;
        Tue,  2 Feb 2021 20:10:45 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Bernard Zhao <bernard@vivo.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drm/hisilicon: remove redundant when devm_kzalloc failed
Date:   Tue,  2 Feb 2021 04:10:37 -0800
Message-Id: <20210202121039.14945-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0wYGk9CTRpPSkxOVkpNSklJTUxDT01LQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Sxw*TD8INTYsFD9KEQMp
        PklPCwxVSlVKTUpJSU1MQ09NT0xPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSU5NTDcG
X-HM-Tid: 0a7762a6f996d995kuwsb83f75402d9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 852 DRM_ERROR is redundant because memory alloc already
prints an error when failed.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 00e87c290796..8491d8267f07 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -852,10 +852,9 @@ static int dsi_probe(struct platform_device *pdev)
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		DRM_ERROR("failed to allocate dsi data.\n");
+	if (!data)
 		return -ENOMEM;
-	}
+
 	dsi = &data->dsi;
 	ctx = &data->ctx;
 	dsi->ctx = ctx;
-- 
2.29.0


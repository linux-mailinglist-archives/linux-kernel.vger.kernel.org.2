Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B376E43DC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1HqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:46:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ1Hp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:45:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E8C8F1F44C4E
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dafna.hirschfeld@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf
Date:   Thu, 28 Oct 2021 09:43:11 +0200
Message-Id: <20211028074311.57842-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes only")
a check for CEA modes was added to function mtk_hdmi_bridge_mode_valid()
in order to address possible issues on MT8167; moreover, with commit
c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal HDMI mode clock")
another similar check was introduced.

Unfortunately though, at the time of writing, MT8173 does not provide
any mtk_hdmi_conf structure and this is crashing the kernel with NULL
pointer upon entering mtk_hdmi_bridge_mode_valid(), which happens as
soon as a HDMI cable gets plugged in.

To fix this regression, add a NULL pointer check for hdmi->conf in the
said function, restoring HDMI functionality and avoiding NULL pointer
kernel panics.

Fixes: 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes only")
Fixes: c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal HDMI mode clock")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 5838c44cbf6f..3196189429bc 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1224,12 +1224,14 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 			return MODE_BAD;
 	}
 
-	if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
-		return MODE_BAD;
+	if (hdmi->conf) {
+		if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
+			return MODE_BAD;
 
-	if (hdmi->conf->max_mode_clock &&
-	    mode->clock > hdmi->conf->max_mode_clock)
-		return MODE_CLOCK_HIGH;
+		if (hdmi->conf->max_mode_clock &&
+		    mode->clock > hdmi->conf->max_mode_clock)
+			return MODE_CLOCK_HIGH;
+	}
 
 	if (mode->clock < 27000)
 		return MODE_CLOCK_LOW;
-- 
2.33.0


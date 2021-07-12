Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F413C599F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbhGLJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356167AbhGLIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:16:15 -0400
X-Greylist: delayed 153784 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jul 2021 01:07:57 PDT
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35337C09B092
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:07:57 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 08389604D1;
        Mon, 12 Jul 2021 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1626077274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yqiw9vakvD3biQvUw7e3pOAubtn1bx+ELCF8m+Mcba0=;
        b=fWZ+xu5f1Y7voLh9UJztHYCK35D/emrZkJ6EweWgy1JiC7Agzg07eLlZ4ulMWpNkNYzqsI
        dyUUbp3zzJov2NvmPAXFx646me2onhJailCwuxkuBy/RpiG5M8Xjmov1oIyBy3amklxEH3
        +QznbvRU9aX5rKipzdikPRZawUCZht0=
Received: from localhost.localdomain (fttx-pool-157.180.225.139.bambit.de [157.180.225.139])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 2FA88360681;
        Mon, 12 Jul 2021 08:07:53 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: dpi: fix NULL dereference in mtk_dpi_bridge_atomic_check
Date:   Mon, 12 Jul 2021 10:07:36 +0200
Message-Id: <20210712080736.116435-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 98eab89e-6b02-470b-a543-117e91a2899e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

bridge->driver_private is not set (NULL) so use bridge_to_dpi(bridge)
like it's done in bridge_atomic_get_output_bus_fmts

Fixes: ec8747c52434 ("drm/mediatek: dpi: Add bus format negotiation")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bced555648b0..a2eca1f66984 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -605,7 +605,7 @@ static int mtk_dpi_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_crtc_state *crtc_state,
 				       struct drm_connector_state *conn_state)
 {
-	struct mtk_dpi *dpi = bridge->driver_private;
+	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
 	unsigned int out_bus_format;
 
 	out_bus_format = bridge_state->output_bus_cfg.format;
-- 
2.25.1


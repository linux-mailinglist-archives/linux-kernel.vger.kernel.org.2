Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3258A3C8280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhGNKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:14:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhGNKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:14:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 74D801F42DBD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] dt-bindings: display: mediatek: add dsi reset optional property
Date:   Wed, 14 Jul 2021 12:11:37 +0200
Message-Id: <20210714121116.v2.3.Ifec72a83f224b62f24cfc967edfe78c5d276b2e3@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714101141.2089082-1-enric.balletbo@collabora.com>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device tree binding documentation for the dsi to add the optional
property to reset the dsi controller.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Added a new patch to describe the dsi reset optional property.

 .../devicetree/bindings/display/mediatek/mediatek,dsi.txt   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
index 8238a86686be..3209b700ded6 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
@@ -19,6 +19,11 @@ Required properties:
   Documentation/devicetree/bindings/graph.txt. This port should be connected
   to the input port of an attached DSI panel or DSI-to-eDP encoder chip.
 
+Optional properties:
+- resets: list of phandle + reset specifier pair, as described in [1].
+
+[1] Documentation/devicetree/bindings/reset/reset.txt
+
 MIPI TX Configuration Module
 ============================
 
@@ -45,6 +50,7 @@ dsi0: dsi@1401b000 {
 	clocks = <&mmsys MM_DSI0_ENGINE>, <&mmsys MM_DSI0_DIGITAL>,
 		 <&mipi_tx0>;
 	clock-names = "engine", "digital", "hs";
+	resets = <&mmsys MT8173_MMSYS_SW0_RST_B_DISP_DSI0>;
 	phys = <&mipi_tx0>;
 	phy-names = "dphy";
 
-- 
2.30.2


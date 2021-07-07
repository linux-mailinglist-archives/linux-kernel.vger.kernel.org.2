Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E43BE794
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhGGMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhGGMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:06:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F95C061574;
        Wed,  7 Jul 2021 05:03:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:c375:7561:3857:648])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5A7081F4326B;
        Wed,  7 Jul 2021 13:03:37 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: display: rockchip: Add compatible for rk3568 HDMI
Date:   Wed,  7 Jul 2021 14:03:22 +0200
Message-Id: <20210707120323.401785-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new compatible for rk3568 HDMI.
This version of HDMI hardware block needs two new clocks hclk_vio and hclk
to provide phy reference clocks.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- Add the clocks needed for the phy.

 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 75cd9c686e985..cb8643b3a8b84 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -23,6 +23,7 @@ properties:
       - rockchip,rk3288-dw-hdmi
       - rockchip,rk3328-dw-hdmi
       - rockchip,rk3399-dw-hdmi
+      - rockchip,rk3568-dw-hdmi
 
   reg-io-width:
     const: 4
@@ -51,8 +52,11 @@ properties:
           - vpll
       - enum:
           - grf
+          - hclk_vio
+          - vpll
+      - enum:
+          - hclk
           - vpll
-      - const: vpll
 
   ddc-i2c-bus:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.25.1


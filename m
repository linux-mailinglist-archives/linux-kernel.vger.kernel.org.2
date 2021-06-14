Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77D43A6AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhFNPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbhFNPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:13 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:1f5e:e45f:238:7e73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3669C1F42B15;
        Mon, 14 Jun 2021 16:44:09 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 1/4] dt-bindings: phy: rockchip: USB2: remove useless #phy-cells property
Date:   Mon, 14 Jun 2021 17:43:56 +0200
Message-Id: <20210614154359.805555-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#phy-cells' property is needed in host-port and otg-port nodes but
not in parent nodes. Remove it from the JSON schema.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml         | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index fb29ad807b68f..b14387a48f6a3 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -119,7 +119,6 @@ required:
   - reg
   - clock-output-names
   - "#clock-cells"
-  - "#phy-cells"
   - host-port
   - otg-port
 
@@ -137,7 +136,6 @@ examples:
       clock-names = "phyclk";
       clock-output-names = "clk_usbphy0_480m";
       #clock-cells = <0>;
-      #phy-cells = <0>;
 
       u2phy0_host: host-port {
         #phy-cells = <0>;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEB3A6AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhFNPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhFNPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC1C061574;
        Mon, 14 Jun 2021 08:44:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:1f5e:e45f:238:7e73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F08BC1F42B19;
        Mon, 14 Jun 2021 16:44:09 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 2/4] dt-bindings: phy: rockchip: USB2: Add compatible for rk3568
Date:   Mon, 14 Jun 2021 17:43:57 +0200
Message-Id: <20210614154359.805555-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "rockchip,rk3568-usb2phy" in compatible list of the USB2 phy.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index b14387a48f6a3..a1420d5e44be7 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -18,6 +18,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rv1108-usb2phy
+      - rockchip,rk3568-usb2phy
 
   reg:
     maxItems: 1
-- 
2.25.1


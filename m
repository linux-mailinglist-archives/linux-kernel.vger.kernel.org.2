Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4B39DE8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFGOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:20:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50764 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhFGOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:20:46 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lqG5X-0002M3-Ev; Mon, 07 Jun 2021 16:18:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     jbx6244@gmail.com
Cc:     robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] dt-bindings: soc: rockchip: drop unnecessary #phy-cells from grf.yaml
Date:   Mon,  7 Jun 2021 16:18:45 +0200
Message-Id: <20210607141845.3331910-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <e7e09072-9cac-413e-dca2-e2a668c1807e@gmail.com>
References: <e7e09072-9cac-413e-dca2-e2a668c1807e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent yaml conversion of the grf and inno-usb2-phy bindings
left the #phy-cells in place in the main usb2phy node inside the
example in grf.yaml, causing new warnings.

Drop it to make the bindingcheck happy.

Fixes: e71ccdff376b ("dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Like this I guess?

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 8c1c46fef157..62fa72cfea34 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -242,7 +242,6 @@ examples:
         clock-names = "phyclk";
         #clock-cells = <0>;
         clock-output-names = "clk_usbphy0_480m";
-        #phy-cells = <0>;
 
         u2phy0_host: host-port {
           #phy-cells = <0>;
-- 
2.29.2


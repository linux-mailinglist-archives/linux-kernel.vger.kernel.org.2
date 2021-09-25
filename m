Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E634180B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhIYJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 05:05:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51150 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbhIYJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 05:05:49 -0400
Received: from dynamic-109-81-211-127.ipv4.broadband.iol.cz ([109.81.211.127] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mU3bP-0000YK-Iq; Sat, 25 Sep 2021 11:04:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org, heiko@sntech.de, lee.jones@linaro.org
Cc:     jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: mfd: syscon: Add rk3368 QoS register compatible
Date:   Sat, 25 Sep 2021 11:04:04 +0200
Message-Id: <20210925090405.2601792-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210925090405.2601792-1-heiko@sntech.de>
References: <20210925090405.2601792-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document rk3368 compatible for QoS registers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
- new patch

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index abe3fd817e0b..72f7a0df5924 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,7 @@ properties:
               - rockchip,rk3066-qos
               - rockchip,rk3228-qos
               - rockchip,rk3288-qos
+              - rockchip,rk3368-qos
               - rockchip,rk3399-qos
               - rockchip,rk3568-qos
               - samsung,exynos3-sysreg
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352EF4180B2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhIYJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 05:05:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51152 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232623AbhIYJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 05:05:49 -0400
Received: from dynamic-109-81-211-127.ipv4.broadband.iol.cz ([109.81.211.127] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mU3bO-0000YK-C3; Sat, 25 Sep 2021 11:04:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org, heiko@sntech.de, lee.jones@linaro.org
Cc:     jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: add rk3368 compatible string to pmu.yaml
Date:   Sat, 25 Sep 2021 11:04:03 +0200
Message-Id: <20210925090405.2601792-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the pmu mfd on rk3368.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
- new patch

 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
index ceb15cea77e2..5ece38065e54 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -22,6 +22,7 @@ select:
           - rockchip,px30-pmu
           - rockchip,rk3066-pmu
           - rockchip,rk3288-pmu
+          - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
           - rockchip,rk3568-pmu
 
@@ -35,6 +36,7 @@ properties:
           - rockchip,px30-pmu
           - rockchip,rk3066-pmu
           - rockchip,rk3288-pmu
+          - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
           - rockchip,rk3568-pmu
       - const: syscon
-- 
2.29.2


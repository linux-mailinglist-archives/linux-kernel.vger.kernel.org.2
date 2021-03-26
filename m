Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29134A426
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCZJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:18:43 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:58424 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhCZJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:18:21 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1EAFFD1406;
        Fri, 26 Mar 2021 17:18:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26788T139903071397632S1616750297978886_;
        Fri, 26 Mar 2021 17:18:19 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d1b6e949e8c436ffddd1e9dcaddf4072>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v5 10/11] dt-bindings: power: rockchip: Add bindings for RK3568 Soc
Date:   Fri, 26 Mar 2021 17:18:15 +0800
Message-Id: <20210326091815.12754-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091547.12375-1-zhangqing@rock-chips.com>
References: <20210326091547.12375-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for RK3568 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../devicetree/bindings/power/rockchip,power-controller.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 9fec9e227432..a4d223255c3b 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -37,6 +37,7 @@ properties:
       - rockchip,rk3366-power-controller
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
+      - rockchip,rk3568-power-controller
 
   "#power-domain-cells":
     const: 1
@@ -90,6 +91,7 @@ patternProperties:
           "include/dt-bindings/power/rk3366-power.h"
           "include/dt-bindings/power/rk3368-power.h"
           "include/dt-bindings/power/rk3399-power.h"
+          "include/dt-bindings/power/rk3568-power.h"
 
       clocks:
         description: |
-- 
2.17.1




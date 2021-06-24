Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCE3B2E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFXLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:49:53 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:51066 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXLtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:49:47 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id ACA82D56BF;
        Thu, 24 Jun 2021 19:47:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1335T140034770458368S1624535240956933_;
        Thu, 24 Jun 2021 19:47:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fb16b192f82d02a1bda5123360655013>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, Liang Chen <cl@rock-chips.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: rockchip: add rk3568 compatible string to pmu.yaml
Date:   Thu, 24 Jun 2021 19:47:17 +0800
Message-Id: <20210624114719.1685-2-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624114719.1685-1-cl@rock-chips.com>
References: <20210624114719.1685-1-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

add "rockchip,rk3568-pmu", "syscon", "simple-mfd" for pmu nodes on a
rk3568 platform to pmu.ymal.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
index 53115b92d17f..ceb15cea77e2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -23,6 +23,7 @@ select:
           - rockchip,rk3066-pmu
           - rockchip,rk3288-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3568-pmu
 
   required:
     - compatible
@@ -35,6 +36,7 @@ properties:
           - rockchip,rk3066-pmu
           - rockchip,rk3288-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3568-pmu
       - const: syscon
       - const: simple-mfd
 
-- 
2.17.1




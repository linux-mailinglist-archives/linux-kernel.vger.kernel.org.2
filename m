Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFF3665E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhDUHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:00:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:36174 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhDUHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:00:25 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 230B8A9160;
        Wed, 21 Apr 2021 14:59:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2750T140649152108288S1618988366606986_;
        Wed, 21 Apr 2021 14:59:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3e5615a098ed173226fa5040f61269ee>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 25
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        cl@rock-chips.com
Subject: [PATCH v1 2/5] dt-bindings: serial: snps-dw-apb-uart: add description for rk3568
Date:   Wed, 21 Apr 2021 14:59:18 +0800
Message-Id: <20210421065921.23917-3-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421065921.23917-1-cl@rock-chips.com>
References: <20210421065921.23917-1-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

add "rockchip,rk3568-uart", "snps,dw-apb-uart" for uart nodes on
a rk3568 platform to snps-dw-apb-uart.yaml.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 87ef1e218152..9bbe4afc26a4 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -30,6 +30,7 @@ properties:
               - rockchip,rk3308-uart
               - rockchip,rk3328-uart
               - rockchip,rk3368-uart
+              - rockchip,rk3568-uart
               - rockchip,rk3399-uart
               - rockchip,rv1108-uart
           - const: snps,dw-apb-uart
-- 
2.17.1




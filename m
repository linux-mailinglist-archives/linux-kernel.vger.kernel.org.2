Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571403C2063
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhGIIEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:04:48 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:34566 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhGIIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:04:47 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 79A3C8C7;
        Fri,  9 Jul 2021 16:01:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P12349T139824269707008S1625817711146317_;
        Fri, 09 Jul 2021 16:01:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cebec1905e2ea82dabc47d7e6a775ecb>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 14
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 1/2] dt-bindings: add doc for Firefly ROC-RK3328-PC
Date:   Fri,  9 Jul 2021 16:01:25 +0800
Message-Id: <20210709080126.17045-2-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
In-Reply-To: <20210709080126.17045-1-djw@t-chip.com.cn>
References: <20210709080126.17045-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Add devicetree binding documentation for the Firefly ROC-RK3328-PC.

Signed-off-by: Levin Du <djw@t-chip.com.cn>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6546b015fc62..7ef902f45b38 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -115,6 +115,11 @@ properties:
           - const: firefly,roc-rk3328-cc
           - const: rockchip,rk3328
 
+      - description: Firefly ROC-RK3328-PC
+        items:
+          - const: firefly,roc-rk3328-pc
+          - const: rockchip,rk3328
+
       - description: Firefly ROC-RK3399-PC
         items:
           - enum:
-- 
2.23.0.37.g745f6812895b




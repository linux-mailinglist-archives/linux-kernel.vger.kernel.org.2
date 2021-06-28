Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1090D3B5800
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhF1EGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:06:04 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:38310 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhF1EFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:05:55 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 78FF6591;
        Mon, 28 Jun 2021 11:54:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.20.131.7])
        by smtp.263.net (postfix) whith ESMTP id P12369T139709984536320S1624852472443677_;
        Mon, 28 Jun 2021 11:54:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ac41327752d6ffaaaa78b061e5dfb0b9>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 16
X-SENDER-IP: 14.20.131.7
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Levin Du <djw@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 1/2] dt-bindings: add doc for Firefly ROC-RK3399-PC-PLUS
Date:   Mon, 28 Jun 2021 11:54:01 +0800
Message-Id: <20210628035402.16812-2-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
In-Reply-To: <20210628035402.16812-1-djw@t-chip.com.cn>
References: <20210628035402.16812-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Add devicetree binding documentation for the Firefly ROC-RK3399-PC-PLUS.

Signed-off-by: Levin Du <djw@t-chip.com.cn>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6546b015fc62..c7b2f5f852d5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -122,7 +122,12 @@ properties:
               - firefly,roc-rk3399-pc-mezzanine
           - const: rockchip,rk3399
 
+      - description: Firefly ROC-RK3399-PC-PLUS
+        items:
+          - enum:
+              - firefly,roc-rk3399-pc-plus
+          - const: rockchip,rk3399
+
       - description: FriendlyElec NanoPi R2S
         items:
           - const: friendlyarm,nanopi-r2s
--
2.23.0.37.g745f6812895b




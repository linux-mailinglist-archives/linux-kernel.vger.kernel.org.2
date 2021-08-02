Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428CA3DD094
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhHBGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:47 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:36739 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhHBGbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:40 -0400
X-QQ-mid: bizesmtp41t1627885384tved9odr
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:23:03 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: QGWlG8nlCFgleCPruuQmzR0U8s4zkQHYElEYonj/YF2MwZnAezFr2N4+nxZx3
        ows+kwHo5BfXQl8Uz8dKuxrt9r9Z85NPRio61rKxMxp8KoYlJkQy4pjRJJECQi8VSu0RxkF
        lxfnSfjYyEKWo10akpPVRdaetk0bijChQHOth8uP9+3xuyE1UJSY9Z5MZ7qW+p5gbsjB07K
        7+AeeFVkKZ8AwEFezTQYIc31qntycD9bHvOWlJGO1rU/U5VmWLMwsnWpVLHE/yv7wg8qENw
        Bd7EZsBclM6J/aOim3b6B9XpHygc5Gi/DPfZxssHh/uA35+tZz7Ecgt7OLNlLVYsr8E0BRr
        w5KV1ymYde3AwEC5MA=
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 14/17] dt-bindings: arm: sunxi: add compatible strings for Sipeed MaixSense
Date:   Mon,  2 Aug 2021 14:22:09 +0800
Message-Id: <20210802062212.73220-15-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sipeed MaixSense is an Allwinner R329 development kit based on Maix IIA
SoM.

Add compatible strings for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 889128acf49a..bce306908eff 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -444,6 +444,12 @@ properties:
           - const: haoyu,a10-marsboard
           - const: allwinner,sun4i-a10
 
+      - description: Sipeed MaixSense
+        items:
+          - const: sipeed,maixsense
+          - const: sipeed,maix-iia
+          - const: allwinner,sun50i-r329
+
       - description: MapleBoard MP130
         items:
           - const: mapleboard,mp130
-- 
2.30.2


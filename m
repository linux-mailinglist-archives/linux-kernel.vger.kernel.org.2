Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5E3DD06C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhHBGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:22:55 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:17199 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232218AbhHBGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:22:54 -0400
X-QQ-mid: bizesmtp41t1627885355t7mamqow
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:34 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: vYPicSn3yivSq6QGr6Xr+kymFQWQtsjJ62icRpbhhKXiBSKIjaIX5ndmrYfUs
        LLsHXI1XavseIxk1b8JeVXU2u8efMPEzYCCLWCuZnBD8nfQVoubUlYY4+TuevNrM+levrZP
        8bopquqiXFprX2A7qo1bJxTYXBfA+CnwJ8RTE6ykFcADNSsFNu6Zafr0eEp5IiSQkwQgilI
        XS+bQkeAJi2vKNs8qE9THmlJXd/bXYx3AfglWxxhCUJmP/btFMqbe0cJGWdJ4rxXnieWqHN
        Ug3Qa9qGs3wY3hveezwbcTb01gCSx5ejscx4EU1evh5p+32+KD9pjZvy1Lz8fjyDzvNHH6k
        c83OGdpF4Lbams9yic=
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
Subject: [PATCH 04/17] dt-bindings: rtc: sun6i: add compatible string for R329 RTC
Date:   Mon,  2 Aug 2021 14:21:59 +0800
Message-Id: <20210802062212.73220-5-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 has a RTC similar to previous ones, capable of
controlling LOSC and IOSC and with only one alarm.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index beeb90e55727..7fd1ad46496b 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -26,6 +26,7 @@ properties:
           - const: allwinner,sun50i-a64-rtc
           - const: allwinner,sun8i-h3-rtc
       - const: allwinner,sun50i-h6-rtc
+      - const: allwinner,sun50i-r329-rtc
 
   reg:
     maxItems: 1
@@ -85,6 +86,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-rtc
               - allwinner,sun50i-h5-rtc
+              - allwinner,sun50i-r329-rtc
 
     then:
       properties:
@@ -108,7 +110,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-r40-rtc
+            enum:
+              - allwinner,sun8i-r40-rtc
+              - allwinner,sun50i-r329-rtc
 
     then:
       properties:
-- 
2.30.2


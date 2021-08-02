Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542703DD087
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhHBGbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:08 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:34804 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhHBGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:05 -0400
X-QQ-mid: bizesmtp41t1627885369t38ro2qk
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:48 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: 4ufqJHNJpU3Jh6A1weDcibsKN7usBzxTYh6gBqlehrXGWveXvWRpmIeTAf4Qi
        dp7OTdXACy0Cu2QKYZj58MZxEqlDDcBOF6zWQNRKlqqs6Mjeo8nStlNi1a2P+vDM7+mIpX+
        qLXhrYSXNIn9aVTRoiwteE+2oVOE/VaFk5WUjY6r1PPg4Wmfm3bXPzSOV/uSikrKIb51/0p
        NL8dXNof2jzOTeX7GVxlnvI9IMyigCljEPxQqczb19E9+WO0cwIOfDgD7ZQ6cJzE/MRmFIF
        vaVk6z8+qjA3Sz3jFBTu0w5hfFpnIGui6H82sRogPJQ0kOQ8zUvEseDfGYdxsk/pT71y4d0
        qddPg3ULcqtd3Z23i3YcbEU3i/YKQ==
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
Subject: [PATCH 09/17] dt-bindings: clock: sunxi-ng: add compatibles for R329 CCUs
Date:   Mon,  2 Aug 2021 14:22:04 +0800
Message-Id: <20210802062212.73220-10-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R329 has a CPUX CCU and a R-CCU.

Add compatible strings for them.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index c4b7243ddcf2..4c9a50f263c8 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -43,6 +43,8 @@ properties:
       - allwinner,sun50i-h6-r-ccu
       - allwinner,sun50i-h616-ccu
       - allwinner,sun50i-h616-r-ccu
+      - allwinner,sun50i-r329-ccu
+      - allwinner,sun50i-r329-r-ccu
       - allwinner,suniv-f1c100s-ccu
       - nextthing,gr8-ccu
 
@@ -102,6 +104,8 @@ else:
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
           - allwinner,sun50i-h616-ccu
+          - allwinner,sun50i-r329-ccu
+          - allwinner,sun50i-r329-r-ccu
 
   then:
     properties:
-- 
2.30.2


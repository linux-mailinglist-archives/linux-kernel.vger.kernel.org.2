Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14283DD072
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhHBGX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:23:26 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:28000 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232305AbhHBGXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:23:21 -0400
X-QQ-mid: bizesmtp41t1627885378thkqeux2
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:57 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: zuISFTXeVwLI7T7y7eeg4g78iC351nEVHKQd2b+SncmfD3a+XPdRldWBHL5MP
        U+jKj8T2vm+sT1R4NldxCktYHKAPu5c/UfCarfief8tPYl50Xoqzs4DSt5s9XXdwmmVL51Q
        b+VorZom+X2Q86oOr27dY8kNUaK6+/0ksH1sCse47cdnapwVWmzK9PpJ38dQbsdaVd0LIZH
        lX7J+3pJJAoKPXjyTbyBzy6sSf3JafkX/MJdLOvzY4+JvCDG7AWrICMCD4BYty3qHcVLYlL
        1uMggGxxMV963YowffSGLScmf1pRDxMvCn0t8dbs9JCR4PUXG4Wd2+l6O8r3KYRlLM8711+
        DOI7BmrqhOw0dTh7ok=
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
Subject: [PATCH 12/17] dt-bindings: mmc: sunxi-mmc: add R329 MMC compatible string
Date:   Mon,  2 Aug 2021 14:22:07 +0800
Message-Id: <20210802062212.73220-13-icenowy@sipeed.com>
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

R329 SoC has two MMC controllers similar to ones in the previous
Allwinner SoCs. However, as R329 has no eMMC controller, the two MMC
controllers look like a mixture of previous SoCs' ordinary MMC
controller and eMMC controller.

Add a compatible string for R329 MMC controllers.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 4f62ad6ce50c..3e8c3c747a9b 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -28,6 +28,7 @@ properties:
       - const: allwinner,sun50i-a64-mmc
       - const: allwinner,sun50i-a100-emmc
       - const: allwinner,sun50i-a100-mmc
+      - const: allwinner,sun50i-r329-mmc
       - items:
           - const: allwinner,sun8i-a83t-mmc
           - const: allwinner,sun7i-a20-mmc
-- 
2.30.2


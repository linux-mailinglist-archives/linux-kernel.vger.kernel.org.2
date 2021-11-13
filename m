Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0614244F103
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 04:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKMDZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 22:25:04 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:43413 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhKMDZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 22:25:03 -0500
X-QQ-mid: bizesmtp39t1636773727t3mf18cu
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 11:22:06 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: YSwSv5UBo8iyDs0LqepHxm3Da4Ty9d3fh9KZboilL/WAOHMO1XsSu2aVYrRk3
        kKh5CGxjGRYL9hPcBttnI5YxO2FrtZQZWcJS3Y6vAtYi1f/DW6/jKFknkRgcDfjC44eOclo
        wDCF2OkauWWkeECWPQgpmWo1lGEgaAatcEBf/77mj+AwAan5nhKWbfnBHW/B9kkil54fctM
        A9X1C7btND+Hqr08VLHbQHXpiSK/kJFzbDxE0CoIuutvDWFpfvJeSc4QVw/tR4zwvUC6hKH
        JNeH3FVYZV5BxOcuduQiDOT2wtV5TjkCqjCV6bxrgrV9EJql85n9vVRmUdxkydu7Oi9SYd9
        3Y/YnFl3FAamtsgRnorBqEWero/PY83TovSu1fq
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: dts: I.MX: Fix typo in some comments of imx
Date:   Sat, 13 Nov 2021 11:21:56 +0800
Message-Id: <20211113032156.48799-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated `configurable' in some comments in imx1-pinfunc.h
and imx27-pinfunc.h.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/boot/dts/imx1-pinfunc.h  | 6 +++---
 arch/arm/boot/dts/imx27-pinfunc.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-pinfunc.h b/arch/arm/boot/dts/imx1-pinfunc.h
index 050a1fc46a77..bd2e679cb26c 100644
--- a/arch/arm/boot/dts/imx1-pinfunc.h
+++ b/arch/arm/boot/dts/imx1-pinfunc.h
@@ -26,9 +26,9 @@
  *                2 - 0
  *                3 - 1
  *
- * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32 configurable
- * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is the pin
- * number on the specific port (between 0 and 31).
+ * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32
+ * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is
+ * the pin number on the specific port (between 0 and 31).
  */
 
 #define MX1_PAD_A24__A24			0x00 0x004
diff --git a/arch/arm/boot/dts/imx27-pinfunc.h b/arch/arm/boot/dts/imx27-pinfunc.h
index 1514d80a3112..75aea0c701d4 100644
--- a/arch/arm/boot/dts/imx27-pinfunc.h
+++ b/arch/arm/boot/dts/imx27-pinfunc.h
@@ -26,9 +26,9 @@
  *                2 - 0
  *                3 - 1
  *
- * 'pin' is an integer between 0 and 0xbf. imx27 has 6 ports with 32 configurable
- * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is the pin
- * number on the specific port (between 0 and 31).
+ * 'pin' is an integer between 0 and 0xbf. imx27 has 6 ports with 32
+ * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is
+ * the pin number on the specific port (between 0 and 31).
  */
 
 #define MX27_PAD_USBH2_CLK__USBH2_CLK                      0x00 0x000
-- 
2.33.0


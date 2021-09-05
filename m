Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF4400DB3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 02:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhIEAVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 20:21:40 -0400
Received: from laubervilliers-656-1-228-164.w92-154.abo.wanadoo.fr ([92.154.28.164]:56852
        "EHLO ssq0.pkh.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhIEAVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 20:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pkh.me; s=selector1;
        t=1630801233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q34awbCQKllrGGfJoHrRV001izcYV1ujUZQWNoqWMNc=;
        b=Z8rvnJjpMOtOXHQm3OSew+DBwwLymRL9PwulknyJumxWYQYXZRCLqwFmdBh12Fb4f2f88e
        IhT4Igp2uPEShNSzCB95pfVQPQrFbdc+PY71SEfhTWbQ0AA92j+DaGLQiyPOr6/mdUkB4I
        dMgHrugElFWJfKFY8hP1yc19GsGyX0g=
Received: from localhost (ssq0.pkh.me [local])
        by ssq0.pkh.me (OpenSMTPD) with ESMTPA id fb51f2e0;
        Sun, 5 Sep 2021 00:20:32 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20B=C5=93sch?= <u@pkh.me>
To:     jernej.skrabec@gmail.com
Cc:     andrew@lunn.ch, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        robh+dt@kernel.org, u@pkh.me, wens@csie.org, willy.liu@realtek.com
Subject: [PATCH v2] arm64: dts: allwinner: h5: NanoPI Neo 2: Fix ethernet node
Date:   Sun,  5 Sep 2021 02:20:27 +0200
Message-Id: <20210905002027.171984-1-u@pkh.me>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <116454729.UZi3dMzWh7@jernej-laptop>
References: <116454729.UZi3dMzWh7@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
node.

Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
Signed-off-by: Clément Bœsch <u@pkh.me>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Reword the commit message and description (in particular, refer to the
DT hash instead of the kernel network commit).
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index 02f8e72f0cad..05486cccee1c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -75,7 +75,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.0


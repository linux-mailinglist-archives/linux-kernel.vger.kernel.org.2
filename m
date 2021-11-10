Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5483644C987
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhKJTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhKJTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:53:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D0C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r8so5910929wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi1SQ0650VpnUBsZivmkkBhDo1jhzZgEKHW44G9Rwtw=;
        b=h3AI7I6ru3Nn/MCBCN35cPu4WE47fz6h+EIjb1eXtPS/nC4egSJFdDxGFcHv0KaE7p
         gt2ox2xz4q/bE6vbUm4+C5y1y1axolM+2MKnGJyp33JG1q5EcxX+mDca6A1MdDAPjH14
         Iw2YT7/zeUur84LG9TKKpGcjdr+t3eoiuYsae9Y5PI2E686+j47lM6po+zm/iif9+2td
         G1gnU1A6G8zFUJMo/eoIoeo8ivhQSrcHpol52F5NQYnWb2OoacJU89GqL63cfQlvR8HB
         qp7IoZjwOuXLDV9bFLm1IgT/dZWW8QzbUJamQ+Rq1MqR8bGTdkRObjNsq73lwQHgNYmn
         kCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi1SQ0650VpnUBsZivmkkBhDo1jhzZgEKHW44G9Rwtw=;
        b=a0vRTowKhRRqXgjkx/M7RIBLtc9GreoOopW9Ldve8GGa2cRB44ioiMAmTdm137efec
         IxE3p5gVSa/oYwE9W5MjZUGPSMP75ef13vJgOf4vNw8g/M/xpojwNMxPfiuCEcxv2v1u
         F3MhBgAWMmlMkKP2KH/eWnIYYa5p6nV0ju2eUy2NmlbcDrAE66vpVW1ya0S/cGmP+H5G
         s6btJVHnbYw+nFf0mW7rbDpt7hi+cZcuveVrrODmNMqut7iv414Pf+JEVV4k8KWT7vdt
         03tYRvg5m2jpAWkxaVIjSvbrvbpKHoLlaCBqq8rp52yGbcBdx7c4N1FQGoVOkRRDacr6
         68+g==
X-Gm-Message-State: AOAM533YXrEUcF4BY60wtcqE3GSa6vsepDvXNmnx/pel9gZ4oiNr6BRJ
        1au1u96PzdW9T/XCksDk8QjjFw==
X-Google-Smtp-Source: ABdhPJyNwAHNRfrXhmSz0qWblbyRi1RZjAletdfZItDgstEuKD8EM5XYNkrrljsACKRpt8B1eOaSzA==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr1857692wrt.375.1636573818895;
        Wed, 10 Nov 2021 11:50:18 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k15sm750935wrx.53.2021.11.10.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:50:18 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: mediatek: mt8192: fix i2c node names
Date:   Wed, 10 Nov 2021 20:49:59 +0100
Message-Id: <20211110194959.20611-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110194959.20611-1-fparent@baylibre.com>
References: <20211110194959.20611-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the i2c node names to be compliant to the YAML schema. The
I2C node name should match the following pattern: "^i2c@[0-9a-f]+$".

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v3: rebased
v2: new patch

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c7c7d4e017ae..53d790c335f9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -479,7 +479,7 @@ audsys: clock-controller@11210000 {
 			#clock-cells = <1>;
 		};
 
-		i2c3: i2c3@11cb0000 {
+		i2c3: i2c@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
 			      <0 0x10217300 0 0x80>;
@@ -498,7 +498,7 @@ imp_iic_wrap_e: clock-controller@11cb1000 {
 			#clock-cells = <1>;
 		};
 
-		i2c7: i2c7@11d00000 {
+		i2c7: i2c@11d00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d00000 0 0x1000>,
 			      <0 0x10217600 0 0x180>;
@@ -511,7 +511,7 @@ i2c7: i2c7@11d00000 {
 			status = "disabled";
 		};
 
-		i2c8: i2c8@11d01000 {
+		i2c8: i2c@11d01000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d01000 0 0x1000>,
 			      <0 0x10217780 0 0x180>;
@@ -524,7 +524,7 @@ i2c8: i2c8@11d01000 {
 			status = "disabled";
 		};
 
-		i2c9: i2c9@11d02000 {
+		i2c9: i2c@11d02000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d02000 0 0x1000>,
 			      <0 0x10217900 0 0x180>;
@@ -543,7 +543,7 @@ imp_iic_wrap_s: clock-controller@11d03000 {
 			#clock-cells = <1>;
 		};
 
-		i2c1: i2c1@11d20000 {
+		i2c1: i2c@11d20000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d20000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
@@ -556,7 +556,7 @@ i2c1: i2c1@11d20000 {
 			status = "disabled";
 		};
 
-		i2c2: i2c2@11d21000 {
+		i2c2: i2c@11d21000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d21000 0 0x1000>,
 			      <0 0x10217180 0 0x180>;
@@ -569,7 +569,7 @@ i2c2: i2c2@11d21000 {
 			status = "disabled";
 		};
 
-		i2c4: i2c4@11d22000 {
+		i2c4: i2c@11d22000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d22000 0 0x1000>,
 			      <0 0x10217380 0 0x180>;
@@ -588,7 +588,7 @@ imp_iic_wrap_ws: clock-controller@11d23000 {
 			#clock-cells = <1>;
 		};
 
-		i2c5: i2c5@11e00000 {
+		i2c5: i2c@11e00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
 			      <0 0x10217500 0 0x80>;
@@ -607,7 +607,7 @@ imp_iic_wrap_w: clock-controller@11e01000 {
 			#clock-cells = <1>;
 		};
 
-		i2c0: i2c0@11f00000 {
+		i2c0: i2c@11f00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f00000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -620,7 +620,7 @@ i2c0: i2c0@11f00000 {
 			status = "disabled";
 		};
 
-		i2c6: i2c6@11f01000 {
+		i2c6: i2c@11f01000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f01000 0 0x1000>,
 			      <0 0x10217580 0 0x80>;
-- 
2.33.1


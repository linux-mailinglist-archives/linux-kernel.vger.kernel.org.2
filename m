Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF42322153
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBVV0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhBVV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:26:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC21C061574;
        Mon, 22 Feb 2021 13:26:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d11so1205610wrj.7;
        Mon, 22 Feb 2021 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3dkU8Q2xSsh1OocnwL/1K4DP7dRN0HBrvx9XsjBOus=;
        b=R9j7OJmc2C9ryyjhZfyyhYRxHfaTbY8ZkXrjf8UUwOUKqIgVGMEkSDsIbYtFSgXuvd
         D45mL1DosehbCzMUmRml3D7zbbcOA8T2barSAZDEbpfnz+Euw6NnLsAl0C+rVoxmCE5Y
         aYbLuJw2awXElbbO1tNk5LX8aliav3EedxSsYMy64VXIZO6b6EuKrt65bgsb67RE6K5D
         IUHdOL3CCuX2XGWea5WUUU2tIQehwbsdXaI0ygEUa6f6D/8q/NclABbVnQQdcsNb6kWG
         Vs6rU1DhuECahtqSlvR07yLWTVqVX/Biy8QB4oRwqz1JlaAWPHpmLz/p9HRrI70+NDQc
         EL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3dkU8Q2xSsh1OocnwL/1K4DP7dRN0HBrvx9XsjBOus=;
        b=GbS8fOp3lYvWjTjTW+Sr1p/zrX91Upl0yh+Nk2UPVvUX/Fcx6c8/AgpQy88bsH8z7w
         ANNf4cgQu90lwZnZ52Tp72xqF1XvFRrTjy23aPAlmPr8QLRgxlqfynpbGSwIst28zviD
         X4piNO4q7BCTFnw9LMMmnsqIroqN0kKgWyH4QAnYqkB0ZprxuElEYGEuRDn2SNbzLPPW
         3UN6Ua9ftpSDVsQIdnIoD/IBV6v/F1MXSkwvsDMOzEEmVgjxvQcp4XBRarXa5F1Pe/Sf
         vY03m9b1FFJNFOYruC+y1eWESGlWnFbf3BfSOw+qheURFdY4RAbWRTOd55mkRMNyN1oI
         WRuQ==
X-Gm-Message-State: AOAM531jZ4BQttJop8qQ7o7QD0VCfpfyh7b0GrL8et3exHtwqkR4BkRK
        luKsVwtyRMELsxHOjfzI3BY0QsDGThUfXTAW
X-Google-Smtp-Source: ABdhPJzOqIOvXEM6fI3382vN8WOAP6lCGnzknz32SFZRa7DkGeVYix4QhFKYC7KnK0l97pTZV0mvxw==
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr22767150wrr.81.1614029165497;
        Mon, 22 Feb 2021 13:26:05 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id a6sm526050wmj.23.2021.02.22.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:26:05 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m board
Date:   Mon, 22 Feb 2021 22:26:02 +0100
Message-Id: <20210222212602.25677-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kontron pITX-imx8m board.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2:
 - bring in correct alphabetical order

v3:
 - no change

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f45db8..6d121bc9af8d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -733,6 +733,7 @@ properties:
               - einfochips,imx8mq-thor96  # i.MX8MQ Thor96 Board
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - google,imx8mq-phanbell    # Google Coral Edge TPU
+              - kontron,pitx-imx8m        # Kontron pITX-imx8m Board
               - purism,librem5-devkit     # Purism Librem5 devkit
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
-- 
2.30.0


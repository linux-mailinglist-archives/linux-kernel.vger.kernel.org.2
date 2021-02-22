Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7E321A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBVOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhBVOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:08:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E37C061786;
        Mon, 22 Feb 2021 06:08:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l13so4929974wmg.5;
        Mon, 22 Feb 2021 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTlBpod/qkS5+lYeKPsZwHey+Qo/T25KoYgivxf00aE=;
        b=aTQ9utTGTcN0mM7CyUB6WZG7CDpz38A5dB8BkhsKcTtaMHkUU7mNSM7ZyJLW9dkRlB
         YEg6WoAo7eSJF5xYS+gwNBmlvhvFv/lU2pqOjGsVnPl9zT97xUPypnCwlGojmQnRgI9q
         4wEQiJjJDJMS8QVA/jmEOy/p60vJwS5XWSJGQzwJPsRJDL6RzoVP6xUwpAkvvZ0Mbfef
         SsKiFB85fUTy9ZcAsI9iQCgim43Def5FmfgYZprFuvPYgs0LYu8KgjP+7KsHD+hM61ub
         A3RKToxVIbSWp/ld5lSS143f0KcvAgwFTYZHeDvaRmwkXgh0pDoYb+T87Er6Js+YsOhy
         I8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTlBpod/qkS5+lYeKPsZwHey+Qo/T25KoYgivxf00aE=;
        b=AL0xYpTyCPU+P4ZfOnODDHaUBY5ExUv55f+9tmrXuwsaqfaamg+wdoomp2wiQO5kTn
         sGfPts61o8bLxMoENmRDqMjxHjvzxSppwwQzgbXVGGIOzIy5U8mDSO9+QMFgB3oEII6H
         KcHAT1liuIJmwUWlDvCmpXMO0vm7HKXQXVYMcz1Uy5QQr8HwDFTDMKBJjN1US1yk12+u
         1rEvMcagtF6/wV/W7p9aFCJK/rqrbCO1+Rq1C3nANmMNmCvJq0vXZIrUn2dXKVMaKS6m
         Azk4SrhjQyJn91+QuMQN8EaZZU0ix4NikkB0hLMv3tpoSY8g6H9DGXxV3yLsZvy4h8U+
         a2FA==
X-Gm-Message-State: AOAM530Vt9bR0t2yJ0GG2muiV9rTpvuVFydiboD5yZJe+2orArpKApTD
        1P2hUMi5WmhOC104GjIutrGFe9FDuyTOn+tk
X-Google-Smtp-Source: ABdhPJzhoDP9rn+03r36a0ixPxTYkL5Y/Uj/my1we0ROsQWx/BBhH3h9WDWdYjXAEQ6+qthnckTeMw==
X-Received: by 2002:a1c:98ce:: with SMTP id a197mr20151304wme.120.1614002883963;
        Mon, 22 Feb 2021 06:08:03 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id g18sm27966308wrw.40.2021.02.22.06.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:08:03 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m board
Date:   Mon, 22 Feb 2021 15:07:55 +0100
Message-Id: <20210222140756.713-2-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222140756.713-1-heiko.thiery@gmail.com>
References: <20210222140756.713-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kontron pITX-imx8m board.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
v2:
 - bring in correct alphabetical order

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


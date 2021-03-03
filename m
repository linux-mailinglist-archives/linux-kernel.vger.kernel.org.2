Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F332C35D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354047AbhCDAGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574775AbhCCVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:12:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BDC061762;
        Wed,  3 Mar 2021 13:10:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so17064843wrc.13;
        Wed, 03 Mar 2021 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9BjJkC0dW3hAg5tKuQ5ojg+EZTgdGlTYwLpnWjpCTA=;
        b=N6r5yQ/R0wIaJV8iMf9nW3mG085j/or55K2pXr9gZhkJytllIWMcoltmYLhk4CuEFJ
         mDL6yCnSkOyaKDjtPiHfZbB0knTTT5RACneO/rRmYcnkhQCU8fPYfZ4coop8g1fuIs0u
         z9hcrN/qLBNPwBcTSkgDeHT3o9XLpGaN4TjhdoPaEY6jiTo/fdT3ggVEsIv3Hlnq3Nv6
         tRV+ey39hAYczN/KY1NOpzF0+Ai/crGMFvNOOEEU1XN/wwLP13gI7HHmlQwCDAqta750
         Lju50n9mPVQP6ybsg6oWhAkIVcg1vt6JN0HYSBB7o6roYaNgX3paJ70wQBQ3LQNMJI7H
         b9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9BjJkC0dW3hAg5tKuQ5ojg+EZTgdGlTYwLpnWjpCTA=;
        b=UOK3nIWlLyOM1xxusHXp0AouCP/1kjyGOdwWGqsMsKGm9JZGM+pW2GqbFYmqC2ac8j
         Dsf+m+7Oq0jtq6vJMPd3nGryX0c4BJ4fbe+LDCY1zmv0jRPoSA51sIdMoQLHe43hWGtn
         8woQRBc77awy0XYdDrKgGYQa6YB2J6vxb8vFX7F/fni8nDyi9G+/pBQs+6lGRwxLigoR
         KVXfnTcCgZNz/WzaIgnIOrJRxrvalLRGQTrecv+IKEowhZn9YCRisTGH0yzFzC35Ok0v
         n3ISAAnh5I59DPmhwEBEwhasr+Ehq54QkrBmQyYImqGWevTyJ9Cq7I4Z5QQxgWvfzfXO
         205Q==
X-Gm-Message-State: AOAM531b85TgBvH7bPGVlPPlhdoaWrfAOEMGvdeMrBTIO4iT1PVGhFnD
        ph3eKqAw3MfO6si7avXzQLZa+Sh7Nd9wPA==
X-Google-Smtp-Source: ABdhPJzo5V6/wUd7huO68FR6cbDoWohHtU622yP8Ti28P7/qO+oFSU44HnzkOAUmd+tMz75WubLVlg==
X-Received: by 2002:a05:6000:147:: with SMTP id r7mr586072wrx.25.1614805857311;
        Wed, 03 Mar 2021 13:10:57 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id y18sm32684684wrq.61.2021.03.03.13.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 13:10:57 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m board
Date:   Wed,  3 Mar 2021 22:10:03 +0100
Message-Id: <20210303211002.17650-2-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210303211002.17650-1-heiko.thiery@gmail.com>
References: <20210303211002.17650-1-heiko.thiery@gmail.com>
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

v4:
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


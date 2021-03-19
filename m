Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4234149C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhCSFQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCSFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:16:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907BFC06174A;
        Thu, 18 Mar 2021 22:16:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r193so4821111ior.9;
        Thu, 18 Mar 2021 22:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3edckeWkehetFViH35S0XzqXThEXQbqg2BOwoSeuug=;
        b=NdTIoOuijUwsaYj4Dw09BSI28gcF1EL2e/Vpt7mPh9jNdxH7Q3xmCZIaiBUIHYbJHj
         bvItglCPOpacJTZuMqWdcSRQ4NUcH06UNLbT1SbZDLkmRu3o6ihzK5JqArIQ4iKLTp/m
         NJZ8b0zEDgGRlL4cozg+XR4Zxp5mWxt1PDC++9k2kPfHUufLPWNwzaXez/4ytPTM/utE
         /R3a7LHIlj8XIHhHbWMcQfxPzuta6knzzuZVKwH05JisO2DASMzs6S8ij9Wqqo9K530t
         UIs6QtB4tuV7W840GBnFz2mR1WehRk89BCwhfF7dAcmWFV7iqun+0HEhJfXq/FCnXN3M
         3oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3edckeWkehetFViH35S0XzqXThEXQbqg2BOwoSeuug=;
        b=d1bAum8vYvj7MwnD+3N4orAxXquQc1tu4rQXeADWEyNqemsPtBCGxo/ADgrtH1JD4z
         Ldg2Sdma8V+m1ftyvYonRJX5kt/28tTTn0gJ8lf5mVVvaxH5wF1J7pyPk3zQayRunxET
         Kag+M3Byj1fa98dXCvBq2Z1bkZ0aP6OLdeizyhVD0V7XLMZXQ0wBFcBdyUDnM2b6xUf4
         7PY4bNrFS0pswcCILXQdg8uiCkEBkGEffdRBiODCTNAwJvIDtr5Ch6qWoueeHBZAHUxa
         BdvD4gje9pSHq92bn1Ibcb2fcuMXVHBnpHqpwBzY8+BVqxU3bKU+e2Fw/gcIsOeYGDlK
         +2CA==
X-Gm-Message-State: AOAM530B167dsuRJH4w0Mm0DVRRbs+z4uoh7yqJeLX6diu4fPpLotlcu
        Lp6uTVEIXoS6iz/VAyG/GQc=
X-Google-Smtp-Source: ABdhPJy+q1ldqLqLY9PELr2pNvQ0eMU68AWpl4HHIRnWGcm+8b1ND5wFhjwL4j6fptQM86NuyOgveA==
X-Received: by 2002:a6b:630b:: with SMTP id p11mr1551516iog.140.1616130994089;
        Thu, 18 Mar 2021 22:16:34 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id s16sm2013154ioe.44.2021.03.18.22.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:16:33 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Jonker <jbx6244@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Fri, 19 Mar 2021 13:16:26 +0800
Message-Id: <20210319051627.814-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R4S.

Changes in v6:
- Fixed format of LED nodes

Changes in v5:
- Dropped the empty PCIe node
- Dropped useless `/delete-property/`
- Renamed LED nodes

Changes in v4:
- Correctly dropped `display-subsystem` node
- Dropped meaningless `pwm-fan` node
- Dropped wrong `sdmmc` node
- Disabled `i2c4` and `uart0` as they don't exist in the design
- Format fixes

Changes in v3:
- Dropped non-existent node `display_subsystem`

Changes in v2:
- Disable display for NanoPi R4S (reference commit: 74532de460ec)
- Light "sys" LED on NanoPi R4S (reference commit: 833821eeab91)

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c3036f95c7bc..4a6f772c1043 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -134,6 +134,7 @@ properties:
               - friendlyarm,nanopi-m4
               - friendlyarm,nanopi-m4b
               - friendlyarm,nanopi-neo4
+              - friendlyarm,nanopi-r4s
           - const: rockchip,rk3399
 
       - description: GeekBuying GeekBox
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5945934148C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhCSFLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCSFKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:10:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657DC06174A;
        Thu, 18 Mar 2021 22:10:55 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l5so6981745ilv.9;
        Thu, 18 Mar 2021 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/RTfl6k6odiLrR5obGXAJjzHlZhKwqdCygdrq5sAW8=;
        b=HIWZSvBJAkzeFS14n6kwaenLfC0Dn0dwCfgK/Tc8CZgkPKhoIPNkGoTcsgpelMPSGw
         CKAvTVt8EXBaf/xhMGxpKc3FNo+noqhcvR6jcvqQXuM41HTDdN7haL+kAp4V3T57rWXe
         jFKzaGRwwZQ4Q3TZA2A+vM5mi1t9vM/oB1wE4rls88/DHOzI4bE2uq7ARWEsBJ6tSDNZ
         DytwWtmjwyLhqo6hM+BzulKU/bYi3czDxjGPOKnwC274pXEz+coggp3BJOH+bPejgMXg
         E4AVXI38YiPE6tl9UDFQdqeosFv5iyP/dyxruZiB9Q8tcFe14rZEjPFz/PANbJMyXho5
         FFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/RTfl6k6odiLrR5obGXAJjzHlZhKwqdCygdrq5sAW8=;
        b=UbmHh81fXoOHSRQF/isKBEXszKZe5P4N8/yf2vxJmWatF5srtU50GXjNgskf8/PE6d
         if51PU/OTuDWBd4MhConR1ZkUONzKyLw070hbgOOVAnIDy2nil01iPz7d8LiIqRsUfCQ
         yTxj/pQnZ0sPhehLNsnKd1ZXoNhfhTf7vxpxDgrQYb5+oJniaRoHWIbW7i0iOV4trS0u
         AB01hygFwVGovycn3PzhVuHWmsjf6FigGCc47vwcPBqjoYUbY1OFI+RaU5msUPzV7nSP
         FB4OCE8ICYwhMlpYFiCg3l+uPD42Hw0H52iBMk16bd4nP84xYTkr/GIHKNb9A1tZFgm+
         4dqA==
X-Gm-Message-State: AOAM5328ZrVy8Qak+3zo1pWQlK7EdAdMh4bvhVAieHvRRZjT1m6pIVRb
        F+vtqGnhtwtnoA3mK/McB/4=
X-Google-Smtp-Source: ABdhPJyDMEiim+cK4UdCEkJvVKxYX8BQKngf8KbCObwxfVQ3pBJjsKyemTMpQD85elWBonm0tZGVow==
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr1414704ilu.75.1616130654578;
        Thu, 18 Mar 2021 22:10:54 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id y20sm2025112ioy.10.2021.03.18.22.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:10:53 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Fri, 19 Mar 2021 13:10:46 +0800
Message-Id: <20210319051047.27619-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R4S.

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


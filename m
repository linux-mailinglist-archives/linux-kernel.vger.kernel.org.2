Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26A831B07A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBNNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBNNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 08:16:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA8C061574;
        Sun, 14 Feb 2021 05:16:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o3so2932232edv.4;
        Sun, 14 Feb 2021 05:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZO1qCnhN92Jv14VX9jv9bkb4bvx0bzbNxASm7AgENY=;
        b=LDkhBDZwQuIV2Xxypx7HxidP+aJ2BSRfH+igHFhtqgLg4OdVfCFOHjbPYlLHA9cRJV
         jgI1aH9qlqKt5D0Jkh6TbOg5z2vqdTStFkpsBLE8fMHh07y3g4H9/wvSmIHiQTIVGoGp
         eld62W83P844OP7LE5WWLA2y+TOoq/ncmxnYfwjFPJMYC2HX5r1q2IoEzl0vI+zI/MGb
         nOO8Fe1/IzWkmEErpjOXNa7SweDhHQ3/qo/ElsE5362+7hLIiGGY96lpUjaD1aghqSEa
         H49YepbOkuWruUmFUkBoiWJE96sr9M1lKEc93czCVWuQm/wPT660WNUhN1Rx5UVEngk0
         OQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZO1qCnhN92Jv14VX9jv9bkb4bvx0bzbNxASm7AgENY=;
        b=tla5nZmc9Mk+wNRjEGggje3gqb0/BooPAIYzKYr4eJhbNHtmYvbhrlNLu2Em554J5f
         PO2suzzDch6/2yqE0I5wmoGzfAg4UEmcDMPN9PDSp3oVXklO6BEt7JIprmagXY3yxAuo
         X+mTAOpLxwt8daMJ5XSkMqj5PLeV/mKPOIB3TlVr8DPuZu7A/4hZHqQ9JGGzD9s7LSXv
         +OT0l3dKx0WZ0c6aw7jDKEQxfxtJQZ8xV64z0dsX8/1v0gM43RYmQ5V2bjWuI74bP64w
         EvQeoKTZvJmimMcEwFPQd7XaSmiLMxxsljnAQ82aL957xy3vDHnIzOQW0nHgYkAVpTsZ
         gP+w==
X-Gm-Message-State: AOAM531oKJRGHEdBiu57+8Sd9J7y1/+eDORrsbqOeWEHFDCSXgg80aVv
        EIu1EfhnXuMFJtVi8iDM4Aw=
X-Google-Smtp-Source: ABdhPJwoSEqYkCgIEFdX4hk+vu4m0g2+2ehxcyjgTB3HKxCX+VLaF84uSmXA4q4rn8W8/IoSK6G/iw==
X-Received: by 2002:aa7:dd4c:: with SMTP id o12mr11368832edw.180.1613308569140;
        Sun, 14 Feb 2021 05:16:09 -0800 (PST)
Received: from localhost (ipv6-31ee9f1acdb5aef4.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:31ee:9f1a:cdb5:aef4])
        by smtp.gmail.com with ESMTPSA id b6sm9389044ejb.8.2021.02.14.05.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 05:16:08 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, festevam@gmail.com,
        narmstrong@baylibre.com, Oliver Graute <oliver.graute@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
Date:   Sun, 14 Feb 2021 14:13:50 +0100
Message-Id: <1613308450-27958-4-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
References: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Variscite i.MX6UL compatibles

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---

Changelog:

v4:
 - added missing 6 in i.MX6

 v3:
 - rebased

 v2:
 - renamed binding
 - removed superflous "

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f..e67b622 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -499,6 +499,7 @@ properties:
               - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
               - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
               - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
+              - variscite,imx6ul-var-6ulcustomboard # i.MX6 UltraLite Carrier-board
           - const: fsl,imx6ul
 
       - description: i.MX6UL Armadeus Systems OPOS6UL SoM Board
-- 
2.7.4


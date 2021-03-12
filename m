Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF01A33967B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhCLS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhCLS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:28:21 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F2C061574;
        Fri, 12 Mar 2021 10:28:20 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id f10so3444730ilq.5;
        Fri, 12 Mar 2021 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ze6w/eTCOz/OO2OOk3Zl0RLx/goZvKrUNfJf9efgDaQ=;
        b=bJyumMMvXzGYhWnVLS7lUDvseVzaqeK14xLUAzm3aK0I5TTnkDVQong9yduJ/Tlm2O
         zJ9AntNRqzvRYAeKEj7pjVXagUJd7g7u61RMIL6OGfQHuYfRLIAA/GFLKo2r8xpArGAh
         ePH+zQ2eWFMfDUM6XZe/EMcN0L7WF9D/6qmK25Nid5x2dE92j/QggC4Us1YsFYNmSCSU
         mgVsTXMYEX113brGbAPzVYSTgznjcJl5fDHkzTzyR1ufoi+dy2ucVjnuQuIoR47okmNF
         tktQNTQGTk7Ig+0ko0yMWH9Kkz5/HCzBhDg38tHsyab0LZN+DsWRHWZmJiLWAAJjuIyG
         QVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ze6w/eTCOz/OO2OOk3Zl0RLx/goZvKrUNfJf9efgDaQ=;
        b=mgsibyGC/JhSUCH+2dt2mdaU3I94D1PO76AXhzvHZthm9BQ7NYcLzqvtQPVFJ1jAiX
         ni25mAhgzKOda5nMfGeEmyAPtNYrG0OzB8oV0VwLWnRQkcqLdci1qh/SDqDhRlvlwmU7
         HNv9Q1bx5cwYc1luHgwR9cXdp5D8+PsFCSyCIvfBZ2uSj6CRkbFfSsa3Gp9YhHgmf6jo
         qyrITPw+g6c6Af+MvzQUZNd2ZEgAoFDGuEgJate8gEzVONmL859OdccP5DL+uur5Q1mv
         aFuRQWSkHsiNJMZ7X1pS14VP85tQrIQslV0CwVs39n/phWIxRJw70Cl+iHH8EQkuAcS8
         dnIw==
X-Gm-Message-State: AOAM533H8hRjPQVdSO1UBTTYSVREKfAmLBitV6kgdWku0+ixEdqs0nRi
        lnkUAoLE4xy4IsrPnoRw1/I=
X-Google-Smtp-Source: ABdhPJx/8daUaRvyk6SF2ZZ5BxWN8dTS4tj6Ww+SiaGK6e/WxuzZvAty7d73XQ7XyLYoa1LaSJh71g==
X-Received: by 2002:a05:6e02:1384:: with SMTP id d4mr3696040ilo.307.1615573700278;
        Fri, 12 Mar 2021 10:28:20 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id c5sm1415362ioi.0.2021.03.12.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:28:19 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
X-Google-Original-From: Tianling Shen <cnsztl@immortalwrt.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Bauer <mail@david-bauer.net>,
        Tianling Shen <cnsztl@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Sat, 13 Mar 2021 02:27:54 +0800
Message-Id: <20210312182755.14018-1-cnsztl@immortalwrt.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianling Shen <cnsztl@gmail.com>

Add devicetree binding documentation for the FriendlyARM NanoPi R4S.

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


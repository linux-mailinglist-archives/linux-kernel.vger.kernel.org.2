Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F0339B86
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 04:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCMDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 22:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 22:25:32 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B91C061574;
        Fri, 12 Mar 2021 19:25:32 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id v14so4407198ilj.11;
        Fri, 12 Mar 2021 19:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkbWvvawOZqv47KK5IQlHKelnnTkdOV4/2jDdv1VKWs=;
        b=oChx00d/dOfZCF5MvE/GxN+89t/pUJ93l0w03dUe/bwP0ZTdzwHrihLPyACvgzziN+
         kf4Mjz1hOceAhMpKoA8lAqW2DecYDIhFjbQqbCZZa+Xpfo2aPi+X9RNFclMtMIzHjJcn
         jzP1jCEbYL+ymBVuz8vjdKxRg310xaiRK7X+IlEWHhTYcuIo8LLIQYKYP6g7Ix9Dx7pW
         5Z3pIEJhjJlTZIfNovlYfKViGxxh3pCJczU8RDa1z0BcMjA5UU4XNM3Wt3ySMAoVK4Ps
         Okv0rMjCVIZkdFC7ewkludCVVYUz7JLE3lckxfRm+UN4cWBRI71JR6asJnpTVtcNaN1m
         Aqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkbWvvawOZqv47KK5IQlHKelnnTkdOV4/2jDdv1VKWs=;
        b=c4BtBobk8ei0kOvWiJhdgzJvSQYSmfSEqU1ACR9+EPRuIQRnO8IvrVy00JNxZ0Cxjz
         pZHIP+BLXQKKF/95FdS4UsSvMDAhwNHHh+iwev3hRmvWnrO/c9/bEs/qi1HnMI36p3AZ
         J3bzVkWvb9bIRRWvxMtA1PXiP8DLryHv++d3B/swy0TJJbuapJG99uwi1sC7SJh03c8e
         vRJRpnxxNo2MbFYYfynBGzIlchLiG4GVO6j3yIOM9ST0vWDCEZ4q20gxIILsqH+QON/3
         EBcTgVZgq2zPjKa2mMWGKWyNFKZmXhAlK5JgHBkEO7o2X1/4BKAoMPOHJ9uKk4PEHPSW
         cXRg==
X-Gm-Message-State: AOAM531ixwCQz7Q15fS8/Mo7nwXfx4WPLQ+pw+FqnngBetXu2I6sEBm6
        ZfuBrYGeEb2oIDtryN1UwAw=
X-Google-Smtp-Source: ABdhPJyO3owciWGFItb+L6559F1y22YE84vWPYb/MCixtNov78PCLOv/0p7+zLN1cRAT+8RXNQVZoA==
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr5103376ilt.149.1615605931735;
        Fri, 12 Mar 2021 19:25:31 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id a5sm3959013ilk.14.2021.03.12.19.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 19:25:31 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
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
Subject: [PATCH v3 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Sat, 13 Mar 2021 11:25:14 +0800
Message-Id: <20210313032515.12590-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R4S.

Changes in v2:
- Disable display for NanoPi R4S (reference commit: 74532de460ec)
- Light "sys" LED on NanoPi R4S (reference commit: 833821eeab91)

Changes in v3:
- Dropped non-existent node `display_subsystem`

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


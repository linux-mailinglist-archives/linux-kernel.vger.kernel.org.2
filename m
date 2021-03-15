Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BC33ADD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhCOIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCOInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:43:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA16C061574;
        Mon, 15 Mar 2021 01:43:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a7so32449316iok.12;
        Mon, 15 Mar 2021 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUUJWf4QmwLHf83jhf+2Lq8pbXwZliJWXgXFKZ9LPAE=;
        b=TrKiOtOdFxR6EoPkeIzgVbd/Mx2nNks3DWYeXrmaEauFqbp5VGuGeRab568SyFhA7o
         7mr9WDTO+O+g7dGXsAMptUw+DeYiTGMsHT0HfbanaNSmVPe88JaYDP8kDvYjG+kn0YS5
         rnmjovxOqPWLnQDaZ6fhQKNgWnEOUE3T4Ae52ZvEvFj0l34jiC30JRceXVimSyla6Yc2
         Y/V6Y9RHlAgeERC6kTNOXW0u79nmZDrt5OflVKGy1lUH/uYqxg1acOZt2hTxwnqY8Yx/
         Ct1qDrhawSRueywfETEtGRkzoQG2Y1tPebYAOTowrcjZz7UQmRuFKchYKSxGEquEJdTK
         OqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUUJWf4QmwLHf83jhf+2Lq8pbXwZliJWXgXFKZ9LPAE=;
        b=FlfA8SD5eL2WghVuyPp5DI7/7rqcVT9y7DpiGQEhGTovgAK38hl3E6WRosZ+5fxRbV
         +x23R3qK6464+YgaU0uCFw6CaSV4QCtIrC40wlCNaey3W/6+5pk+IkDIwuERge407evt
         3u780sPZBe7NzFx4ju28fibNskMZcSXL3WRSgV/4LZtmsyeu9aJ48MGvypKZbXvylrVh
         n+qAgs3xwwPOuUqUGiEs0K2Zkm0FkjWTT5rMCxz6ssP5lUWIYbbicRVpZ5dokkcpjpFE
         +Rby+b40z/KrJlAHjUTM/p4sFeY1J7bOfurmiUJ27vXinaXSPFo3Z2FgpuliN5PvXAYY
         fhxw==
X-Gm-Message-State: AOAM533NvLfwPzyC0REK/oT0LzEFkF8CH9Bx3Q21Rys3Ksh4xwQ/zdM0
        JP+tDas6yq7qzACOXa5DmrM=
X-Google-Smtp-Source: ABdhPJxo+SPbROn/1I5dup9r39OCO5aRNS9OXt8o98ljW0f7OO+so7zDxhM8DkNaP3KWhXIwIde1yA==
X-Received: by 2002:a6b:3bc7:: with SMTP id i190mr6672451ioa.163.1615797832456;
        Mon, 15 Mar 2021 01:43:52 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id w6sm7375110ilm.38.2021.03.15.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:43:51 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Tianling Shen <cnsztl@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Mon, 15 Mar 2021 16:42:40 +0800
Message-Id: <20210315084241.22345-1-cnsztl@gmail.com>
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

Changes in v4:
- Correctly dropped `display-subsystem` node
- Dropped meaningless `pwm-fan` node
- Dropped wrong `sdmmc` node
- Disabled `i2c4` and `uart0` as they don't exist in the design
- Format fixes

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


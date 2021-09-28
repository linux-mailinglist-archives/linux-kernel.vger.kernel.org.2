Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EB41AB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhI1Iwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:52:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53496
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239774AbhI1IwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:52:11 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A7CB4031B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632819011;
        bh=MrRtMKWESY45De0HF10TbNHiqJiU4JWtrfj4T60+/KM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ndER0NAr0UN+YQHUTT2ns733/eJLlpx4hh5yjodfw+hgXyETeClSYKznf4KJ2p4pf
         D52xjHq1U7JzKDcK1PCskxIbfzRJrlnC9X6oaHD6c6d5d2VKqTSUcPrkRA9HZ/ZrsK
         SBqn+bVfxdNwD2eZKDPxGlLxsjDeatDfhYNH8xiveDJpXIm/VAjJYO9IQmmuB1ECEL
         mlDzNk6BUlT9rAt4aVYxyl+z6s69QmQLC1O2/ZL0zfepLNSMaUvipY84xrf6oEpRgQ
         LyEasZneHj6pW9X++t/ppSLTAmRy/nYq5yndLW3eMEnewnPAKvbnbzOKd8ZB+vjR0r
         mpiVVpr58LOHA==
Received: by mail-lf1-f70.google.com with SMTP id d16-20020a056512369000b003fca9e038ddso17503781lfs.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrRtMKWESY45De0HF10TbNHiqJiU4JWtrfj4T60+/KM=;
        b=1yAzHSAp13ZZU6Oxum3bHUEqY1lpij183jRvZ7S1hgCye07xpINxpF4XUQeyP+C7XT
         Wm0E3uIhb3B1x5FYQkYbn/aJNnk9SiMsgRqGNKP4aW9MFw0z1s+/F/WfyeArbos926l/
         6DHi2xz8RdrRpNZGbF7dACIHK1cMD476+b1rKn9NN3VkhQwia5KH92nIWLfbynbozyNF
         2sR9IZwvbYT49LZFNBckhGUyPR3Y3gZL0KK45ZGYV3TdcxvwuimmnZv8tvATS/bNLc1O
         EZs8XPPgVvrVyYECqA32sMIo6xcUxcZiLRZI8OUNaCw0zOyGheAEnfktKtsviQX4s+YN
         iulw==
X-Gm-Message-State: AOAM531kTGwXsLS8XOdyclzrqkLtSsDGF9CAEBpTCmIDOl4aaLF3qXhZ
        KZ6sz3xhzbGeQZe7qwEWx20Rl4URjbYMbpwOZztPI3sl01svR6wIFPyKPvgFLIPOlohcrOFPz1E
        wJwkx2tZyVVdbNivPuaKYOfNVNVzJuuifkZlxRslLaw==
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr4530588ljo.261.1632819010966;
        Tue, 28 Sep 2021 01:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeT9hh5MikDORvgeeNHLdkoBlQ51tYUHQvGyxCDV/oLrmwZnjOgz8Pgq3riPZog98Bec4NGQ==
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr4530572ljo.261.1632819010805;
        Tue, 28 Sep 2021 01:50:10 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13sm1848419lfl.205.2021.09.28.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:50:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 10/12] mfd: dt-bindings: samsung,s5m8767: document buck and LDO supplies
Date:   Tue, 28 Sep 2021 10:49:47 +0200
Message-Id: <20210928084949.27939-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the properties with regulator supplies for bucks and LDOs.  At
least one board uses it (Exynos5250 Arndale).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/samsung,s5m8767.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
index 35018346f68b..e97a94cab4e8 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
@@ -96,6 +96,44 @@ properties:
     description: |
       GPIO specifiers for three host gpio's used for dvs.
 
+  vinb1-supply:
+    description: Power supply for buck1
+  vinb2-supply:
+    description: Power supply for buck1
+  vinb3-supply:
+    description: Power supply for buck1
+  vinb4-supply:
+    description: Power supply for buck1
+  vinb5-supply:
+    description: Power supply for buck1
+  vinb6-supply:
+    description: Power supply for buck1
+  vinb7-supply:
+    description: Power supply for buck1
+  vinb8-supply:
+    description: Power supply for buck1
+  vinb9-supply:
+    description: Power supply for buck1
+
+  vinl1-supply:
+    description: Power supply for LDO3, LDO10, LDO26, LDO27
+  vinl2-supply:
+    description: Power supply for LDO13, LDO16, LDO25, LDO28
+  vinl3-supply:
+    description: Power supply for LDO11, LDO14
+  vinl4-supply:
+    description: Power supply for LDO4, LDO9
+  vinl5-supply:
+    description: Power supply for LDO12, LDO17, LDO19, LDO23
+  vinl6-supply:
+    description: Power supply for LDO18, LDO20, LDO21, LDO24
+  vinl7-supply:
+    description: Power supply for LDO5, LDO22
+  vinl8-supply:
+    description: Power supply for LDO1, LDO6, LDO7, LDO8, LDO15
+  vinl9-supply:
+    description: Power supply for LDO2
+
   wakeup-source: true
 
 required:
-- 
2.30.2


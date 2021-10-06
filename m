Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2038A423EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhJFN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:26:55 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52028
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231630AbhJFN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:26:23 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CFC063FFFD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633526654;
        bh=/TxQjVg4dqdEH2Xf1um2+yFrWocR1Yxndc1y14FaRBg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jBxei0CuvIv7U2mU6yuFCvzM6tM/Ym/dETpaPEeiaP1o5+R+R/kuF+uFvhot3G401
         ss1VF3Pccv5TtUZq2vSzdnoOmeyUAeSF2q1IAJmHmzwHhUkbw1vcmR2pmC7QuQ+Zi1
         0dUCalssvz/7H0Jesl6oCUGjQd6yQaHoHhOL5UhvsWjIQXf6zEnkT5XcteRKJvR5qP
         KyfP5c0ilP20FF8jQbceUvBiqJSjAOG9D8Wy66Hnl8L4Ttc4eQo2KdtZJMU5lGbrqb
         jKdcqf3e1KpyvfiKv1kWEy/8LgB6Ypf4CF+WYdYUUrvXyPRyiaCOQoAuz0Hb42lQK3
         pYVpRVyZ7Udrw==
Received: by mail-lf1-f69.google.com with SMTP id x29-20020ac259dd000000b003f950c726e1so1969520lfn.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TxQjVg4dqdEH2Xf1um2+yFrWocR1Yxndc1y14FaRBg=;
        b=oxouvuBWroN5Q+G1X/46oKdVj/+YGJePsYUrnOceKEA6md8qvAOxteYSeKYgT4YNjC
         o3qhJtL7JUVyLW1yb5oj/M9FQ+bxrJ5ZJ4MQdmOQ9zxSYtP5NrkLEEZ2Dl3s47uzmp2I
         prKQtBnpY2smcDlTLr95qut/R1adKokICs8ccCk46avOXvD9Kej1XNoOy7emdaVMepBA
         sgxnuxepYFyRMWdsn3VlbHZ8CB2c5BIJVeH9YPe4HCtBX/Ck9+cHuBdiMMidezAHq06u
         eykF47TvMD3lT//8dQyWtHuxqpfyuFUPC2jFMPy87ZrsTMQV/XbSuq1t0wrRV/969Cp1
         YMcg==
X-Gm-Message-State: AOAM53236QiDGHavwrdsDP1PFMq2xBc9jljWy2cayi3OTDyWqq90Du5c
        ko6eyR8rgCKCY6oXvCIwPrViqU2bNHBv7tuoWnfGtvWKQtSVW1isF42kqKHm60r54Rq57rOJ3JS
        KW2NkDYpcHE4kayy45QqJR9iPyHzPPyzN0cvr+C1KvQ==
X-Received: by 2002:a05:6512:239d:: with SMTP id c29mr4977145lfv.298.1633526654165;
        Wed, 06 Oct 2021 06:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyxI9DCzgHmNifB29wk0t7bWAAJ9cLaVRutS7AHt+PrtijiOQ5EPAj7BrzLpCD5bUEE/p/rw==
X-Received: by 2002:a05:6512:239d:: with SMTP id c29mr4977129lfv.298.1633526653997;
        Wed, 06 Oct 2021 06:24:13 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y12sm2002819lfg.115.2021.10.06.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:24:13 -0700 (PDT)
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
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 10/10] dt-bindings: mfd: samsung,s5m8767: document buck and LDO supplies
Date:   Wed,  6 Oct 2021 15:23:24 +0200
Message-Id: <20211006132324.76008-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006132324.76008-1-krzysztof.kozlowski@canonical.com>
References: <20211006132324.76008-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the properties with regulator supplies for bucks and LDOs.  At
least one board uses it (Exynos5250 Arndale).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/samsung,s5m8767.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
index b2529a48c890..12dea5aac8b6 100644
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


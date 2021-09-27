Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF107419494
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhI0Mwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:32 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46032
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234431AbhI0Mw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:29 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74F0740268
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747049;
        bh=jeMIEXiKB7wPBA3ymi6+lgomz3wpzPFtflbOU3+5glo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aHOxSqEIshH2dJ8yriKQTssYx6Cjg39YMK8olCDgv8y/GGajdunItySSY7ZiQLHoT
         huj3zhgvsXPFPBAoquAW+nLNm+XjLLgIqx/LGhMrQUHc4I2XOHSPYkPUyf+F/T/OE+
         SSWR6nXTrZPTqOsg6rQUdDJOTDB7QY9fatmOSvvKjt7cNY8GfIkk8P7u1HylPzg5Gw
         aF7DgFkZmW0YoAtpzjLiypf0ZdDHXqGYXgmuHdCA7hv3qaZwEmyU9bMv8krk3xe7BB
         9Nh5GZEDblTLgjsyr3l9zmpMhfs91fBIlLmJ5vceEYWXcOCly6zwY5tBLJDdONh0I1
         kTHUNAxJZAjeA==
Received: by mail-lf1-f70.google.com with SMTP id x4-20020a056512078400b003fc8e963f1dso12300394lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeMIEXiKB7wPBA3ymi6+lgomz3wpzPFtflbOU3+5glo=;
        b=nSKMso4uo1aUHO+x5xWQ9ZHYt96+qv1HwNIu28mCn7Inq5ZURCLHGNYbc8fi1J12th
         0BbUOjAlns8+chtsdz8KKW3t/a3bljYRrQv1yIHjNQ/3ZbxVAL12gbKPUHFfDtnHfsjg
         TSEqEVKOUvm2g0971Ch5OpI0FnT6wZ6wcuffGgJ48O3xVQnWHMqPFdJZ1uZm6yyyhqpA
         /2igNxXAPwkM8hMo1u8MszMwgRWFBM5i0/LxV9WXdydzoKkd0CIRfKDEj3xmTqTxbgM8
         j8uy08VNPx2SOyYnMvgx9++Z60L16r1OB7QPDJXyIeUFuxTjJtpi5U0Cxf5+XIoGVhqY
         297g==
X-Gm-Message-State: AOAM532q751l9kltP5/+QT7ioTkkUlwfKs+yfqPNI1UI45KPCL7Xcv4T
        Bdum4Pz3FB4N4S1LkO+RWeyOTTO6E+kxlSy1L8Ton8X5jYYg43x685ANuYmXSk+v03ve9YH2JQw
        J9BKcI52mPiqc2hzEjQ7pyjyf8jJ1NoL9sPOnQBbwPA==
X-Received: by 2002:a2e:140d:: with SMTP id u13mr17389339ljd.298.1632747048870;
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4XgRv4NIfqOOqXINjjLOjy/LJUFeE0f5kcR1+muR49/z/9l4mGGfT5izyr31+Z/ahcTOfdA==
X-Received: by 2002:a2e:140d:: with SMTP id u13mr17389319ljd.298.1632747048691;
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
Date:   Mon, 27 Sep 2021 14:50:39 +0200
Message-Id: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip PolarFire SoC FPGA DTSI uses Cadence SD/SDIO/eMMC Host
Controller without any additional vendor compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Adjust commit msg.
2. Add tags.

Changes since v2:
1. Document vendor compatible instead of dropping it.
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..4207fed62dfe 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
-- 
2.30.2


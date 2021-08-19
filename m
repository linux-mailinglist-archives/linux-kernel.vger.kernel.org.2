Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42843F1D29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhHSPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:45:57 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42258
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240434AbhHSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:45:54 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 99B70411F5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387917;
        bh=9g8lVxW/0vIBsgyWcHYECrU1Y69l0dfoNbAMk8ILUfM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SKS4tBzPDpF0JiynZAqsbxOp3Iltx/bv2Q7GVXtjySELskxRmkerEEGFhqUXtCbQl
         bDt7PrCm/sz942+ZfGV6huN/hv1zXmhWhkDFAhTh8pp7/ckfflbGFLY1jNl6vhGQGe
         PLmG3XMj6N8NF7WNNdD5e3FR2M/9Ln0s7y47BMU6iWAD2zAJnjwa4DM5xt/Erni4I+
         aXrJS1Neszfzr8lF+keIgTBebHKNRpbcFpZ1I7Ztttq565aeAeQqkJ0P/Wydg/tumg
         1CnH1tOistWoImKnURofDvTKB+W1mqoyU+vGMIQ3EyBlTrsCmVUVmr0tiEjNFrSvq7
         CMIgL9FSoCWQQ==
Received: by mail-ej1-f70.google.com with SMTP id s11-20020a170906060b00b005be824f15daso2423755ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9g8lVxW/0vIBsgyWcHYECrU1Y69l0dfoNbAMk8ILUfM=;
        b=ZehLEKa3xccNSQ2wtUIwrzp7rzARLQO1fygzn7q3Uo8IywKtUG5sMyhr23ILjLOj/g
         DZ59TPuz45A9ZyQEae7BtaYoN4GNk21NU7CIbms1F77kU6N9cYaRU1ZdcttCR7tyEO2q
         /962cGojymUPjHu3PmBdLoxf8xA2aN3BRmboqEAR/p2+x1GtV3PfHPIeqslOcFStdGu+
         fVPwtV0kmaqNBJqg5D3suQHTV02fZwTS+YgVt4PhLIl9XiqVCvmx99MlBgKv8wTc7f1C
         CTV6870ICqki2Yw3QCiXwbcpsy4UVHy0xcE9WWMnEclNtIA3cUZnX8D83n6/4kP4Wfpy
         7FxQ==
X-Gm-Message-State: AOAM5327wPmGgU3U56SI37M6AwaVG++x7RVFCa0yFeS3WkEayrgGfXw2
        Sep/IMDUA20FODzWTpmA/YxkR4hUi5GUBhNIE+LRdHC1J5AvoFC7+vy61lQ5Zo1gZkKoeqxwL3X
        jjThewLg+JzB9hm+7fNrYUVHx1D99UwevIEy3H6JSMg==
X-Received: by 2002:a05:6402:2936:: with SMTP id ee54mr16886864edb.70.1629387917313;
        Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydJxAR9RqcEIloU3dIrjmUihGpRPfzhtv3jlhyIeTCtbI+Pz4nUoF1CAoY/Ww8GACdR8Ks2A==
X-Received: by 2002:a05:6402:2936:: with SMTP id ee54mr16886841edb.70.1629387917156;
        Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI controller
Date:   Thu, 19 Aug 2021 17:44:32 +0200
Message-Id: <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
without any additional vendor compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..0489aa92cb54 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,9 +15,11 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - socionext,uniphier-sd4hc
+    oneOf:
+      - items:
+          - enum:
+              - socionext,uniphier-sd4hc
+          - const: cdns,sd4hc
       - const: cdns,sd4hc
 
   reg:
-- 
2.30.2


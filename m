Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B94115C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbhITNaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:30:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34858
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239439AbhITNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:30:08 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A3173F4BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632144521;
        bh=o/Js1PjbYfMgzPBeKDkGOA2puRzMdr5LGwoQCLB6OLo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fvZYJegStS5QF/PKhR/t/+Q0klBCpCYmKP3BbedKW4ThFCGpBbhu5It1xUVMKJu99
         5yhx42ZfGKh71wZmz870fDIyuAOFPaFS6IgLGiCTnzPNkpDEHDeDg4Ev8gYyzCwn2w
         ZeNUYUeDXge+qLaFy2/SHlWJ3pF9r4hTWnBa1puQC4Y3Yev3fCJNkj6cR0YTYk1rCo
         iw2Vh/71vEn8IRsDM8E6LBW/4nyk+/yyqWFwMR7QZJP7+FDmZpiGZ9LvcLA4CQM0Lj
         RDkNNVOeKc8FE0YKKAgERY6DrcVgDdkaoj9Cl5/Om//GttePAqQCbOBN4uxL33gAYF
         vmNDU9FLUp/Iw==
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so1798185wrh.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/Js1PjbYfMgzPBeKDkGOA2puRzMdr5LGwoQCLB6OLo=;
        b=aapeiC9WMCHIM1Vk9+88frVXdLdC2YOaP6p/3PhHJT32NNGmV3A5Ihpc2bMuol4E34
         UWDmyVKC+0eQ3IwOi4pE6JclJ1s0Is77LRUHnW0Cth5ex2alC2ogpQyb6W+JjmOsa00I
         skHMrquxO9uPiKCBf99iLBc3s0tBYRe2Os5hZ+rr2AYkouxtFVP9QMPL3UNOKmM65hhZ
         6GJ/Tk9IXN1PhI4LSGdhXjAkKrhYFL14YzHWTzBBGysw4syaBF2c6dpAzqPSjnrX9uYD
         ceUR6oxr6Ih6yV6SfzlBVD2qnjBo6J1FMPHjCwy2HWMGosaVWNC7FivclpG1GUPB+eaP
         uYfA==
X-Gm-Message-State: AOAM532BdeFj0rPXNT2lWSS6iugfTSVtiZQNQV9tw55JO+qorfg56xhe
        096QUGU2nQ++SpTF6H1KOTiQ/6DIaTovckFaBkQ2GOhhzQypzT9TsmrX7E491WC/C8+m2QoUwvX
        WzhLB0P6kyDQy8jIuqV22YUtOL2K8aVVvmHR1zGALXA==
X-Received: by 2002:a05:600c:19ca:: with SMTP id u10mr15004744wmq.45.1632144521108;
        Mon, 20 Sep 2021 06:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Tjyuod+S15/Y23kxUirk/6MQldc+XQ33JOgIf8TozvJ3laDQt2n04lodhRvn8cF9FhtwQg==
X-Received: by 2002:a05:600c:19ca:: with SMTP id u10mr15004733wmq.45.1632144520924;
        Mon, 20 Sep 2021 06:28:40 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g1sm45429wmk.2.2021.09.20.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:28:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 4/5] riscv: dts: microchip: drop unused pinctrl-names
Date:   Mon, 20 Sep 2021 15:28:29 +0200
Message-Id: <20210920132830.152802-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
References: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl-names without pinctrl-0 does not have any sense:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v1:
1. Add review.
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 1 +
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..0db64ac7dc33 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -33,6 +33,7 @@ properties:
       - items:
           - enum:
               - issi,is25lp016d
+              - issi,is25wp256
               - micron,mt25qu02g
               - mxicy,mx25r1635f
               - mxicy,mx25u6435f
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 83bc14860960..55d86b078c53 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -267,7 +267,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			max-frequency = <200000000>;
 			status = "disabled";
-- 
2.30.2


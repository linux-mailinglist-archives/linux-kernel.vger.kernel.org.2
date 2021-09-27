Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53014194A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhI0Mwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46132
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234457AbhI0Mwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:32 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFB5940198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747053;
        bh=SyASrYorVTAId0TEMO105U7AUWnylOwqoa8kfxON3jE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vfQ4LX+VFyA8BvK/3NUb+tMI6uNuf0YvCTldR1jv+F4WCudVFBgshsEB77iyMoPAx
         kNgUmH9+m70q90NmIfa8Ud9NVpzFpfJMZ6SNU/5GqV9SV12n59Af4sRn21z5CP2Ohw
         QiFkbXGwLXUXBIMe4pu3gXB9pIx95BO010Mo5RhGaWpIR8K4M9RRRr1zo8nwkuq6EQ
         eMXrq8+usk32w4jBYsnpw5pOTnbvnSn9xQQaVxuzmSI00SRfmq8o4vXoW0f+IBhf6k
         WI7nBdMVL5N9/OOj1P7AzQh4iMVdHIHVowRtkFve3AfkDZlJmXX9+4mMGUndz2BLk9
         DndwNDcLzW+KA==
Received: by mail-lf1-f72.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso15767520lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyASrYorVTAId0TEMO105U7AUWnylOwqoa8kfxON3jE=;
        b=vQbRaOKNgRK9/J/E+u1619YoB+W5Uajq+XUlczAjE5xMW/ZI3vlKer04OtjIZYnChj
         lst02PaB0r0SI1UmHRbmI8/huZwo6aFvd0OUjz2TPIxJJt3CqQIP1VZ3Hmfxtlp+50zr
         G2Mhzn2JHeJrgbrTFqf5iwKanFxL7OLqEjMvfLUGJP/1KMBgZF7kvA4gyvqWBRqTIwcr
         bUNpJCW7aEkL0om6bJLMJ6w58O//R2SZ3tlK/VdDBZ+fRYEB+G4Lk0Z6ofKBBGlA8pXV
         iNbXBMEsfmMyiZi2qjDceuv8U3vFoNKAOcJXSBWn1JzOGInTXVgXWaPxQTyRhsmXhmDY
         UQQg==
X-Gm-Message-State: AOAM531zBXF4mh/3Yvs2yrilXupBF2TXl5aEQ6ZQxPR7lB3Dj6ghqtQp
        twMJ9IiwaMLlz/NQxSFGfGj9Zj9esbIxa4fm/LLIFYe3G8qb6VpfC1NCI5TsltQCx1cThUuPSUH
        ipF41pPgLweZi4SAKr/nbJp3PXz4hFDXt3iocolszjQ==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr29270316ljf.458.1632747052646;
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycBjgE5omkxVTRNXAq3XyHF8zrpabI33eB8OG82RLQU8OwyqzbTmKcsU4pMNaQM29AXA8IbQ==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr29270295ljf.458.1632747052477;
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC node
Date:   Mon, 27 Sep 2021 14:50:42 +0200
Message-Id: <20210927125044.20046-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree source is a description of hardware and hardware has only one
block @20008000 which can be configured either as eMMC or SDHC.  Having
two node for different modes is an obscure, unusual and confusing way to
configure it.  Instead the board file is supposed to customize the block
to its needs, e.g. to SDHC mode.

This fixes dtbs_check warning:
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: $nodename:0: 'sdhc@20008000' does not match '^mmc(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v3:
1. Keep two interrupts.
2. Add comment.

Changes since v1:
1. Move also bus-width, suggested by Geert.
---
 .../microchip/microchip-mpfs-icicle-kit.dts   | 11 ++++++-
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 29 ++-----------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 07f1f3cab686..fc1e5869df1b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -51,8 +51,17 @@ &serial3 {
 	status = "okay";
 };
 
-&sdcard {
+&mmc {
 	status = "okay";
+
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 };
 
 &emac0 {
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 1d04c661bccf..b15e93d1702b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -262,39 +262,14 @@ serial3: serial@20104000 {
 			status = "disabled";
 		};
 
-		emmc: mmc@20008000 {
+		/* Common node entry for emmc/sd */
+		mmc: mmc@20008000 {
 			compatible = "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
 			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
-			bus-width = <4>;
-			cap-mmc-highspeed;
-			mmc-ddr-3_3v;
-			max-frequency = <200000000>;
-			non-removable;
-			no-sd;
-			no-sdio;
-			voltage-ranges = <3300 3300>;
-			status = "disabled";
-		};
-
-		sdcard: sdhc@20008000 {
-			compatible = "cdns,sd4hc";
-			reg = <0x0 0x20008000 0x0 0x1000>;
-			interrupt-parent = <&plic>;
-			interrupts = <88>;
-			pinctrl-names = "default";
-			clocks = <&clkcfg 6>;
-			bus-width = <4>;
-			disable-wp;
-			cap-sd-highspeed;
-			card-detect-delay = <200>;
-			sd-uhs-sdr12;
-			sd-uhs-sdr25;
-			sd-uhs-sdr50;
-			sd-uhs-sdr104;
 			max-frequency = <200000000>;
 			status = "disabled";
 		};
-- 
2.30.2


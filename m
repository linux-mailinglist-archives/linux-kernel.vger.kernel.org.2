Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31C3F7589
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhHYNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:06:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34280
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238451AbhHYNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:06:18 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A54140658
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629896732;
        bh=lrFOqJg8K+1XmVsF/GpvrcRXBvTi8X1Jdxp9tcz+qM4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GABSUjE+Fl/asVQF557BfZJ0qbfYayqHleFpFsCTMi86+dib5w20Y89snZBkmAcRy
         C36TPK4wQC//3n+x3x9jIucrLh0y42DrkT7k+oxz54ocYxpFzou4gswWhb+ZfnxHNy
         7xeNE/oQmkt4RkzcOOyyPhqNK68NdUlWxEaiYjSGozESlT/9wuZlWGh4sKRqUAmwR3
         8Lj3WIWfyd3EfjrbJnCQ1zUcCjoiv4iulEIGwjth4LzkHH7x5SULCqYf/1imBEIlmT
         jhH9y5CmwlJPaubqqN6s8x75v3/N+SQvq4Z85hiwphTLKGxE478yakTlwZ5eQ8PGaA
         t6fIMfv/KPPpA==
Received: by mail-wm1-f72.google.com with SMTP id g3-20020a1c2003000000b002e751c4f439so2809797wmg.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrFOqJg8K+1XmVsF/GpvrcRXBvTi8X1Jdxp9tcz+qM4=;
        b=JNF8ZZXiYysbQ5LB+3i90Y5keNfL/8Xhwc5raVx8UgAJqcDG/G1nchHKVxW52hsjb/
         fAQc9JkLMg7lCr+9kGe6pcs/f095ybv1I/hyqDyPwsNWkJs89GN6i2jmNkzEfmR/7RA3
         GvjB6hrMqsFWHmczczbgZy2ldS9mc8jU5yzycaX50Va6E5l4a4b9ChsEvU2Zq+4PgdYD
         WWDgyxbxpp1DXdVU9OC0eT8AkIxOVeXxMIgy9UQlouNqTl6sGX0fI8moa45DvtzjW3B1
         lMaUUgEDK6Zl2cvBjIeWSpa1MybF077YUGWhLFcP4l67xlquyk7yUf4gxNWrMZf8Kvxn
         e7MA==
X-Gm-Message-State: AOAM530rN+qPnshF1bAyQ9KAAPzPqMz9XUvu7emNIHszAUR5Qr1/QeJD
        48G6Fj/IdrxseJzo1xoORqNANAPZMCvNs8/BbpLwO75kpXqmzWBNCddqpVgrdrBiT8sk1/TzysZ
        DQ2iycK39T6qbi5hKqYvcPTNIo+Xw5eJWInOS3Nflhg==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr9316783wrz.369.1629896732157;
        Wed, 25 Aug 2021 06:05:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyADruAn41uaMoIibr3RD756bAEGF/fXXqaWRQ4x7Vv3pmlISb8rI06kiDTgzghEeX1S6dBhg==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr9316757wrz.369.1629896732021;
        Wed, 25 Aug 2021 06:05:32 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id 11sm5338828wmi.15.2021.08.25.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:05:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
Date:   Wed, 25 Aug 2021 15:04:48 +0200
Message-Id: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible "issi,is25wp256" is undocumented and instead only a
generic jedec,spi-nor should be used (if appropriate).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 +-
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e88ae4b..633b31b6e25c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -63,7 +63,7 @@ &i2c0 {
 &qspi0 {
 	status = "okay";
 	flash@0 {
-		compatible = "issi,is25wp256", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 2e4ea84f27e7..9b0b9b85040e 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -211,7 +211,7 @@ vdd_ldo11: ldo11 {
 &qspi0 {
 	status = "okay";
 	flash@0 {
-		compatible = "issi,is25wp256", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
-- 
2.30.2


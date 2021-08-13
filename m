Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF063EB52D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhHMMUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhHMMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161CC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso20377500pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Di47GUy6tetqqQE22JBysnHPPz3MzJuD8k18pWiqxo=;
        b=aqsbn03KP4nyTGMiqRYZsE+icZTZ1YfCVwlkcBGl4ZBLP9hjo94E5M48vWIzHY4QhO
         7bQ+rHvk9dVAYn2DFQ50HKyyh/EYOUqJEq6XTHkdKZWhgEzhia1/msroAGGIFLo3yAa5
         4vu0R4szjmjcYrDXV9zGzYiSqyX+p3MF3N0Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Di47GUy6tetqqQE22JBysnHPPz3MzJuD8k18pWiqxo=;
        b=NnoPX5XV4tSvXdNWWPYGvSZ71nnGv1JADJ2JZ3+79NpbzjPjcLAaHVYEohUSjGJmwn
         4fbXm0YZx9OpD/tb502y6xp1o0wYQ8JrxE1Y7jqdD8fss8tUSATY/L3TrFqxJPER2zQQ
         P/5hQl5x2UPmTyVgpdLK//xWQ6VWRSbdqhcgXhsjVFb76vLUvjV3P1u9v/6wMI7pzsYj
         uBrK5G05cXkwBJixgy2C8aa2wFkmX3C9GLhukgaHvaWBTrwVp3uv11n0hEBGBYbw8sZi
         qMeDVGzJcYXd3QYdW823n7mJG7fmedeF3kP7jMVxBJldf1u1tJKl/nU5O47nIPoGINJa
         zE+w==
X-Gm-Message-State: AOAM5300+PzV6fafGRHVarPBPDBVplLv5LKXv5xNTMVb96Z6cdL4o604
        0q2OzhlPm1KhoWsCZqQrJNrkIg==
X-Google-Smtp-Source: ABdhPJxFW7YDSIy36xHldQt5PEerBOuZ1Ngvzs2SlQfdRfcIKg3KKXQSl0n5gHTIuEevJmFFIwkJlA==
X-Received: by 2002:a17:90a:5982:: with SMTP id l2mr2425365pji.18.1628857212238;
        Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:5293:be68:a318:ba36])
        by smtp.gmail.com with ESMTPSA id v15sm2181680pff.105.2021.08.13.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kansho Nishida <kansho@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/1] dt-bindings: mediatek: update audio binding documentation
Date:   Fri, 13 Aug 2021 21:19:57 +0900
Message-Id: <20210813211947.1.Iaddd8d9fd3ce70ac40663afb9d6fa5b76ef0c38a@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813121957.3089816-1-kansho@chromium.org>
References: <20210813121957.3089816-1-kansho@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates audio binding documentation.
And change audio node names in dts files in the same manner.

Signed-off-by: Kansho Nishida <kansho@chromium.org>
---

 .../devicetree/bindings/arm/mediatek/mediatek,audsys.txt      | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                      | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 699776be1dd3..409a425cbdd3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -28,12 +28,12 @@ For common binding part and usage, refer to
 
 Example:
 
-	audsys: clock-controller@11220000 {
+	audsys: audio-controller@11220000 {
 		compatible = "mediatek,mt7622-audsys", "syscon";
 		reg = <0 0x11220000 0 0x2000>;
 		#clock-cells = <1>;
 
-		afe: audio-controller {
+		afe: mt7622-audio {
 			...
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 890a942ec608..a54c9cc2063d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -590,12 +590,12 @@ uart4: serial@11019000 {
 		status = "disabled";
 	};
 
-	audsys: clock-controller@11220000 {
+	audsys: audio-controller@11220000 {
 		compatible = "mediatek,mt7622-audsys", "syscon";
 		reg = <0 0x11220000 0 0x2000>;
 		#clock-cells = <1>;
 
-		afe: audio-controller {
+		afe: mt7622-audio {
 			compatible = "mediatek,mt7622-audio";
 			interrupts =  <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
 				      <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9ea4c5001b1e..189e3545226e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1119,7 +1119,7 @@ audiosys: audio-controller@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
 			#clock-cells = <1>;
-			afe: mt8183-afe-pcm {
+			afe: mt8183-audio {
 				compatible = "mediatek,mt8183-audio";
 				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
 				resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
-- 
2.33.0.rc1.237.g0d66db33f3-goog


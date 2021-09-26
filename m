Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BA441871F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 09:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhIZHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhIZHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 03:23:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367EC061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:22:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k24so14578075pgh.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rgzg8J8HaCNFTJCTGijijfBBizgKVxNjDBbx5SerjSo=;
        b=h78cLKrUR6Fb/xtNUx6PCdVVKnn5W7uMJStZi70Y9JENKFlY26/2ixdCW5EK3FgMm1
         KbvNnwhitCaOwyQiieKP12ooNHwi8nV3SeNwX1Hib4Al3UXf1o7mB509hC3mHB5QlGm/
         fhXMq53cu+7DPXm0BYYwL0okd6DiV6AYiny4WbSOy3am++uT26rZKvzdQVLcxz5zGbkE
         Ulg+sTJyOyCLcK5d9DMAStm8LJP4/PJanmqSHrFsEU3L5oknkI+MMaah1u7qGdnRT3wY
         ibCnC9pEUUJIleFWTs8lOVQVfehm6K5vT5GX2iRnxRx2ZQUn99Bp49ZHs5rIjr3YYDmJ
         0Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rgzg8J8HaCNFTJCTGijijfBBizgKVxNjDBbx5SerjSo=;
        b=wB6Fe3V1SaAXq6HqFry6+3H42aky+iWnrW13zY7jwiuY5TiPKALGNkmdaDEKK+MyNH
         mc/zwk2+97qjoiwptzh+jkBaTrVrcQ/MlzessbAoLqbCgOoiEvdlA/sZNZ9d7l86bVCl
         zkvz8F0UJP3YYCHTf8OXm6JqVc3QV/uOmMGf9adfsezSOMwLYIa2TFCEJlGZfadHHJrE
         /R7upPT+orE99pkR/bJkh702qSZLg5BbFNjmjCt8XplH8oyz8m/8OCxSmGya9FaS7R2r
         oZj2gf9hm3itrxCB9yjs4LaUvKmKU4r1H4G4cb+BVxCzgn25lY5G/N1zRlTf1MDYgmrS
         Qo6A==
X-Gm-Message-State: AOAM531oWnuwcjWXprWLIpYaavTe+govvbB59UPwtzxSRM497J8geQg/
        HZ+xsKGfPZm51hsBkS17E17CjA==
X-Google-Smtp-Source: ABdhPJxJPbYclGRZxLMxE8I0Lz/Tqb8XX7PcHF2w9ObUbbmB7upkWAO18lmwCdPWkqYAYOL2Zc/y8w==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr11397356pgk.334.1632640942653;
        Sun, 26 Sep 2021 00:22:22 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p13sm13359704pff.73.2021.09.26.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:22:22 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm630-nile: Correct regulator label name
Date:   Sun, 26 Sep 2021 15:22:15 +0800
Message-Id: <20210926072215.27517-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.5V (29p5) is obviously wrong for regulator l4 and l5.  Correct them
to be 2.95V (2p95).  No functional change.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 849900e8b80e..11d0a8c1cf35 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -308,7 +308,7 @@
 			regulator-allow-set-load;
 		};
 
-		vreg_l4b_29p5: l4 {
+		vreg_l4b_2p95: l4 {
 			regulator-min-microvolt = <2944000>;
 			regulator-max-microvolt = <2952000>;
 			regulator-enable-ramp-delay = <250>;
@@ -327,7 +327,7 @@
 		 * Tighten the range to 1.8-3.328 (closest to 3.3) to
 		 * make the mmc driver happy.
 		 */
-		vreg_l5b_29p5: l5 {
+		vreg_l5b_2p95: l5 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3328000>;
 			regulator-enable-ramp-delay = <250>;
@@ -559,14 +559,14 @@
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
 
-	vmmc-supply = <&vreg_l4b_29p5>;
+	vmmc-supply = <&vreg_l4b_2p95>;
 	vqmmc-supply = <&vreg_l8a_1p8>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
-	vmmc-supply = <&vreg_l5b_29p5>;
+	vmmc-supply = <&vreg_l5b_2p95>;
 	vqmmc-supply = <&vreg_l2b_2p95>;
 };
 
-- 
2.17.1


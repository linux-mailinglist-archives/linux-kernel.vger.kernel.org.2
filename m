Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4557B3BC7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGFIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhGFIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:38:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C75C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:35:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1086601wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U29Y6gKeEJ/TOx94H/sMKCVR9hUDyqP/L3iEJdAYqrs=;
        b=CVRjvDnphK8OIOr+WSbxlBLysMoOQmGuvVzSNiA5YpA8aulbXuqSVbxSkKbGIRpzsp
         CNToQ+8lo0wfmYDz/amG0/MENZU/jjJW3QOst3+6s3Etu/A/KXLCFAiQ0P9SPLb/Wo2I
         pGxpEIiujVVLF5WlxRza3BVPsy0NOewsratezVzPprOGTHmazPp4CP25ACyduwsRgYEn
         ikrn7oU7VeLTBD/xgQrcxzUdjyQJ0oTdyqoCBG14AZ6xPUjx0te0Za5dxUdUNJd1bizu
         GrNa3kwits5aTEgz1jTl5haUGWKuIiOVkOZvfhDENXLK7mhIxFGZ5EgqYMo6htRbQ4as
         fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U29Y6gKeEJ/TOx94H/sMKCVR9hUDyqP/L3iEJdAYqrs=;
        b=SU2TnIeASbMSL5zyc6m0AoL6xt1KAcODi6VXmXxEfkumkjkKPMSYP59YW7FfoM2+Ls
         YuWVWSEzIMgca0cIwHT2wlKPg+jy23+69Iy4se07EOjM/jQpFRCtxSTEsLEChV2y+RbM
         8KQ73zmlqgeqfocHG/tJXSwRdj3Rt+56bXWrJwZTmpWBSTounf42t2XpFu6ClP//dqAw
         LW26AJAUKkhnUqEMBvgCqA6N73ZKgw0+rp9fqoWSMSWsrs6nsYlZki5oyjT0RBsR+hyF
         BUgtsVIn3gIFhjFTyYJqJ6cSyCasQ5uSccoxKI0+QAsS8zo+gp2q7QCnaE/tx8KwEfyk
         /+DA==
X-Gm-Message-State: AOAM532kX8sabDaqTVQGm6FmaKPSTMzKGJs2yoXzT8DzubbZQBtEn+vE
        dpV3koWI3xp9+o7a8QwV2ia77w==
X-Google-Smtp-Source: ABdhPJxEEOBF97iGp273zrFwZLYeKJjeHZ05+Y4nRIhToCETllcGM0uusreYOQChi7yXJghwHWM+EQ==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr19925721wmj.119.1625560527911;
        Tue, 06 Jul 2021 01:35:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r13sm5451111wrt.38.2021.07.06.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:35:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] arm64: dts: qcom: c630: fix correct powerdown pin for WSA881x
Date:   Tue,  6 Jul 2021 09:35:23 +0100
Message-Id: <20210706083523.10601-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x powerdown pin is connected to GPIO1, GPIO2 not GPIO2 and GPIO3,
so correct this. This was working so far due to a shift bug in gpio driver,
however once that is fixed this will stop working, so fix this!

For some reason we forgot to add this dts change in last merge cycle so
currently audio is broken in 5.13 as the gpio driver fix already landed
in 5.13.

Reported-by: Shawn Guo <shawnguo@kernel.org>
Fixes: 45021d35fcb2 ("arm64: dts: qcom: c630: Enable audio support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 140db2d5ba31..cf01d3f2ed8a 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -698,7 +698,7 @@
 		left_spkr: wsa8810-left{
 			compatible = "sdw10217211000";
 			reg = <0 3>;
-			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
+			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
 			#thermal-sensor-cells = <0>;
 			sound-name-prefix = "SpkrLeft";
 			#sound-dai-cells = <0>;
@@ -706,7 +706,7 @@
 
 		right_spkr: wsa8810-right{
 			compatible = "sdw10217211000";
-			powerdown-gpios = <&wcdgpio 3 GPIO_ACTIVE_HIGH>;
+			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
 			reg = <0 4>;
 			#thermal-sensor-cells = <0>;
 			sound-name-prefix = "SpkrRight";
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657A5319337
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBKTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhBKThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:37:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CEC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:36:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b3so5344709wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0oJrlLa1XWix8J18XAZ23nQzXA4EZb1A3RY1JzHR5A=;
        b=wdMZ42DQqD7GenhjCm2sSpLmUB3FNGnp0Vb8PP9wcuaFQEbgjc653pIS7L5OamomWq
         xzytTTWnQomw4i5StbKFfdyU/b23hdiAtH8gN6JnRgVm0m4P9nSkxxJWpVKVFu1PGIej
         BsjQncIVFYMt/Pouk3uzBFl6/ikvPGPBHcTV8mW5oPNVpaJpf9pLBrBBrX4A4q2pWcgt
         C5DttvZwbFg8+0CHPJP0jIwhAYuQxlJaTM7aX3OG67gy1Xmy2a+iDu1Q13dGMymuDuWo
         p/uBFbcpmxH4fM1BF6tDTV9lWC8LWjHKmDy63uJHnLz31pYcuaopmVgCV0NGkbgN5OMb
         o3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0oJrlLa1XWix8J18XAZ23nQzXA4EZb1A3RY1JzHR5A=;
        b=Un+uDGD9KEa2QaiVB97Fj9HRnPHX3/VeJRHG+gnfRMiwi5AIZ81FLABOGOn/lqbWIG
         aeGD1C5rTgi+MM50UlRn42Am67wBdToYaGQ7XhzEh1ec51RKNwZZCKelEumIaJGDM6mk
         nR4bS4W/1xIZeAhlYmdkiJjDR3JYLYpusGN0EAUxLsfTlchCzgCHdYnTk7H6FkzJnsWu
         oh22MRTYI4uPZBrhCVj+jq/IIi0hnHfkSe6/LVHeTBjpDS6OgfPTzcn4NUftiUP0xja4
         hk62Eb515E5UckL/aF/oNfIOwp+Rq2mOa0H8QRjoKI1YSU/Zbajjx3RMi62WyD/c3cpi
         dQzw==
X-Gm-Message-State: AOAM5329Zn0fQKDP1HZ6o3A/cSgde1gUurl+jongisD2zYSny6uUPZFL
        vBwJFw7qdknBJ4fe8y7AHa2X5w==
X-Google-Smtp-Source: ABdhPJwAwFnT4K2bDQJyIX0+wceKSRYQFPASVcjdOZDRI7g5WqoHA+9e7yYMRk/DT7Sp0zz+1ktu8Q==
X-Received: by 2002:adf:9226:: with SMTP id 35mr7232631wrj.408.1613072199441;
        Thu, 11 Feb 2021 11:36:39 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j23sm8788649wmo.18.2021.02.11.11.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 11:36:38 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     sibis@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] arm64: dts: qcom: sm8250: Fix epss_l3 unit address
Date:   Thu, 11 Feb 2021 21:36:37 +0200
Message-Id: <20210211193637.9737-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit address of the epss_l3 node is incorrect and does not match
the address of its "reg" property. Let's fix it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 947e1accae3a..80fe1cfe8271 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3721,7 +3721,7 @@ apps_bcm_voter: bcm_voter {
 			};
 		};
 
-		epss_l3: interconnect@18591000 {
+		epss_l3: interconnect@18590000 {
 			compatible = "qcom,sm8250-epss-l3";
 			reg = <0 0x18590000 0 0x1000>;
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9F44BF67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhKJLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhKJLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:02:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8CBC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:59:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t21so2673269plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmXHtUph5kI3A4THoshYaiB9SXE1WqSgPuWSYTceQ14=;
        b=XMGVuBzJ9Ua636COgZ7s+PAk3M23S6fAVhvJYTfxGzerPvlwM1qTsepNn8Fq4x+Y6l
         KDt/KPHMyXLN1S/Jnp9dgOm4t9KBrO+iqImjtjru4DILZdMpWzuTe/6zlOU5xA47lMpi
         me77Ax88fBqKXc9QIgb3zXEnUKJUQH+EwcbAqz6iQ9A3MYMCa3hCiw94u7G7cLB5LRm9
         UJNuznl09pdVaCuxNwWljMrhaav1Jj7QotTO9e8Vej/L4TrbyjNj9Azg0zlkztjbzbN+
         ARNq4RjsGN/AR5VMvVHAlcr5yNqbdv3Idq1GGoKd9MFWRxO0f5rNa9ZpvF9TvRyxhYbY
         albg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmXHtUph5kI3A4THoshYaiB9SXE1WqSgPuWSYTceQ14=;
        b=XTXL4xqtoa8YDUl24PRH23QHwmjOzvlD8F+QCHeerY7XZUP40EUYuNoQMoNv4JkQ0L
         KONyFLv0hH8JzbQlo5dIVQ1V0nLDE51AUDNCjKdH/IzBCdnAZiOJ7TU6djAfwkb65EWh
         UKdeKHALBTa37JkEtruSVKPaCFVm6aTIO4boSQSxyNugFUg4/88CKvZMmgaDBBJqFiDa
         rVcJdI9QWHlCORlMxCSrVW0JFB+Tc/3xy+/ncJ6gq3z3ca2jk8jtMubQD3P7AArbMfR5
         jPdS7RleJ+S7IG5SpIpvVg+wJ1VGljEUicvVR02f6PNovHGwV+8jzeYcU/wvAgIKAgxh
         6SJQ==
X-Gm-Message-State: AOAM530epxfSeTPWkSygzAFu+O24924LUVlkuWL+N9lWIgYD0/Cq016z
        zD/KeuSDPPPZHnQP2907zP5yEg==
X-Google-Smtp-Source: ABdhPJy4ts8w7Xkiy9SPbaVv/tdNYX5gLSvj68Q0W/rZCt0biWFoqI2+HODRQOYEkFQFNXDuG/+AFA==
X-Received: by 2002:a17:902:8505:b0:142:892d:918 with SMTP id bj5-20020a170902850500b00142892d0918mr14860752plb.39.1636541991083;
        Wed, 10 Nov 2021 02:59:51 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 02:59:50 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 02/22] arm64: dts: qcom: msm8996: Fix 'dma' nodes in dts
Date:   Wed, 10 Nov 2021 16:29:02 +0530
Message-Id: <20211110105922.217895-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory patch for subsequent patch in this series which
converts the qcom_bam_dma device-tree binding into YAML format.

Correct dma-controller node inside msm8996 dts, which
leads to following errors with 'make dtbs_check':

     dma@164400: $nodename:0: 'dma@164400' does not match
     '^dma-controller(@.*)?$'

Fix the same.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 27683d7fdfe6..508cd9d06350 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -705,7 +705,7 @@ tsens1: thermal-sensor@4ad000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		cryptobam: dma@644000 {
+		cryptobam: dma-controller@644000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00644000 0x24000>;
 			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.31.1


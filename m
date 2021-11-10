Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8844BFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhKJLFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhKJLFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:05:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39324C06120A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1337491pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsJUSeawRggU7HvC1GGQkny+erynvmNA844erz8yhy4=;
        b=OyyzqvHEGotpRlMylxG78FbvLVcDXUkQRB9SZR2k3eQPQ6grpX3VL05W0fngsblcif
         mFKJMzJt3T3SGWco6pXk7UOsCfYx8193kD5pyUN+bRj5S3BJbJAFw1z56sNPQhvxcS+M
         bDpMr877A1sPN45e4frzLakQHBWZWm7pIzNOXlZsowU5vG8ZHhj8q6UzZ0GuZ4KTD/Pb
         nFBMFLA1FCdNkgS70sGl+kOPcYjbair6Hhn8GzkE4+In8y7nVXUV6TeVLi89IFfhpthR
         SkQ6mqZ7uWjbcHs0BIOtlLj3OllyKOWgjSI5Ek8RpdXQqRMd1mCJtWYvh+8WNCaMiXV4
         w+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsJUSeawRggU7HvC1GGQkny+erynvmNA844erz8yhy4=;
        b=M4Rbvd/Xl5A/JdBnWuwBcWWlVE6qLzS3ixYYlkjEcKgc9YQRaIFLBvwGMuslVw9O0U
         iOsWEbvj8/bI7dkZ2DVO+ZE8ht9031GbIRg08c7YuRw/YjskOtHeKXyQU99lMweRHsTn
         BNnpv7X7F35Ja6LwkO8sod0rdNtti4q7iVhFY3IGRhm6eR+lTPWXHlolU3ILzauJgeNW
         BTfJNtKZW2l94Toah7yFp//ojdTEzqsfwKaghm30diPwa+wfW2jCAct7qhpHYdcrtibb
         LZ+IJsoJ38xg9DRNEtiJ/q3P0jabcyz1SYe1fKMqe0Q+ZSqxEqrEWVSmCAaHUMth+yQJ
         TTpw==
X-Gm-Message-State: AOAM530ecrtodyAPZqyZlJ00ehQhoFzZ97dAmb9bDS+SnBYedGrPt1xm
        Qlyj8jWNQ3rw2GvV2pL5d2iQDQ==
X-Google-Smtp-Source: ABdhPJy7vzX+EY24OxB4TyLtpk5RbdKef/4eabLR0cRiecJSxnS2mbbv6xg1MFUEyNQZdrgavNUJNA==
X-Received: by 2002:a17:90a:bb84:: with SMTP id v4mr16003228pjr.4.1636542087735;
        Wed, 10 Nov 2021 03:01:27 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:01:27 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 21/22] arm64/dts: qcom: sm8250: Add dt entries to support crypto engine.
Date:   Wed, 10 Nov 2021 16:29:21 +0530
Message-Id: <20211110105922.217895-22-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
"sm8250.dtsi".

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6f6129b39c9c..691c28066cec 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4104,6 +4104,34 @@ cpufreq_hw: cpufreq@18591000 {
 
 			#freq-domain-cells = <1>;
 		};
+
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
 	};
 
 	timer {
-- 
2.31.1


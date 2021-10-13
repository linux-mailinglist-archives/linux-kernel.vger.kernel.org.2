Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4828742BE07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhJMK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhJMK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:58:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334EC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so1536572pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRXyuG4K4UcrJ1NjhumTmbpE2063xuupe5W8qPOe4Yw=;
        b=v48ZoqGZB7XBFy4q3wSP+rpZ4GvKK73lK9ne2goyM63IJhmVaW5O+PoWh7UvL/I0KF
         B/omhA9z9YSDHUDu9EgRKqapA+FW9CNquP/e/jP4UzDiEM+pNTbxvlcfh81uVJMyXuSD
         SkcPYHLqv4TZDCgfVWQbxsddBJaqZZe3Q4HMM92J8rMn/j6k3pBZAKREGSyU3ho9zES0
         G1Tzh47VXyZpu7Sw+vsvfjDudRSo19tdatCXJ65NuQ3rTXIevmofT9i9cWaRqyEmYUPF
         Fs0pBL7u3wfYkH1fHRD2ImyOb6zybW+SiEMQUD+SdeSofu/hU3YgvxJ7HYKj97kpuwhZ
         iuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRXyuG4K4UcrJ1NjhumTmbpE2063xuupe5W8qPOe4Yw=;
        b=mCJ5Foc1lBHDRP160VeIMRc8jFct+7xsuo4c86NJViMKrLZY5gN/BiNZrimBVh4Jb1
         V7PpsYTBVxnw6sCgFZAq9fdkddFAE669LQbsTIfMHLgS/yMiDv6Olg5n8GqHVQy9qfd0
         9UfoZ6z+Ja1UNU7swqnYqElf5FfRzay4jwLgLuj/THig27Dlpswi1sXmtknNzUQFtEIh
         JvdI2V10cdeza58Cu7lT4ardE0LGm4zjDNQVMSCIWDI2+vG7f16y6sfOhBL1AlWduhUU
         o7bOiOPAN69Zbpp0Jx6XdI91cdLgVnZEzQVYVL/KWevrkn/tQiW+meN/qL+LA1jVqxaL
         5RLg==
X-Gm-Message-State: AOAM530bd9RmF2xXfu7fnqIZh/VV778a2GAUk+EhFdKjxd5i29AsPXrW
        eF9ebrt4fJ9qazEcLuSg3QbZ1w==
X-Google-Smtp-Source: ABdhPJxmJGsHbblFvtmcLLVBxQ5sWiyEypF+LZjUgEWQKbSz5GPyxK01w4yn2G1a1clXidIKtRMpGg==
X-Received: by 2002:a17:90a:1504:: with SMTP id l4mr12586375pja.181.1634122561455;
        Wed, 13 Oct 2021 03:56:01 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:56:01 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 01/20] arm64/dts: qcom: Fix 'dma' & 'qcom,controlled-remotely' nodes in dts
Date:   Wed, 13 Oct 2021 16:25:22 +0530
Message-Id: <20211013105541.68045-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory patch for subsequent patch in this series which
converts the qcom_bam_dma device-tree binding into YAML format.

A few qcom device-tree files define dma-controller nodes
with non-standard 'node names' and also set
the bool property 'qcom,controlled-remotely' incorrectly, which
leads to following errors with 'make dtbs_check':

 $ arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml:
     dma@1dc4000: $nodename:0: 'dma@1dc4000' does not match
     '^dma-controller(@.*)?$'

 $ arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml:
     dma@1dc4000: qcom,controlled-remotely: 'oneOf' conditional
     failed, one must be fixed:
	[[1]] is not of type 'boolean'
	True was expected
	[[1]] is not of type 'null'

Fix the same.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index d2fe58e0eb7a..7b6205c180df 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -200,7 +200,7 @@ cryptobam: dma-controller@704000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,controlled-remotely = <1>;
+			qcom,controlled-remotely;
 			qcom,config-pipe-trust-reg = <0>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index db333001df4d..99668e84953e 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -212,7 +212,7 @@ prng: rng@e3000 {
 			status = "disabled";
 		};
 
-		cryptobam: dma@704000 {
+		cryptobam: dma-controller@704000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00704000 0x20000>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
@@ -220,7 +220,7 @@ cryptobam: dma@704000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,controlled-remotely = <1>;
+			qcom,controlled-remotely;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 52df22ab3f6a..390468e1b62e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2686,7 +2686,7 @@ sdhc2: sdhci@74a4900 {
 			status = "disabled";
 		 };
 
-		blsp1_dma: dma@7544000 {
+		blsp1_dma: dma-controller@7544000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07544000 0x2b000>;
 			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
@@ -2743,7 +2743,7 @@ blsp1_i2c3: i2c@7577000 {
 			status = "disabled";
 		};
 
-		blsp2_dma: dma@7584000 {
+		blsp2_dma: dma-controller@7584000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07584000 0x2b000>;
 			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 34039b5c8017..a46838f1e310 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2187,7 +2187,7 @@ blsp1_i2c6: i2c@c17a000 {
 			#size-cells = <0>;
 		};
 
-		blsp2_dma: dma@c184000 {
+		blsp2_dma: dma-controller@c184000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0c184000 0x25000>;
 			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b3b911926184..72ec48c4e03c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2312,7 +2312,7 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 			};
 		};
 
-		cryptobam: dma@1dc4000 {
+		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0 0x01dc4000 0 0x24000>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
@@ -2320,7 +2320,7 @@ cryptobam: dma@1dc4000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
-			qcom,controlled-remotely = <1>;
+			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x704 0x1>,
 				 <&apps_smmu 0x706 0x1>,
 				 <&apps_smmu 0x714 0x1>,
-- 
2.31.1


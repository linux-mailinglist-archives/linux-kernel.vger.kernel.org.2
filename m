Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D944BFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhKJLFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhKJLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:05:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A737C06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x131so2303163pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxo26PM+v+FavVwWJDiflViEe+y1rULkr8xHn7NoreQ=;
        b=zhftXFPYnO12H4n30/cgoywIiLqysx+A7rPrWK22HI7wvhzbJwGLfp2YaFIpdBKxZ2
         C2uHrfQ7YgTL+K6kIkFJigdyw9jy0vE5FwcIWmfEde4bswYdI40yrRBaxRprUOmjKrwv
         zSlF/X1iO+sJ0SBudjcl7j9ud4HCBdOvjeOJl+cnHrzWMidplmYiEs6KPsUBYgUBbeOv
         7y4uVSUUnRsDh42AVPrB+5cnc5lTxjBURJ2jJv0poNUmsPyOjTjLPi+2Gn0pgdRwXcVU
         XsV6RwYTs1SHUlm0GNWE744r1IgXycmFobSd/alnPxDfZQiTq/haljbfWNGu1vSxF1B4
         iCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxo26PM+v+FavVwWJDiflViEe+y1rULkr8xHn7NoreQ=;
        b=IMRwF0iGZghqJJ0RugBeWJ3RVm9pwn0WhZ6GOgk3iYfZQyJfrww21WaPBLs6F6PRPt
         CautqCe9LJNA6UBhGkXNbL4qwW+MqRE1nIUkrsYrFo0Ka9COY4pNibPiTyD7PwONOYQf
         0YQosCh0siFG8J3REU4IkiuZbdNEABiU8vnSNPz3Rbxqb3fjmlcDq4IP6gLDb34YM6td
         PiRcpbptBhaaiXo9VFsjuU8pqFjuZqJDEjv10rPRVN+0AFVMM2PjmvU8X3lggagGkgru
         c0QIh18Rigb04RllLynxw0hDv6lxSs0CYRFDc5wZno6LgRUcnlxzzXoKqWbAWDT2I/Qp
         w3BA==
X-Gm-Message-State: AOAM5311yENZRt/8fxN21dp/L0P1FKfKimn+rfN8iWt9/gxG4AvjdJas
        nQJrF3McEIRm4lwRrJndYFSoqg==
X-Google-Smtp-Source: ABdhPJwfrC9ZDNHn68Fi6Mn1jXishCHGAfMAf6ZHJ5MivI8p6rLke2bsknx/eSpwXFD+wj09yjYriw==
X-Received: by 2002:a05:6a00:168c:b0:44c:dc5a:7ee0 with SMTP id k12-20020a056a00168c00b0044cdc5a7ee0mr15974796pfc.40.1636542092668;
        Wed, 10 Nov 2021 03:01:32 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:01:32 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 22/22] arm64/dts: qcom: sm8150: Add dt entries to support crypto engine.
Date:   Wed, 10 Nov 2021 16:29:22 +0530
Message-Id: <20211110105922.217895-23-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
"sm8150.dtsi".

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..2af74a11da69 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3672,6 +3672,34 @@ wifi: wifi@18800000 {
 			iommus = <&apps_smmu 0x0640 0x1>;
 			status = "disabled";
 		};
+
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8150-qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
 	};
 
 	timer {
-- 
2.31.1


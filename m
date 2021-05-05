Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9629374A63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhEEVjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhEEVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:39:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA66C06138C
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:38:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so3212965pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDeLoqy+m6bioGGQ0GfxGS6rwvI3pr4vU0sm5fTC/IA=;
        b=qU2J7GvV3eAL4wLd/SslzfLclw4OQWRXaaOn2oJuuJOTfEuHByToqlwWZgjrT8Za1Z
         gpuQXrS9tu9tK5heE1Z8YbakxvmJnll/C8sZhWxS7UuBLIFPDNy8HpRWv/NAU2EqgHJV
         3cASXjEhUTTIzXvooQEzNh3vbfjZTqV482XIKUXGmlew3biLw1iY+amm4yv0KjQutK42
         yv3IZcTxfb7m6GArlV1pGspfzskTrJ4rdMKYCOkqzmhQsJJucxUcVEYCbvqY7eUguXrl
         3tK5XB9Urlfa7jJNi6ZMmn1P8NxFqbMXaeX78op+4dwtgXmdkadx1IWjJA84lSaRLw0T
         h7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDeLoqy+m6bioGGQ0GfxGS6rwvI3pr4vU0sm5fTC/IA=;
        b=J3g85oih3ts3h5+Qcoptc4D7zUIWx+uvxaaGZ79vFbANxENJqcG0jOz/6MpJxJEesG
         CKr7Ch7cxH6+P5eiiQmBRsKosYQ+3slO90AmUGTre12/BGOm6ZmfokW/AkhWAsLVWAZ+
         4nT/H0izoao7NQW+zHCW0/2NH8XODqtAKkt0e+43W3zI2icwRZaw6t2wN2/6oFiO1/XJ
         pSHlIg8n8JQnuEAZarpiAFXXRj9zWSe3BCeihYkFCGTSP57sR6a1kBRpSNqTV+VousHv
         c1HUI1mgDKV3Il/IRvBoF6JH/Qi4J71GM3YCviCvqzS3N3oaxPp74BMDvq/dLAzkirHV
         iUfA==
X-Gm-Message-State: AOAM5316oiH/f80X5wooWcCJxLp0oiZUogGjXZk74IXoQwSVqemADc9s
        UElRNb81xXNO5JJEirwjYwsWoA==
X-Google-Smtp-Source: ABdhPJyWPlU8fw5IDWX70/6t1JZhWToow81MBf2PDhVcjmJ80nixg6lDZgAW1mX00TAt4OOq+latXA==
X-Received: by 2002:a63:eb10:: with SMTP id t16mr914422pgh.393.1620250710621;
        Wed, 05 May 2021 14:38:30 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:30 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v2 05/17] arm64/dts: qcom: sdm845: Use RPMH_CE_CLK macro directly
Date:   Thu,  6 May 2021 03:07:19 +0530
Message-Id: <20210505213731.538612-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 3e482859f1ef ("dts: qcom: sdm845: Add dt entries
to support crypto engine."), we decided to use the value indicated
by constant RPMH_CE_CLK rather than using it directly.

Now that the same RPMH clock value might be used for other
SoCs (in addition to sdm845), let's use the constant
RPMH_CE_CLK to make sure that this dtsi is compatible with the
other qcom ones.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..2ec4be930fd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2316,7 +2316,7 @@ cryptobam: dma@1dc4000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0 0x01dc4000 0 0x24000>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rpmhcc 15>;
+			clocks = <&rpmhcc RPMH_CE_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
@@ -2332,7 +2332,7 @@ crypto: crypto@1dfa000 {
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AHB_CLK>,
-				 <&rpmhcc 15>;
+				 <&rpmhcc RPMH_CE_CLK>;
 			clock-names = "iface", "bus", "core";
 			dmas = <&cryptobam 6>, <&cryptobam 7>;
 			dma-names = "rx", "tx";
-- 
2.30.2


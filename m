Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CCA45E83E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359192AbhKZHMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359053AbhKZHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:10:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A086C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7387446pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S41K82TlyzNl7CcaiiH+u/JaFxF407OUxi3K6nruXfc=;
        b=Uov4MAOiZoH9n71UibBfiL0PLknrKMUEVLcZTqF5+4B54tzM5BJHoWjZB0MoDsPXBr
         n5Gbw9YHVI9CQq/St/ZMpfibv9sRkI04VqfRgY8JGVirGhsv1vKmlefT+AR5BZAV4kQW
         7Wbxdt8yejpNzNYv0v+1UjgW7mjzNIk+QxTmxSKTaMExIVJXj4/tDpfiAJz3jTjYneRA
         oNNOUm0FEDbR1R0un0UE7cAZpDMmHaUI8SEiF1aN8gc9u+SHXss2tOB32+ZZBzQtzvGT
         vOTeklKYQ2sTjJSXoRiSy65eNjsuXkDjSQYbfU9hT2cfOJpKsKkY52wpG4tGE6c9t+T3
         K3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S41K82TlyzNl7CcaiiH+u/JaFxF407OUxi3K6nruXfc=;
        b=kv7ci9K7iU4oajR2O2kOD/h0XBNpIuE7/YIhpA9aNMY3Xsk+8sPyK51fB37jKgO08F
         qrJ533BjZ5NmQ14EY3XKqDIQ12GXvvDuOovhKScUnGM7axQZeqQ3IdizYQEXot2zKcYx
         3GB8a8O1Y2EclcecQJdwPYU7I96Pf3ejK18sRHo1me8AylJb+22TXKxt4GVoElPzoSiY
         kA1MUOzyXGE5M4jDml1FVbXQrnci87XwQ9NVJohQXzoRcPxm+UNKiq+/y0j/OlkaeX2E
         bdMvVCN40jUuSc/Hawt7Ym+Hu5Zk+oHtkh8a3QPxa7cnB8llBhqvAN1k1zcdsDF1njWZ
         p5sw==
X-Gm-Message-State: AOAM531roEaIlkiJqHMEHuqDRm1YnJV7sfJEKjfsRrnEbCzmVU2zbnNu
        mYIyqjzC/9rJd2vLpjMzhDbP
X-Google-Smtp-Source: ABdhPJzlUwFRFdxVEaPxyaiEw8xBo2gwPzIa/WiIEgIZqRZporwRCkVKYaDV+Rv9FKUrnEwYU1vvfw==
X-Received: by 2002:a17:902:e74e:b0:142:fa5:49f1 with SMTP id p14-20020a170902e74e00b001420fa549f1mr36045659plf.84.1637910332593;
        Thu, 25 Nov 2021 23:05:32 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/6] ARM: dts: qcom: sdx55-fn980: Enable PCIE0 PHY
Date:   Fri, 26 Nov 2021 12:35:16 +0530
Message-Id: <20211126070520.28979-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIE0 PHY on Telit FN980 TLB for PCIE EP.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index 80c40da79604..e8b5327afbe7 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -236,6 +236,13 @@ &blsp1_uart3 {
 	status = "ok";
 };
 
+&pcie0_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
+	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
+};
+
 &qpic_bam {
 	status = "ok";
 };
-- 
2.25.1


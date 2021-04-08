Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92E4358ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhDHRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhDHRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB76C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m11so2281562pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIgU/OjhUT9TbTsGyinKnrhgMtWW6SgsB8GT9Tt1KRM=;
        b=PbyAMzlCjYcY7U5BOOwD95ruqMi6k3Segi7l9PgfvcDDZMx4/Gaa0VRjHFjs+fbhIW
         oDlEVTJf89TEzkyBgTh5MYlNuRYcK33Cv4Jt63J1G0qD3OlJ6eI60taGGgLiclbT1MuH
         2edwo1yD4fdarxF4U+V3CjE7XIIHN28Roo13/Hn3Drc9ovvPuOHOrdjPRTYBHdRtDkDP
         gJPwN18b6tBufToqLokPKf5lxJaJVYZ0iRaf6W/wfn3A4GjE4woSr10TNkOwmjvnDdDM
         hdMItYPqWYCQDmlpYsf64e4aabS2b8/ZRvS7XWEQRgFshI4vnJ0EC9VANnVUrO2ddOsZ
         I+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIgU/OjhUT9TbTsGyinKnrhgMtWW6SgsB8GT9Tt1KRM=;
        b=AnRZbryfOUMHhpqUkEFC0kxoniCmed3Oazj9NCPvy4juRID0alqdfGYq1mAnlba/qi
         /Em0rhutthCyYW67S7FjqDcDOfbguSbhQewCa0G8nN/4myTjmyAszD28pcxNWCE097KL
         7K/YbWGmN3S8MQbc8g1RxUENGRY3bYJQlI/m9YTQYr5pzIt2P4YTiGMhYIj9xN9exucH
         EFGNJv2886Fu7UJXpZBdCmD4mwKfRlhA87vU0LMPIUjRYvp4hrtsSIkNKRrsjOpXIfJI
         2/+c3K7sBxupWu48NDAvM2ox1rRKWKN31awFPNq7oIxvOq4mJMt+suS6FNbvjZyn4n9Y
         EOmg==
X-Gm-Message-State: AOAM530Exmjy8Q7MEfAMDFt40jo7qcGONB9+Ebs9/5L2SvoECyKOGcVT
        3g7cBrt7Cu1VITfIy5jG3D6B
X-Google-Smtp-Source: ABdhPJx8IBDpeSJ1r0ZIvj4lTY3SkB6/L31LQMXsPI1wm9Cy/4z3qTX4qbeMcEwTy0nJA1EgGDFM4Q==
X-Received: by 2002:aa7:962f:0:b029:244:8f8f:4734 with SMTP id r15-20020aa7962f0000b02902448f8f4734mr3544723pfg.49.1617901531470;
        Thu, 08 Apr 2021 10:05:31 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/15] ARM: dts: qcom: Fix node name for NAND controller node
Date:   Thu,  8 Apr 2021 22:34:51 +0530
Message-Id: <20210408170457.91409-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common "nand-controller" node name for NAND controller node to
fix the `make dtbs_check` validation for Qcom platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 7bf1da916f25..ff1bdb10ad19 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -480,7 +480,7 @@ qpic_bam: dma@7984000 {
 			status = "disabled";
 		};
 
-		nand: qpic-nand@79b0000 {
+		nand: nand-controller@79b0000 {
 			compatible = "qcom,ipq4019-nand";
 			reg = <0x79b0000 0x1000>;
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 3372e076f9bd..aa3edecf5810 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -294,7 +294,7 @@ qpic_bam: dma-controller@1b04000 {
 			status = "disabled";
 		};
 
-		qpic_nand: nand@1b30000 {
+		qpic_nand: nand-controller@1b30000 {
 			compatible = "qcom,sdx55-nand";
 			reg = <0x01b30000 0x10000>;
 			#address-cells = <1>;
-- 
2.25.1


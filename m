Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639C0358AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDHRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhDHRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB19C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so1733986pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVewZhBEpab07BjvnZGNIe0pCoZUQtHPXZvSB4BTsrE=;
        b=FQ6iT7/BUaQdyx1lCcVKI+fBNrD0R7wrF586oSPf6Q69EQtCC09G14my/u7Ae3cJQW
         +QYAwY4ZGDQwHvAGXK47Pidf60sax9TWpps26Z/j9SHXjSwR+QVIIhkkyILOGdWOVpvx
         n56reyQ2TevS4ekSD/BIL9c+NK4hghog/+hDBkvc9wuwcum15unmAZrvmCyOCuf2uoGG
         1/SzJfV+e8eSCv1B22yTBaNDsulNMrSBdXaIt8h5T9/0/qa5tmf54LAi1CV9s2CZz/GE
         uRZkzfdVV1NKKjYRq/VAky4t4t6GIw4CmXfsX4b8pTsfcR6fhrOm1rYxkhafsNJsmlOs
         ChFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVewZhBEpab07BjvnZGNIe0pCoZUQtHPXZvSB4BTsrE=;
        b=tt9e3VDEtu8xqivRxJgY54FU4YZdVmOqEkEagFZ5Xzt4rtRNyT+uL4x2ueErNDHzmQ
         bGm326X8ROl3OjMZKXOiYIPZg56ZzSV7bBtrPBdR175XJd+uT4oLNStC60/Tv46kXDwo
         LbS2gfFOyauKT7OOHwTtdtDsEXC6TUEFOofPAOwTYyyb7bIPQqCFIKD+la1LYrHzUDi/
         Z3id9A7dKYtHiuMcisImRcnKDFB9HAnDNcmbJ6flJf57MqOoi39f+82ZmvzBOClWkqiX
         JINpbD9nHNv62zbXgmLRH6IwKW33ei2Fb/WMF4yuSzjLQ8g2UYlONDTvNnpoS+cfKZXx
         Op7g==
X-Gm-Message-State: AOAM531SLAoXD10Btu6Y236cuAjQoqtTU8AoQCMyFmdbN32SskK/gyT3
        GwdVjttfovvUj97OcbXLoHuWeoZRxz7B
X-Google-Smtp-Source: ABdhPJx9o4ytZ52X8NPOX/CmhXlrfj5kntAaDsEpYueTJSEuvWPURuGzRzLHgMd7n00OsOplEJGhAg==
X-Received: by 2002:a17:902:525:b029:e8:e347:b07f with SMTP id 34-20020a1709020525b02900e8e347b07fmr8671570plf.34.1617901521172;
        Thu, 08 Apr 2021 10:05:21 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/15] ARM: dts: qcom: sdx55: Add IMEM and PIL info region
Date:   Thu,  8 Apr 2021 22:34:47 +0530
Message-Id: <20210408170457.91409-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on SDX55 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteproc.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index f2805b526516..4ca871735025 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -379,6 +379,21 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 		};
 
+		imem@1468f000 {
+			compatible = "simple-mfd";
+			reg = <0x1468f000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x1468f000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0x200>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdx55-smmu-500", "arm,mmu-500";
 			reg = <0x15000000 0x20000>;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C2358ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhDHRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDHRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBB2C061765
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1741657pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkGTLvSx/Floa4sNfaIw69QwwL07yolmpgJlxSppzaY=;
        b=YeADWS34uHnGr6tx+/VVfp3uAbOHbTGwk7CIJkvNyxEfJu1W8xg9tj7GyJFBN1ClFl
         zTv3mv6rjwvwNJjb5O1hWVguPBfHyXGEayNrHqD867wA4w9G7SOKCWcgElUDeQkvHRsn
         hZ5zbTcR8WPabx0SjOkNpja27nvNleqeyxbLifN/Q9ytRaPfdqC3Re7BaGbOnfqDt7sv
         qExPMjxSCDOskZofPgrHvs/1TC79gmonQJTHxjQlgX0IGxL5xDZiDtd/te5o6PluRvWm
         Mi/17iAA4qw+LXpmCQr6NOFYdhmnqJqmvwfF2ui5Q0OyBHwDwLKGNgyn2kjK7SLAVXun
         j4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkGTLvSx/Floa4sNfaIw69QwwL07yolmpgJlxSppzaY=;
        b=tqoSjQJaoVyfcaQbs2xW1V/q5+3pGJCHQ3ZsU2md+Q6vq+eqIVXLgJzrvv9v7S7O39
         Bi/4gvpffaXIvon7JcKI2FaMaz4KNLQRDIZpDalWle8ycSAo/CewiBSNnc6giA2iwKPI
         cQ8J5ClgH9iyGuEWuNceIncUVzWlZVirhq8UQammoysQs78CNn/vsZU5nAFwYZ83jEOF
         5cQ7U5AorZs8Dz39sBJW993ZRtRaNkAbqw50QaEUkkpZRzTCWWHmPz7kDaccLFZvppnf
         d1J2aW24mEZUSmiV2PdtorGbUSWJBvKaO9gIeH1HKcdpSzHQBbMGEDjmXgSF+yVioup6
         gZQw==
X-Gm-Message-State: AOAM532sASTtmO/67CJErAuXzmZO3NE+VLhbAfBoCvw/CD7lG87fqX/l
        5tzhLnDY8cF5p/MnzsYhTSaW
X-Google-Smtp-Source: ABdhPJw3f75RrnJ7R6iJ5CcLJcgrdCqPaYWa4OFVEbf9Ij8JK9jFQhlmCNoAoCeMwVBjpKIEnrJffQ==
X-Received: by 2002:a17:902:8b83:b029:e8:bfa4:12d5 with SMTP id ay3-20020a1709028b83b02900e8bfa412d5mr8634243plb.21.1617901529108;
        Thu, 08 Apr 2021 10:05:29 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/15] ARM: dts: qcom: sdx55: Add interconnect nodes
Date:   Thu,  8 Apr 2021 22:34:50 +0530
Message-Id: <20210408170457.91409-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect nodes for the providers in SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index daf34f24a5d3..3372e076f9bd 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sdx55.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,sdx55.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -253,6 +254,34 @@ usb_ssphy: phy@ff6200 {
 			};
 		};
 
+		mc_virt: interconnect@1100000 {
+			compatible = "qcom,sdx55-mc-virt";
+			reg = <0x01100000 0x400000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mem_noc: interconnect@9680000 {
+			compatible = "qcom,sdx55-mem-noc";
+			reg = <0x09680000 0x40000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@162c000 {
+			compatible = "qcom,sdx55-system-noc";
+			reg = <0x0162c000 0x31200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		ipa_virt: interconnect@1e00000 {
+			compatible = "qcom,sdx55-ipa-virt";
+			reg = <0x01e00000 0x100000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		qpic_bam: dma-controller@1b04000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x01b04000 0x1c000>;
@@ -589,6 +618,10 @@ rpmhpd_opp_turbo_l1: opp10 {
 					};
 				};
 			};
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
 		};
 	};
 
-- 
2.25.1


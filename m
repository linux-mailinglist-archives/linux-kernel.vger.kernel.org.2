Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160E8455BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbhKRMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344824AbhKRMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:51:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4EC061225
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:48:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso4757970wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MnCziYMj92L8PMiePOBU3Unu2LBDv1Q/PbZAPnFHko0=;
        b=F0USZ6Tl+2HpQj4nFvS1NM24jLmsFJBIqx1DNPQq22AysKlkPgmRyQYBYZr3s/Wmmn
         HDrFTYJxRY0H4WX4hi0ZM95peaDBCiWjJsCM3spz1RcCUhEd39W0ey3lUk1I8+9jHO7m
         eGcyt95zIPruDOh7v2maaWfbcERhubatsUybJ6BOjrms5tQiB2CfzO2WNtKtH9BgNzV8
         7TlRSaPrjGJAWLvxsdN/jeYIpadUE997eXYN/aKsGWLEBjwERrAlHiLKdPwq/aAtXIKU
         ukmifPhUayIT/I0FpvvLGDEFgeww3u9sWl/S133Z/3yOAD0IVoo92tWpxlqXH35E1AbJ
         6qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnCziYMj92L8PMiePOBU3Unu2LBDv1Q/PbZAPnFHko0=;
        b=yN5owGKietkcV0B/k4Af9L06g9jNiCUJZV3GxFKCxQBrST3ZpJWFDXKxe+IV3kmUt8
         oLaAFKSrU2HWWAukdVJLlzzQVX7b5bHz21nA7aCroHjJ5x8a8ag/VstnW1dhuPf+npji
         LgKg3xxqutOWCT5qo5CzqH8J+w8+NsPo8OB0EeTXbnaoAZxdhobDkvU6qVBVMt4s/NvZ
         /K0pEfwzdkjWvcTXvOd5efC9eJsSdyYs5DU8S1DezkjoM9xjb1Dh8zzI2H/vQBAuUWkK
         5SAyWlhsyjppjjBwZ4uJOlLDb61AJo73tjmo7t8YZfjLnwYm3CUW1ovb0oBysNgmOiAQ
         c8xg==
X-Gm-Message-State: AOAM532x/szSwIWUPS1Q8jg0G25g8JMXcoKPsye41bg6oVmvNn50EiM+
        yjTnbWxibLPTg/v52LafegIUGA==
X-Google-Smtp-Source: ABdhPJz86pB1ZOf/GAJsoDuXUDt85ZQ4Xkk7ydzEi1eUjqPD67j4xio8bPelFi5CAZusG4KwWU0vHQ==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr9476992wml.85.1637239707883;
        Thu, 18 Nov 2021 04:48:27 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id h2sm2955635wrz.23.2021.11.18.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 04:48:27 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sdm845-db845c: Remove clock-lanes property from &camss node
Date:   Thu, 18 Nov 2021 13:48:19 +0100
Message-Id: <20211118124819.1902427-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118124819.1902427-1-robert.foss@linaro.org>
References: <20211118124819.1902427-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-lanes property is no longer used as it is not programmable by
the CSIPHY hardware block of Qcom ISPs and should be removed.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 13f80a0b6faa..2cf4b932aee2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1125,7 +1125,6 @@ ports {
 		port@0 {
 			reg = <0>;
 			csiphy0_ep: endpoint {
-				clock-lanes = <7>;
 				data-lanes = <0 1 2 3>;
 				remote-endpoint = <&ov8856_ep>;
 			};
@@ -1166,7 +1165,6 @@ camera@10 {
 
 		port {
 			ov8856_ep: endpoint {
-				clock-lanes = <1>;
 				link-frequencies = /bits/ 64
 					<360000000 180000000>;
 				data-lanes = <1 2 3 4>;
@@ -1211,7 +1209,6 @@ camera@60 {
 
 		port {
 			ov7251_ep: endpoint {
-				clock-lanes = <1>;
 				data-lanes = <0 1>;
 //				remote-endpoint = <&csiphy3_ep>;
 			};
-- 
2.32.0


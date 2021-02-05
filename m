Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD13109C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhBELCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhBEKzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:55:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505EC03542D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:45:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so7201982wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UlBA+jrFoLLefklW/JXu8ZcQb+a+i4EuznUW8mxqVQQ=;
        b=PqKERPjbhxZNjkGht1IFO5TdJeRVTxzAZGFYKkDKSrC8ellJI/LegoneY4UXNMyD9Y
         WhBN0TjwlegpGe5zpEn/KfmKlyZkFZA6/85Wj2xnBxatPNiMKGYPY9UWzNP6lTyuhUyq
         p6Da6T/uUewppG/gL/2KkLAcHB5YVJTAELWrJeka6x7W3YEMEdY1ueR6Spf9s8X/h6H5
         Jz+gvbU3XiFNDMNCOOMWdTqfs+fFiBFctEyKQYBsgIts/ztYkH7RQWYrmtewt2WBy9G5
         jXpUQA/jsu+2SYt4xZ/wzCEM1HqAvXpfVz1XWzT/s790M6BF+0ZfsMNZ7uQdTWj8K8cJ
         HYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlBA+jrFoLLefklW/JXu8ZcQb+a+i4EuznUW8mxqVQQ=;
        b=hfpj7kpELvvk+0N+isp4Mq21nbO9JN+Jwh3nR4cl5HCqxbdR0UKE6cWgvbttf41ahR
         GeJ5rcG1NLnkpMiNB0g80cEXL/XAaszBL+nGjGc+pbr581pp1GvhnVn32JGYS2ZjlM+V
         FKAjCxZ+ysuL4L9tNK6a5Kric3m9gaHeTWREQluXZZkNxdZRf2sZvi0aspTLxgUZmmDE
         6rlzA0/H9+bkzqYyq0yPuEJXf0GCfinyB3boa0f6MrY1l4m5h5R40iWvlMnHwTOGzylv
         zdNZDAaImNCNOLBRALURU8KGRNL6HM9Q4ck+5Z1U1TuLlj7TP0zQum8dvAe5kJbFdS+l
         kJBA==
X-Gm-Message-State: AOAM532HxB7/7i64wopDcP8q/lImIcXyY5BrCcGo+geMdQNmaKEsrvBv
        apM5UKK3vlO5oeg0pMIZN+G0SA==
X-Google-Smtp-Source: ABdhPJxoovUV7wVeOhzmdRMv7aCTKZPQPB3xPLRIoQvFSA/9FWjM8iO4wmInb5AIfzCqE3AHzssUyw==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr4434247wri.105.1612521930887;
        Fri, 05 Feb 2021 02:45:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:38fd:e0db:ea01:afc8])
        by smtp.gmail.com with ESMTPSA id u4sm11300233wrr.37.2021.02.05.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:45:30 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v4 22/22] arm64: dts: sdm845-db845c: Enable ov8856 sensor and connect to ISP
Date:   Fri,  5 Feb 2021 11:44:14 +0100
Message-Id: <20210205104414.299732-23-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210205104414.299732-1-robert.foss@linaro.org>
References: <20210205104414.299732-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable camss & ov8856 DT nodes.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 5842ab65789c..d89286f6aacb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1108,6 +1108,21 @@ &cci {
 
 &camss {
 	vdda-supply = <&vreg_l1a_0p875>;
+
+	status = "ok";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&ov8856_ep>;
+			};
+		};
+	};
 };
 
 &cci_i2c0 {
@@ -1139,7 +1154,7 @@ camera@10 {
 		avdd-supply = <&cam0_avdd_2v8>;
 		dvdd-supply = <&cam0_dvdd_1v2>;
 
-		status = "disable";
+		status = "ok";
 
 		port {
 			ov8856_ep: endpoint {
@@ -1147,7 +1162,7 @@ ov8856_ep: endpoint {
 				link-frequencies = /bits/ 64
 					<360000000 180000000>;
 				data-lanes = <1 2 3 4>;
-//				remote-endpoint = <&csiphy0_ep>;
+				remote-endpoint = <&csiphy0_ep>;
 			};
 		};
 	};
-- 
2.27.0


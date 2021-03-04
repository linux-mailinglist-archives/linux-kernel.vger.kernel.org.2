Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00A532D296
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhCDMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbhCDMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:07:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA0C061225
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 04:06:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w17so975679ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6kqHVgRXcGTejXZV+UwM9uyGX3tx7DzRfC3/Q/v2WM=;
        b=A8YAAwJbPf/mDfZEPle56kQyjHalh7PJYSM0ijYG4qQwZk5lPRSAhvvIx8CWCahSIr
         gjPmVtDOkfy7eOaiDJfdJLdI2yhdyKVVTKAbNZLT9Mg4EyD9G6S2fXRT9zxqfwp9jpYT
         2IXKAiwfWaucGDGv1F4q5l++eipR134GvwLn1s2Rfh0TYSFsqI0pUTDd3LSBozATZHwS
         XfH7ThGKIG5bAQ20eFxqutHCbtBOXiCaNYezOBt/y++QHLXO440cGmL5AAajQ2xN5c+S
         dN3UiLcXw1P4sMUEqyp7Ml1leVxPUx/YFhLYp0c8xT2cJ1gUAt6xdOlzfRLXltLeMxJg
         NZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6kqHVgRXcGTejXZV+UwM9uyGX3tx7DzRfC3/Q/v2WM=;
        b=DlsM9Ox3BNn2j09B5CnDUzDL71fPkooMktmNEnJ40bc8/k18leIRrFH3lAjplfY5g5
         lZByYFYGuiDvfHMaeXStAxsuKzP0Jnd444hrabhDLWuoP4jdBfAdyK9qPIAE9TTNllVD
         5VmGMTc2uU+tdlBBjq6hlBM/djFk8WzHcJdkIjvha2nN6BwKTcbDHfiak4gaX7gzAjuX
         M4VMitPA6rvX5zuaduX3sJKou90mKDc5wWEqimrd4c5stHpn2mRhz4+5H8dGxRPB7pDs
         x9vzkj6o80WMRMTm2aC7joUKRFbv7P3Lf+kuPrGMMqnq2Vl6AkbBYthZ6NB4l55DNUI2
         oJ+g==
X-Gm-Message-State: AOAM5315SMLKvA3D3grfmPLYZhvVZ+/hNJmtXfTo24XXGp/0DvhUlTSM
        LUTw5nVGuf26IRvGb+sGCZ0C8Q==
X-Google-Smtp-Source: ABdhPJxZkDF6mr/G1/aQr7MK5ipPu4ir8YUy583pJz1UQL5iuV/1jAqlQga3cHnYIh9ezZKtKH6fwA==
X-Received: by 2002:a17:906:f9db:: with SMTP id lj27mr3881177ejb.399.1614859568051;
        Thu, 04 Mar 2021 04:06:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:470a:340b:1b:29dd])
        by smtp.gmail.com with ESMTPSA id cf6sm20464447edb.92.2021.03.04.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 04:06:07 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v6 22/22] arm64: dts: sdm845-db845c: Enable ov8856 sensor and connect to ISP
Date:   Thu,  4 Mar 2021 13:03:28 +0100
Message-Id: <20210304120326.153966-23-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210304120326.153966-1-robert.foss@linaro.org>
References: <20210304120326.153966-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable camss & ov8856 DT nodes.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v5
 - Andrey: Add r-b
 - Change CSI clock & data pins


 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 5842ab65789c..ca00be42fe67 100644
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
+				clock-lanes = <7>;
+				data-lanes = <0 1 2 3>;
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5138D069
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhEUWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:01:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92245C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:59:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j12so15285632pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5OnOgOOmWpMxKvaJfHdYnxsVHFmf/RGX8LXSt1tTYI=;
        b=QsemvWtvaAVUPew3IHPYLY11CPb8ipFmb6oOvD/sjkrcvdnEl/q+r98ITP2gQ8WujF
         JWYiSc2g4yGPbVRkO11usYX6ynylrCOijGH9eD9M+MawnNyueBzgXC60au4xUwnLYfpK
         tUfY5AEC9T33rCel6vpRoOvO5jn3eHvVdcK9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5OnOgOOmWpMxKvaJfHdYnxsVHFmf/RGX8LXSt1tTYI=;
        b=dnslgcUiG3lb+aOLgv1J9Cr8GaWd48EXyk2IzgdkcE7u+Ma2xzjONeVLvFIznp05j5
         3JisUyaYRClwr4tENEt+yBV3AJuHXgB9kY72/tkg4BdJcb5yzGe3UnHbIbHFErGoeac/
         dpofzIf9GMLUWsLPxXIbdhfVTqm1UHvTijpwmcVTr50RNPCuNpWbFqefGcEcP6DnA9LG
         xuYSaLbNpo/XQBDmcZAdma0KhPK3uiqBgDmok0YcfF9j7YFLhUySJac/rEt0tl0/D8Nh
         E/1Xo+BNb3DYHShsp4XhSxh/zT7l/yNRsMLbGu5ibsB4QDqJ3tnXLb9CSF3L+/DRVlih
         VNxQ==
X-Gm-Message-State: AOAM530dRamrMesyiG74UgdvkVl4L3CF+7DNqOLCa/STPWBpAyiABvkf
        RsY3vC9M5HxovSo7dV6zzxMPDg==
X-Google-Smtp-Source: ABdhPJy1wX0IIztVh3UB/sVZQXtLZrQzqNk7XiYWYOIQqGKZadHcvBhWlOZrQbsK3X/dDCg1CS0uEw==
X-Received: by 2002:aa7:88d6:0:b029:2e3:b74b:2a5b with SMTP id k22-20020aa788d60000b02902e3b74b2a5bmr9160641pff.4.1621634399153;
        Fri, 21 May 2021 14:59:59 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:22bd:8c3f:584d:d265])
        by smtp.gmail.com with ESMTPSA id h8sm4590835pfv.60.2021.05.21.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:59:58 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Move sdc pinconf to board specific DT files
Date:   Fri, 21 May 2021 14:58:42 -0700
Message-Id: <20210521145824.v2.1.Ia83c80aec3b9535f01441247b6c3fb6f80b0ec7f@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210521215841.2017349-1-sujitka@chromium.org>
References: <20210521215841.2017349-1-sujitka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sdc1/sdc2 pinconf from SoC specific DT file to board specific DT
files

Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
 3 files changed, 204 insertions(+), 102 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index e77a7926034a7..07133e0af581a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -598,4 +598,106 @@ pinconf-rx {
 			bias-pull-up;
 		};
 	};
+
+	sdc1_on: sdc1-on {
+		pinconf-clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc1_off: sdc1-off {
+		pinconf-clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc2_on: sdc2-on {
+		pinconf-clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-sd-cd {
+			pins = "gpio69";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
+
+	sdc2_off: sdc2-off {
+		pinconf-clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-sd-cd {
+			pins = "gpio69";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 609f0ceafd095..d128a0ed6ad3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1540,4 +1540,106 @@ pinconf {
 			drive-strength = <2>;
 		};
 	};
+
+	sdc1_on: sdc1-on {
+		pinconf-clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc1_off: sdc1-off {
+		pinconf-clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc2_on: sdc2-on {
+		pinconf-clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pinconf-sd-cd {
+			pins = "gpio69";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
+
+	sdc2_off: sdc2-off {
+		pinconf-clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		pinconf-cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pinconf-sd-cd {
+			pins = "gpio69";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 1fc328ba0403e..0630a9c410b58 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1872,108 +1872,6 @@ pinmux {
 					function = "lpass_ext";
 				};
 			};
-
-			sdc1_on: sdc1-on {
-				pinconf-clk {
-					pins = "sdc1_clk";
-					bias-disable;
-					drive-strength = <16>;
-				};
-
-				pinconf-cmd {
-					pins = "sdc1_cmd";
-					bias-pull-up;
-					drive-strength = <10>;
-				};
-
-				pinconf-data {
-					pins = "sdc1_data";
-					bias-pull-up;
-					drive-strength = <10>;
-				};
-
-				pinconf-rclk {
-					pins = "sdc1_rclk";
-					bias-pull-down;
-				};
-			};
-
-			sdc1_off: sdc1-off {
-				pinconf-clk {
-					pins = "sdc1_clk";
-					bias-disable;
-					drive-strength = <2>;
-				};
-
-				pinconf-cmd {
-					pins = "sdc1_cmd";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
-
-				pinconf-data {
-					pins = "sdc1_data";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
-
-				pinconf-rclk {
-					pins = "sdc1_rclk";
-					bias-pull-down;
-				};
-			};
-
-			sdc2_on: sdc2-on {
-				pinconf-clk {
-					pins = "sdc2_clk";
-					bias-disable;
-					drive-strength = <16>;
-				};
-
-				pinconf-cmd {
-					pins = "sdc2_cmd";
-					bias-pull-up;
-					drive-strength = <10>;
-				};
-
-				pinconf-data {
-					pins = "sdc2_data";
-					bias-pull-up;
-					drive-strength = <10>;
-				};
-
-				pinconf-sd-cd {
-					pins = "gpio69";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
-			};
-
-			sdc2_off: sdc2-off {
-				pinconf-clk {
-					pins = "sdc2_clk";
-					bias-disable;
-					drive-strength = <2>;
-				};
-
-				pinconf-cmd {
-					pins = "sdc2_cmd";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
-
-				pinconf-data {
-					pins = "sdc2_data";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
-
-				pinconf-sd-cd {
-					pins = "gpio69";
-					bias-disable;
-					drive-strength = <2>;
-				};
-			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
-- 
2.31.1.818.g46aad6cb9e-goog


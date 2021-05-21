Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1282438D06F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEUWBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhEUWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:01:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA00C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:00:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s19so13641079pfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2V7fmw/fmgZiVcO3AfU6PNyi6PWDJ3vPw52uwZKHWA=;
        b=RI8V3dwaAwJhbjkfHkPgO2ZyS3w4TIW3vYIgNDAwxZydDtq0dIM5c8IOph2dJvSeDH
         FhDuNkvWfIgu4S32nM52ZXTv/mgAdzugTo9aYEUbVTx9t7RLLqdUYQFKsAQg7fQXR6pO
         I0f8YvXuCQdmCu1Kzp8rcdEmAWRNnHqU4M0ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2V7fmw/fmgZiVcO3AfU6PNyi6PWDJ3vPw52uwZKHWA=;
        b=uMS3D3RRo2GlMOC6AspNWpS6K18Of0ZGdO7eQR0Fdgt94KqUAKRKKYmnZn8FgD2wN+
         40/QJW1HC/lYPPufZ/sh5eeRf0+oEkNHMZGyNBeYLHnc4LmRJR+bptU3rmuZ8L5lOGMu
         8+wx1rbkVNYI6k84LzP/KQzu3Dz+I79KUkeY/Dwi5h8YtXKcTG6ruKUnAUWbTCfvFhEB
         CF2g92pV/z5uPqwTy4saSz68k0ASMfrXPeZZsdtI1rPn0mC2j83MDF5n0uQE5AGiXb2+
         soLEt8owYLp6EVDUHJsNB54PwMeMDp9YrhN7Ov1MAObSvPtruu/Lp5ubBtyLLTMi596F
         wXPg==
X-Gm-Message-State: AOAM5334Ukdd9nkoLL2rPi8g15fNCve1Age5jur5zpLyQs5J177hJJGC
        kWSU5cfA+dwEpDXL8PITExmvzg==
X-Google-Smtp-Source: ABdhPJwFzwge0QTObIl3lZKYxTMVYg/MyrzPrxuxYe/7+wxEWHelKB6+Rkxq5iqFRSCJz+LG7fOx6Q==
X-Received: by 2002:aa7:8f37:0:b029:2db:551f:ed8e with SMTP id y23-20020aa78f370000b02902db551fed8emr12017972pfr.43.1621634426412;
        Fri, 21 May 2021 15:00:26 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:22bd:8c3f:584d:d265])
        by smtp.gmail.com with ESMTPSA id h8sm4590835pfv.60.2021.05.21.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:00:25 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7180: trogdor: SD-card GPIO pin set bias-pull up
Date:   Fri, 21 May 2021 14:58:44 -0700
Message-Id: <20210521145824.v2.2.I52f30ddfe62041b7e6c3c362f0ad8f695ac28224@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210521215841.2017349-1-sujitka@chromium.org>
References: <20210521215841.2017349-1-sujitka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor board does not have external pull-up for cd-gpio. Set this pin
to internal pull-up for sleep config to avoid frequent regulator toggle
events.

This change is aligned with Qualcomm's DT change posted at:
https://patchwork.kernel.org/patch/11675347/

Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- added pull-up for IDP

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 07133e0af581a..0c255edb7f3c3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -696,7 +696,7 @@ pinconf-data {
 
 		pinconf-sd-cd {
 			pins = "gpio69";
-			bias-disable;
+			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d128a0ed6ad3a..330deb4967ca2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1638,7 +1638,7 @@ pinconf-data {
 
 		pinconf-sd-cd {
 			pins = "gpio69";
-			bias-disable;
+			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
-- 
2.31.1.818.g46aad6cb9e-goog


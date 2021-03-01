Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDB329FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574838AbhCBDvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbhCAVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:41:01 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D010C061A2B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:35:01 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id e3so8416883pfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlWXwvFYXokduORUwulUZ7cOw3te/q/W8pSCRFa5whA=;
        b=Sl4NNWg8xqy7BpI7lsrbZPkY9kICEuQ4HWufUUAIfGK9vHMSr+64D9WT+oJTUT8u28
         d3ZeKB5ZYGJLYcyHGlsV81PPgPTvMa0at9WNq1D7myvxh9wBfK5i6LcqfZtz35B4Tmrl
         WkC+69sxOb2AJY8Kl94JxgfgroPNq9n0fzdPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TlWXwvFYXokduORUwulUZ7cOw3te/q/W8pSCRFa5whA=;
        b=Ty2kVhSMb5bRw7KZ70ilxqObr6kQLe8DldJyQFgw6u1AZ4NPoo6ZaAiByT4sBNXaUG
         /Nt+VButmqOeZ711bPSwg63YViLOKvkpRV19y4Bqm1Vz6s4HspPDoT5MYvwp8QDSjqp3
         Uz3XeFlan2Af4Oob15l0QX32sjawzb5n/nwukHVl59WFuhxvJsSKxrAdtn/Fa7GkRSoV
         e4mtjRhKT33nz+yJYiYKwxsF7S/M/sg0wCo3VQn2bxOR6D4Gd2M6i8pliDfjOLM8hXZ6
         4xSRsBDsVgzJYxkShfp4kwqFcK952rNJi3rVTT1css43hS4+tSmCK47WrgnEadbMFu+w
         yCyg==
X-Gm-Message-State: AOAM533bdp5dJRI7ni1Vns5Z3oHApxLX3Xuvbc12asAaXKV14molNjEz
        YlfSCmYgLKjmLWSWVlwW5XxUOmrBtZV0cDZS
X-Google-Smtp-Source: ABdhPJzlinyEIqF2J0y3A4xwcOxYj8VLODA3XlbQmIvff/Zcr8Go+6OyKGPZXU+ELjrkKODCSbzx4Q==
X-Received: by 2002:a63:4708:: with SMTP id u8mr15326609pga.102.1614634500799;
        Mon, 01 Mar 2021 13:35:00 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:35:00 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] arm64: dts: qcom: sc7180: Set up lazor r3+ as sc7180-lite SKUs
Date:   Mon,  1 Mar 2021 13:34:34 -0800
Message-Id: <20210301133318.v2.10.Ia3795e192f5bbe17e6714e45fcb0bf5acdbd4c17@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Lazor rev3 and later use the 'lite' version of the SC7180 SoC.

Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[dianders: Adjust commit message which referred to downstream history]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts  | 5 ++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 4 +++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts     | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
index 6985beb97e53..dcb41afdc82a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
@@ -5,7 +5,10 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor-lazor-r3.dts"
+/dts-v1/;
+
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
 
 / {
 	model = "Google Lazor (rev3+) with KB Backlight";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index 0881f8dd02c9..be44900602d7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -5,7 +5,9 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor-lazor-r3.dts"
+/dts-v1/;
+
+#include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index 19e69adb9e04..ea8c2ee09741 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
 
 / {
 	model = "Google Lazor (rev3+)";
-- 
2.30.1.766.gb4fecdf3b7-goog


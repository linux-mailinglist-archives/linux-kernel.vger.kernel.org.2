Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3F440579
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJ2WaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhJ2WaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:30:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D567C061767
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p20so5191118pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8p+7yp48w7//WEs7Ji/brBBMvp8OpaoSralsz2SZ1rQ=;
        b=hOdKuoyb/kTIYG3+Aimk41yC5VZLTMT9+gJASOR6FGE9iMV23NyGIqMRLjJMPr2Cih
         4fmeKDUOYqplEoMVe14eVFcURaPSmirM8dfmWYUVN87OVal5ZxgTQv1jAlpCdFmhtX/c
         ApfjOlpTyWHoApvNBQfveWmGahrcb6Ez06LWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8p+7yp48w7//WEs7Ji/brBBMvp8OpaoSralsz2SZ1rQ=;
        b=JepsUIBDpyIOTkb6SqCbzfKD8ZT9Kp0RJxoAR5WQ+kfu8gjMGXNoKS2pFxYhviTeuA
         gaRduGcWq/Ojk0uYVOLjVAsPI0w7trRhWjNr5WlBzibcPS8dOAwuWdCYoEnRHeS0xGNb
         12e9sYNPkJvfr1H3zQaWfjQXfN9w9ZDD8BZbR8/pPhK4XsHL+Sq1Me9+/HYSNYARwkhm
         +3biYx96g0Sbr0MvACJVxo97lp0YP/UfG/xvEw+HBGXRY1aP6CAF3VZrQ0BLOfdpganl
         DV8ZrmkPFdgdnnwU4dEUTYdJROxBHr2M7ski5PippWbDliNNgqi23ttuAXq1imv7xGaq
         M8QA==
X-Gm-Message-State: AOAM530lx4vb6ZlItnZ2ztNzKCtNt5C+9sIZi7TtbbBrG9nrYhTBLbjP
        ao7Pt0GH4ehi+opr8/fp8Ys0kkLtTNKP4w==
X-Google-Smtp-Source: ABdhPJxnzZSyIvS4cPeOnXvq/PbcoYEMgbjFgjqr7TNr9LSSaEZ7Ci2Tr6ySneYvz3lBsDdSQLpIlA==
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id c1-20020a056a000ac100b0044c4dc6b897mr13921865pfl.25.1635546469875;
        Fri, 29 Oct 2021 15:27:49 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:e956:ddc4:6e27:e270])
        by smtp.gmail.com with ESMTPSA id v14sm7756660pff.199.2021.10.29.15.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:27:49 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: sc7180: Specify "data-lanes" for DSI host output
Date:   Fri, 29 Oct 2021 15:27:41 -0700
Message-Id: <20211029152647.v3.2.If23c83a786fc4d318a1986f43803f22b4b1d82cd@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
References: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM DSI host driver actually parses "data-lanes" in DT and compare
it with the number of DSI lanes the bridge driver sets for
mipi_dsi_device. So we need to always specify "data-lanes" for the
DSI host output. As of now, "data-lanes" is added to ti-sn65dsi86 dts
fragment, but missing in parade-ps8640 dts fragment, which requires
a fixup.

Since we'll do 4-lane DSI regardless of which bridge chip is used,
instead of adding "data-lanes" to parade-ps8640 dts fragment, let's
just move "data-lanes" from the bridge dts to sc7180-trogdor.dtsi.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index 6dbf413e4e5b..f869e6a343c1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -9,7 +9,6 @@
 
 &dsi0_out {
 	remote-endpoint = <&sn65dsi86_in>;
-	data-lanes = <0 1 2 3>;
 };
 
 edp_brij_i2c: &i2c2 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d4f4441179fc..bd5909ffb3dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -603,6 +603,10 @@ &dsi0 {
 	vdda-supply = <&vdda_mipi_dsi0_1p2>;
 };
 
+&dsi0_out {
+	data-lanes = <0 1 2 3>;
+};
+
 &dsi_phy {
 	status = "okay";
 	vdds-supply = <&vdda_mipi_dsi0_pll>;
-- 
2.33.1.1089.g2158813163f-goog


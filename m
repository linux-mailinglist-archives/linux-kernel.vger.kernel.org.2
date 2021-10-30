Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06504440574
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ2WaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJ2WaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:30:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C013C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso8289833pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FiNpbWsQ1AURQ4l0x934XjrZg11DiQc/mByDM5SptY=;
        b=YKY5vW9oso/yUk/J5kLStrUj/F7QkEJ10L0nXgOVB+n0AfBHbcrPxSRwViZ/uhQEhI
         Fkqt9HboOiKw36BecKSTetqOAZpc1LzXlZ+hGEMde8vMT5icQk/XkfyQBiaAJMSxOL0g
         epWK0UJAZ5kwJ+tYxy4Se5szspr0bHfW+7ALE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FiNpbWsQ1AURQ4l0x934XjrZg11DiQc/mByDM5SptY=;
        b=XVt9BULyq70a+i5pAJeiWQPBMIXprMX57Tqcqctx5UbbC3XvC3cfoktKhu3X+e9vgZ
         aO2iCClPo1T4JeNpGnmVsFmv9RvIvmqYV0wa/iszEx5elfVKfPvrNUKSbS8oqCMLYdeK
         5BPZOnuamwKDm91zBGlszWLAuIwv9fj0fEWa4I6eXG4SwXrBz8j5/YTrn8pOCSi9DWKt
         TySTjQkdgODWWqxoPYXpcd1YXTtH+8j2Rtdzo4hbBPZtdDZgiLinebFN7/R9ontZPkwl
         91mSMz6+GkYhev3LjExhaGO4i0ZcZBnKG+pYBN/u1ZcvtjzjqNC0AZ/0jxmkl3/74eBa
         QJ7Q==
X-Gm-Message-State: AOAM531+ksTaGVKlzKnTFSG+QhdzlCr600y7ll8uaw9qYIqxMjlHROht
        JHqak0EPHCXbQgHy1SPYfx37ziyZZpeDDw==
X-Google-Smtp-Source: ABdhPJxOUrAr8JIx2irI6EQjMHkdS9XbqnP128y/F33ONCuGC4zmm/ZspZ/svgol1Cl5BxIgFpF2sg==
X-Received: by 2002:a17:90b:1b11:: with SMTP id nu17mr22487040pjb.129.1635546468388;
        Fri, 29 Oct 2021 15:27:48 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:e956:ddc4:6e27:e270])
        by smtp.gmail.com with ESMTPSA id v14sm7756660pff.199.2021.10.29.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:27:48 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/4] arm64: dts: sc7180: Include gpio.h in edp bridge dts
Date:   Fri, 29 Oct 2021 15:27:40 -0700
Message-Id: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The edp bridge dts fragment files use the macros defined in
'dt-bindings/gpio/gpio.h'.

To help us more flexibly order the #include lines of dts files in a
board-revision-specific dts file, let's include the gpio header in the
bridge dts fragment files themselves.

Signed-off-by: Philip Chen <philipchen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
index a3d69540d4e4..6a84fba178d6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
@@ -5,6 +5,8 @@
  * Copyright 2021 Google LLC.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	pp3300_brij_ps8640: pp3300-brij-ps8640 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index 97d5e45abd1d..6dbf413e4e5b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -5,6 +5,8 @@
  * Copyright 2021 Google LLC.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 &dsi0_out {
 	remote-endpoint = <&sn65dsi86_in>;
 	data-lanes = <0 1 2 3>;
-- 
2.33.1.1089.g2158813163f-goog


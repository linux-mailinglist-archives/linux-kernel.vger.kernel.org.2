Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6843F403
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJ2Anv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhJ2Ant (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:43:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C57C061714
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:41:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so9307342pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCbr9sHhPoOYTttiMC9wrUBW6ygnU7eeaDDHFz4/imE=;
        b=ECAx9YAlPnA1iDQafmSAgZSeqWS3vJClmNYWenxzFskKGgJJu/Enn7b9+gLoiXpAJL
         y9Ih/K3w255iNuV83wasztitEUlwySOreXKHMiXo6mX7jRTwBUD1Q/WW22LvH3Z3rXTQ
         qcfcyrGM5LkMOLKL6B4cvgFIXV73K0KbqHDVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCbr9sHhPoOYTttiMC9wrUBW6ygnU7eeaDDHFz4/imE=;
        b=0H4qDEdbIrtsy09oiol3b2rNqWe99ksc7Ovrjyp9m57q9I/QooBAySqUu8ckoq42xc
         /inuAaJs/rukgdX9zK95qx9de2mVldiPdCErboRqUplwH7fzIX5qcUQ29GXQ0D+yOaEQ
         IkyPS4OKMupJQxBdO0mrzapZzxapxeZr2k2cJRScXg3aJ1yvjnUQyHl5JrtPgaqBC1hq
         JC/g/EAuGGqPI9jyGavoXZ6XaqM0P/nsh/+mrN6uxokygikGQIgfiJB3ClGTxZS2/cH5
         a4qOu1TS7Ilp689iKCGqrBhwfhoi5tctc6UR7Nkt/qN4aegKrLwF61KmNgBbAN/p90Ot
         iprg==
X-Gm-Message-State: AOAM530ypiavld+ujcK9sY3kAJntAMGoZ/FmPnA+Nankp/Aa3Zfzh/Wr
        93DCov/QUxz8pUUGyc4//8YdePtqQvsP0w==
X-Google-Smtp-Source: ABdhPJw1+zcw8qqYdbD+AuRBSzHxdUw5h2idj0R/H3v8Uv47IRYiimIrRoNqpSgTqGVKd80DDLomLw==
X-Received: by 2002:a17:902:bf02:b0:13f:cfdd:804e with SMTP id bi2-20020a170902bf0200b0013fcfdd804emr6744632plb.1.1635468081547;
        Thu, 28 Oct 2021 17:41:21 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:e956:ddc4:6e27:e270])
        by smtp.gmail.com with ESMTPSA id s2sm4373846pfe.215.2021.10.28.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 17:41:21 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: sc7180: Include gpio.h in edp bridge dts
Date:   Thu, 28 Oct 2021 17:41:15 -0700
Message-Id: <20211028174015.v2.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
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


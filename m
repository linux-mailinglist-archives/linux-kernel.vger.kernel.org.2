Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25D141BDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbhI2DpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbhI2DpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:45:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15666C061773
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bb10so593542plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGr1UhBmzv1ZbRN4Jw2f9I0cji4GhDLktnzGXnOfSCw=;
        b=lojz6FLPpIyl/A59txe+JHKvs0tCb0UDRptBdBrDrIrrWgrcokj/x1HSe4Hhp50GYs
         U8XmdWwKpC+k+MPz7KBY1yZHubAPNbDt7Tdewt3igCI4axF5G3kxktfW2I/52ctLAm3x
         gN7JAhAuyFMi3HXqIdRBNTpz0BUJi0q4mM8jTzZO4kk4l1fZ6soZgXhvBEJ1Ew1liuam
         chGBsDQGCbKP7wl5fYYfkIRCb2kLudDdbwVhZNN0PcvlnsR9NXxjF1UQoZhES9G0fwyb
         3d2xdnGW6IDDlRABDOMrF87uTfdMdCmbqv4da/f2gfFWVN+UrGXvc1GHxoqFJWG7g8ho
         GSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGr1UhBmzv1ZbRN4Jw2f9I0cji4GhDLktnzGXnOfSCw=;
        b=cWGulYCOGG0JamPJo5kBHS82fM3N2UAsJvOLaskNQP4sKiGOyoXP34YdFwNBAKx8Q2
         Touy8YYaK1ghAqeIvWVQKLJUe2AQkwomrvhoIhs9RWOab8KiTqhQ8BFCLOcN2FTdWHPk
         fEPWyQC2PPcfL+uABINp0URgww0Ul6m/CRmMpQWi+x/LXdSNlf99OZ81cROUCTlEgyC8
         CrciLeD9coyYX274KmOXD2xptVuY2+WBGF+vtne3MWrwG3HQQKMS8aur/h3mal+Sl3Ex
         tMyGvgthhmoDlCJG4W5VUS+Ck9qQHHdi1K/7zRWpIlrYvEUuHHOoJkJ/JFqlR7R66dmg
         qaBw==
X-Gm-Message-State: AOAM5317OLFsA77a2GeGoGZNadLaBR2BHMJg8qHhXv72u8jqm6ZbFk9L
        r2hu/z1Gx0RTBiTz2/AuvUAYhg==
X-Google-Smtp-Source: ABdhPJz/CbZ/RVuQyXsLtfbfTUh9HP70UcEOYZ/Z9mDXIxeGLpabjuICfiiIaLeetmoAaxOHYEUvjw==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr3884145pjb.15.1632886999671;
        Tue, 28 Sep 2021 20:43:19 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b7sm533032pfb.20.2021.09.28.20.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:43:19 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 06/10] arm64: dts: qcom: Drop reg-names from QMP PHY nodes
Date:   Wed, 29 Sep 2021 11:42:49 +0800
Message-Id: <20210929034253.24570-7-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929034253.24570-1-shawn.guo@linaro.org>
References: <20210929034253.24570-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reg-names' is not a supported/used property.  Drop it from QMP PHY
nodes to fix dtbs_check warnings like below.

phy-wrapper@88e9000: 'reg-names' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
        arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
        arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ac775189a2e4..216d703f3e55 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3678,7 +3678,6 @@
 			compatible = "qcom,sdm845-qmp-usb3-phy";
 			reg = <0 0x088e9000 0 0x18c>,
 			      <0 0x088e8000 0 0x10>;
-			reg-names = "reg-base", "dp_com";
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 4e943e4a93c4..99cd54c69956 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2994,7 +2994,6 @@
 			compatible = "qcom,sm8150-qmp-usb3-phy";
 			reg = <0 0x088e9000 0 0x18c>,
 			      <0 0x088e8000 0 0x10>;
-			reg-names = "reg-base", "dp_com";
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b19a3619e56b..dcda4fac46b1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1202,7 +1202,6 @@
 			compatible = "qcom,sm8350-qmp-usb3-phy";
 			reg = <0 0x088e9000 0 0x200>,
 			      <0 0x088e8000 0 0x20>;
-			reg-names = "reg-base", "dp_com";
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.17.1


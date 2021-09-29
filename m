Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84A441BDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbhI2Dpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbhI2DpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:45:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39BFC06177F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 133so1331768pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FYXdO9hJvhFltLYbg/A8prSsur4Hc5VN104uh+rlA1o=;
        b=VOBqEd74mVR9Y+lhOSmIztFfoJmPWTu7mP445QOv9cgjUnontrVnGc+EfpbzmbuB05
         W/k4Lj/fd6Olb4muOd06V6Si8QV0Ft1iYCxM46WvEbRfccp9NrMHLrxiUKvqxoZuJdpS
         HPjCSv3b/L3WCgEPsYxci0743LdgOAmyge42cN8S0WNixC6Fy/P9saTORPTNh0kDe5KA
         WvTc4SPsXEtYjlBW/W2v0dumVL+vKuwGY91go5qPATPPPGSGDP6ypU7CmMMw2O0rCT/+
         XSJcBs3u++amTRYkUvXAYGNyX9eSjRZ9ZchdMFLcZNNlRNRvx6BIiitP4OgfjYMp0cd6
         IRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FYXdO9hJvhFltLYbg/A8prSsur4Hc5VN104uh+rlA1o=;
        b=bQPamr2gldfQF2I+VK2Qt3btEYspm6+xaQbsl99/FZOg2MzU2bQKf5MiJDedlE+KfP
         x4u2kzlHxNPexsyKfxi71TEeBXpGQfn5IZpaTvYp4/IqBojtj076HB3penu4mi5/J/zN
         5XbeFAtVcVTnlf1OtHv2x/ehS3X1gd6Bwhvsmhtgxnv/KrxmvDMsZ+/Q4yAl9QAYleb+
         2nTPtzPLJ93u5pWz0wPF0Uckns9O7hpW7tIeYf9OHQOhQ8TyK2e4U+Zyl4ZrXSB8gfyK
         nXkCqoKiyfophrcRjwf3WEleOXHnUhhEyp59Y0Cma+OVBxZT6R5AHz98txzPJKtvGMUQ
         ZCSQ==
X-Gm-Message-State: AOAM5313g9eYQzSEQvEazZIp6W6WUJQJBDQclNksbnKYcdBQGu7DmTpH
        eZFarnrXpuJIAx8x4tEPqqjetQ==
X-Google-Smtp-Source: ABdhPJxDn6uBmUa9SlWbpmR7EUFl7Ur07P+cgOttjL5zAM5eauFC2MUQEDyDL2Ou3akJ0ia+q/zMrA==
X-Received: by 2002:a62:84d7:0:b0:438:af8:87ac with SMTP id k206-20020a6284d7000000b004380af887acmr9255549pfd.56.1632887009510;
        Tue, 28 Sep 2021 20:43:29 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b7sm533032pfb.20.2021.09.28.20.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:43:29 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 10/10] ARM: dts: qcom: sdx55: Drop '#clock-cells' from QMP PHY node
Date:   Wed, 29 Sep 2021 11:42:53 +0800
Message-Id: <20210929034253.24570-11-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929034253.24570-1-shawn.guo@linaro.org>
References: <20210929034253.24570-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#clock-cells' is a required property of QMP PHY child node, not itself.
Drop it to fix the dtbs_check warnings below.

qcom-sdx55-t55.dt.yaml: phy@ff6000: '#clock-cells' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
qcom-sdx55-mtp.dt.yaml: phy@ff6000: '#clock-cells' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
qcom-sdx55-telit-fn980-tlb.dt.yaml: phy@ff6000: '#clock-cells' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1e6ce035f76a..44526ad9d210 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -228,7 +228,6 @@
 			compatible = "qcom,sdx55-qmp-usb3-uni-phy";
 			reg = <0x00ff6000 0x1c0>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.17.1


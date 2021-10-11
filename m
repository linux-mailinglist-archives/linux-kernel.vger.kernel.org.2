Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191954287AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhJKHdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:33:55 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43396
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234459AbhJKHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:33:53 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 885973FFDE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937512;
        bh=XwHbWdp7VVwQ/yycSh88XsBspIrkx9lp92AdUBkvmF8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vNvYQN/o9SY69ky2ld9Dwi7jjXmcrd032m0fIvdhmCbEc/TajrcOg60ftavWKQGnx
         XzzOtlXeLmZy8gFONZxu5h4kyD/wN+TScOAjDASeHj2ElQDWfv7IehHAZ48+avDYPr
         j9/WX+dlQhjnIV2kAF1cb3hiymYYnHIXNvghz4ADCHBxjHQHS9o/h8q+z/HcDYm8dT
         U207tIOq4kSDWAIKXuRrMbCz0nPiKQ9B4XrjczHDSuaoNyoCnJV4u6EkgWB1j2mDMY
         UrDrJYZrTwQWpnSc/NdJN4hqvbmUTPTRRye04/WqA8F540INOCSH7PteXnwYl0RIqD
         bo6I2ovYFn/SQ==
Received: by mail-ed1-f69.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso9672936edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwHbWdp7VVwQ/yycSh88XsBspIrkx9lp92AdUBkvmF8=;
        b=mqujzGiooq2MRSklFdVia1CkvuqRxsGYt8S/G8j4zPw76r8sUr8blTlpuUPjbE7ani
         rW60dTXNieFekYUCEyUvFAQz0vXDj70R6wrOuj7mXCKUph0h/VseCZ8JQUPXTbBantq8
         /7lqg7Mg879gnXUljiP1vzVaeufP1DYcG6X9DREnL3zqI2QSjKHENTbUn7wWx8zAscXz
         OaDTvS8Q/AdzSbYQuX020a82EHFMENM323dLKduRWx7srLpl+lP/DGdQRqbuaWZPaCBa
         HP7o0Gp0cAz/W96ntIjjNNARw5aa2PAAJ9ghyHgx3HwJwreZnvjJ0OHQISMgMXCwD1DR
         6oiQ==
X-Gm-Message-State: AOAM530iOu5jgbmO8uLHwmaOwFeK7knPSJivK7e/RJYWv2erOkGVuRbR
        UP6ZfPHEO7rY2oiRQ9KZ5nCtgIIblu1xElfwPydEFQdw7VYXZ6KkXyibqc2kxa4xZwQ5ti/FrZQ
        all3w/eKPpJ0lGBZf42X5BmvYpzDSpyxg3pHPZnmDiw==
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr34199909edd.113.1633937512229;
        Mon, 11 Oct 2021 00:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywCR4sOtwh0YCcCUI9FHmKswBlDB3H3/tQT8Wk1uf3GQGN52eB0kGY3pjRUV8qGtdaaS42gQ==
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr34199896edd.113.1633937512032;
        Mon, 11 Oct 2021 00:31:52 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id dt4sm3054377ejb.27.2021.10.11.00.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:31:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: qcom: msm8996: move clock-frequency from PN547 NFC to I2C bus
Date:   Mon, 11 Oct 2021 09:31:43 +0200
Message-Id: <20211011073143.32645-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the early NXP NCI NFC bindings required the clock-frequency
property, it was never used by the driver and it is actually a property
of I2C bus, not I2C slave.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index d239b01b8505..01e573f0dfbf 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -185,12 +185,12 @@ &adsp_pil {
 &blsp2_i2c2 {
 	status = "okay";
 	label = "NFC_I2C";
+	clock-frequency = <400000>;
 
 	nfc: pn548@28 {
 		compatible = "nxp,nxp-nci-i2c";
 
 		reg = <0x28>;
-		clock-frequency = <400000>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.2


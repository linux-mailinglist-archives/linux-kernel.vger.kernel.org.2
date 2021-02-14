Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6531B262
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBNUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:18:33 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666AC061574;
        Sun, 14 Feb 2021 12:17:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q9so3912634ilo.1;
        Sun, 14 Feb 2021 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtL4Z7oV84D0lqSajYeR5hxfxbfYpsIfNN/c8hJ+Ehk=;
        b=iS3oxrVSiC849d7n6oYw9555IAEPtpeVSMTrLenLnUDhtNsHsGU6ZDG5XNL5T557Gj
         OmXz0z5EWSYCTgd/v5bHYXYc7MFy8i/c7D6bu6zTuLauDyF+IQ+h9zGRIh8ZHbykZVd9
         vljhIKdpGKX+de/tLBklNZp/oZc4EHVIXieyGJaMT5kQUA74Jbw4BeGCO5LD0aS9yRmK
         TGQXqIIfe+N8vgfXyq2HptzqpJzo4pSYpUX/Wn/aVLX1YVaWfL3QmmX71U7xn3ekmEfU
         +ytKIDgUgy7mQm/umL7sAY03vf0Vy6bwcWM63s0fPcXnG2TXXoRfNSssftMW14A7CKxa
         +oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtL4Z7oV84D0lqSajYeR5hxfxbfYpsIfNN/c8hJ+Ehk=;
        b=fOV/hlaIUY534bkgXZ3VbDmdkW0rNwEY7RPt/KKZWUNIbJY8kUF0KMlqRMNAqBkrI4
         cO3MbIFCxrP5urYCdoa2JbIoZvKlXU5yf6eoKY+u/a49QjKarcEEopYBuhTugGbB26D3
         bzLKGASLKTcLmkKdk2jev44Nsrjxgg+H1P3HYtk6GrlkKSbMTeDe3/yngiIWMhEivccM
         I5FBUZnEzlLMOQuNndjQD4ujz0hbsG7tLlive2Djwm6ypvgHNlUuXs3zeSrJmPYcQtB6
         RaGWpnlc8pdjrjd5kfsFePL4EigqFTFEikspkNavKhAxvsDqhbBMDhPsM4mEItdbAg8t
         147w==
X-Gm-Message-State: AOAM533Z1XT0A0PK9wyB34x++yZlkZgSHR/zy2ouD+Xez21k9mIvg41p
        HXx69sZxBDTe5qpLeB47Yh8=
X-Google-Smtp-Source: ABdhPJwxr8/B5f8+wJqTLPlZtDF0nFduROoaSQ6kx511pu6OMbZFLI60S7DlgVU4t6hOPou85iR4Hg==
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr10186654ilo.41.1613333872866;
        Sun, 14 Feb 2021 12:17:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:76d1:e2bd:f122:8b2a])
        by smtp.gmail.com with ESMTPSA id f14sm8286506ilr.14.2021.02.14.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 12:17:52 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn-beacon: Enable SDR104 on WiFi SDIO interface
Date:   Sun, 14 Feb 2021 14:17:42 -0600
Message-Id: <20210214201742.300344-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable 100Mhz and 200MHz pinmux and corrsesponding voltage supplies
to enable SDR104 on usdhc1 connecting the WiFi chip.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index de2cd0e3201c..c35eeaff958f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -262,8 +262,12 @@ bluetooth {
 &usdhc1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&buck4_reg>;
+	vqmmc-supply = <&buck5_reg>;
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
-- 
2.25.1


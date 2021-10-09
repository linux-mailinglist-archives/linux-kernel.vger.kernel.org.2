Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0573427BFB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJIQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhJIQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:28 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331CC061570;
        Sat,  9 Oct 2021 09:27:31 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so6709033ioa.1;
        Sat, 09 Oct 2021 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zzXwvdYEE2oSUbOPipC2xtN8cg8ckOIhMVrjQSoey0=;
        b=NtVhnVbKlXLZXp6Bs/LDacYmsxl6qZ+SCebGft4mtFtwkEfixgFDwIbcmo7YFzYdPZ
         MGohkHzUOg4PXWaVuDFYoxwR8Ua1QKRCBqeoY/3dHoX0XRqYIwyNnFD8ZmR2wLYFUBoZ
         qhLB1M5vvXLeG5eYvfdcTSBxe+wvcvBf0dJ71htZdpIwqbjbtKq1rnbX7VrWdEEZqNfQ
         XVH1WoGWyCsnAo93Z2kENZ6PqJUTm4r7w7XR9h6cFm/EIF9bVBD2SIEEF2e+ZLo8d/EQ
         Y2g56r333JPKO+vUFNKL4jDax901Iua6amYYE20UCZRYlvlx4/87ZdSOsfYGlNHrJ/40
         k3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zzXwvdYEE2oSUbOPipC2xtN8cg8ckOIhMVrjQSoey0=;
        b=yIi6NkyAr9I/RXxNzp5Q111Sm/h8A3EfcGc275sDSBlHwZd1aFP0RZ9hn7Zmahyduk
         cXOkf4iCUAlGkoU6iu9VY3QlI03LAprd8HVqh6OCDdalZJaTymAyC3h8RY3XL74vo5R8
         UC7uZ3JqlXvm3AEcbMlyzfS3o82H8YTO47S8fjlcRISTp5MAkERIHspUXar2ZN3GKcut
         CT9cMOrRwkMZc3MVNEj+dVHtKcGPV4MyxDje+zJ0KE7y7fWNGtfCY2ukH9xG2aGZ4Wub
         5VMH0q4WKcrEEKzz5EBrBLOo7rSthRp87ept+amvrmnYSHAX3fx6OGJw5pE/h2pJj+0T
         XnRA==
X-Gm-Message-State: AOAM533umpi1Drtfw2nGZfWbUzzOUuIXJobOKKqBHiXTxZS5vbr9OAGy
        jsKncl2EOwuoydVh8wpgdbU=
X-Google-Smtp-Source: ABdhPJx9i7Y/iU5Wpv4RKbl4owXCFmvwSaAsfUrPLG1jEDjn8UmKW+CHBj9gvX8epfMOE1c+KKUahg==
X-Received: by 2002:a02:ab94:: with SMTP id t20mr11892317jan.117.1633796850717;
        Sat, 09 Oct 2021 09:27:30 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:30 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/9] arm64: dts: imx8mn: put USB controller into power-domains
Date:   Sat,  9 Oct 2021 11:26:57 -0500
Message-Id: <20211009162700.1452857-8-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have support for the power domain controller on the i.MX8MN,
we can put the USB controller in the respective power domain to allow
it to power down the PHY when possible.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index f5bafd9db673..4e9d7099bb4f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1021,6 +1021,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADE3F027E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhHRLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhHRLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:18:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291CC061764;
        Wed, 18 Aug 2021 04:18:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o15so1378071wmr.3;
        Wed, 18 Aug 2021 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npcrXFBJjU968BkHBeT2qoRCIDqfxC7izKMFTpUlPDQ=;
        b=iRGgMnhAfeNa+YdR2DDIilZ+e59oWTMFPwPPlmreODpxo7y1lAT+8/1JsEnR5zU3h2
         y/2pKuJ41vR8gR2lhfW7WQ29QnWqqDSVNGNOph/C2pRYbu7uhDuARAB/KDgxdV75/WY+
         n+vxeCUx7V5Go0LE4A6vdRN3ogGXEpo30ULpqRMgMAnPjK4b+RoyHciGNEez1KDU1ayK
         B8iwzSAIeVnDB48Tai4vHlMCAjA/QYZmh1FBab1hzAjHTf5VkQvhWf2TW8yNKlmQ5z+y
         CGYeezw3bv6KNM6KIsemHtThN0FxZJ0V+qWws4qxl1eFg/EM3byBz7wIq6Lnk5q5g9/K
         Hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npcrXFBJjU968BkHBeT2qoRCIDqfxC7izKMFTpUlPDQ=;
        b=IlMQNafWjgJWGiLkMyKMG8f4ruVKxtOquFKAdAgBBFP0zNToYJptOuCL5QNxE3Hw0A
         FHQB2maPVUnkQxst+7VEuhOo/HCZ1BSz7QfQMEuTkVAatfZKWkebVM2ok/raAf8O+hFv
         jETjE2+hsGkvLXQfEUHW7BEwqMEqZWS3YtBSFi+XGLT+s3oFD01xwxPSrX4O8cIzlKHb
         dgV2pTdrlj20DgrWOY/mMXB8qL0DBL1EjGYITpEgB+dFV6FHrsa7lYLkfUvp/8frByq4
         yoxwbt0GdiMFuGqajiwOXB9KY5az0blG3wFDoY7vw8DweVQ0rpPCpOTiP7jcQ9HZQsDh
         GfKg==
X-Gm-Message-State: AOAM532e6sv10aN4gNAB5UAZQy42V5VNMA0VMadXFJCxMWb86INV2kkC
        NJOkhRdDsJPTl15YfRZSHx+92zp8RAs=
X-Google-Smtp-Source: ABdhPJx+bmnU9lYeMmZWV7Lki51hGDj4DGDffJPKKxD6Nif5lxcWMujQD938JOQQWXkCjk8tCW5y6g==
X-Received: by 2002:a05:600c:4a29:: with SMTP id c41mr7823042wmp.86.1629285480817;
        Wed, 18 Aug 2021 04:18:00 -0700 (PDT)
Received: from chgm-pc-linux.bachmann.at ([185.67.228.2])
        by smtp.gmail.com with ESMTPSA id f198sm4929586wmf.11.2021.08.18.04.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 04:18:00 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am64-mcu: Add pinctrl
Date:   Wed, 18 Aug 2021 13:17:46 +0200
Message-Id: <20210818111747.88569-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definition of the pinctrl for the MCU domain.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 59cc58f7d0c8..2bb5c9ff172c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -97,4 +97,12 @@ mcu_gpio0: gpio@4201000 {
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
 	};
+
+	mcu_pmx0: pinctrl@4084000 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x4084000 0x00 0x84>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
 };
-- 
2.31.1


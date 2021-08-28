Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2763FA573
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhH1L2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhH1L2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:28:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51543C0613D9;
        Sat, 28 Aug 2021 04:27:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso6030863wmi.5;
        Sat, 28 Aug 2021 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBzD8FxFJi7JItUTC8+nJv3vzp4FadFerggqU0WYbyk=;
        b=Ji5hc88rxIK23WQaP4glpWIX/sg0UJ2QT4Af20LI+E2DUMPSZf0pz614Yv/IW0pAcv
         Ensym9qCWVpDg53ACoxkHGD2sXbAuG7efvpeHSJJ74d7kmAiPfCm/E+bpTiqfMo3GsPR
         kPrN5+Z1hyXes8W3kD2DwYe8Skx8FxBNkstQc+VXFYycQL5u/+0Ay9hhAr+I0wpgC57Y
         psDl4tqNP+kFcbcCoLP6nO1dL5Rm3NyVy0kITf17np7ZBL/Y8oYgBt3gORPKvRwcuh0B
         UfoKlp6Y9cRi9H1UAwvt8/NoueG9qrFVp3ZlbBFZZeaW0mQ3lUrXUU5VuP0/zsPCePNq
         Q85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBzD8FxFJi7JItUTC8+nJv3vzp4FadFerggqU0WYbyk=;
        b=eeDpirxbsuvtilfRXfL33Dvt0mCl2AAeWxg1eneJ3NqRdM8LtJCLZxpJ/8ZLInShwy
         UQHeDcBrt/2kfgpNO0OOdEEL4kWD0joQlVuiF6Tnb8nzmp/AnlHT1u2wtBMOgqBEqTo8
         bCn8SbUMZjS4euJvdwJmCC4jpHDdTzgIDd9dNibbbODImx3gqrDlw0rNmuyF2auBHjA/
         XmNTB2LwC1v3ZYu0s3npd9+/01vAI5UbWiyAAZoDaISVAazu/reVky++z3lqpZW8q/XZ
         PGcpimUCBE6swfk+AvYONY5+xobOO6KGVJAU0RSVFp4E2JE6hOpzqkX5xPsoG8JpOXBj
         kv1A==
X-Gm-Message-State: AOAM532XgcTATMMFhTRNFv9WSXYGH84owGM6Swge7DAievsWIdFnSPao
        0iFOIBtroXcXQSpDeC3Xars=
X-Google-Smtp-Source: ABdhPJxhKA8lvEWl9vuLC5xQwJkLnQ6CnDNWt1l33Nwu3yPIp90vhzHbyr67vaQA9nOeBaf8HMmc1Q==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr13244955wmb.59.1630150059990;
        Sat, 28 Aug 2021 04:27:39 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id d145sm13571021wmd.3.2021.08.28.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:27:39 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: NSP: Fix MDIO mux node names
Date:   Sat, 28 Aug 2021 11:27:01 +0000
Message-Id: <20210828112704.2283805-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210828112704.2283805-1-mnhagan88@gmail.com>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following message by adding "mdio-mux" compatible:
compatible: ['mdio-mux-mmioreg'] is too short

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi                | 2 +-
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 6f2ccd059e73..180827500f25 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -371,7 +371,7 @@ mdio: mdio@32000 {
 		};
 
 		mdio-mux@32000 {
-			compatible = "mdio-mux-mmioreg";
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			reg = <0x32000 0x4>;
 			mux-mask = <0x200>;
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 8860f2fefc63..57d0c5eb9749 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -72,7 +72,7 @@ led-5 {
 	};
 
 	mdio-mii-mux {
-		compatible = "mdio-mux-mmioreg";
+		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		reg = <0x1803f1c0 0x4>;
 		mux-mask = <0x2000>;
 		mdio-parent-bus = <&mdio_ext>;
-- 
2.27.0


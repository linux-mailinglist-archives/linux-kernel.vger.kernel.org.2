Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1F3FA4C1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhH1J26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1J2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:28:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4341C061756;
        Sat, 28 Aug 2021 02:28:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q3so13596416edt.5;
        Sat, 28 Aug 2021 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO5P+c/MNcPVuw9OJF09SP3sm2xgsheSfNcKULrpmyY=;
        b=lR7Sha9B7gOw10ZpqEIY7mcZivzuDuOyqwLr+v5Jjta8Fq7vVpKAH3sCBblX2bUkaF
         QneLIKAT8zzVaON7Z36wJob+uxlDBRsbNZH53cnVAGFd1cnXu7uPfNgR9iWdP3A6ekpn
         uAcDbMfNOkqpDqU07TDHR3qk97FB7PTCZbkCBVS3Nqm8OSPKN48XpnuKFHlCDIBYFHRg
         f3N4mUVGZDfxxJcWYaTQ+eKCoF8TaM68SKZAmI6IB7E7IOEwzxL4N5KpQw4zlATVn+Aj
         igcUzz0LUbMclsWVwlExv1KyRIvgX1cawxUx2ftUzGPiMXTAoynhPR+OYg7p75leI9ay
         2WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO5P+c/MNcPVuw9OJF09SP3sm2xgsheSfNcKULrpmyY=;
        b=QDC97eqoz/XXcN/3YXO3LfU6VwR1YjpuVWmR2eRmvPk7sh5prg6SQJVgnnQuMuPRsL
         6VZ6lVdOdZzgTpHqMu4ublaCTAbvfzWgdj29Mos7RxUgOZuzTxkEXP441UiL0LmFpnLH
         L7Ly4KsTfdoK0t92EmzwAvNLMzTXN5Zho+2JoRP4UA0WMmpz3aw565B56QYgFMxDRlkX
         a4vZ7Vpadgs3SHvhqYIvQO9BXQCXE3qh8yjNQsSlqO7KaFynpsXJKdCBB5h8XSpYwx33
         eDb7SZni8sM2fsrD+X2jS7UpFPeSB8FkqDGE/W++aOSUEP3mPmdsKegoF18cu8qDbh6i
         w0/Q==
X-Gm-Message-State: AOAM530+eH/S3qlC0pVUsUdCZQZLY/qUwysYDT78UbGoqMT86tdEmAhM
        DO57nMwfPbFKXhlBZtt83WE=
X-Google-Smtp-Source: ABdhPJxrIXanuue1M1LVabN2JIXPUCJiqkPU/VSsbD1cuWK/98nBHFJkDvzo53cLYH2mm1oSLVbOoQ==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr12480670edc.113.1630142881442;
        Sat, 28 Aug 2021 02:28:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y23sm3866058ejp.115.2021.08.28.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:28:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: add adc-keys node to rk3066a-mk808.dts
Date:   Sat, 28 Aug 2021 11:27:55 +0200
Message-Id: <20210828092755.24560-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MK808 has a button inside the cover for the boot loader to do
some action. Add the adc-keys node to the rk3066a-mk808.dts file.
The rk3066 has a higher maximum DC supply voltage for the analog part of
SAR-ADC VDDA_SARADC of 2.75V then other Rockchip SoCs.
For the "rockchip,saradc" node is a vref-supply property required,
so add a regulator for it as well.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 9790bc63b..667d57a4f 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "rk3066a.dtsi"
 
 / {
@@ -24,6 +25,20 @@
 		device_type = "memory";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <2500000>;
+		poll-interval = <100>;
+
+		recovery {
+			label = "recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 
@@ -46,6 +61,13 @@
 		};
 	};
 
+	vcc_2v5: vcc-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
 	vcc_io: vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
@@ -164,6 +186,11 @@
 	};
 };
 
+&saradc {
+	vref-supply = <&vcc_2v5>;
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.20.1


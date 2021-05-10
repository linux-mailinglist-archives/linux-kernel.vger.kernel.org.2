Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA47379606
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhEJRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhEJRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:33:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C13C0612F1;
        Mon, 10 May 2021 10:29:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so25713744ejc.10;
        Mon, 10 May 2021 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zPZnXyNiITS1+tga2LkqtsJSSJCY8+DuMqte16OgOgA=;
        b=V+W8htSrVhXwsW0l/oyEpTn2StkXXbaVoRhOAECMU1WYOpkX/GL7Go+VY1+BybiodQ
         0P7DjHJCZvtCbWd8XiBRctvLB0mBVINuMx9qZNPhdFiXE2Xm3P1z9yhSOKx6Dyy5RtED
         2Hz4JMcw2nEIzbLC3/b0Jl0ypUomWRPGVFQK1mrd4BmIRIizYUFssFM6wqHvh99Aw8LY
         Gm7hLDHpZNQvsfcIwHlJlwaJcM7/gbvKEuudEUXACKtWeEYGZ5pwzIZHB6+26X333TlH
         ogosfZwQyjBebMjxSr6gYODQfzsYG7qp2MJCL2ipB5DZwXkCP/xsEq4MCpUp861wHOUD
         aoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zPZnXyNiITS1+tga2LkqtsJSSJCY8+DuMqte16OgOgA=;
        b=ra3bGcYNe/wbbM7KxgWZpHTpMtCeTFLXhlWZZ1Kv6JsC9ckmqNah0OZFJsu3a8M7RG
         L6JYI9Y6Da8tsyd/enksbFVISphYjwfErvJRD8fg1VjiYL62Z9cbXdfsIFTY8QNnJSJs
         5CMIKUjucReXGPvVS7DCY1HKww72ZuDalFGzBi1xhSfwz/qQZrpJR59/0b0ELnLnOmjc
         KyUxv+lftZd39eBCyehbZ2PR2vg8T1vznubQqMUhU3C/aUSHSHbSpgvxHUcBwtFRsZ2n
         TzVf9M6II4+i53F7bPRpUVmWOToZhRwXbkwDe/f724Koh8twcDH4T20bG42PAoF8Puar
         q45g==
X-Gm-Message-State: AOAM532OVKkUl33j3MG366VykNflXuxdE1FZRi4IeGnimutv+oiYK0l3
        bYiiaNvnJuIXymXqcqKGFsk=
X-Google-Smtp-Source: ABdhPJx2bYXVXBCJKyTo+5sI4UwIDOABWxWjS+okg5EsuFjME9+vKWnV5k8mUiIGHZHVQa9c3Xs/KA==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr27061945ejk.338.1620667758481;
        Mon, 10 May 2021 10:29:18 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g17sm14215855edv.47.2021.05.10.10.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 10:29:18 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: Remove more clock-names from PWM nodes A test with the command below gives this error:
Date:   Mon, 10 May 2021 19:29:11 +0200
Message-Id: <20210510172911.6763-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/arch/arm/boot/dts/rk3228-evb.dt.yaml:
pwm@110b0020: clock-names: ['pwm'] is too short

Devices with only one PWM clock use it to both to derive the functional
clock for the device and as the bus clock. The driver does not need
"clock-names" to get a handle, so remove them all.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9fbd96c3f..61028a5c9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -384,7 +384,6 @@
 		reg = <0x110b0000 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
 		status = "disabled";
@@ -395,7 +394,6 @@
 		reg = <0x110b0010 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
 		status = "disabled";
@@ -406,7 +404,6 @@
 		reg = <0x110b0020 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
 		status = "disabled";
@@ -417,7 +414,6 @@
 		reg = <0x110b0030 0x10>;
 		#pwm-cells = <2>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
 		status = "disabled";
-- 
2.11.0


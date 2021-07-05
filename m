Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7443BBC25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGEL2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:27:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82AEC061574;
        Mon,  5 Jul 2021 04:25:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f5so8678687pgv.3;
        Mon, 05 Jul 2021 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSq+dy0O5oRMlKOqeW803Ui/JsbCcM2UdiN8eL+UmKE=;
        b=OqCNw1vrTFsjIkGqy9R+9e6WA9nh+JeqRratgb+SWJ6MYSc8ohKiBjes6UqYUqET6l
         9r9APc79PE3PoEYeeJasXQtSqthZABzXUgiOLhWwKFpsueIhOaAHzI2lnjispYOkCX1C
         7h3e97Y7fK8awMj/Fc0Gakm5zifZn+VwGaPHY+ycWLRlw2bC8/0lZkyk+K+1YNSWX+AW
         AhrgmIPlClpE/5ZuA0txEROEWWClT50PEIJ7WzFMYvqtqCzZVOIPwrafhn9Hlkfl+5rR
         ouGLpzoziEl052WRwx9xWwektOXH7KrZ2OGAJFvXTdS3hY5GD7V5mA6rjyuwI9aEi0mG
         pQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSq+dy0O5oRMlKOqeW803Ui/JsbCcM2UdiN8eL+UmKE=;
        b=GJTn+RJS2SPHUVy5Z8FaIDYQe0Bg/bwtWpAQLQ2xZs54FsgcGr/IlhBEUq/wCdXWKg
         vFTPR7PwY6DhVtmjLOH4FvzSO3L+GAjjWQEccVdl3qDsAnPgkNuQoa5Dm2K2Q4j8FYoH
         A/rykCkl2s13/fFZ0u3BP+mcKp+6nvwHBhZ1jghSu3qkdbslOMajH/+eQ57t3lfxba3X
         +XsoknrZ8Cuhbmipgl3dea1HeIHrCvFjX3DNZRGcJZurZm1vtEim1R6hyR5dgzzdV7t/
         ebJS2xftBiJoikDEMXU0vauxvp+zc93w3FQRxHmeVR3AgE1/YmDDuBsR1paW3zuxLrbq
         wXxw==
X-Gm-Message-State: AOAM532H8EUhnn+dXI6eIfg33d/mwxxGMes8Dc8qQi/nrW360GRV1Qp0
        7iLcjuGetg4YwIBTpaJHgsU=
X-Google-Smtp-Source: ABdhPJwAk5MPlx6hiwAyy61Z2ms4m7rXtJFRdnmV9Ir0yLk3A9Eq1i8i4Al1J3Tsh6Q7tsUCQXRiAA==
X-Received: by 2002:a63:b60c:: with SMTP id j12mr15367319pgf.393.1625484320454;
        Mon, 05 Jul 2021 04:25:20 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id gi20sm20976959pjb.20.2021.07.05.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:25:19 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 1/3] ARM: dts: meson8b: odroidc1: Fix the pwm regulator supply properties
Date:   Mon,  5 Jul 2021 11:23:53 +0000
Message-Id: <20210705112358.3554-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705112358.3554-1-linux.amoon@gmail.com>
References: <20210705112358.3554-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
instead of dummy regulator.

[    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
[    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
[    7.117184] VCCK: supplied by regulator-dummy
[    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
[    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
[    7.118498] VDDEE: will resolve supply early: pwm
[    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
[    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
[    7.118553] VDDEE: supplied by regulator-dummy
[    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT

Fixes: 524d96083b66 ("ARM: dts: meson8b: odroidc1: add the CPU voltage regulator")
Fixes: 8bdf38be712d ("ARM: dts: meson8b: odroidc1: add the VDDEE regulator")

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1 - Fix the commit subject and commit message
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index c440ef94e082..04356bc639fa 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -131,7 +131,7 @@ vcck: regulator-vcck {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		vin-supply = <&p5v0>;
+		pwm-supply = <&p5v0>;
 
 		pwms = <&pwm_cd 0 12218 0>;
 		pwm-dutycycle-range = <91 0>;
@@ -163,7 +163,7 @@ vddee: regulator-vddee {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		vin-supply = <&p5v0>;
+		pwm-supply = <&p5v0>;
 
 		pwms = <&pwm_cd 1 12218 0>;
 		pwm-dutycycle-range = <91 0>;
-- 
2.32.0


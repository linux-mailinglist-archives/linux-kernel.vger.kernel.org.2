Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA5C3BBC2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGEL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGEL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:28:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498FC061574;
        Mon,  5 Jul 2021 04:25:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e20so18050421pgg.0;
        Mon, 05 Jul 2021 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2TH5jVOBgH+4QEJTPNMHLBBgJD/0e08oBjTYiq4sNI=;
        b=Pqf4YHi/dQIZKy74e16umSQiHidGvgZVANhwc1qU9L2RqmFNnvH4JbSpbM3pyV2Qsy
         9Fuenw8HQDfXJ5YmJcNCz46yQ5GSNs9M6ZFei0JGf2ZebDSrQ9MsERHrWvngEjZA2ygS
         RnmrhwY7woCZEiKHkyBpC5hjYXuv/GWPPBIj9bRzRAALDHua0T0TseE1UNpoKHPqdjh5
         PPJ9yGF5DbBp6NqgDkwy01Gxapmgf9zywsW8U71WKSAa3yOELSdNJKsRikqXnbaV5REQ
         QIv837ATw/UUaPQOUm+qdKG3iCb5EgJCTeAKWfAE7mI9xBvQU3IeU4CCvtjkypgEZQSG
         DXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2TH5jVOBgH+4QEJTPNMHLBBgJD/0e08oBjTYiq4sNI=;
        b=EIfDc5sXb31/0ccLmQ6T6sgy7MKQsJrK136b3STLL9voQIkBnwpBHgkwxk/1QtZZgR
         a+wM3QiZ5SwyPIhyseqB9P6k2ljlYz02HCccNtDPJ8IVTT/msRD/fp6WHUNuWUHfeSFX
         UInv8QskXZyKheJ9YbzLCC2R3ebq9fbyLGxix2spUDSikPvAnY38NYFIAV6Hag3hxmUI
         9/ME/q4WCopEnvgySeFpI/DfgUaPST0eHFbx2cgl1JmW8iRsRRZ1culW4U2VCaQz/ZaD
         39LegMvmT4++80OolG9h2W7IVIipy5r06B2/5mL5TWNPQP0T/PYb306mfxRQ/FcJQKP6
         PSiA==
X-Gm-Message-State: AOAM530M2ENJPTl1HkItEUnZcn2oVAHL0C5R8MBlers7tZ70CiJlbXZA
        i8LOQJjHG7vPUASCeCcsta/TQKmjwJo=
X-Google-Smtp-Source: ABdhPJwvgdqwKjKXtAl9q/7P+Q9X+61LySVkfjmu15v0eYAfaJnEqFnOGvu1DQXj8kZBqzxIujxQCA==
X-Received: by 2002:a62:ab10:0:b029:31e:4a34:b78f with SMTP id p16-20020a62ab100000b029031e4a34b78fmr6278644pff.69.1625484333422;
        Mon, 05 Jul 2021 04:25:33 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id gi20sm20976959pjb.20.2021.07.05.04.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:25:32 -0700 (PDT)
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
Subject: [PATCHv2 3/3] ARM: dts: meson8b: ec100: Fix the pwm regulator supply properties
Date:   Mon,  5 Jul 2021 11:23:55 +0000
Message-Id: <20210705112358.3554-4-linux.amoon@gmail.com>
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

Fixes: 087a1d8b4e4c ("ARM: dts: meson8b: ec100: add the VDDEE regulator")
Fixes: 3e7db1c1b7a3 ("ARM: dts: meson8b: ec100: improve the description of the regulators")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1 - New patch in this series
---
 arch/arm/boot/dts/meson8b-ec100.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 8e48ccc6b634..7e8ddc6f1252 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -148,7 +148,7 @@ vcck: regulator-vcck {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		vin-supply = <&vcc_5v>;
+		pwm-supply = <&vcc_5v>;
 
 		pwms = <&pwm_cd 0 1148 0>;
 		pwm-dutycycle-range = <100 0>;
@@ -232,7 +232,7 @@ vddee: regulator-vddee {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		vin-supply = <&vcc_5v>;
+		pwm-supply = <&vcc_5v>;
 
 		pwms = <&pwm_cd 1 1148 0>;
 		pwm-dutycycle-range = <100 0>;
-- 
2.32.0


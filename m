Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B03B71E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhF2MRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhF2MRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:17:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569AC061760;
        Tue, 29 Jun 2021 05:15:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v7so18334540pgl.2;
        Tue, 29 Jun 2021 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlqRgdeiXEIYSrXLcXViAJxLAnONyVn/mV1IwG0OAbE=;
        b=bW4owkmj3xr8ZQb2A3aCyS1AqXdnbfAz+x61VdR5tSaFnD63cXTpQcNTncWTzlN9br
         tNFPYFdKrf3Bjk27qeG7cToVRSa05Bd+3PEoqrEkteRvtNCuhzMZFAxWwpaPsXm0twNH
         6CgIpdWqKtuFc3iUB2XrG1lMo42gtZUGGXEfEnvx9l5fdGjuA5Qo7/74rsBV0ncizrV4
         Q1c9UluMJphyGuDqTcjk7sR/er2Arn11/U89bKnIFWLuYiotCYC0QqpP6X60VqVd655q
         z38GSrCaIa4J+E7u1WGG6StfOodcFetaBCob5/vrLzxhXpILKBQJbgRFydcXVKomWc8W
         SFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlqRgdeiXEIYSrXLcXViAJxLAnONyVn/mV1IwG0OAbE=;
        b=UBiqZV1mYCFp5BDjD3FBuDuwmAEEiXqr4Y3WloiCRgw8yBLcRixn6CUz1AGqMUYsRZ
         +ykKyBYMYKwQMsISy86mqm4cLFp9AbclahJF/XRxDU7uPbmTT9iURM/NKQIf5AFwAd5v
         BEff941ywsd+QGlivVb3lKl3GWN1q3fP0fNWO8PkfmkzGinASNC6qAa6hiysRLkgoNGu
         RNBFUpOqAgsy/xmNZqjoMKIYqI97TWMCrw0XsBSlgZeZFzMQ44eGVfK/jFouYKKwUi/v
         4eA/+YDBoouhB1uCGe0d8xponB83c6DvoU7TMLEUhVyqmhKBFsV+VIjIQs2Uc7FJMfI1
         Y6Tg==
X-Gm-Message-State: AOAM531db44r1Ja4JI07xVWs/5pUouDelCWCZCYUm9z0y6Axw2iYyonD
        e97xhlJ5Gmz0IThMItD7BAo=
X-Google-Smtp-Source: ABdhPJz6IDnmzNNrr0eZ/jlPZz8aRmiSr1TQxpE+yHlMpP7iqM9Uea0AslVBxgA0SSdA1DVWiu5LZA==
X-Received: by 2002:a63:234a:: with SMTP id u10mr6507856pgm.322.1624968908431;
        Tue, 29 Jun 2021 05:15:08 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.37])
        by smtp.gmail.com with ESMTPSA id j79sm19324714pfd.172.2021.06.29.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:15:07 -0700 (PDT)
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
Subject: [PATCHv1] arm: dts: meson: Fix the pwm regulator supply property in node
Date:   Tue, 29 Jun 2021 12:14:58 +0000
Message-Id: <20210629121459.6341-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On enable CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
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

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
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
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8023BBC28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhGEL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:28:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1EBC061574;
        Mon,  5 Jul 2021 04:25:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w15so17968023pgk.13;
        Mon, 05 Jul 2021 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDZbinYJBWKM1QjowJRvhAhj+rc1HIs8nrrDeByCIeY=;
        b=VuxWpwsbKgYAKFhuGVNLXs7je8SG9X6q1H6wbk8lp4t/qrILYO5kdHg2ICNpJ2APeh
         2MJVw8RCI0JOGGa2XCpckN+6DqukkPjq9xoeS+dhWRnUE8k7jDOk0X7OkRGe3UyanIT3
         muEqU6QJy3GnccAEOK8WAlHelNBUJLibdMJcEn2SnGkrbS8ofFAG1F1hQY7UZK+xeDZY
         0daz8WqxPW0RHyBUOOZxHkZxvuT6ze++UIS6LxDq1n2cxaP36IjLjds87/uX7LJAM6Zw
         pPEdOSrqt35VYFY6iplmAXsbphx2KFa+gnNyxaOP0s3CJrXv3lwHXnB7wAJwl3dxLjID
         8z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDZbinYJBWKM1QjowJRvhAhj+rc1HIs8nrrDeByCIeY=;
        b=ctvjkxpgXa1BoDd0B0P4Ocygmgmo1xTVO/ZCt8F3YIZsZpjCQlZCApNu18hyskDsY+
         8ZtQkmTpDiDC5Drvgkw+n/sPoLMn9E25NXaiTaAEdHk/xnFSdhETMRHOqVJPQkutBcUI
         KuwinUsqlmPyHW5bqYS1NjMhAv99TqY/3srJ/9f1ni6/LwbHDNYyugVR/eiWA1ooc9JY
         cuTHCQX94U1HnrZmO2Nkv7wL0x6BMXLO0/TyS/2hxIIWiqYXuM4r48CfkDBoMJ6FGdlN
         OZPW6PnW/MMWjyu1YG4YQDaBH6jgHvX0XOTzlvOJVGFOgBk65iFGRS/0xeFmVCm8F1i7
         /k2w==
X-Gm-Message-State: AOAM533X2dayr1jhYrro1XXn2uGQuR+xFTsJb4NyE8QPS57NXemZqF6v
        o/AHJxsTcI1DePVVbV4/os8=
X-Google-Smtp-Source: ABdhPJwwtQ8dB2Fr98yk4I1qmSxeeG1/V2KPB7XAz9bCOD8IjFSkA/KsL2Fcd9dPnqTiNv15KycztA==
X-Received: by 2002:a63:5156:: with SMTP id r22mr15594368pgl.264.1625484326680;
        Mon, 05 Jul 2021 04:25:26 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id gi20sm20976959pjb.20.2021.07.05.04.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:25:26 -0700 (PDT)
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
Subject: [PATCHv2 2/3] ARM: dts: meson8b: mxq: Fix the pwm regulator supply properties
Date:   Mon,  5 Jul 2021 11:23:54 +0000
Message-Id: <20210705112358.3554-3-linux.amoon@gmail.com>
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
Add missing pwm-supply for regulator-vcck regulator node.

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

Fixes: dee51cd0d2e8 ("ARM: dts: meson8b: mxq: add the VDDEE regulator")
Fixes: d94f60e3dfa0 ("ARM: dts: meson8b: mxq: improve support for the TRONFY MXQ S805")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1 - New patch in this series
---
 arch/arm/boot/dts/meson8b-mxq.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index f3937d55472d..7adedd3258c3 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -34,6 +34,8 @@ vcck: regulator-vcck {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
+		pwm-supply = <&vcc_5v>;
+
 		pwms = <&pwm_cd 0 1148 0>;
 		pwm-dutycycle-range = <100 0>;
 
@@ -79,7 +81,7 @@ vddee: regulator-vddee {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		vin-supply = <&vcc_5v>;
+		pwm-supply = <&vcc_5v>;
 
 		pwms = <&pwm_cd 1 1148 0>;
 		pwm-dutycycle-range = <100 0>;
-- 
2.32.0


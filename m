Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23741410D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhISUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhISUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:31:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60EC061574;
        Sun, 19 Sep 2021 13:29:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y8so14277976pfa.7;
        Sun, 19 Sep 2021 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie2JEfOdwkfAgarAQQw6URHCDiUg2nskqRFB/yYax5Y=;
        b=Kcxd+1d3eo4B7+Hsd9BaglHAAxY/zDeo62MrJ9O/0+iJssG0OT2/5HGg6jQ/2l8VPT
         B7OMVfV2v2c3aO/wDvAx6E+kLQgqct0YjDZPQEJceM9dDrFCjL15S1BorrHsm1VOPzfe
         vv5jROAPfu5A87+42D2hdni9iirqNI2g6Su8lOOqM1KrJY4HWtvLTNWI1Tp/za2q6nrA
         tegPwwRDzIjl9Mo5TidS4B7vTfPhuzlXtERsQg4mm9MKn1RCbTmVv2ngrfewlZJU5s4U
         6nE8uhv3G6OJOeCD8mzUxit136QwIaRxoOa8M5QGy0ESUabJENFMSNvkbSzkMQ8z916z
         hOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie2JEfOdwkfAgarAQQw6URHCDiUg2nskqRFB/yYax5Y=;
        b=xowYoDl55YAMOSnePyv/37QFI7+Kxl84g1jAH6kxXBi2x55JC3/ghJjx0XvWKPWMeU
         eoMCNpYKYu/VPYvjTF9GzBGnancvCZrDWeoPx1ybLo3NayX9Hloo7wDprXAXlFYIeM0P
         fMVupqv6/doD6T6pVvA3voaYmWBNjOSxb0zsI6vLYg/ndV6xC6fb+bRy2u1mkN57RnC8
         o9s0h5NZ/gJchNBGKWm+08a/2itEA2isDQDXBPClM5bWwfPQYUMWOO3mbK4kfCnEhGjG
         ODGySdQKHyAMDTLQ/s/KIK2j5zGVpH1CbA2vbGoc9aiIjpU8Yu4yDuGIGXPcMmBvX3Ko
         I6Rw==
X-Gm-Message-State: AOAM533LnUZB5nPNnHRkgJB6suQlF7TwuerquRaKHLRlcjipTAHDNpL9
        PUI9ZMjloxxA3DFRWp6W3Fk=
X-Google-Smtp-Source: ABdhPJzQUkScYLlLXCUIUaWWlx6Paw9NU0cLiRAziUrhO3V7AQ3MkZJfFaiPLAmVNTw0CfmtxYZF9Q==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr21724307pfm.65.1632083379911;
        Sun, 19 Sep 2021 13:29:39 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id z11sm12663684pff.144.2021.09.19.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 13:29:39 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 1/3] arm64: dts: meson-g12a: Fix the pwm regulator supply properties
Date:   Sun, 19 Sep 2021 20:29:09 +0000
Message-Id: <20210919202918.3556-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
References: <20210919202918.3556-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling CONFIG_REGULATOR_DEBUG=y we observe below debug logs.
Changes help link VDDCPU pwm regulator to 12V regulator supply
instead of dummy regulator.

[   11.602281] pwm-regulator regulator-vddcpu: Looking up pwm-supply property
               in node /regulator-vddcpu failed
[   11.602344] VDDCPU: supplied by regulator-dummy
[   11.602365] regulator-dummy: could not add device link regulator.11: -ENOENT
[   11.602548] VDDCPU: 721 <--> 1022 mV at 1022 mV, enabled

Fixes: e9bc0765cc12 ("arm64: dts: meson-g12a: enable DVFS on G12A boards")

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 81269ccc2496..d8838dde0f0f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -139,7 +139,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&dc_in>;
+		pwm-supply = <&dc_in>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index a26bfe72550f..4b5d11e56364 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -139,7 +139,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 579f3d02d613..b4e86196e346 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -139,7 +139,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&dc_in>;
+		pwm-supply = <&dc_in>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
--
2.33.0


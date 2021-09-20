Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF308412A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhIUBot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhIUBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8CC06EAA4;
        Mon, 20 Sep 2021 13:47:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso923390pjb.0;
        Mon, 20 Sep 2021 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=negJEmlBwychqQvUaf9DSXZmOiuLhN4g0dv45lSP0LQ=;
        b=L3TNF6EN7cHguOBzCM0Arz5/bPR7CEAfuw4xkWoHYts2enJhLBfEBEDkFF6l5aGrEo
         tX9Ks9e+ivtQjfJzm3LHaVWI85AI0UNW8/c3BF8+yhmLCz21mt2+EQgMJUtdcdcekk04
         kfT53llaWsbMcSClBYIVhVVUQ3YWIzjhZVrhmwFmp+o6lU/ecOhSy6wegKdAgsVG6wEl
         eSiTmtEZ9pEhulNUhBvo4YZQi0lm0eJEL8QKIwJr8CXkJ2t+4qAjbq2Jabdhb0V9nJQ7
         OiYBYythj59uoJ4MBLGbToI3NULR6fQLUFade1YEPIgHFjD/eBnJNPs10d5kRCeWMT41
         ncfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=negJEmlBwychqQvUaf9DSXZmOiuLhN4g0dv45lSP0LQ=;
        b=ap+LNxntdtN7by4vQTWShhFuDIs+iVOWU1IDE1IKGqEWXrI7oS6zjFt4kGhOvXwl00
         UuMKtnCZ6LUq0eQLB2EXRi6NVJ7k0Xnz6y3MHeaZGOnfu8ef5ujyS1dCe2h51ZTUAuY6
         wN0S+1KU8mpDUO3iqFSwZNqr35YJh1r8OtPHsNj7qqltGxjy/H2rS5MKHPDoOidHsRwo
         akAhEHkNEmJf9PDl2/SxjjaWfSSWAApw4lPvfueKWHFYfli4RQd+PlrE1ECHGBdUydkp
         kbFedWJ3/bnbkhDBi/m6lG/TTIW45YW6VbtkddaSTNoLSH9Bv2ETk5E+W/mM9l8NBCQN
         xHrw==
X-Gm-Message-State: AOAM530XYun3klqPEsImbcNvqNtU8TfFKvpwpx48azYHlpXVEdM10opv
        Ske+wlHLitDb8f8pP51fbNU=
X-Google-Smtp-Source: ABdhPJzM7a6CEuViVnduDd3u0m+ZsprmeQW+c4ZNJ6T0udLTS8gWdvP73PxgnLhxbPjlGU30vi6qLw==
X-Received: by 2002:a17:90b:605:: with SMTP id gb5mr1031850pjb.51.1632170873344;
        Mon, 20 Sep 2021 13:47:53 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id u10sm15250263pfn.147.2021.09.20.13.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:47:52 -0700 (PDT)
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
Subject: [Patchv2] arm64: dts: meson-g12b-odroid-n2: add 5v regulator gpio
Date:   Mon, 20 Sep 2021 20:47:37 +0000
Message-Id: <20210920204739.950-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Odroid-n2 & Odroid-n2-plus schematics,
the 5V regulator is controlled by GPIOH_8 and in Open Drain
since this GPIO doesn't support Push-Pull.

Fixes: c35f6dc5c377 ("arm64: dts: meson: Add minimal support for Odroid-N2")
Fixes: ef599f5f3e10 ("arm64: dts: meson: convert ODROID-N2 to dtsi")

Cc: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1- Added missing Fix tags and update the Neil's Ack
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 344573e157a7..26943c53dfa7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -99,6 +99,8 @@ vcc_5v: regulator-vcc_5v {
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 		vin-supply = <&main_12v>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
 	};
 
 	vcc_1v8: regulator-vcc_1v8 {
-- 
2.33.0


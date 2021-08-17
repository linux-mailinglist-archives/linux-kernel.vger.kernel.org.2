Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9643EE573
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhHQESd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHQESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:18:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF8C061764;
        Mon, 16 Aug 2021 21:17:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso2778589pjh.5;
        Mon, 16 Aug 2021 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpxBu92wuMGjuu73ePdt2ALcCgck/seakH/934m3wMk=;
        b=n5HdRhWN5TbSsnCX5eXDbIAbobwmKyo+CHqfdwkqrdHQnVLWXT8u+L8nIGHr/ECqzb
         LnEjs3TlTcURBN1F1O4OnGvtU9DhfM16sEj1b9HqXw4SBXTIimi/6pKKRuVvJz0RX65o
         wC7lDDVsPali39wzzZaYD6xBKsF+3meHaUR9BFSo8QlGS41AWghmEocachcYu+qygeDD
         ugY8xvQggKaURnuY5a3tr9/6uw1apcJav2Tb8OBA+lu/NLi6TlsmACO6bVzj0KVzDQQF
         huxwClnFDfmTO2ppMM8PEXUxM4vSXdvTFzQJz8cwQ9PxSLg8O4rOq+IUeau3DRAlenF+
         M++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpxBu92wuMGjuu73ePdt2ALcCgck/seakH/934m3wMk=;
        b=HRtdLVKZrNjCJZ/hkkmpL2TkMW2OtsmoP4LueuyzKEacL0IVrELkBn11XoBOYCBQ/s
         b2NBLhb+j42rlKE+1LB9uLn4gqsJccY17hjjhmtJjIM8TKIq4bu24trhduN8e70mN3MK
         UJQyMkSs4PGzhvoeIjfttVbqLKic7mM9unsswxZ2rBKktoQQjnrzh80QhCrKcSLIfIMc
         PJ4ywrdLC2vJK7dzBQBxji0B7hOkGEFERGqoFlsGolAwSTMIuOEdFHC02+ghIbv21Plo
         ca1gKRDF9cKrIcIdAxGSN1WuISQUbsUUqFFngtF1Ko2EafIiX+LaozNTfQDoBgpTKbEM
         rU/w==
X-Gm-Message-State: AOAM530yzFIy9HhmqTrUK+UHSRyVMXWWcn3sRit5vhyBYjAWRZSFAVrX
        EkExSkCGhAiFCkiGUM38c44=
X-Google-Smtp-Source: ABdhPJx9t0wz2w+3ZEoqQyOMi/HcbFuDmHp37FDbVUWs25k7cQkfmZM1eB4P53YnrNBeune7MzcWuA==
X-Received: by 2002:a17:90b:4b45:: with SMTP id mi5mr1498660pjb.43.1629173879025;
        Mon, 16 Aug 2021 21:17:59 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:17:58 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 3/6] arm64: dts: amlogic: odroidc2: Fix the chip enable signal for usb power
Date:   Tue, 17 Aug 2021 09:45:37 +0530
Message-Id: <20210817041548.1276-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the chip enable signal changing from Active High to Active Low
to enable input power to USB power. Also updated signal name as per
the schematics.

Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2:
Fix the typo: shematics -> schematics
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..3f4f16a5dedd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -38,12 +38,11 @@ usb_otg_pwr: regulator-usb-pwrs {
 		regulator-max-microvolt = <5000000>;
 
 		/*
-		 * signal name from schematics: PWREN
+		 * signal name from schematics: PWREN - GPIOAO.BIT5
 		 */
-		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
 		/*
-		 * signal name from schematics: USB_POWER
+		 * signal name from schematics: USB_POWER - P5V0
 		 */
 		vin-supply = <&p5v0>;
 	};
-- 
2.32.0


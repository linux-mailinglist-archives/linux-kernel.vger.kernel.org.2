Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7643184D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhBKFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBKFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:24:14 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E9C06121E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:46 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e7so3113027pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drLaSc5ZM86pYsr4qLGvKU8aVv9tTxJbObF+iwNMmEQ=;
        b=jp6hj6pAZiQPW3brKYdJFQwHu7V/w6I6J6wMmvcoskkhHdvU5VWS3StPS6ZKXC0vDu
         fRLGvDYkHBrB/12nBLeQjy+uAynaTZfcN+UCbE9hsP8CJP4KrsMTCtWUE1+eCR187F+Q
         0lkoF9qUAj3hkLRMVH5+eOY2Zpa2qUcMd7YPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drLaSc5ZM86pYsr4qLGvKU8aVv9tTxJbObF+iwNMmEQ=;
        b=LRSIGdi6UEIk2humg5o9NzDgq6FMcn1j1CXLXpn6wDl3OPT0tMOV0u/1iIPP/Phf+M
         Z46G0GRMdKEGALFyaobUXYjyc0HYcjIqQZAVeY+9i4ATGWiVXuLNoSMuGFxU58JDLQFk
         PjNsJvA68U682q55z2qjSDOqDcun3eJ60hAwT409p06SMf3TdJjcZBvJquzD26BTNanQ
         f6jFUToxc+76IV1CibTBdukiLS2oz2kkB9UQ0PYCHRglBNcePaY/IKuwG6NFW0VNM8u6
         ezUcbSS2/blJDysqiKDkOPxfsOr6Otn09FELo0KmmoY8um368vjEpiT9tNdN4pZLntpU
         IdpA==
X-Gm-Message-State: AOAM531xzUSs1GirWVJSJTn9QmXUzRTfJCVlObLFcLKyWTM+Ry1X6B7P
        cRLfmFHTI9li15FZLr52Di1MaA==
X-Google-Smtp-Source: ABdhPJyHpMF49V0rRYm+e1K3qaBAEMF89qgT53q/leQhoUKNZHISqHdbh9vE3U7pIb57dPPHmnMhXw==
X-Received: by 2002:a63:215f:: with SMTP id s31mr6408465pgm.146.1613020965624;
        Wed, 10 Feb 2021 21:22:45 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id o21sm3493511pjp.42.2021.02.10.21.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:22:45 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 6/7] ARM: mstar: Add the external clocks to the base dsti
Date:   Thu, 11 Feb 2021 14:22:05 +0900
Message-Id: <20210211052206.2955988-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210211052206.2955988-1-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the currently known MStar/SigmaStar ARMv7 SoCs have an "xtal"
clock input that is usually 24MHz and an "RTC xtal" that is usually 32KHz.

The xtal input has to be connected to something so it's enabled by default.

The MSC313 and MSC313E do not bring the RTC clock input out to the pins
so it's impossible to connect it. The SSC8336 does bring the input
out to the pins but it's not always actually connected to something.

The RTC node needs to always be present because in the future the nodes
for the clock muxes will refer to it even if it's not usable.

The RTC node is disabled by default and should be enabled at the board
level if the RTC input is wired up.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index b0a21b0b731f..889c3804c251 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -46,6 +46,21 @@ pmu: pmu {
 		interrupt-affinity = <&cpu0>;
 	};
 
+	clocks: clocks {
+		xtal: xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		rtc_xtal: rtc_xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			status = "disabled";
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.30.0.rc2


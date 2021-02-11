Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689273184D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKF0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhBKFYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:24:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFFC061221
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so3030750pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vk7Z0AS7ak4J0BwIBs0zSntFuze/upcDQo3SRk3ydVI=;
        b=m4hEkGAhe/bsNcOv9Y6cZl08ZjTGXhVFHQvUJtbARWhP3WYfyhNlc9HVPtW0kFkBLt
         6Fq+zWLqWe8hlBhKhY68VS5cA+5RjXodulpr2PmzOb1NmT3Q4pfkqUFgq685zVyNEhz2
         PNG1xv3+zvMSVcujr9L6wd7ahhwYtmyqROBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vk7Z0AS7ak4J0BwIBs0zSntFuze/upcDQo3SRk3ydVI=;
        b=Ul3DtkUQDwZYV80KwONNUwJaTAUjKiE1dpUEWFGI+R1REzJD45tMjQsJ9RbYgKXDDd
         iwj/0d+rYuRu3NUJ68qdxFPI1rLu6R/JKifp8FpvYhtmuxIcc8+wK4GXRStbbmj6Hyfn
         YZe46zoGx5WDhiwc27ovjWZ3vQz/uT51SgXiq0leKVxgtqOuIPRqc3NUiugkHgtOoMdb
         UraVapnb1sChdUOtxF+kvWb1nlSeWm5tBl2GpcsBQWE5WEQuq9pggID1zwb9bdja/H0p
         IUGlfQvM3u+giANyVCR7CLgsE5xkQMc0GuFvLV/ik9KblvPpE9lHvPFKCnIe6JI78khE
         778w==
X-Gm-Message-State: AOAM531wuE7bUpawbZSkPh8O28oCg7F9rcg54sWs2314Y+6lD0ewX3HL
        +98AeGfRjtIR6/wbSa9M0GAsyw==
X-Google-Smtp-Source: ABdhPJyISaJ8cwyL7Zx0SCuhZTeWSCJmZ3TmVwLz+shRCM5N9O/vaXtiCDAHszb9as31QHnl+NVk7A==
X-Received: by 2002:a63:c741:: with SMTP id v1mr6379922pgg.316.1613020968122;
        Wed, 10 Feb 2021 21:22:48 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id o21sm3493511pjp.42.2021.02.10.21.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:22:47 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 7/7] ARM: mstar: Add mpll to base dtsi
Date:   Thu, 11 Feb 2021 14:22:06 +0900
Message-Id: <20210211052206.2955988-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210211052206.2955988-1-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the currently known MStar/SigmaStar ARMv7 SoCs have at least
one MPLL and it seems to always be at the same place so add it to
the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 889c3804c251..075d583d6f40 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mstar-msc313-mpll.h>
 
 / {
 	#address-cells = <1>;
@@ -124,6 +125,13 @@ l3bridge: l3bridge@204400 {
 				reg = <0x204400 0x200>;
 			};
 
+			mpll: mpll@206000 {
+				compatible = "mstar,msc313-mpll";
+				#clock-cells = <1>;
+				reg = <0x206000 0x200>;
+				clocks = <&xtal>;
+			};
+
 			gpio: gpio@207800 {
 				#gpio-cells = <2>;
 				reg = <0x207800 0x200>;
-- 
2.30.0.rc2


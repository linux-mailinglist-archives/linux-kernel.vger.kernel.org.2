Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAF4528F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhKPEFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbhKPEFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206CDC07C913;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h63so9168002pgc.12;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BnmYhRHMbl6al/VZfPwCvPsCh3WqVvvOInhNYAOIIuk=;
        b=awStt/vVYkrbKeess7rNUzcu65CfFVivaIUwzRDyQg1H6nxn++Z600P5hPhi15LUmh
         Rch1EJTsxqiM5IUHn2Ix+yp51SjifJ8TT5VnoCveGyjc7Mx48fRI5X0gi2Qe2rDpsJpm
         pQw1ES/6ANIETPYys65GcQ5AS9ewuawphftY900sTlBSA2F5F80mVKOAGp9Lf3tzZYqN
         t54AufbSD9jJK3tkynk38tObKpaDGC3m8+qR4x5mijTqRcAd0SROULT4xsLVdApyXZBy
         2xKNIHagyl+ErIyqta1OjTKhm0IuF/XMj6G7vFuAabPyC21o08ld81+VuLUC0Vnxw+1Y
         qSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnmYhRHMbl6al/VZfPwCvPsCh3WqVvvOInhNYAOIIuk=;
        b=shTiy5uBUrMuEWaGpTBmt3SM4MBsim7fqth2ZbFyAh8WxAhNr0mjCNfhu0WSN+JlGw
         KsDZvMEm4xAbS1sBZ9RbEKgERHFlsWH6m0wV30f1kwgSotXRrN7X1/S23W0Bsb6zwiu5
         OBTcJTZX58jcuis9JvAK/HB+huJ2VXdZX8CxKUThdm5qN7ae8L/IYfF6xKwubKbupTWt
         JgA5S414vSn+QQIxilaWBx0i7kQDW2bAcMdLiWLmlhB4+evyF4kZmQ0C2IkHDDiSeH5D
         +wE62xLu5YE+NZT5e6KmtkuqYjJmegd1qk2H0qY60efPoqgkT9jcYKWSBBgW7ySEt65M
         GBzA==
X-Gm-Message-State: AOAM532puixtK7M76MfIgTUa7tqXeYlY8ewEUcGCX4R1jyUWboE758Ua
        R8NiOofzvvs0i7oK4H7qNJUMc1frht51GfOz
X-Google-Smtp-Source: ABdhPJw/GR5ON0SN/Z+RpccDkF2ZW7HKJZcxlk60eX8P/cUfJgS6ystchbfoeziDSG6Hg1M7JRP1OQ==
X-Received: by 2002:a63:4542:: with SMTP id u2mr2232907pgk.396.1637023985658;
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id p14sm452548pjl.32.2021.11.15.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 7EF82900959;
        Tue, 16 Nov 2021 00:53:03 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH] riscv: dts: sifive unmatched: Fix regulator for board rev3.
Date:   Tue, 16 Nov 2021 00:53:00 +0000
Message-Id: <b9bccf0b5b9373994298dc51e7ddf1f455d211b9.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing values are rejected by the da9063 regulator driver, as they
are unachievable with the declared chip setup (non-merged vcore and bmem
are unable to provide the declared curent).

Fix voltages to match rev3 schematics, which also matches their boot-up
configuration within the chip's available precision.
Declare bcore1/bcore2 and bmem/bio as merged.
Set ldo09 and ldo10 as always-on as their consumers are not declared but
exist.
Drop ldo current limits as there is no current limit feature for these
regulators in the DA9063. Fixes warnings like:
  DA9063_LDO3: Operation of current configuration missing

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 .../boot/dts/sifive/hifive-unmatched-a00.dts  | 84 ++++++-------------
 1 file changed, 24 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index e327831d0d48..bd6e90288c8a 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -93,47 +93,31 @@ wdt {
 		};
 
 		regulators {
-			vdd_bcore1: bcore1 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-min-microamp = <5000000>;
-				regulator-max-microamp = <5000000>;
-				regulator-always-on;
-			};
-
-			vdd_bcore2: bcore2 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-min-microamp = <5000000>;
-				regulator-max-microamp = <5000000>;
+			vdd_bcore: bcores-merged {
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-min-microamp = <4800000>;
+				regulator-max-microamp = <4800000>;
 				regulator-always-on;
 			};
 
 			vdd_bpro: bpro {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <2500000>;
-				regulator-max-microamp = <2500000>;
+				regulator-min-microamp = <2400000>;
+				regulator-max-microamp = <2400000>;
 				regulator-always-on;
 			};
 
 			vdd_bperi: bperi {
-				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1050000>;
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1060000>;
 				regulator-min-microamp = <1500000>;
 				regulator-max-microamp = <1500000>;
 				regulator-always-on;
 			};
 
-			vdd_bmem: bmem {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-min-microamp = <3000000>;
-				regulator-max-microamp = <3000000>;
-				regulator-always-on;
-			};
-
-			vdd_bio: bio {
+			vdd_bmem_bio: bmem-bio-merged {
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-min-microamp = <3000000>;
@@ -144,86 +128,66 @@ vdd_bio: bio {
 			vdd_ldo1: ldo1 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <100000>;
-				regulator-max-microamp = <100000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo2: ldo2 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo3: ldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo4: ldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo5: ldo5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <100000>;
-				regulator-max-microamp = <100000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo6: ldo6 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo7: ldo7 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			vdd_ldo8: ldo8 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			vdd_ld09: ldo9 {
 				regulator-min-microvolt = <1050000>;
 				regulator-max-microvolt = <1050000>;
-				regulator-min-microamp = <200000>;
-				regulator-max-microamp = <200000>;
+				regulator-always-on;
 			};
 
 			vdd_ldo10: ldo10 {
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
-				regulator-min-microamp = <300000>;
-				regulator-max-microamp = <300000>;
+				regulator-always-on;
 			};
 
 			vdd_ldo11: ldo11 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
-				regulator-min-microamp = <300000>;
-				regulator-max-microamp = <300000>;
 				regulator-always-on;
 			};
 		};
-- 
2.33.1


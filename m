Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A713AD9F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhFSMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhFSMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:21:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C1C061574;
        Sat, 19 Jun 2021 05:19:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ho18so20379863ejc.8;
        Sat, 19 Jun 2021 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqaKCJ/vNidDzmWvE8Ei4HGIsfolJuD4g50roz5brLo=;
        b=p6DFUjdh9W+9ZOuXEgrAJzqvw4HlQfCSoE5KjuaOhEiqgIKfbquadYu91Z6lYGSwsU
         Pg1uV2sBaAzDDIIYwmXosaQwqRYvFEhmhH6av1PPy4NMijcSJVT+a9s+bt+yUweK79mH
         cuYjufd64+ARD7R08LaxvW0SIUNBUj2EqslfXO5XLDWyzYYCCulefa1lxGL3VGsURur9
         w+tmDFSmTXjs666V6TARTvMCSxAlWKSlpYq9l/qdJNq7OQfXqCX5mcjSZ1g/f2GtFAbP
         uK+9jnidGTeFmYoJYKVV6hwKPwm1Ju8j2LXsWaDLY5TfFQTMMvqAnvcmscC0S39Bim/B
         OH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqaKCJ/vNidDzmWvE8Ei4HGIsfolJuD4g50roz5brLo=;
        b=ANr4B7xh15EYErid08aJPdnze0IwuC6Ptzi+amQR5YXD9VJ7P7VtQKaR7ZUzLLH2xB
         dlcl3F87Fae2kPcHiPrCDRwulzXOpyKhzH2Zp0xsEbs3+dHpd/I1oJcJiS0tsHwgkB3S
         4dafFiqAHU1LGm8CgJzIr0bOSkyREYpBftmUKX7bNR2jduo6BArIkBJnQSB0S0EncKfp
         HlpsiVcJLqBaGuOiP/u3JaPgTlfHLgdUmgnW7jlE5L9DEhcHIQG8CQ7krFxcoyQvQrQJ
         RQ/6UfSxLfLsRrPI502sqYT9/MsqhbZMjfcPGqAbEtEgKvhFnNmbyprFeJhqEXkcw96y
         WNmQ==
X-Gm-Message-State: AOAM5321x3PtbYWkuaQhM4/ng0wBt3sDDjxm0q/nmXjHH4fgUeGtW7NE
        +bKQ7aU7DvGI1bsrl6pLBtI=
X-Google-Smtp-Source: ABdhPJwsOi2XYm8L1rzaXqA1OPOhf+cK6DVMTj8QYRFL3OnvtqeS5oJ1CV+q+F0i+1jUniYnzLzcyA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr15243159ejb.542.1624105179476;
        Sat, 19 Jun 2021 05:19:39 -0700 (PDT)
Received: from BLUE.mydomain.example (83-87-52-217.cable.dynamic.v4.ziggo.nl. [83.87.52.217])
        by smtp.googlemail.com with ESMTPSA id w17sm2299405ejk.112.2021.06.19.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:19:39 -0700 (PDT)
From:   ericwouds@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Eric Woudstra <ericwouds@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix mt7622.dtsi thermal cpu
Date:   Sat, 19 Jun 2021 14:19:26 +0200
Message-Id: <20210619121927.32699-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Woudstra <ericwouds@gmail.com>

Cpu-thermal is set to use all frequencies already at 47 degrees. 
Using the CPU at 50 for a minute, the CPU has reached 48 degrees, is 
throttled back to lowest setting, making the mt7622 terrribly slow. 
Even at this low speed, the CPU does not cool down lower then 47 so
the CPU is stuck at lowest possible frequency until it shut down and
stays off for 15 minutes.

cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
                 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

This should not be set al every cooling map. It should only be set at
the highest cooling map. Same as in the example:

https://www.kernel.org/doc/Documentation/devicetree/bindings/
thermal/thermal.txt  line 272

But then without the fan and added a third map.

Now temperature will be regulated at 87 degrees celcius. At temperatures
lower then 87, all frequencies can be used.

Also see the post:

http://forum.banana-pi.org/t/bpi-r64-only-10-cpu-speed-at-already-48-
degrees-celcius-speed-not-increasing-anymore/12262

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 890a942ec..b779c7aa6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -170,14 +170,14 @@ cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu_passive>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 0 0>,
+							 <&cpu1 0 0>;
 				};
 
 				map1 {
 					trip = <&cpu_active>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 0 0>,
+							 <&cpu1 0 0>;
 				};
 
 				map2 {
-- 
2.25.1


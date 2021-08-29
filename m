Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E513FAEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhH2WjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhH2WjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:39:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BEC061575;
        Sun, 29 Aug 2021 15:38:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i6so19796459wrv.2;
        Sun, 29 Aug 2021 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0TveZoZ8oNTWULN8QNEQfyPvlN4L18et67NPrsFtbs=;
        b=T8bkdU+eGis53ocm5/R4Y8h4e4DD/EIpcDX91jmO9dJGYfTYTEhQxZ85J/9AHRCnCP
         q/pUJj/zfEYiq5czUPw+0oT5OhAMICEJJgEm5ZaVXtr5z2NYxcg1g4DLNgQvzeMkZIHQ
         rDs0K7x7HR6Vjca0h0/sLQ0pbQP7nXDSqKJeBP9kwF0HCxzlOT77XrgGQes9gbFu6q5S
         muup3PZFxD9ubTOA9xBatqcX0lvEwIywgFY/ej8cI7Ete39x8lp+QIIWRdq1YGFVjM/z
         4MDZZFSZP9F4p+1dAelwJr1hzQLAjo621RvfMqUeFLE3ZFgWdxJNPVR0ZRK7QREYBYyn
         mA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0TveZoZ8oNTWULN8QNEQfyPvlN4L18et67NPrsFtbs=;
        b=M7klBQzF0e54ydZPkDEmHApAIJGKoVbRi0LmKOdQ8qS+o91Mjzk+t0lPaiJ2iB69SC
         tHR4VyHoX2uTXjJalyLI39/R8mxDU2Gy2aZv8cnOyQSOxPDiFmJMmQ+NvpsorE/q2XKR
         GrxrV9wcy+LjZF859VV/mKU5HluCyuZlhwb+zdWU7uGMaUhuzqIpKsbfzbeDehyHQWfF
         y/FrrBI4mtqmL8sJ0VGLWIYEHnVcdwJVG0mHF3tRv8K1T8iIW2Kfo2UvvaoOnbdQNyim
         XlTzvQmWyxSmkbzl3TTubEYcxCOoa4SKKu1wzgj+q8LEY/7FAalgWxERbI0BuXXmnaSx
         mugA==
X-Gm-Message-State: AOAM532Kxq9tVVJWJY6g8iH3d3cYp+K+uJcEkrJj3R+F8F7dyJO5Jwq8
        Fy5bjcWtX5IQ2kQH3XVBIHc=
X-Google-Smtp-Source: ABdhPJwNol+sV0hkoiW0yV1lH9Hc9aNLjqh+tMQAxksEFG4GxZs3QxSdtfQdT9NOgef1ATAD3DrjGg==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr22821643wrm.394.1630276697917;
        Sun, 29 Aug 2021 15:38:17 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id s7sm13603878wra.75.2021.08.29.15.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:38:17 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ARM: dts: NSP: Fix MDIO mux node names
Date:   Sun, 29 Aug 2021 22:37:49 +0000
Message-Id: <20210829223752.2748091-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210829223752.2748091-1-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While functional, the mdio-mux-mmioreg binding does not conform to
Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml in that an
mdio-mux compatible is also required. Without this the following output
is observed when running dtbs_check:

mdio-mux@32000: compatible: ['mdio-mux-mmioreg'] is too short

This change brings conformance to this requirement and corresponds
likewise to Rafal Milecki's change to the BCM5301x platform[1].

[1] https://lore.kernel.org/linux-arm-kernel/20210822191256.3715003-1-f.fainelli@gmail.com/T/

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi                | 2 +-
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 6f2ccd059e73..180827500f25 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -371,7 +371,7 @@ mdio: mdio@32000 {
 		};
 
 		mdio-mux@32000 {
-			compatible = "mdio-mux-mmioreg";
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			reg = <0x32000 0x4>;
 			mux-mask = <0x200>;
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 8860f2fefc63..57d0c5eb9749 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -72,7 +72,7 @@ led-5 {
 	};
 
 	mdio-mii-mux {
-		compatible = "mdio-mux-mmioreg";
+		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		reg = <0x1803f1c0 0x4>;
 		mux-mask = <0x2000>;
 		mdio-parent-bus = <&mdio_ext>;
-- 
2.27.0


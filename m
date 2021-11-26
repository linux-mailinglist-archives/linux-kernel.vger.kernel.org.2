Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A345F5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhKZU2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbhKZU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C6C06175B;
        Fri, 26 Nov 2021 12:22:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l16so20950151wrp.11;
        Fri, 26 Nov 2021 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bjLeLE8NisM6I6x1ix9MSyRmnprV2Uww+hlJ5LbrFk=;
        b=jAea0yatGm2kjrF5pO/TRDoDEIdz9mmVwiuKkzv5K1FHSXMraphJ2xs3Zk9umxV6tY
         7oTuIH/SkGA69zCglBihqdSrdmEb+X83lcl/g2edGvCidp0ryd/Sdxfysk/Yu4GdvMbY
         etkaRn2JvNAszHS6/myD4fDxFtgm3MAhWyLxa0Wf0NDTxqNba4enQfvsoPONclR2tcEo
         Vegs403IjyZhp1nO6bO0G1J7Re4eB0q17RjckEKzaSzwMgM2rMmLCIzpPu4fYnfJXofY
         sp6KKcDHa/TgOxr5NCXVPiiAVZYxryv+qsyP5UxKQ++nKcI0xmOXVt0cXWNfH1KlGsZD
         pzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bjLeLE8NisM6I6x1ix9MSyRmnprV2Uww+hlJ5LbrFk=;
        b=aSI/6vqxckpSD1gkLR3lsiTzCeEjIELe9GFr/cI84VOiZGT+NOdcxTyZOVWsK2/aQ+
         tZ/a28jR8tEeKMg6A47umwR07d9watWnqUehTdREPjN//uF7qHgFcF0QD0P9IGRmKB+F
         7+93jQDhousnNxCXSlm1nlQWLKnGHf7bV0GGZDAYyyA/SAuo4LJzi4MN4/YS8WRNGfWf
         a/tRLSvj7uekRrg4Q5QxtpwbIMx1dcSgHMUbQQSBOW5mGYni/brsQiN0tRG2fBedHaQf
         HPmyjhbQAwEBCzjpNjEZTvkwWZerB30XS+fN9ngNFi7iwUbKu8q7kb2Tq2Qgmgn7Z3d4
         5sFw==
X-Gm-Message-State: AOAM531elZZgrm0M5ijU5TTm+BBxu2ugWWDniLXiK543VBL+aCfwZjBX
        eMLGScjMMPRvwRu70b+M9R0d41meAw4=
X-Google-Smtp-Source: ABdhPJwkMeFhdNvv6zrQBQAJpIm1bhwUMJDtlNZjSQHYx7AO6OXvKEqLvLWtoZ+ZErqWeVYTr8bBWA==
X-Received: by 2002:adf:b34f:: with SMTP id k15mr17056010wrd.125.1637958126248;
        Fri, 26 Nov 2021 12:22:06 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id u23sm6980262wru.21.2021.11.26.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:05 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: mstar: Switch to compatible "mstar,ssd20xd-timer" on ssd20xd
Date:   Fri, 26 Nov 2021 21:21:44 +0100
Message-Id: <20211126202144.72936-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the real oscillators as input of timer1 and timer2 and
switch to "mstar,ssd20xd-timer".

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
index 6f067da61ba3..6ff1f02e00a0 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
@@ -6,6 +6,14 @@
 
 #include "mstar-infinity2m.dtsi"
 
+/ {
+	xtal_timer: timer_xtal {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <432000000>;
+	};
+};
+
 &gpio {
 	compatible = "sstar,ssd20xd-gpio";
 	status = "okay";
@@ -15,3 +23,13 @@ &smpctrl {
 	compatible = "sstar,ssd201-smpctrl", "mstar,smpctrl";
 	status = "okay";
 };
+
+&timer1 {
+	compatible = "mstar,ssd20xd-timer";
+	clocks = <&xtal_timer>;
+};
+
+&timer2 {
+	compatible = "mstar,ssd20xd-timer";
+	clocks = <&xtal_timer>;
+};
-- 
2.33.0


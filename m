Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D63907BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEYRd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhEYRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:33:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:32:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b17so37244386ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FX+Myz9UW9+R3DoFF03APM91XZJ8+7X0lpmWP9GVHdc=;
        b=j3/RnxzjxBQSByHoAXbaUZpLCoRKxj6b7S4lVDAMFxmWZ9K9Y8vp3bcjnonF1J6YoV
         CFqMmCUnRQ0AjRprdBTtwoAuX3pchRY9X3IFu8qrOeGoz1sFiAXNMLBCbFUdalsd+JTl
         TqfuE0kwZcqaDCE+ru1t/sVtYWAKprjX5cljC7MO7PvS5pW0Vye1a0z5p7UmFDGbUp/V
         eO1OI5OdP7CC7+P+xRZqN1sKYYaSaelwrEQ++hal2SyblpLpqhmuOUbhFB83E4j+PNcg
         VsBUCGbrsIQcS7iBAFfM/3+2p0iLRMYk2qa0tVUxCJbx7KRWSi9s7Zp84q6gps76VcRI
         3q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FX+Myz9UW9+R3DoFF03APM91XZJ8+7X0lpmWP9GVHdc=;
        b=R94xR1IQGiC4Qzl3qf+c9zOYRokxnXsYtNFjpjotTJ9Jnj5HDElTnfFovsgS7eSyT6
         fouLg+BMXlZCrTQPixeYkYzlq8BVGE/hEUSgXwl0Fx17sInY2G5we2y1zlxU5UEs3/rM
         AnkJjfbvtfkhyy+fJ1Ac2l8yaZY0Tsw3g1n2IuBtZWmAQmC+rp0YcBilXVSvLu5K+6WN
         46EusHnaY2XHus7budznmumXtXeXilldXhEBRIl8Lbun6Oe10Ag5iVaUYnTM2owH/XMQ
         m4c67Rpxs547x9bK8askzRlHXbpjBiWO/17uHtzKHAzM0lylDF/FfeIUwHnGskOKLUgh
         GaTg==
X-Gm-Message-State: AOAM533WXh/LHqKlIgR5p0KlCPpEtRtKwJN/aZb7ZOpXkc6dcRoeda94
        twgFSaZ+aY/D2kA25EbDVjI=
X-Google-Smtp-Source: ABdhPJzqbdQp4LPkjittPUdOdComclEgugyKd2qH/RiZEWU244OkNGIfIUuVKM4ZdqJ7Hv7F1iPl2g==
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr33179428edb.113.1621963939861;
        Tue, 25 May 2021 10:32:19 -0700 (PDT)
Received: from flex-5.fritz.box (x4db5b374.dyn.telefonica.de. [77.181.179.116])
        by smtp.gmail.com with ESMTPSA id z4sm11061591edc.1.2021.05.25.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:32:19 -0700 (PDT)
From:   Andreas Rehn <rehn.andreas86@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com
Cc:     rfried.dev@gmail.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andreas Rehn <rehn.andreas86@gmail.com>
Subject: [PATCH v3] ARM: dts: sun8i: v3s: enable emac for zero Dock
Date:   Tue, 25 May 2021 19:31:59 +0200
Message-Id: <20210525173159.183415-1-rehn.andreas86@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210522205039.179486-1-rehn.andreas86@gmail.com>
References: <20210522205039.179486-1-rehn.andreas86@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwmac-sun8i supports v3s and
Licheepi-zero Dock provides an ethernet port
furthermore, align nodes in alphabetical order

Signed-off-by: Andreas Rehn <rehn.andreas86@gmail.com>
---
Changes in v3:
	- align nodes in alphabetical order
Changes in v2:
	- add ethernet0 alias.
 .../boot/dts/sun8i-v3s-licheepi-zero-dock.dts   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index db5cd0b8574b..752ad05c8f83 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -49,16 +49,18 @@ / {
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
 		     "allwinner,sun8i-v3s";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	leds {
 		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
 		status = "disabled";
 	};
 };
 
-&mmc1 {
-	broken-cd;
-	bus-width = <4>;
-	vmmc-supply = <&reg_vcc3v3>;
+&emac {
+	allwinner,leds-active-low;
 	status = "okay";
 };
 
@@ -94,3 +96,10 @@ button-800 {
 		voltage = <800000>;
 	};
 };
+
+&mmc1 {
+	broken-cd;
+	bus-width = <4>;
+	vmmc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
-- 
2.25.1


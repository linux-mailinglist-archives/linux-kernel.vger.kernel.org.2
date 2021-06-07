Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5439D56F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFGG4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGG4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:56:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E49C061789
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:54:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m18so16259300wrv.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1M00BIXNHjbYONusKxop0Uf6pH0dXi9px3pnctoNpiQ=;
        b=rOwuFqH1U+UWA98YWVC/Z4EZh859kA8eOey/658SqyMYEf9h5/CZ8QN/soWTzMbCIF
         +xr4OIFSMV4iqWS4qHb/416IjpqhCGs/T6FSTUPNL5nat2R5yTkZ4gKC3jYNyLjDevEc
         XFXvFM1WoBd8PCf73ef8QxrTfZMRRPTic73IQQA7KLWMJt3fsHTdRMQAeb0CQOWpvRMG
         TcWcRsAUFNkQEyagf8cwi1YrVN3CQvtTJPIVpbh+2RUN/cuCvFp0LyDNaTvMInGOl9GK
         gTE/9GwKQDtP0V/drKCoPuJBjjSQFDSdHrCUcTEwaOWdurUsMF3AbpLqwlutnf79yBm9
         gNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1M00BIXNHjbYONusKxop0Uf6pH0dXi9px3pnctoNpiQ=;
        b=YrEJKEVlBEk2hpY3Z6iGN7xpE2jxcVmYTBNMknOyl0iEsteRPu4vYemCXKgJEgq3ME
         HxJw1S6mX/tzMskmf8DuNWhl6AuZnB0B/B/wUtj4VNrWFN9FCddvcVSNPfE0BbVBA8ho
         8UZGqAv9JmRCi9J958PtT8TSuYEidseSyhgect3ZYuSgo7p3J38i2Pl04kS7v7IEETp+
         bcYh7CwjB3JCsPx40DEAXPBDVqzNtJ0wcr41wRLViPf05XR6cCSQAx6yCwtsYGBZpAwz
         16jmBjKGtiyO7ZTI+M2bEkkrTwVDjIfiwRyP3DADXqgPT0iw8Z2VkwVWN5hycAv8YhvG
         vwdw==
X-Gm-Message-State: AOAM53227Npa5jtYsVZugmTGuwhft3uP4LhSHP32Ps0SERM9gV7w3sWA
        c1+8ehGKmzEebx/Y+CsDQjCiVw==
X-Google-Smtp-Source: ABdhPJwU02aex0XwNNQc0sK7Gsam8Cgv6FgnPe79ajdp71dz1OvZSQfRy4FjzaCtX61dw5PZ8eX1Kw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr15255562wrq.152.1623048891062;
        Sun, 06 Jun 2021 23:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 7/7] arm64: dts: meson-sm1-odroid-c4: remove invalid hub_5v regulator
Date:   Mon,  7 Jun 2021 08:54:35 +0200
Message-Id: <20210607065435.577334-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; h=from:subject; bh=2+XB2Oss9iZD3QAWh2ekV3OVz7bGhwenvkupndMpnFA=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJBaa4WmHRO5GXz/nWgYW23KSV7SOX+plOr9fgU 0ZJpR+KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQQAKCRB33NvayMhJ0UHDD/ 9yicfv1d29ovM5jCi0kTXgGdAZnedKktOtS4zpUlBgmZgcLUkJslkuKVyZAn/EcWUvH0YhzRksYBbh Yhdy97FbJJ00y+I2qMxly8QxEMEdKO5SCpaov9SD7de2wpjXuBgJGR+x4Vn6B01Jh8H4st8ZLWehiE zexv+tt62Tu9PZXdH3/ORVnLaujXwmhuGcK6CM5qAN6t/QjO2XccBva5w+OB2JCQy0aGqh9LsCaKZl /RZjn2asSIIK2V4OKbwmlX5fi5ReeqBIazRK7JMjAjjhcriPbbMYSCaS0R38JSGXO98qo2u/NsRZOz UWzILP7TkdbzAuC3m111+mH7PtjkuiqP6KVmn4hhwbSFVsImqn4CTlMvN/Q6JgAj3+fGTyKBcdo8dz LgWHBo4yKpSvKqcjya6RVUOsmBRZf3FFLiiTT+gwmO0ZnAQkdjo8H47Vr62RcW7bVEoS9JMsr9/1lj VclXqGdxXXld3L7Lhsx0UhOV9kSc9CxdddD/HH1EsxZASkm/uqf4eSgNyth5bdgwSVKqVGVd7Oz0+A zbzqBQeuiXlwQLzxNhOGptrjpJzU6t7pZQYIxYemHyoGDTYYgOzewwRxaXX/v7pH87Pe7Pex9cHiDp LbvoZXSNRbp9tiSmzKcLQW5o/lAm+P2suyXCUX2Qi0GfVbLWeX0VQMDJLbdA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the hub_5v regulator which controls the HUB Reset line with GPIOH_4 which
is already controlled by a GPIO HOG.

Until we can properly describe how to control USB HUBs reset lines, keeping
the GPIO HOG is an acceptable solution we use on multiple boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts    | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 8c327c03d845..8c30ce63686e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -23,18 +23,6 @@ led-blue {
 		};
 	};
 
-	hub_5v: regulator-hub_5v {
-		compatible = "regulator-fixed";
-		regulator-name = "HUB_5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc_5v>;
-
-		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
-		gpio = <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	sound {
 		model = "ODROID-C4";
 	};
@@ -58,8 +46,3 @@ hog-0 {
 &ir {
 	linux,rc-map-name = "rc-odroid";
 };
-
-&usb2_phy1 {
-	/* Enable the hub which is connected to this port */
-	phy-supply = <&hub_5v>;
-};
-- 
2.25.1


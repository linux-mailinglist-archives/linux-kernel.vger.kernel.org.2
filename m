Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E3396FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhFAJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhFAJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ACDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so1040132wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKDRJmHZMttlPazPpLKHDHRMGULieniEi0dVs1UUNhU=;
        b=l5wDNWXw4cqTBt4syqV9crdRJqm/REl/4kIxoAwrGT2c5hlrGMjnP355npzLeP50Zq
         jTqNdXtkXoOpVSFqdBhrhHSuHewM+Im1hYCTjgRAALIcozGVYrnZKjNjSfnX4m8ZAA+u
         BXSXvecZmDPHQRq5UPJRCWSFDsX6OtFNMmi7dFsPFTWvty+JTXaF/Dw6Hl9Wb7uwPu9Z
         7zlQX+ntkocvYsheYqDMZjUB1eUoDtoMv8s49HV9Nt6gbnTDGzIVXQrZjPLXCgizZU77
         5j+Wkvs+upMPD3ny3YrlYHGmjwdib2lA0e1VoKf9Scdop5nKvr/fQTrOq9mW85unHecW
         5WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKDRJmHZMttlPazPpLKHDHRMGULieniEi0dVs1UUNhU=;
        b=l6aO/pX/paQJoDDVHygsMLg/hiALBpzXVA+vOtzDMxdddKlDq6eqp6rWWmrZPsXGph
         d2kI/WIfFYtfiGiR1dSJQsSkFdQRqOQuMuWef3qOR2lg2LvxigdTsPH9EmJHObUtMyVv
         fefqZPk/4zSmAL8g+t6X30PHU2E2f3DYPtby1ZfR+8d/atfo7W7TcyKQcr23gEUZXHEh
         nSJUMf5pYB7OXsPqkfVK6Njb/WC7fjOYNQjgQ4meW3gJawF9qX8t0xeJCZX6ADlpJ1D1
         LMz4M1Q+vOf/AmrmesY1O9FXmQUTlKF+BwAxJoC6gt0gevn37OzTGFBu4OJTbbrRznot
         cDtg==
X-Gm-Message-State: AOAM530D8f4JX/Tsfyr+EtK2iv/XVkgDEjqMYpYc7sprt/elOdcCtWnD
        gUNb4lIH7pGpJFTfyiw+OHxu7g==
X-Google-Smtp-Source: ABdhPJwb0D1ljl9jqkDdlMD1b5Tt0ywJhK1NOqRLW4VGZkjTCrbHVE5tB/0Tvu1x4KA60a6ZfQWkEw==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr25126567wmc.127.1622538109884;
        Tue, 01 Jun 2021 02:01:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/6] arm64: dts: meson-sm1-odroid-c4: fix hub_5v regulator gpio
Date:   Tue,  1 Jun 2021 11:01:37 +0200
Message-Id: <20210601090140.261768-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; h=from:subject; bh=+HX1gg32b5nfI1HpsRVt78lcl7f9Y+0WlkxAc4RatNw=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc7dRy4QVTV+uXHTDrPa6RSP+kH0/tRtz4WQN/f 94GH8xyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3OwAKCRB33NvayMhJ0Ur8D/ 9qjOSWOCqqeI4U9sOTWJdg9pm0MuOZCQKdpX9HhKHeOvbMwATil8QLbSfDHuxtnEIUIfgnGNBdThD3 /M6+2whxepZJnMAnxWcA5MVfNyZrB94dU6aI2AX9+sApZgvK9eFAZQQF2I6wXz5ExnkdfLJlDZaxlZ 63GTj1HZ/HS2KKvx9jUaeq/bte2wJSJ23uWue1G0sc5+ZR3PkOJI60758wlNx3KsG05B+kprDxxrR9 22E9U9CE5Hm7LUt8vzH34SAWx0egC/37ETqBABrQOSxKFVIBu47BuY+S8+bIgvWrOZetS9ssQMcoKZ qINDH8CXqzadkxIm7+NWsaV2tySZfB4e/yuwqqLymMCPRvHUcj//cbaRh1//0K9SjotV6ncWSzIWNi pvb6k6MBtBYUdu1Yl0K/hdwR4PBFKLQSYP90NROKZ/bXXsGkzMFYhvF6XPKi5iOQdBNZP5nREzNkEl hqAgQNyc0rLinvBd6bLHLiUkOuaVzWuH9H5rAyxES6ZJ9iB/LBy/z5MIIC+xUvfCZN5NNQOcE/pdoB 5WAP9VgXY5EV05QnCHFKaHCoa+U3SEDakqCejIZQ76tiK0XjkyLsHCuE5nbZVJsbhALUzqFFTKdj/x tHeMjvOeZroDfTioxAx9eSxW+v0DE6B94V+pcCakQ+m0E02eeYARvaDiCmDg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Odroid-C4 schematics, the HUB_5V regulator is controlled
by GPIOH_8 and in Open Drain since this GPIO doesn't support Push-Pull.

Fixes: 326e57518b0d ("arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 8c327c03d845..63695ea21b1c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -31,7 +31,7 @@ hub_5v: regulator-hub_5v {
 		vin-supply = <&vcc_5v>;
 
 		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
-		gpio = <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 	};
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECE45F127
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378340AbhKZP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354276AbhKZPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:55:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E2C0619EC;
        Fri, 26 Nov 2021 07:44:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y196so8469576wmc.3;
        Fri, 26 Nov 2021 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pX4j/3IbsfRWpBbXodLKp3Ooot7rXdkPhrMGrMwdyWc=;
        b=AgA6dlVN8+MxCY69yDgWXVIwfqwHDmubESbFeUHARnLUW5T0CicoqzKNAP+DzoA0+/
         hOAsQyxPmKrVMYF299xM2CLHKkw6CvUfXZgdzb2MsXLv8GEhGuqrkaio6Pn76HakeaGg
         yNWMrF8/me7pQRRnSbAQrXzBuLeOrnmZa0fCe1yrcdUH/Yv/8V8YQcaABXJ4Zdy5toJA
         1CUsw6cZhQa3VQfGethcCDMFZBC3GxL65BrqucrncGXwD+T8Mz1hNw5ocGBTcpBvJTKF
         ojfbV68Z190Z0sGcxHrbVPOXWjvY2FX/M07/WYxvyUqwYdJOC9CaqvSbd+n1OAzV+gxl
         i7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pX4j/3IbsfRWpBbXodLKp3Ooot7rXdkPhrMGrMwdyWc=;
        b=UFdTKrIfyKke4zs6I7TMMZ4xgwo5EYcO7BxGSN+rUj4gMf8+YEgSRdkCtyTxgutNFp
         i2IbDZUmTq07Uv7b3+NwXsP1gPre0JWi+CtHRwMIsPOgMsxvF6B+vOuYAZ37cRg8hgu1
         L8xopTQMTtAa29utvLkP52WTHXC5mADDi5FmNHalpb9YfmTCC2jPpcyvk1hHRiaJ2gjT
         jZou1CozNTEeAJ9MRcLckPNkQWy/GQuottDuYNQTCcFE5TESblm7UIxcPAPu2goTt/BH
         eIKguXy4Im0EKyWKPohm1/ynmXRrcyf7fPvQY568tuHGQKgqyC0Dd9/XB9qdq7dhSzFi
         16bQ==
X-Gm-Message-State: AOAM532G19P2vlxuGM5nI3LbeicLGFLG/+SJypgRacUbxmFXQkkNBiVv
        107gmjnjbslOqRdeS6Wa6SU=
X-Google-Smtp-Source: ABdhPJxy5WZeJkCDxGPpJ20fBso/4CEHRxiGR3BRtJynzdR1LTnPQwXFPtils/lZCoP0kz2L/m9zSw==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr16274799wma.129.1637941448071;
        Fri, 26 Nov 2021 07:44:08 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p13sm11372400wmi.0.2021.11.26.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:44:07 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
Date:   Fri, 26 Nov 2021 16:43:44 +0100
Message-Id: <20211126154344.724316-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 Model A has the SPI pins broken out on its pin
header. The actual pins being used though are not the m0
variant, but the m1 variant, which also lacks the cs1 pin.

This commit overrides pinctrl-0 accordingly for this board.

spi1 is intentionally left disabled, as anyone wishing to add
SPI devices needs to edit the dts anyway, and the pins are more
useful as GPIOs for the rest of the users.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 4d4b2a301b1a..166399b7f13f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -509,6 +509,11 @@ &spdif {
 	status = "okay";
 };
 
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1m1_cs0 &spi1m1_pins>;
+};
+
 &tsadc {
 	/* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-mode = <1>;
-- 
2.34.0


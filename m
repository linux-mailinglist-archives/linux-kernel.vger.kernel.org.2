Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99944AFF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhKIPEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhKIPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:04:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27759C061764;
        Tue,  9 Nov 2021 07:02:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so21952720wra.12;
        Tue, 09 Nov 2021 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTYWV3nFhsgRzCKGFoDGpSlf4DtT065khk9Y6j+f+zU=;
        b=jnVS46qwHdRRNGjrF6xSPOakVWUv2P8snKeh6DSfw47Z/ZPpji/GBjMaYDVjAklfoP
         8lDl2Urn7GhjSQDYvuxL/xn1lOxVnryTwnNpKauHPWCnviBrA+OuHK7GcC5DXlsSdqNK
         Hmu0eZWD6UdgfF8g94MCvAvO4NK6PYWbW3+XMse3eFkj/2AwsOiKtPs1Y+8VakFStL/q
         s63Q1nChJMn/4YrgFMpSKYu0JcJe6sM9fyBfndf5MavM5A9I5fkwwhU8jzlf8S5Pq3wb
         95G1M7lKlAqrcINDGTo2y6wBEJGy3XQmLyYjyn9QxUM3qju933CfkHSRlDH0ukyzYTlG
         1I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTYWV3nFhsgRzCKGFoDGpSlf4DtT065khk9Y6j+f+zU=;
        b=siPx/bNoMg7LzD2NVFTkqrnHJ8kYx8VmN7B4YD1mRvtCEDYj29+vX4W14dMVcwQ7wm
         OUzpE3WuNJlC+2SI8uNqowd/D4c0PHRXO+xnWsto9FlX91XVKGlkdNxbfJ4APFazD5WG
         scjzVIFSHDP0FntpVhxGcK8XouKD42+0w4xJqlMnfPIlg2OBiPypZ3eRelWDqu8Od3XA
         BSH4eWK1HzDfD5+NCOeeBLcYxCh1tT9w9cHNvmTKqJz3uvEw5pl0OvPh1mA57s9EyATN
         4qeIhe5qMCmqCphkpS94YppVoTKksa8XwD9FnEM5XTlZ+z0BBkg3Oyg/6PJL2e6A2RvL
         zryQ==
X-Gm-Message-State: AOAM533IGT7sWUuOIubsQHIN59N7dj9hpXyR0U4IM/blwthM8/RWLpGv
        PffGreFX0LS009BTQwykTrmACjahMqw6Og==
X-Google-Smtp-Source: ABdhPJygps4YrjlSn3HJQTTlqp9f+bHTW50W4W1/HeB/RdintfzFv0bAPdQZdHzjGEurWC2jep+I8w==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr9966179wri.251.1636470121226;
        Tue, 09 Nov 2021 07:02:01 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id n184sm2703152wme.2.2021.11.09.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:02:00 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am64-main: add timesync router node
Date:   Tue,  9 Nov 2021 16:01:40 +0100
Message-Id: <20211109150158.164778-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
multiplexers to provide selection of active CPTS time sync events for
routing to CPTS capable modules.

This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 42d1d219a3fd..c9321a80353a 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -564,6 +564,14 @@ cpts@39000000 {
 		ti,cpts-ext-ts-inputs = <8>;
 	};
 
+	timesync_router: timesync-router@a40000 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0xa40000 0x0 0x800>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x000107ff>;
+	};
+
 	usbss0: cdns-usb@f900000{
 		compatible = "ti,am64-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
-- 
2.33.1


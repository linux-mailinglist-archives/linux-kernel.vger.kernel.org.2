Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1436A458333
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhKULxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 06:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhKULxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 06:53:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A656C061574;
        Sun, 21 Nov 2021 03:50:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so11225974wme.4;
        Sun, 21 Nov 2021 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQmd9SukAAF43qeHe/hCA71TFxm5LvRKe4XmZtcUxKc=;
        b=RDBLjNI76TODJM5qgyUj027n20BGoY1WOj3Sk4nSnC6FBvtLMT33IwaMDmdfTDYFk2
         5gZrxAkjvuSPuGCqJOWY5SMu0IqlALluQyjPAehA5A1MXs9pSrbScBUDV05crA0YqeLp
         yJHH2utY3c7U/Mlrf347VYeNpa11wGoCGqA/jY7c8nWwAc2gM5Nmc1pyKXzRGgSn9Z0w
         YiyniT8plYjOUsC1pjJWPW1KgxJ8am5hcXNIg/IRA87P0vwOtpDbGNVsWfsgVO1c4OpL
         Z4Tji7oXKQoGU7+/Ky+YIiquaU1bNobwpqc0LwP75b8qeI5w35E3L13iGnr49J6u3UdC
         p9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQmd9SukAAF43qeHe/hCA71TFxm5LvRKe4XmZtcUxKc=;
        b=CyQ1ojCAtHQLby3iFH4fL2AevHzw/cj7VE6/7v78BdujajVnttERje8JcQw2iMJfB2
         l6Uz6W2q5hzO7LFEkKvLdqY+n3aY35CiliH/y1EMB+CS2wWbCB5p4woPO5A8c25+Rsg5
         8xnsTs9A4hnEQn4q2VulyEblaDP2T/axU3344xCBOyZ75dLazt8aRkIQXOp+GDPQWk0V
         GhNCmC0I072T46Ql7NockYcO3v5oUw0UdNIK8Ja6FFpHX2e+O3Nj0qsjLe93iye2aUUK
         9Bp0Ez7KCtkysBHk1gZoMs3PMM6OOO15psN/XcfAdZBqEh0tL0tVHwmg5UyggEhazqdB
         uKhA==
X-Gm-Message-State: AOAM532BSV5KxP2OVNM6cd4a5Mp20sxesuh+J/GHVagwUWKCM5P2X+M2
        wQBXZPZMABhbpPZx1wmekXRX5aWkN6Y=
X-Google-Smtp-Source: ABdhPJzkhFF5ybtUoDP7TCWR73DLqGOFVRq0CK/YuNI+VJs8DFIFv3aOv6EVyx43I5Ml2MGHzwWBtA==
X-Received: by 2002:a1c:488:: with SMTP id 130mr19311234wme.157.1637495405798;
        Sun, 21 Nov 2021 03:50:05 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id m36sm6575118wms.25.2021.11.21.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 03:50:05 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Add I2C node
Date:   Sun, 21 Nov 2021 12:50:02 +0100
Message-Id: <20211121115002.693329-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has a LED display driven by FD650.

Currently there is no Linux driver nor any binding for it. However, we
can at least provide I2C node in DT, so user space scripts or programs
can manually control it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 6c10ff7f4b1c..7c37aa4c60cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -32,6 +32,14 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	/* used for FD650 LED display driver */
+	i2c {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 7 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH6 */
+		scl-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH5 */
+		i2c-gpio,delay-us = <5>;
+	};
+
 	reg_vcc1v8: regulator-vcc1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8";
-- 
2.34.0


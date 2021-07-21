Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E773D178B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbhGUT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhGUT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70079C061757;
        Wed, 21 Jul 2021 13:08:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f17so3448601wrt.6;
        Wed, 21 Jul 2021 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bf+dR+yHWxHSrbBWZl+fm/pQJX2x0mMUSsYE7kFkM0w=;
        b=Gse0jsvPUkEnxPf7xeq2Ee8yzoyUKqPquA885RHVPStTl6le6I7Qq8Awgy45xSoW/L
         /cwewR6GdIplxMvIyEqF3zKhPrzfr57ufHuASJnZpKTtik7AVFY+DsTy0xT9J1VTnFaq
         XBTI5LzhVYWSIGlp54SKqsxPQqsCbCj+kTcmjLMZkulyO45VsR3N5cTK30XernXjwbW9
         TXNoWbcDCXapxy89m+1FAiALDffaVcwyxgWFoPGdYKApbxRAiTIkqJR1eTAC0sNNClAo
         Dk1F2G7I3QSqFYyB3fekZmUQqdFdl/Y4pZRSI8lqDVlRfMV7SWW96xWSvqvorMQYYY5s
         0pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bf+dR+yHWxHSrbBWZl+fm/pQJX2x0mMUSsYE7kFkM0w=;
        b=X6JgwHcf66CRIGZ+k9itSb69gAedeXfFhdLv6wrrSJJovySTq8bHnDgt3H9GpcTNX7
         MMiclOLE3WoOlU0ZtXOIHf0+HAeqc69Lphc33mi0WRM8AKRIX7BfjcippRgvqVCMS/3W
         PNvkTFdG5KnKI0z85rOCfKMdHhGyu3PzGHUrjH6yeBbd9Z+oAbk02pgQH9SjL7gBUX2T
         sVJmN/Vkbxp3vFeHczq4kD/EHYomLk4FR0Q4Ir6bURcAZ2XJ3Jg67m7SlWfOHipQCyUT
         xpF9fGfPqeFv0WyMBBOR4VSTbFrcHXNT7Ejc+CQ4u0vNMwNiQdzRgBHVsmcmBfgdZSdB
         vgQQ==
X-Gm-Message-State: AOAM533zhdWpWuDAA6+PxmTSye/laRFyEIk8BNSEwwWvem//zqf1T9rI
        FrchHRJIOIsu3urXrHs0uOo=
X-Google-Smtp-Source: ABdhPJxunoO/hCMFfjZaGm/AjlBiUccZ4KayI9hR7iFIhKik9owg55mlVYlhHguvoOvPQAusEdaeiw==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr44544560wrv.151.1626898134141;
        Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id k24sm28927162wrh.30.2021.07.21.13.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:08:53 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: allwinner: h6: tanix-tx6: Add PIO power supplies
Date:   Wed, 21 Jul 2021 22:08:31 +0200
Message-Id: <20210721200832.916644-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721200832.916644-1-jernej.skrabec@gmail.com>
References: <20210721200832.916644-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While there is no publicly available schematic of this board, it's not
hard to determine voltage of GPIO port C, D and G (only ones which can
be set).

Port C and G are used for MMC/SDIO communication, so they use 1.8 V
power supply. It's not clear if port D is even used, but if it is, it's
pretty safe to assume it uses 3.3 V power supply. Value read from PIO
Group Withstand Voltage Mode Select register from within pre-installed
Android agrees with that assesment.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..a1dd8f472cc8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	reg_vcc1v8: vcc1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
@@ -99,6 +106,12 @@ &ohci3 {
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_vcc1v8>;
+	vcc-pd-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc1v8>;
+};
+
 &r_ir {
 	linux,rc-map-name = "rc-tanix-tx5max";
 	status = "okay";
-- 
2.32.0


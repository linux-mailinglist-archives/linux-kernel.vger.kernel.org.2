Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03434D49B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC2QNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhC2QNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:13:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D5DC061574;
        Mon, 29 Mar 2021 09:13:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6964213wmi.0;
        Mon, 29 Mar 2021 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ZiO1iVwSoVj9P/6X3+DQz3ORP6IjIgP74RDaktXeLw=;
        b=bmM2rwSwTpnT8Z/6JyLA8AsCfuXFr5FlCeR2+vaIEjLrZ03HaNLq5XAJ0kFA4CWWju
         CLJ3GxLCAvp4Oi/bQBvgnagAup7PsXryis9YycN7Kapb5QxqBpYjGgUi9gq4PQtkEBoW
         WeDGfHo9V65hCQswzJ5rooic6Raac0lNXvQHWLkDF0fnZcpc2DKSjf4CxoEZ0d8bZFJ1
         4kkRDNq1P9wMQ/4C2Y0CUvuWfGg3g5/VxCKWCTkr1/nehdOiVZy1NyJXkQrZuQDHWKNm
         Rt1uGhiiU8yU99VNVByljj1DgzVJhwnWpvVzVStFMof3WifLB/jwK5litaa8CW76TOes
         OOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ZiO1iVwSoVj9P/6X3+DQz3ORP6IjIgP74RDaktXeLw=;
        b=apGxYsGjRy1vbRDVdQ9NOIBVQP1bz04HPicHEeRJlEF3SsgVwDhLB0yUf6YXV7EnVn
         2MKkmoiDAIP+brqf5EC8L9ZMUSj+OfhjJV73Y50ZCjsMqMJKAY6MpX0RwqcF9TwbIFmk
         THGyNv9FJUX1TrzokHiTmUpYQpxEC92A810j1Trlb2YyS3pGNDn8MxOasfGNCodhE6mA
         MVHRC6PVYQlHbqy+g6LkHrzqMFJcohVjseHsPFmyLNzQbyjlDGRV6XtxRd1MPXTuBDXv
         e6mAIGKbmtJXh2jAVKfS5/2Oi8w8GW0CNfgJBrwObKzl1F7hCsu4I0ATECfCMBfYxogZ
         pGFg==
X-Gm-Message-State: AOAM531BGZ3Y0koJf7OkyRddSw2xZmRgfNVMjwYj8gWswTAnH2/KzvHx
        +b+6JPtaIWzE92g7riBY3BA=
X-Google-Smtp-Source: ABdhPJy+3OyI5kSwbOAvtK90lDB7L/TtTB6Wj5hNGK363vselfFA2Mm6mEUDQB4pckYzLR6847e4RA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr25824003wml.147.1617034382865;
        Mon, 29 Mar 2021 09:13:02 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a6sm28570964wmm.0.2021.03.29.09.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:13:02 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] arm64: dts: meson: remove extra tab from ODROID N2/N2+ ext_mdio node
Date:   Mon, 29 Mar 2021 16:12:54 +0000
Message-Id: <20210329161256.31171-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329161256.31171-1-christianshewitt@gmail.com>
References: <20210329161256.31171-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an extra tab from the ext_mdio node in the ODROID N2/N2+ common
dtsi file.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 58ce569b2ace..2f8d574c30c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -410,7 +410,7 @@
 
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
-		/* Realtek RTL8211F (0x001cc916) */	
+		/* Realtek RTL8211F (0x001cc916) */
 		reg = <0>;
 		max-speed = <1000>;
 
-- 
2.17.1


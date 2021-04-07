Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD29356281
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbhDGE0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDGE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:26:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F63C061756;
        Tue,  6 Apr 2021 21:26:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u11so3944831wrp.4;
        Tue, 06 Apr 2021 21:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAA73BHK2onrx2B6pnnkviQI+lx/FL5gWOos/API620=;
        b=i4w+E45V86W8zeaTOHDEzZtxpR37iTqe3f0VnGnqJYeRUmBcuBP6rQdMTBbE6WBTq7
         Ni1RBl9rDs8lIjFoFqto7MOb4NfE/MJdNuzVL9sxuQVbSDbLxLa1fJEUSFt9aKapuqCS
         g1qoovyaCa5NSH/uffGucEDQ+vTyz5UKTepLQ84oxMvI524Fygpn1uJoB0PrWjclUQIZ
         XT5jsEsHNzH48a7MqGpZjtYhUkoVVl+tz2dvA2iTazrYvkwjGpTeE9lxlRcaeGBm6zRv
         YbiIg7wWsjk+ATUtRK0n2cMYX6H77FM79z57BakoSj78h+NqxJ1YXLZUXg2jIJ53k56u
         zCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAA73BHK2onrx2B6pnnkviQI+lx/FL5gWOos/API620=;
        b=rW9QifHUC+zzuV9xIxvDv7OL1rrl18xwmIgluKzgV/RcPpvqyGL3p8HamNzViWGrAi
         WrS/xDuybZzhAV0GEPkGUCGEWBNjsqVyqcdSTtKkQTKoOFfsLH5vbpl+NfUdaie8YC9W
         ggnV5o1D3vZvkXKRcqgeSgx06CaejIdRMlNS4veI0aVNrNuW11BM9rzL9EeB2ZH816UI
         zTf+Sq/or93Eqwb+e/QEWW70dRb36lIup7VWstYMXAs652TN9QhCyzXrgcmRndYiSBkA
         ui2vbGL3AFTd2/eTNYDj66kQAwH1mP+MAloiWg/4OHm3lUA3SrkoQ9ImOeBHifqio+sd
         l9TQ==
X-Gm-Message-State: AOAM531+DG6Sha3QkVShXqx+VU6Ix6p5R7oas7lHEEgRza1zkgN07oe7
        DdkwoAJDP9Q+QeqQMx3iHF4=
X-Google-Smtp-Source: ABdhPJzzl2KjectSUjyCvsMOLhRE8KMf6RwofThQ5+Ei7MP+RMlbSBh5Ey0LoKqTwcKtrNts3P1x9w==
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr1086850wrx.182.1617769575873;
        Tue, 06 Apr 2021 21:26:15 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k3sm16487112wrc.67.2021.04.06.21.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 21:26:15 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/3] arm64: dts: meson: remove extra tab from ODROID N2/N2+ ext_mdio node
Date:   Wed,  7 Apr 2021 04:26:07 +0000
Message-Id: <20210407042609.9736-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407042609.9736-1-christianshewitt@gmail.com>
References: <20210407042609.9736-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an extra tab from the ext_mdio node in the ODROID N2/N2+ common
dtsi file.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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


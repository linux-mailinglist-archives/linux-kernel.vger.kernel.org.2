Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4858353C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhDEHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhDEHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:45:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2623C061756;
        Mon,  5 Apr 2021 00:45:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r17so1753455ilt.0;
        Mon, 05 Apr 2021 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of0etr/M++Ql4TAEyEfHWlaTB4IzHPopxzN/wLtkswc=;
        b=C3SNREK/DkSyGjALgjOrLej4NAxb6RFe5Iupbzkxy4PLbZDXsclhP4SYHYyi9MdOcr
         u2wwBE/hcJRjDmPdcvRjzLPteARWGfWE6BOLjTa0CGQvenhI9TyP4fh2Axe+y1rUrc0P
         hByqlH3KpwZFDuzrGTMGM7z3C1lVBESWQIoa5V71PjDDh10x+dNxcR1DxkDWpf6BN/9I
         LXbR68UWEcobHJD2Sji61/lo8wFqizm1Bx7sfNniATakMNB+EiWCc4conuviqpGDW7/L
         oRWBYT2zPXFo1VeODylQTWvU09+pMtNMpf981HX0gcPRDzrH3xMdEwrqgIvaFJHGCE49
         DVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of0etr/M++Ql4TAEyEfHWlaTB4IzHPopxzN/wLtkswc=;
        b=PAAPBKDsBKe5J4qPeTXPpHLH3pB0tC7Yfyl4tXzCpBOwSj7CJwZYXpv6+ShdhG7V7E
         jNwTdnCyse+FZgc0+YSMNGSL2m/9V5ow6/msUS9tDYlja3HVET7GgeBMknBnUfaWdVTP
         lZNNDA0rwjnv+3NC0NHqQ3qs9shZ4KIUVehiEhUxjUgESjUphj5tAE+ah2rbnDRr1lGc
         oIbiee0Mwz0lspmhk2V+wUuId3LClSVnPg4eDMUEAv4u95m32Om8IjdMUNwYA1KJYECU
         spBmcPf03LBLEHYuHl5VPfyOCDqfHBURmzZDP6RXNAUnMcKwNVrrnn/VZgSn2BGzrm/I
         /oNg==
X-Gm-Message-State: AOAM531iEQVm+o2snfxAA53F5HuNYff+idQZFQQO1CLtA/SeQ96cwO0i
        16fgSV+/Sznb3qC9y4CnCd0=
X-Google-Smtp-Source: ABdhPJyGQ6UbGo7hPJmlb4jNG5lkMgpLnAcFgMz/JAmL6C/GatdZgiDn5/+W9rJVIQnSvqYIk0dKew==
X-Received: by 2002:a05:6e02:80d:: with SMTP id u13mr19051712ilm.159.1617608708324;
        Mon, 05 Apr 2021 00:45:08 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id x18sm11857686ior.10.2021.04.05.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 00:45:07 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tianling Shen <cnsztl@gmail.com>
Subject: [PATCH] rockchip: enabled LAN port on NanoPi R2S
Date:   Mon,  5 Apr 2021 15:44:59 +0800
Message-Id: <20210405074459.4217-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Bauer <mail@david-bauer.net>

Enable the USB3 port on the FriendlyARM NanoPi R2S.
This is required for the USB3 attached LAN port to work.

Signed-off-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index faf496d789cf..6ba9799a95c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -37,6 +37,18 @@
 		};
 	};
 
+	vcc_rtl8153: vcc-rtl8153-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8153_en_drv>;
+		regulator-always-on;
+		regulator-name = "vcc_rtl8153";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
@@ -265,6 +277,12 @@
 			};
 		};
 	};
+
+	usb {
+		rtl8153_en_drv: rtl8153-en-drv {
+			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &io_domains {
@@ -364,6 +382,11 @@
 	dr_mode = "host";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.17.1


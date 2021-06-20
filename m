Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48323ADCE5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 06:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhFTEoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 00:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTEoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 00:44:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0499C061574;
        Sat, 19 Jun 2021 21:41:51 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z1so2224782ils.0;
        Sat, 19 Jun 2021 21:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Auirp+Jz2MDqf2r2ES/YFzAEpckdtisnPPAwXVaOT6I=;
        b=bzIbyG1/szcELa5FlvFZ7lDJ7mZEJTyYKroe36+/wg/Z5p3ANQzmkY24pxniO1Idu3
         EjahKNDs0VhsLKYv0+t1cslp0NY4q4z9WY3D/N8A4cC9UvPqdMLXPrDBvlBbSED9pKmn
         xNFO4V28msXevDqg14MgaklKXAZ1BGAE8I4Zl83yBqqHQ+ivZviZbwK++4v8RSDZxdah
         VVJgRpam0WSXArpDXO8YfPmGUl9osvajPPxowFk2QwW0/rfnWBPmz1MSFtjZPXMqW0eJ
         ji2Qpj1Wf4ouw9YnmP/ScZABBWt+T/2WAyxfehBryEEM2TOg2JwhST29SHb8SZ09iJmY
         8mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Auirp+Jz2MDqf2r2ES/YFzAEpckdtisnPPAwXVaOT6I=;
        b=jBFsYY3d3pT1vgkp7rAFHAIAuW3Mk69SkTkw8kovf7oHKgpue+Q3xoSx3zwX84l4Am
         UaYoAC/PDRn47WqoZpPOpTNaGSbfaW6zsOTTdG/1BlN3vSFHVTeW32Aqy4N7TjTcp+c5
         n/7zfRowgKjgwdTeGatu7KOZOQIObdPbUr1CVV23Rdb/Zhxj74AD7iiyZNcbQwODkqtA
         PaGdKUvCz5RL0KL4z4a9fEGfZNB4dcns1RqZqbMViNyueBO6HzD/46URrPlr82EnqyXA
         23LFMzq27S+ksNBju3cQwxOrhCYcY9IFz/ojvyJTF0CyxjHVKgi6VKt2OocMhsWvlDYY
         J8kw==
X-Gm-Message-State: AOAM533JGe3EeJI6RXQHTZpzfRpu/Apecu+lsWkVKEEYju9fVVP3GPPX
        rGgT+N9FtjWJecdwFHZxEso=
X-Google-Smtp-Source: ABdhPJwPKiHyEjmmMj3lbeEi4CF8atUFyNoVJMemXd3iNN7/nXzETZtHCd2Bo9jdzMrVhGZRtELi/w==
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr5653046ils.255.1624164111172;
        Sat, 19 Jun 2021 21:41:51 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id a11sm7360909ioq.12.2021.06.19.21.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 21:41:50 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Pavel Machek <pavel@ucw.cz>, Marty Jones <mj8263788@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Sun, 20 Jun 2021 12:38:02 +0800
Message-Id: <20210620043802.6580-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
stores the MAC address.

Changes in v3:
- Added address-cells and size-cells

Changes in v2:
- Added the size of EEPROM
- Added `mac-address` cell to pass the MAC address to kernel
- Removed `read-only` property in EEPROM node

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index cef4d18b599d..2813c4a0378d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -68,6 +68,26 @@
 	status = "disabled";
 };
 
+&gmac {
+	nvmem-cells = <&mac_address>;
+	nvmem-cells-names = "mac-address";
+};
+
+&i2c2 {
+	eeprom@51 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		size = <256>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		mac_address: mac-address@fa {
+			reg = <0xfa 0x06>;
+		};
+	};
+};
+
 &i2c4 {
 	status = "disabled";
 };
-- 
2.17.1


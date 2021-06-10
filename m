Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18E3A2805
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:17:03 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:38497 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:17:03 -0400
Received: by mail-il1-f169.google.com with SMTP id d1so1154213ils.5;
        Thu, 10 Jun 2021 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/78X0f7LqdRdmPi/tp9TPrXzFkLBCtxmrNk3TI2dNQ=;
        b=W2Jm6lywEn6eiUCl9Zb+34ejPk2vXPHjqkTN6IqUT09FJpJmNUPd0NfZzqphFg75sG
         472bLe5QXynhuYVpUIEWi7fiooWU+xfgJlX7IrZ7C5PY+Uu3shpgyhOt/Rz/IEjckAWL
         9wvjCSru43LYaEXN4TblGDcR9RGq9xBRiqT75ywHBX1+HpAJFq1vAPZLnwwAmK45yCVz
         Wfum08TntgRmlpslTBnDoSTaAN9fVIyma07r4dqFA+8NjCCPP8PswOfcwxRE629qFko0
         G4y1Y6dzSDH1DxB+xa8Et6hmIueD2l6e7NlgqVnfy2D+jaYNL9SSFdMICunh5QFeq8+B
         wLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/78X0f7LqdRdmPi/tp9TPrXzFkLBCtxmrNk3TI2dNQ=;
        b=fms5r30QxX2nIS9Bm2IkvJym3hFZ3GpWN7B6M4mV3ymUXtqIc+tpMzn9V5a0c3I0cO
         q4gSgbPZQx8K5IbC0+00SICtVloR6szHksC/ElYit8i3+lMaO86ZBpYvt5rOmoRSHyIx
         696xlUKp8qhlgroEx8c5FsV/+yQ0MtSH7akLCjpCDsDQJr8K0XFdYwLmWdEGGL1EiFUA
         ElUv1zaADN7UuD6DX8f/WT3uE7hECX2q4SCdUAnk1+8qSKYf+fv/pawwubhcnaKYOZHX
         rN6p9puWSJLSrfC1EGsZ5zGNsmmmH6T5Ac+RwzuPwmQbLJghhsxVmIP/Hv3v1k5FnpRQ
         aMTw==
X-Gm-Message-State: AOAM531QzaUAcRJgsMlCs4TJf7c3NBJcHFRhp/68pXpQFIlcJL4C8AJe
        6FJvIgM9QL6qxTXD7nqk4Gg=
X-Google-Smtp-Source: ABdhPJzYSfbe3hWJjYplEeAqz67k/aL8GarfKYOygb1YS3OgVA/VJNIHW2BrKjAJ6NQPA8jI4HE8Ug==
X-Received: by 2002:a92:cf0a:: with SMTP id c10mr3094498ilo.97.1623316446966;
        Thu, 10 Jun 2021 02:14:06 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id e14sm1398266ile.2.2021.06.10.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:14:06 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Thu, 10 Jun 2021 17:13:57 +0800
Message-Id: <20210610091357.6780-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
stores the MAC address.

Changes in v2:
- Added the size of EEPROM
- Added `mac-address` cell to pass the MAC address to kernel
- Removed `read-only` property in EEPROM node

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index cef4d18b599d..50d3b11eb925 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -68,6 +68,24 @@
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


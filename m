Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E383AFB82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFVDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFVDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:47:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF63C061574;
        Mon, 21 Jun 2021 20:45:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so12544600ioq.9;
        Mon, 21 Jun 2021 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5uuQnSP9UxYJq3+6Mm+ZaoiUY1KfaxszzM+7JAhhJE=;
        b=UQja5nwsSQGYrlIHxyde4FGTx5YZcwWXh/aJSgi4mfgV9g5IqiN99E2YoMfw6WLOYF
         U2LISx0h2pplGn8HtN26stT4Z1s78kHGaJ+Ln463TwoWimN0U0VUKAqmujteUuBHaV4P
         fTFUYoxctuxN+LewHammG26IeU3WoVtv2VV5e5GqlEAFf2VmPb7qsb3MKzfm3/RM4yaZ
         rdQsHDdlLZrzoNdRtMx64ZWJ8JNRmWRca0bDHZ6xDbzczhYk3cHj2riLwNxoMtWd/Wul
         wlvNKUKYp0JDRd0kfyozUgDaSLn2maYuGMbsy3olaU7GSaEKzx0tCBXx8VqhwP+rPGkZ
         DhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5uuQnSP9UxYJq3+6Mm+ZaoiUY1KfaxszzM+7JAhhJE=;
        b=XBTl6WcKBFPtYa/zxBiihWWilurVa+uetPPOZgL2SYc8RLVHz4b2l0FgttWAtWehGe
         MbC4zLTYND0XN4WXLVrWqafRB5lQmYIW0N9dIgUE0VcX02sOx8rLJ+peZwilLRAumQx5
         SPa8Yr3kqqjuJQgDg9OkCOB+bFZYd8OvJoASBwSG5YVjauU9LT4Jvi0FjzAiUkV/7Rv8
         TehrYDv+wQQMF9JhW+PKKN5989YjamaeWbJW86o7qNE9VTwmcFXdHu/m3gD/eq4ofCaN
         bnrQVYClZZZ+957OzaBkqvc0yabrtCRdvWhJwVcUNlVdq8t0Ubl3fswcfeSyTsPQSgqW
         0ntg==
X-Gm-Message-State: AOAM531CIws4ZbL9Po17vWpbcCn/KdegY6q0wnFhDOhWaIvZGFnIjJqV
        IcVq5PEi3be0OqV/j4+6fKjodJ+CrwE=
X-Google-Smtp-Source: ABdhPJxiNOtNjtuER6Rvq9RhV2/1tkUyrPvC/FngOqmT83PJmaETDEhgkjWY1xu1/Bno/ChlJ8rqtw==
X-Received: by 2002:a5e:8513:: with SMTP id i19mr1120380ioj.50.1624333511502;
        Mon, 21 Jun 2021 20:45:11 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id t15sm7042329ile.28.2021.06.21.20.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:45:11 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chen-Yu Tsai <wens@csie.org>, John Clark <inindev@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Tue, 22 Jun 2021 11:45:05 +0800
Message-Id: <20210622034505.18824-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
stores the MAC address.

Changes in v4:
- Fixed typo error: `nvmem-cells-names` -> `nvmem-cell-names`

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
index cef4d18b599d..cd5541971170 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -68,6 +68,26 @@
 	status = "disabled";
 };
 
+&gmac {
+	nvmem-cells = <&mac_address>;
+	nvmem-cell-names = "mac-address";
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


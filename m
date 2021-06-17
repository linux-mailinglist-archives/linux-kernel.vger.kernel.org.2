Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE93AAA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFQEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFQEwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:52:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF9C061574;
        Wed, 16 Jun 2021 21:50:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i94so5088796wri.4;
        Wed, 16 Jun 2021 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1H0pRK+p9SqfiPEkg/fuHEcESDP6rKm5XaeGluOXB44=;
        b=rpQs4ZXeo+Yv7RZBLrTk8MPAbfNG6uJkL0o0C/VYsmaGbu+xJYA42CPhNls34kCK5a
         V1t6TKoFIaN9XXPfgonRV5RH+OuJX8Lh/j/uUCgWdfJ3vKu6cXaAiXZNZhXzHBrekgbX
         ZgxsoQAjfgwQ9htKXLkCYLpALrLFyXczcowzPREIfZo4so33dWFjQpyfOSH0roTcdvS/
         0WByXlgJUcQUjaDVEf7AajWtPkkEN/UjI2FX8Lo8qU6JVmJf49VGdnIeSAVs/hRvlK0/
         Id+Q/mbDe+KD9amsbH/VpFyzd/S8UZDkEaAJ9duhq138GCEqeREvyyFwiGJaGZTQ9Oxo
         GTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1H0pRK+p9SqfiPEkg/fuHEcESDP6rKm5XaeGluOXB44=;
        b=D/KrRQQ01zSkDOUQCaj0EjfyGmGb1UfQkBUnVBjROVbNZ8zaTKjwA3EZoOx+jNMvAb
         k/sV1P9iTgRImOud11PsQ7SC71SiNi52TxmQZyafHHZHmYyRny+V2mASLz6Qbt6sR3wF
         YqWeboHeFOvmllzRDnKeUcpgMYVi0ihiaRSDrEplZUyU8SulCgbuMD67zCnyURvlg3lx
         OmPYNW0LikfsLlGgyQv3x81XvHkQkm757iEt4h58JtLbC0ThwJvpwfos9i3YUpaGldob
         JQppU81CEHQLBcMqDSYzjZTih5PkjLRej5wZLdRAJKJdlWajaE6GPyBGAKgwRzzcbtIS
         r/lw==
X-Gm-Message-State: AOAM532wqziJ6B/hYrVCctXStZkpBiHC6BpSNszT97QuRq9ixLaWqOLc
        rlIqxK/Blgo71VXrCPSA/A==
X-Google-Smtp-Source: ABdhPJyK5VW6f5WGABPtt+CT0g9pGSVIMgGRmmCBlmt4nt0PrKA7657C9oY+PUkydL3HprmgUjJ1eQ==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr3155825wrq.31.1623905401488;
        Wed, 16 Jun 2021 21:50:01 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id n13sm4587460wrg.75.2021.06.16.21.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:50:01 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add RK3399 Rock Pi 4a plus board
Date:   Thu, 17 Jun 2021 06:49:54 +0200
Message-Id: <20210617044955.598994-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617044955.598994-1-knaerzche@gmail.com>
References: <20210617044955.598994-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi 4a plus board is the successor of Rock Pi 4a board.

Differences to the original version are
- has RK3399 OP1 SoC revision
- has eMMC (16 or 32 GB) soldered on board (no changes required,
  since it is enabled in rk3399-rock-pi-4.dtsi)
- dev boards have SPI flash soldered, but as per manufacturer response,
  this won't be the case for mass production boards

I didn't add yet another compatible, since the small set of differences
are captured by the device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index c3e00c0e2db7..dbd7d37950f1 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
new file mode 100644
index 000000000000..2deaab7f9307
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-op1-opp.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4A plus";
+	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
+};
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DEC450003
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhKOIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhKOIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:36:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039AC061746;
        Mon, 15 Nov 2021 00:33:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s138so5928923pgs.4;
        Mon, 15 Nov 2021 00:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gMkQZauTwd6OuO+QfItqAhCFoiNfC1xEu6hFg/h1EE=;
        b=Lc+JSpSqLP1ALI/lFuAfnHgbQxisllh8DaVDwop4LsuY+kOWf8vo54WttCBSXunw2A
         k218zUvtfUz3+NA047StSxSQdWJFoz5B4VKSpja3Td0TqKovIt83ifxRvkqULY8ejI2I
         b/JXWRvVdrqW32ncDADLxILBVzDNX4OE5GAHo2uAzqDQP46Rr0jlvEN3DRxRxENP7EDt
         wQU2neAjydJyBMZ3zxqOlc3WV571xt4dSh7ZrUv/t0itMDQ5haZDfDu74UcpcblraOVO
         uidfOGSUJ510TAMdQoctTINeb7aURAR4vgN6DoD1La9TShKjpVzUvl39Ch0dEMbf4yTC
         Nxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gMkQZauTwd6OuO+QfItqAhCFoiNfC1xEu6hFg/h1EE=;
        b=LKqcQQvw6/Am6dUKisCt219Nz2YF1Xq5UaHvjW40Pp8i08UIZcFoss7t2VLAYeW6b+
         UfhormyN7LnL/iNTtVR8f7/rmWVnKD0Ax4LyN4hQiaBGCbyoqUl5DFyvd8upJeivB6RH
         Ucfef4D9ZkIBL8W4o0X3yfUqKvwp4rqU40+h42mZG56qeknVY5hQDSbNgERLB5ouOa6L
         biqppu7VVXXcHX4bsjIly6yE4XtmpJAwMdIcVAB2xWSXCwfkTz4Lve3KEGWdH7FmexF4
         b53eM8aEebDY78m2QujWnchVswmJrnluOEeg1U6HFecgPwss6h+pP1RUAgyIUUf42/dr
         CWSw==
X-Gm-Message-State: AOAM533SoI3cC+wt1oqcPnddMTRT/1bRfp0Qz015nqv3Ohn6IBYnB26T
        RuPU4uvI3/KSVKXQnb4mMc5V/VWW8L1m0A==
X-Google-Smtp-Source: ABdhPJx/d1+XqlXqsJgHJV4tgEC0br4TKdZQ71lEr0uj1XQOpofUk6AA2eG9uVqze1Eb8JJvgmuFLw==
X-Received: by 2002:a05:6a00:15c1:b0:49f:d21f:1d63 with SMTP id o1-20020a056a0015c100b0049fd21f1d63mr30936426pfu.18.1636965210524;
        Mon, 15 Nov 2021 00:33:30 -0800 (PST)
Received: from localhost.localdomain (104.194.74.249.16clouds.com. [104.194.74.249])
        by smtp.gmail.com with ESMTPSA id n20sm11012537pgc.10.2021.11.15.00.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 00:33:30 -0800 (PST)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, wenst@chromium.org,
        christianshewitt@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2] arm64: dts: rockchip: remove mmc-hs400-enhanced-strobe from rk3399-khadas-edge
Date:   Mon, 15 Nov 2021 16:33:21 +0800
Message-Id: <20211115083321.2627461-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mmc-hs400-enhanced-strobe from the rk3399-khadas-edge dts to
improve compatibility with a wider range of eMMC chips.

Before (BJTD4R 29.1 GiB):

[    7.001493] mmc2: CQHCI version 5.10
[    7.027971] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
.......
[    7.207086] mmc2: mmc_select_hs400es failed, error -110
[    7.207129] mmc2: error -110 whilst initialising MMC card
[    7.308893] mmc2: mmc_select_hs400es failed, error -110
[    7.308921] mmc2: error -110 whilst initialising MMC card
[    7.427524] mmc2: mmc_select_hs400es failed, error -110
[    7.427546] mmc2: error -110 whilst initialising MMC card
[    7.590993] mmc2: mmc_select_hs400es failed, error -110
[    7.591012] mmc2: error -110 whilst initialising MMC card

After:

[    6.960785] mmc2: CQHCI version 5.10
[    6.984672] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    7.175021] mmc2: Command Queue Engine enabled
[    7.175053] mmc2: new HS400 MMC card at address 0001
[    7.175808] mmcblk2: mmc2:0001 BJTD4R 29.1 GiB
[    7.176033] mmcblk2boot0: mmc2:0001 BJTD4R 4.00 MiB
[    7.176245] mmcblk2boot1: mmc2:0001 BJTD4R 4.00 MiB
[    7.176495] mmcblk2rpmb: mmc2:0001 BJTD4R 4.00 MiB, chardev (242:0)

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 -
 1 file changed, 1 deletion(-)

V2: update & tidy commit message + put testing information here
(suggested by Christian Hewitt <christianshewitt@gmail.com> )

Testing with a selection of eMMC modules shows no observable performance
difference. For example, testing with DUTA42 116 GiB & BJTD4R 29.1 GiB:

..... mmc-hs400-enhanced-strobe disabled
[    7.175053] mmc2: new HS400 MMC card at address 0001
786432000 bytes (786 MB, 750 MiB) copied, 3 s, 262 MB/s

..... mmc-hs400-enhanced-strobe enabled
[    7.135880] mmc2: Command Queue Engine enabled
[    7.135928] mmc2: new HS400 Enhanced strobe MMC card at address 0001
[    7.136992] mmcblk2: mmc2:0001 DUTA42 116 GiB
1048576000 bytes (1.0 GB, 1000 MiB) copied, 4 s, 262 MB/s

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index d5c7648c841d..f1fcc6b5b402 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -705,7 +705,6 @@ &sdmmc {
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
 	non-removable;
 	status = "okay";
 };
-- 
2.25.1


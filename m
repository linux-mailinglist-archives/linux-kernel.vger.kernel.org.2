Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0842744BB77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhKJF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJF4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:56:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C7C061764;
        Tue,  9 Nov 2021 21:53:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b68so1637761pfg.11;
        Tue, 09 Nov 2021 21:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUMJHV6ISsdKfy1mWWM3Q3JFhiOT5WxpZzF6+QjqwNg=;
        b=Vt9VxIzU4aG3ALLwBZC6iYlE6e+REQvXk5XlrOuiydmP1N+q4KMs+JiMhxGxs1TvzE
         JF3TT4NMZndIYcxaGkM7E4fxQaRIoLX4jO2cbykUGppseQG1ZkIVkiWlKl+tMqGHFWbB
         qcIykAMWjHE9cll6Ca0woYyO0733CTyAFfa/Jj1WbhmiumDm1BECdALUpIG6P2UsvdbU
         OOj0r1CXsOp39nil1nkqavhnPPSayeQDJw/MAMt1B9XMgAjWSSi1OJkMI771CfMy8pRP
         g7RbXPSo7j7Xkd8J3g6k+bKrN/7HDC3v7YNW+hFA6BXPsu71nWpA6d5zB5zeRc79Qhv+
         g/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUMJHV6ISsdKfy1mWWM3Q3JFhiOT5WxpZzF6+QjqwNg=;
        b=ipMIh2K/h/NvgunmX5yHDcJeUFp5Gr8rZskH0LIpAF41dKqKAK9/XnTeY+p00PDYyw
         dmXDkoNaiOWazzNGOYTYqV4e4lkPQ9R8sKB4hp2IXyvf7PRIWqXJtvn0VNkazTt4ep1x
         OruqGeddas6pUfsMQlr1D5pzmf3AYvhtwgKk4pOgOd1J/TrbGpaPfew1vwpyqX7RtHFs
         KDcTuhobRvPzlsno+CXYlAeoWkhGik7h27cG8wPfai/Pqg2w5EOOxB+MmC7bPnSt9PCe
         ZJZkk/DC0Gx9fLwAUUjKUNX6gsMdKUidFR+0RObRxIJKC0nAPCOwB+81N/so+E1NPsua
         Vo3w==
X-Gm-Message-State: AOAM533SDVnWqOJaWk4D4vKIzWr6645QY5b5NyLFVzxz2U/Dx4xfyyr6
        WAByrrc4wt9TQKy0FX1Mbzg=
X-Google-Smtp-Source: ABdhPJxXTZYHB2UGHAUNtYwf3kP69Bis45hSi+RvLIuzi4J/8jzDu11Q9GCv9DCihg8WtplitYdf7g==
X-Received: by 2002:a65:6158:: with SMTP id o24mr10207501pgv.141.1636523633472;
        Tue, 09 Nov 2021 21:53:53 -0800 (PST)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id h10sm22640981pfc.104.2021.11.09.21.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:53:53 -0800 (PST)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, art@khadas.com,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH] arm64: dts: rockchip: emmc remove mmc-hs400-enhanced-strobe rk3399-khadas-edge
Date:   Wed, 10 Nov 2021 13:53:42 +0800
Message-Id: <20211110055342.1693350-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mmc-hs400-enhanced-strobe for rk3399-khadas-edge

Not compitable for some eMMC chips ( BJTD4R 29.1 GiB ). And no
performance difference in our case from emmc-hs400-enhanced-strobe option
for other eMMC chips.

Problem example ( eMMC chip BJTD4R 29.1 GiB ):

[    0.068282] platform ff770000.syscon:phy@f780: Fixing up cyclic dependency with fe330000.mmc
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

Workable example without mmc-hs400-enhanced-strobe:

[    6.960785] mmc2: CQHCI version 5.10
[    6.984672] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    7.175021] mmc2: Command Queue Engine enabled
[    7.175053] mmc2: new HS400 MMC card at address 0001
[    7.175808] mmcblk2: mmc2:0001 BJTD4R 29.1 GiB 
[    7.176033] mmcblk2boot0: mmc2:0001 BJTD4R 4.00 MiB 
[    7.176245] mmcblk2boot1: mmc2:0001 BJTD4R 4.00 MiB 
[    7.176495] mmcblk2rpmb: mmc2:0001 BJTD4R 4.00 MiB, chardev (242:0)

Performance note for mmc-hs400-enhanced-strobe usage:

Other chips DUTA42 116 GiB works well with or without
mmc-hs400-enhanced-strobe!

..... mmc-hs400-enhanced-strobe disabled

[    7.175053] mmc2: new HS400 MMC card at address 0001

786432000 bytes (786 MB, 750 MiB) copied, 3 s, 262 MB/s

..... mmc-hs400-enhanced-strobe enabled

[    7.135880] mmc2: Command Queue Engine enabled
[    7.135928] mmc2: new HS400 Enhanced strobe MMC card at address 0001
[    7.136992] mmcblk2: mmc2:0001 DUTA42 116 GiB 

1048576000 bytes (1.0 GB, 1000 MiB) copied, 4 s, 262 MB/s

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 -
 1 file changed, 1 deletion(-)

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


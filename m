Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E66424236
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhJFQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbhJFQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:10:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F7C061746;
        Wed,  6 Oct 2021 09:08:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p4so3018113qki.3;
        Wed, 06 Oct 2021 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfABEpKo5aCNhWWFRp+nIlEvRuLr9UIoJUGA9Ex395U=;
        b=ayv51O0gLvoEXmat4PQ4z81/U1Hvza8JetE3UwN63L2VeYSuntgDlAsTfyUWewvaS2
         7L5BoW/KH6T2XG5GAfKJ3yo00j/GZ/Dpldamrg0i21AmXPp07Hf7ic2ff0ew9NTKcWIc
         YPCLZYW1zdba7lW5zoAVuQ97Vsy4mC+UK4aiIYYJNYfWHD+61t7jGHSyTO+0XYd0OiEt
         njb8zQXKhS5GcC6/2N3ccFG5W/3mNGoC6IcIFM7TDglKzOsG8QyRMZ1rE/sUTooXepYz
         nHnWNsCISbBMUKz9eO/XMVkc0zVwWnM7jrEP04PNjWNYppILtixsk83iPqy17GO9yhDR
         ry9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfABEpKo5aCNhWWFRp+nIlEvRuLr9UIoJUGA9Ex395U=;
        b=Vo0MTXUiZHRwJpW0BHc7/TXax3UgLNXZ5yhSRuRTL89psskDvDOmRuXERMclyxlQfi
         pqmtS1uBz7nnwDFJ04hYxmL+lldEu9tknKwXRgBr1u/v2zMXk2sLiLV7csXLc6KkS9rw
         mRP1A19fJBATMcM1DOEUEcfwvzWQcz8qxo4ops7NG/Ml14+g/CBPmAtRTDS8/6mNvl8v
         wz3N12xT0Vup0AXR6ny0H734sw1A5HsjqZdPrGdRm/ccyrdr+Lr4LytmwI6Z7L4iYG+g
         /gQwx2XUjlt0TvDU6t7vhLcD4DnIih/2bkIBfWTqmSEUASeKGJPFpVHO/dQJnzkXH6aN
         /IJg==
X-Gm-Message-State: AOAM531kEsL4vPfCqn3u3K9Ka5dnM8hiJCZuEtyPkLghHhWDUSQDe04I
        NNbo3KKWXyEB1zgHShtm2zwOFgqxRn4=
X-Google-Smtp-Source: ABdhPJxV+DBdtxktwW++z9lHxpFRu6s4Ph6nQw4TBCFM2s860zrVlXxr9ws71JBix1XdPplQoI506Q==
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr20456170qkf.2.1633536512064;
        Wed, 06 Oct 2021 09:08:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k10sm11917526qkk.124.2021.10.06.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:08:31 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] rk3399-nanopi4.dtsi: enable sdmmc regulator on boot
Date:   Wed,  6 Oct 2021 12:08:17 -0400
Message-Id: <20211006160817.13808-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to boot a nanopi-m4 board with an SDHC-class uSD card, the boot
comes to a full stop shortly after initializing the mmc subsystem. The boot
can be cajoled into continuing if, after waiting a minute or so, the uSD
card is ejected and re-inserted. Waiting a minute or so before ejecting and
re-inserting the uSD card is crucial since the boot will not continue if
the card is ejected/re-inserted too soon after the boot has stopped.

The nanopi-m4 has a uSD card and an optional eMMC module, either of which
can be used for booting. In my case I don't have the optional eMMC module,
therefore I'm booting from the uSD card. When booting from the uSD card,
its regulator needs to be enabled at boot.

Curiously, this should have been an issue from day one, but it only started
to become a problem after commit 98e48cd9283d ("regulator: core: resolve
supply for boot-on/always-on regulators") was merged. Additionally, by
coincidence, I happened to be using an SDHC-class card in my device, and
saw the failure. However, if I use an SDXC-class uSD card the problem does
not occur.

Much thanks to Mark Brown and Javier Martinez Canillas for their assistance
on irc!

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..5cf02e2ef9b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -71,6 +71,7 @@ vcc3v0_sd: vcc3v0-sd {
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc0_pwr_h>;
 		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		regulator-name = "vcc3v0_sd";
-- 
2.30.0.rc0


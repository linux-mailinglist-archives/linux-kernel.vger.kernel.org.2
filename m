Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9023AD9EC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhFSMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFSMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:15:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53664C061574;
        Sat, 19 Jun 2021 05:13:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so5301768wmb.3;
        Sat, 19 Jun 2021 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDlTNFHYwLk5xi0VvCLQr10w0k/br31yDZKxEdZ1FEE=;
        b=R9IlMqLcFXLYqDDDwIAE5rP72/gyJXe0EYlqzDh8cBsZZecewis6zMZWkHzJhk/fHQ
         QDQfx7TTH/c2YzY7K5heVV7C/LyMq9SXdAclnpTC3cBG5QHEla+ADeD8KcgF4Bwt5N+S
         Gj/DzePLCmNEktpKGuRzJU15w9xqvBrzuceg44LZj7g9hSY9KHronMNV7aPVlfXH880W
         RmolukQSFceIOPqMcU0TdI/Nzy16UWx1mHM1RmyEY/lUAVLMik+B7lXr6OOBmRjbDfV2
         LyJbnnGz/sC5FYnFtgYkXO/GRL+h10uSYIa6HUn3LAGVXX3stc1G5VM1/I8NOCQ9rRqv
         sNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDlTNFHYwLk5xi0VvCLQr10w0k/br31yDZKxEdZ1FEE=;
        b=RyeOYAQoeTkOm0Be5deCVmxd0YRgNQFPEvnxDNTxvloQKAIDt5KQjZuMibGFpXXC+x
         zBOdlj7MkGDUw14sRQaiiejIeLm83g4uho/aZyAuh06iH3jofjaHerNijLhDVqeZWcoG
         2Eh/8KLGDL5o/50ndILGQaBkV49Ja44X+uaN/7Xzsw23EnYJmtpK0cNgFcWol9Uagm1R
         a1/ZdgWoR7u45QknVKDkn+gqd9g9TELevlglvxiwgMEHe9p64l8oO7/WENoBYm8znC82
         PpkCOReTIO5OzJXjUMS9S0/KzJSdO98hKTv33lJef+hHeY+wbSlllek5Tj1SzvUOWmpJ
         imhQ==
X-Gm-Message-State: AOAM532NKCY+ZCfAgJuTxVQ0dtlZavwKuMsjh2d7jzuGKgSPJG1aFRb5
        GD4ro+E91dHwByRH2TJUGw==
X-Google-Smtp-Source: ABdhPJzRqG+YnB4JKSyiAwM1Ze7WstxBZ0H9jz5lFnVOAl3bCCAp4xOSZg2eEmiVD4ovacuU615osw==
X-Received: by 2002:a05:600c:4ecc:: with SMTP id g12mr16332068wmq.40.1624104797992;
        Sat, 19 Jun 2021 05:13:17 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id h9sm10197869wmb.35.2021.06.19.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:13:17 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Re-add regulator-always-on for vcc_sdio for rk3399-roc-pc
Date:   Sat, 19 Jun 2021 14:13:06 +0200
Message-Id: <20210619121306.7740-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-add the regulator-always-on property for vcc_sdio which supplies sdmmc,
since it gets disabled during reboot now and the bootrom expects it to be
enabled  when booting from SD card. This makes rebooting impossible in that
case and requires a hard reset to boot again.

Fixes: 04a0077fdb19 ("arm64: dts: rockchip: Remove always-on properties from regulator nodes on rk3399-roc-pc.")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index c172f5a803e7..da3021dc0ff3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -389,6 +389,7 @@ regulator-state-mem {
 
 			vcc_sdio: LDO_REG4 {
 				regulator-name = "vcc_sdio";
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3000000>;
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946B540C3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhIOKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhIOKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:43:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC70C061574;
        Wed, 15 Sep 2021 03:42:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b21-20020a1c8015000000b003049690d882so4402737wmd.5;
        Wed, 15 Sep 2021 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgo6Yb1X9wS95dBMTKdBBDgrxoGCLEJr8Z6/JZ15/ic=;
        b=Q6igbe40DJKzHRUCwY6lSsF1a0SUYMZ7BX/lZz4SHix092qAU4camkUkL+gXx5Q2XC
         /QhvgRZ3uMBqJEprU4LB+oLGa2sVZI+qA6+PpGzgwh4sAW6znXV3Ioy3TRmuFbkAnFVz
         SC7RCyTvnfB9L+zvEI6LgJU98+HHM9xtjmsyVv8w5rKkXPfVilqe91FNZTg3rlMArhs8
         bxkr518Z6G7rsrXMJEiSjCSL83q+fChDF8FQ1m4k1xHG6b8fHC1/Mj6sBejoLzgfeNFs
         /E5FPVM98ZcZd2bOcdCadQ3ttDWibAJmDvZxBs5n0D0WNv4j5hjjxpSJEiOU9PbpbfZ1
         v8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgo6Yb1X9wS95dBMTKdBBDgrxoGCLEJr8Z6/JZ15/ic=;
        b=t8Z53gMvXDD9/wT14RbJz/TT0r8cDctgEknqcTpXsLv/r6JvMXhaMKlS/JL36/YCWu
         fODs0Gr2LoH1YuwO3kbfbBwRTZ8smBd9yMXXqdctQlHjAURByC3qxWGO+v1cC3f91WEA
         J4YCsrjbBMhAWewH7Z1HGGPEPms9bdh4NWdDRaCWaNMAGgN6N5JuJCTTrsOF2WCc2NN/
         oqUw+bbK/QgyM65HWxQp86CMf6VDhq2gy52zs7D3IrKPPSVvQ4JLznQ6lChyoWBCom6M
         IBgfgi51avJ+ncO6f5/f1c0Wly9JVx+XTH9qzwlpJCu9OpkWzvD1f1HtuI7Mbp1HRvis
         4mqQ==
X-Gm-Message-State: AOAM5331OdIUrRGF2l4Ayjp0ww+1uR9rX/wkhrHzead7tKejFcXVheiN
        bQ93idyVgp2cyOTvzkncB0o=
X-Google-Smtp-Source: ABdhPJyLUFn5YuG/uyaSOIJoVC3BBuFKn7Lg+SDIEmzpI4CJQq5QpM0b/c5Fe8i0kE35K6gOMuvkmQ==
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr3696144wmz.174.1631702548689;
        Wed, 15 Sep 2021 03:42:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3d3:9cc4::e68])
        by smtp.gmail.com with ESMTPSA id i2sm9023751wrq.78.2021.09.15.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:42:27 -0700 (PDT)
From:   "=?UTF-8?q?Bastien=20Roucari=C3=A8s?=" <roucaries.bastien@gmail.com>
X-Google-Original-From: =?UTF-8?q?Bastien=20Roucari=C3=A8s?= <rouca@debian.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        =?UTF-8?q?Bastien=20Roucari=C3=A8s?= <rouca@debian.org>
Subject: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date:   Wed, 15 Sep 2021 10:41:56 +0000
Message-Id: <20210915104155.2237481-1-rouca@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") sets the RX/TX delay according to the phy-mode property in the
device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is the
wrong setting.

Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
the Ethernet working again on this board.

Signed-off-by: Bastien Roucariès <rouca@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 8077f1716fbc..ecb91fb899ff 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,7 +112,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.0


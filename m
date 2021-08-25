Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D903F7E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhHYWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhHYWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:20:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F891C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:19:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w6so423974plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y91ZZBFmSi3o3CDJ8D/muM7G6GHXmZrIVUvgWSiFNA=;
        b=hWNx527ojuNThiL2YMY3rZod4+Absf8DJSeJjrO49nLpWRQI3m+2ekATsn8sTS93FX
         bP0o8PIavWDxSLI3bRSZktmWzndwZiI90kzxMrP9uHAgWqR0d2bOyh9RCv3XVtdJ/4lz
         bdKPDdq6Kx+RE9e6mHbWeAB12Z8PZA+Ve8m64+iGU/vsieXsR1gM66yOi6YQU5YU0IQe
         ASa1i20ApqlFz/d70s/KFEJA+Gd12HXD68b8yzVDisF4e8ME2vM3rhjInw5bZ/pDzmcy
         sgxAK5JIMKW15oFwHPvczE5PyFryxpuWEV1qogUMASSO6foCfQlgQexK7dIE1oP++Ahd
         CzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y91ZZBFmSi3o3CDJ8D/muM7G6GHXmZrIVUvgWSiFNA=;
        b=m16DsvtH1nfNf7WvcG3c7fy0/tEN2jmUMre4KY6LIF3X8CoKU9l41MMsDyv53FwbcM
         Cf0ISx71fNzTCoFtNkdRwQxIpKCU15+XrUvmvQfkK9l6jNHPDyE3y4NMhTjuSQxmFxKY
         pwRrZr3fkMcQBsAcKRMztwQfDsCb/1aUPiBAjapKJr6pqPmghl5x+p7WUHKDrb9yViDx
         +wlkK01i18yLXcwprHdFrMCg2fcAlQMFnFa9PR+hzCwBPTUXUOcpEkJEjj9vR/27h8D5
         SSltbQzBQz7PDZbsGFCkG0hUqTCPfZea4uNSFY7kpAldJQzOvJXaK1i3DPj7PG99v28P
         H5Ig==
X-Gm-Message-State: AOAM530NLw112Zobl+bqfcA3Dhrnp4cE3dlJh9WlM5ekURxi+uAfiVlb
        rxKX4IpazTsKx3kFOTPquAVDBg==
X-Google-Smtp-Source: ABdhPJx3ajUGrJMkfstuFqFPcxHSkqyvquMO1us6MWW98soyBM8Kd3/DJQ6RnBTpANpt4pJ8qmtAaQ==
X-Received: by 2002:a17:902:e8ce:b0:132:b140:9540 with SMTP id v14-20020a170902e8ce00b00132b1409540mr678239plg.28.1629929980596;
        Wed, 25 Aug 2021 15:19:40 -0700 (PDT)
Received: from localhost.localdomain ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id n1sm969527pgt.63.2021.08.25.15.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:19:40 -0700 (PDT)
From:   Drew Fustini <drew@pdp7.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@pdp7.com>
Subject: [PATCH] ARM: dts: am335x-pocketbeagle: switch to pinconf-single
Date:   Wed, 25 Aug 2021 13:25:19 -0700
Message-Id: <20210825202516.1384510-1-drew@pdp7.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the compatible for the am33xx_pinmux pin controller node from
pinctrl-single to pinconf-single. The only change between these two
compatibles is that PCS_HAS_PINCONF will be true. This then allows
pinconf properties to be utilized.

The purpose of this change is to allow the PocketBeagle to use:

  pinctrl-single,bias-pullup
  pinctrl-single,bias-pulldown

This dts already defines these properites for gpio pins in the default
pinctrl state but it has no effect unless PCS_HAS_PINCONF is set.

The bias properties can then be modified on the corresponding gpio lines
through the gpiod uapi. The mapping between the pins and gpio lines is
defined by gpio-ranges under the gpio controller nodes in am33xx-l4.dtsi

Signed-off-by: Drew Fustini <drew@pdp7.com>
---
 arch/arm/boot/dts/am335x-pocketbeagle.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-pocketbeagle.dts b/arch/arm/boot/dts/am335x-pocketbeagle.dts
index 209cdd17dc1e..5e415d8ffdd8 100644
--- a/arch/arm/boot/dts/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/am335x-pocketbeagle.dts
@@ -205,6 +205,7 @@ &gpio3 {
 
 &am33xx_pinmux {
 
+	compatible = "pinconf-single";
 	pinctrl-names = "default";
 
 	pinctrl-0 =   < &P2_03_gpio &P1_34_gpio &P2_19_gpio &P2_24_gpio
-- 
2.27.0


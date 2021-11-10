Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68C44C8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhKJT11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhKJT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:27:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w29so5797122wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBcNPte2JXqPPCbEyKj3qBnsYEms5FQgmkXXyIOHj4o=;
        b=g1uERBZq8p2ygU7G/w6WcKWaEF0vsLuDSAM24vOncFKQu6RUj7RcLgPl5GXCxE+9pX
         4YpW4iLSPc96b7BKxII6r88zDn7HNPI9RjkhMn9T0sH6Oot09NPQb6fb4690M69mTiR/
         +ZQZmvO+Rw6QQUGOx2QUwK2eVOCzFtN5ir7wY0KH+6bITt8fkx21LrgIcZgtUEiwn4C8
         eBgIARzp/Vf3VvREVqCtloMZp/qVEf1Q+Q5jxIu4eSCikcUcVISJWI8bWnsMUgFZswLw
         EbCjKsIhWzabKpbpbEJCK9NoVSznd5ISCSt4jSw/1dtaDssSVaVFG4NjuDUu8T+PE4ZT
         o2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBcNPte2JXqPPCbEyKj3qBnsYEms5FQgmkXXyIOHj4o=;
        b=UToHyiACHquwhJJ8lfq7tsioqdBhNFYSkEsLLbzGH4+/vNxgXbNElhhDO2ejBCoU9n
         5J9j5hNGUdZ8Af5VHzvfdNwhneUh5DIF1QGajFByeKMNkzQ3ZI95/nZJo85ztrD5VWbn
         w8haK3+c7WzxvBloFYWFrmyYBMVKfQ1/aNiLlNkEFWUSm4Wh9FzT4rlU4Fgu4EzAeNPC
         QEaXSyttk3GivqJxelZqxR71IjFmioEHzqsV4SidgbvlqwTqmFotM9PjooaNJRwAgyS8
         Y9BHZ3wUsBj4dZRAmvSEaa9Az/V08rGvAn7DFlrnsd5znSHVcKVBg//LK4IAlVrPZmTz
         1RvA==
X-Gm-Message-State: AOAM531pZ07GeBjzJcyPn9PROd39nYJHF+UsPGNQi2bdWEC0C4uWyP7f
        ArC2Wsl8NfkehB92TsE6+Pup6A==
X-Google-Smtp-Source: ABdhPJz2CFovYIbvWQjxyj3Y/wTT7TED3FY5M53+Mhy5pC+92jywXsPb6uDNVPidlkv4OHjR3R7s/g==
X-Received: by 2002:adf:eece:: with SMTP id a14mr1689076wrp.333.1636572274488;
        Wed, 10 Nov 2021 11:24:34 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id d16sm6250113wmb.37.2021.11.10.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:24:34 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: mt8183: add dpi node to mt8183
Date:   Wed, 10 Nov 2021 20:24:15 +0100
Message-Id: <20211110192417.4177741-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

Add dpi node to mt8183.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index ba4584faca5a..7c283c0b68b5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1443,6 +1443,17 @@ dsi0: dsi@14014000 {
 			phy-names = "dphy";
 		};
 
+		dpi0: dpi@14015000 {
+			compatible = "mediatek,mt8183-dpi";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DPI_IF>,
+				 <&mmsys CLK_MM_DPI_MM>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL>;
+			clock-names = "pixel", "engine", "pll";
+		};
+
 		mutex: mutex@14016000 {
 			compatible = "mediatek,mt8183-disp-mutex";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.33.1


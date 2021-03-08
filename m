Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58925331B06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCHXje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhCHXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:39:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A47C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:39:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4836343wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNI4lb320b0g3N9E/pXmEbLu1U21wMPwIZ392wgv3s0=;
        b=YcPsI338+uXPcczjZIr4QmN6Oyh6oeU8GRI3DSZWU3u/MWJjM8XgFa0Gb8xQ60FIuJ
         lzjDln7EN43CZ2axKiPiz31vDsxWjGmobql/eL7UYG7y3XCNXVZk5UCCwxpiaNGsupRK
         0f05SH8UHs6G8D+vBiqFwlx6hjdrJfaT/0qeKJAv9gkTBqc18h9tmUqiebabPE7IIu1f
         iBRI34fSmAX3HLjR1L/DolojefjT/AiXjNQEwdPcFxTHxONrme0Op9ywkzOJgH1A0wf2
         oXzx4B+03hMEdrUn3qIrj2ju5Y3+wdE0SIE2LEVe+KsvcpHeHGV3vgcvilfsF4BYcQML
         YStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNI4lb320b0g3N9E/pXmEbLu1U21wMPwIZ392wgv3s0=;
        b=eE7xy0sc5tJHTCoDmhFCaSjpsQBTGty3blvqRZk2PljSWzvTi9AeNE8Io1BIbpdC/N
         XuoW3mP9FaCYdgKGXoER6IaWUjgujqAnoKB+vmemtciv6oenuv7+t+ueZp8gBPtPVB6S
         UNjUcNE3qsKYlNp1cr3YMRlqoeFHthtFV69U0R5zMzXPleKz48wggxDIdjXP2uFBg2Hn
         +In5d65TqwcOPCrTLYdB0Nbn5RukLHHEpQfbqrwoJpOJ8pFxa+wfRTm6w7QUqo/wkgpo
         d1n81phRz3a/kbxXBlaGNPDx9NhlV2ZhLBmxyaxkhp1YEyUL5okSNTkk+4dz+lhRLRJE
         hM0A==
X-Gm-Message-State: AOAM5302I1+8JAFsnDyOX9jXVsZZJWlK2UByW5ubc0l60VJtd9SrCvXp
        wtmoD9iuZF/C7IO/Xo0msqg7vA==
X-Google-Smtp-Source: ABdhPJzyFTtVk78UxQ9gsfuWPRMnCDwLJyL02l9xh21o6mqTHpXZXVEojYMD8BQd+qOCQw4hoQxpqA==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr1023445wmk.135.1615246765017;
        Mon, 08 Mar 2021 15:39:25 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id b186sm1145408wmc.44.2021.03.08.15.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:39:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
Date:   Tue,  9 Mar 2021 00:38:56 +0100
Message-Id: <20210308233858.24741-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308233858.24741-1-daniel.lezcano@linaro.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on rk3399 platform.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index edbbf35fe19e..6f23d99236fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1937,6 +1937,25 @@
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.17.1


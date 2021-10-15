Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C4242EF71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhJOLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbhJOLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:15:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA0C061570;
        Fri, 15 Oct 2021 04:13:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g36so23392478lfv.3;
        Fri, 15 Oct 2021 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96jnA4ej/Uzri1MzuZ9UoSs3Fw1wfRJ3Z/GoE9dIJXE=;
        b=QorjoxGzfxWLxsFjAE+2QAcprbyddJkXxfvG+tUBRIWWMbQkCZJ0L72XWxTvcrYTR+
         7sxnnPb+nXNGhcwXEmZAb7aspra0lXbt0YdfFAzhKusySohB/3VM4Dw43S75sg2xpQ2a
         Y49OMqsGlX+nDiDF2bUX/s5K9qTuAErMhYOqbYA60liaY4sIIZmMM+vVujZt/y7/UHe7
         3kooHCFoXNMi4VFkndM7Sh+XoMNLGU9vwEEdL/N1RgrwMkx/RK8TovMGueViiJoPM8A9
         m+qgzpkWJa2rUopXCd9cROY2SopzmqiLQ+215B3TlxYbRbZWIoN7o7UNCXeue3l5TQqF
         WS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96jnA4ej/Uzri1MzuZ9UoSs3Fw1wfRJ3Z/GoE9dIJXE=;
        b=KBIyNS1/ZhnByg8XdtamtWUTje2dTnuyXIKZzNrRauJ8JFzjXXC8gKt4nQ2zUHeWBc
         rLiAqDkGjL+uiPkYdz9hoxGrCkhHcWBQi2MwBPmeSigPQgDpuhPQL7rUmhgesHo7TA+j
         pGGL1429iYNnaMa3rRZY7rB3GbhnCUY3tLdrPdZwP21iRGKcTgixxQ+k5A7evoHQmwYW
         85Om2XoIUfo1i35KKJVHbuyEJ9tsWgfYg+BuNomsn+wXvdvQSBtdnedN/HoJPTfo2f2U
         kA8nJkn5e7oZzPRQ5bPZM2yk1q0wtjIjS/zYl+VDu0h5J/pF2YRjrU6VbxA0O9TEXEVb
         bcrw==
X-Gm-Message-State: AOAM530/TRZx3eSD5qWhzA++bnQjpukWCSFpu+v37rJPjmNLQ/XRCRLH
        3WgLFSfdsHWdLsTzEwtT/As=
X-Google-Smtp-Source: ABdhPJx+ctQa7OfRWwCG5zVAX/y0wrmmRLdqUITithI8O9z8oH8ze1L6DTb8XMoQEHCzGx4BF9Y/rg==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr12577381ljp.441.1634296414372;
        Fri, 15 Oct 2021 04:13:34 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id s25sm534647ljd.63.2021.10.15.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:13:33 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: add spdif node to rk356x
Date:   Fri, 15 Oct 2021 13:13:01 +0200
Message-Id: <20211015111303.1365328-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

This adds the spdif node to the rk356x device tree.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index b721a34ffa8c..f0e3fe445ace 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -608,6 +608,20 @@ sdhci: mmc@fe310000 {
 		status = "disabled";
 	};
 
+	spdif: spdif@fe460000 {
+		compatible = "rockchip,rk3568-spdif";
+		reg = <0x0 0xfe460000 0x0 0x1000>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dmac1 1>;
+		dma-names = "tx";
+		clock-names = "mclk", "hclk";
+		clocks = <&cru MCLK_SPDIF_8CH>, <&cru HCLK_SPDIF_8CH>;
+		#sound-dai-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdifm0_tx>;
+		status = "disabled";
+	};
+
 	dmac0: dmac@fe530000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xfe530000 0x0 0x4000>;
-- 
2.33.0


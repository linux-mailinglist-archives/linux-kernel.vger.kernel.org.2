Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8E456939
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhKSEiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:38:54 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47519 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233616AbhKSEiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:38:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 414192B0117A;
        Thu, 18 Nov 2021 23:35:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 18 Nov 2021 23:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=FSBsap0iMHO4q
        Mv181KgMzdHblwIfhkId6nAlNJsH1w=; b=I5hMTZV5qTLB/4sqXJJ6/Uen2dazQ
        6QTJCXt8VKM1HGBx6njXcHd3vtApgJ5u1ZnXSn3+ZKV3/ZtRMmIwk9B0Xigfz9xR
        ZKJF7znw8Voq70OlyQ33zXzUllWeSCAp3Qha2h90wvs/Z8rEK+kRzrBMI7sQjWvR
        oV2P92cdsZd3akXEZvdm11Yy4g4MBHWTXzHt3w3OBSsKYPlKzdQlIMjelcAMAPaW
        +uNcCHioV21ycHqc1KgX62t217fjQgcC6YqptLUkAs8wiETiRGKVSk+5kiBz5KZW
        /x9/ZeFe+3MkeOPYbZxBTN5VLIWKkv7tv4EvIAmuLL+HIlyW1KHzrk/6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FSBsap0iMHO4qMv181KgMzdHblwIfhkId6nAlNJsH1w=; b=M8qzvfvw
        pltlqJoKPet8SybI+3fQ0+cnP7cegxiYtVK1Y4bbo6CHL77rVcjASoZbL4FPQi/I
        oLCqwxOIuoTres8rf/Sq6KJsep0Wz58sbJ6l16/POb+CRLPvCUnZ7Q/1OEZl/h+E
        PwCrYgegYe6fPFVOR+rZ/ClrGfuzuuFSvzub9RG1ha2OScd4++QE/7Zdu+c93aiu
        EehxpRDxLreoiNzLEuSPxfOPIqo4ye+m1Fdq08bf1HPck5uK8EcQeJrj4piSQzgy
        QcYzxQUkqcD86/ZF9fCcnjwkd1eLwEv+PgvCFLsNcmudYC2tA/fFbwy0kcV8dKIB
        2I8ALTLTAAXk6Q==
X-ME-Sender: <xms:pSmXYSftKG157AYLjpILWIC3IY9jOFPaSIFIYhJls13RH9mN4Wsg5g>
    <xme:pSmXYcMfaPn2pLM9tbV-ceaKvyIYGxuHg5QA9PIVCEeDHIdOpDfZZsgb33OMjgzKL
    Cnhs4nZzNBAryLp6Q>
X-ME-Received: <xmr:pSmXYTgQAxfXCHU0_v2tac2cwEoosbacVFhvAZ4Zd7uUZDMeflcJ-LP-ICEtlt2S19xNIRAVi-BZAIZZAkqD-oCtuZzRb7l86S1j3wEP8w89ASAkNLUaP_YuiVE9OBkg2tPaCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pSmXYf-jY1VvbkHYMGkuyBcsgEsgV1JxXP9jZpn6VXnIvaT94s-PJw>
    <xmx:pSmXYeuxG25ej2wGiqlueQTFPY0PmJHNaB8tvbcxhskOeokLEDpnxA>
    <xmx:pSmXYWF_LhNqKPqwVu77PfnlVC3pQHzCDGD4oypEk1dWbfZ8KS1L3A>
    <xmx:pSmXYfmUTntsikP18I681GGjk9sTYVgDIiHwbCZn5gkJFDqf-Eeo_9Wwm_Y>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:35:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: clk: Add compatibles for D1 CCUs
Date:   Thu, 18 Nov 2021 22:35:39 -0600
Message-Id: <20211119043545.4010-2-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119043545.4010-1-samuel@sholland.org>
References: <20211119043545.4010-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D1 has a CCU and a R_CCU (PRCM CCU) like most other sunxi SoCs, with
3 and 4 clock inputs, respectively. Add the compatibles and bindings.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../clock/allwinner,sun4i-a10-ccu.yaml        |   4 +
 include/dt-bindings/clock/sun20i-d1-ccu.h     | 156 ++++++++++++++++++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h   |  19 +++
 include/dt-bindings/reset/sun20i-d1-ccu.h     |  77 +++++++++
 include/dt-bindings/reset/sun20i-d1-r-ccu.h   |  16 ++
 5 files changed, 272 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index c4b7243ddcf2..15ed64d35261 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -34,6 +34,8 @@ properties:
       - allwinner,sun8i-v3-ccu
       - allwinner,sun8i-v3s-ccu
       - allwinner,sun9i-a80-ccu
+      - allwinner,sun20i-d1-ccu
+      - allwinner,sun20i-d1-r-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
       - allwinner,sun50i-a100-ccu
@@ -79,6 +81,7 @@ if:
       enum:
         - allwinner,sun8i-a83t-r-ccu
         - allwinner,sun8i-h3-r-ccu
+        - allwinner,sun20i-d1-r-ccu
         - allwinner,sun50i-a64-r-ccu
         - allwinner,sun50i-a100-r-ccu
         - allwinner,sun50i-h6-r-ccu
@@ -99,6 +102,7 @@ else:
     properties:
       compatible:
         enum:
+          - allwinner,sun20i-d1-ccu
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
           - allwinner,sun50i-h616-ccu
diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
new file mode 100644
index 000000000000..e3ac53315e1a
--- /dev/null
+++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_
+#define _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_
+
+#define CLK_PLL_CPUX		0
+#define CLK_PLL_DDR0		1
+#define CLK_PLL_PERIPH0_4X	2
+#define CLK_PLL_PERIPH0_2X	3
+#define CLK_PLL_PERIPH0_800M	4
+#define CLK_PLL_PERIPH0		5
+#define CLK_PLL_PERIPH0_DIV3	6
+#define CLK_PLL_VIDEO0_4X	7
+#define CLK_PLL_VIDEO0_2X	8
+#define CLK_PLL_VIDEO0		9
+#define CLK_PLL_VIDEO1_4X	10
+#define CLK_PLL_VIDEO1_2X	11
+#define CLK_PLL_VIDEO1		12
+#define CLK_PLL_VE		13
+#define CLK_PLL_AUDIO0_4X	14
+#define CLK_PLL_AUDIO0_2X	15
+#define CLK_PLL_AUDIO0		16
+#define CLK_PLL_AUDIO1		17
+#define CLK_PLL_AUDIO1_DIV2	18
+#define CLK_PLL_AUDIO1_DIV5	19
+#define CLK_CPUX		20
+#define CLK_CPUX_AXI		21
+#define CLK_CPUX_APB		22
+#define CLK_PSI_AHB		23
+#define CLK_APB0		24
+#define CLK_APB1		25
+#define CLK_MBUS		26
+#define CLK_DE			27
+#define CLK_BUS_DE		28
+#define CLK_DI			29
+#define CLK_BUS_DI		30
+#define CLK_G2D			31
+#define CLK_BUS_G2D		32
+#define CLK_CE			33
+#define CLK_BUS_CE		34
+#define CLK_VE			35
+#define CLK_BUS_VE		36
+#define CLK_BUS_DMA		37
+#define CLK_BUS_MSGBOX0		38
+#define CLK_BUS_MSGBOX1		39
+#define CLK_BUS_MSGBOX2		40
+#define CLK_BUS_SPINLOCK	41
+#define CLK_BUS_HSTIMER		42
+#define CLK_AVS			43
+#define CLK_BUS_DBG		44
+#define CLK_BUS_PWM		45
+#define CLK_BUS_IOMMU		46
+#define CLK_DRAM		47
+#define CLK_MBUS_DMA		48
+#define CLK_MBUS_VE		49
+#define CLK_MBUS_CE		50
+#define CLK_MBUS_TVIN		51
+#define CLK_MBUS_CSI		52
+#define CLK_MBUS_G2D		53
+#define CLK_MBUS_RISCV		54
+#define CLK_BUS_DRAM		55
+#define CLK_MMC0		56
+#define CLK_MMC1		57
+#define CLK_MMC2		58
+#define CLK_BUS_MMC0		59
+#define CLK_BUS_MMC1		60
+#define CLK_BUS_MMC2		61
+#define CLK_BUS_UART0		62
+#define CLK_BUS_UART1		63
+#define CLK_BUS_UART2		64
+#define CLK_BUS_UART3		65
+#define CLK_BUS_UART4		66
+#define CLK_BUS_UART5		67
+#define CLK_BUS_I2C0		68
+#define CLK_BUS_I2C1		69
+#define CLK_BUS_I2C2		70
+#define CLK_BUS_I2C3		71
+#define CLK_SPI0		72
+#define CLK_SPI1		73
+#define CLK_BUS_SPI0		74
+#define CLK_BUS_SPI1		75
+#define CLK_EMAC_25M		76
+#define CLK_BUS_EMAC		77
+#define CLK_IR_TX		78
+#define CLK_BUS_IR_TX		79
+#define CLK_BUS_GPADC		80
+#define CLK_BUS_THS		81
+#define CLK_I2S0		82
+#define CLK_I2S1		83
+#define CLK_I2S2		84
+#define CLK_I2S2_ASRC		85
+#define CLK_BUS_I2S0		86
+#define CLK_BUS_I2S1		87
+#define CLK_BUS_I2S2		88
+#define CLK_SPDIF_TX		89
+#define CLK_SPDIF_RX		90
+#define CLK_BUS_SPDIF		91
+#define CLK_DMIC		92
+#define CLK_BUS_DMIC		93
+#define CLK_AUDIO_DAC		94
+#define CLK_AUDIO_ADC		95
+#define CLK_BUS_AUDIO		96
+#define CLK_USB_OHCI0		97
+#define CLK_USB_OHCI1		98
+#define CLK_BUS_OHCI0		99
+#define CLK_BUS_OHCI1		100
+#define CLK_BUS_EHCI0		101
+#define CLK_BUS_EHCI1		102
+#define CLK_BUS_OTG		103
+#define CLK_BUS_LRADC		104
+#define CLK_BUS_DPSS_TOP	105
+#define CLK_HDMI_24M		106
+#define CLK_HDMI_CEC_32K	107
+#define CLK_HDMI_CEC		108
+#define CLK_BUS_HDMI		109
+#define CLK_MIPI_DSI		110
+#define CLK_BUS_MIPI_DSI	111
+#define CLK_TCON_LCD0		112
+#define CLK_BUS_TCON_LCD0	113
+#define CLK_TCON_TV		114
+#define CLK_BUS_TCON_TV		115
+#define CLK_TVE			116
+#define CLK_BUS_TVE_TOP		117
+#define CLK_BUS_TVE		118
+#define CLK_TVD			119
+#define CLK_BUS_TVD_TOP		120
+#define CLK_BUS_TVD		121
+#define CLK_LEDC		122
+#define CLK_BUS_LEDC		123
+#define CLK_CSI_TOP		124
+#define CLK_CSI_MCLK		125
+#define CLK_BUS_CSI		126
+#define CLK_TPADC		127
+#define CLK_BUS_TPADC		128
+#define CLK_BUS_TZMA		129
+#define CLK_DSP			130
+#define CLK_BUS_DSP_CFG		131
+#define CLK_RISCV		132
+#define CLK_RISCV_AXI		133
+#define CLK_BUS_RISCV_CFG	134
+#define CLK_FANOUT_24M		135
+#define CLK_FANOUT_12M		136
+#define CLK_FANOUT_16M		137
+#define CLK_FANOUT_25M		138
+#define CLK_FANOUT_32K		139
+#define CLK_FANOUT_27M		140
+#define CLK_FANOUT_PCLK		141
+#define CLK_FANOUT0		142
+#define CLK_FANOUT1		143
+#define CLK_FANOUT2		144
+
+#endif /* _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun20i-d1-r-ccu.h b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
new file mode 100644
index 000000000000..4c2697fd32b0
--- /dev/null
+++ b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_
+
+#define CLK_R_AHB		0
+
+#define CLK_BUS_R_TIMER		2
+#define CLK_BUS_R_TWD		3
+#define CLK_BUS_R_PPU		4
+#define CLK_R_IR_RX		5
+#define CLK_BUS_R_IR_RX		6
+#define CLK_BUS_R_RTC		7
+#define CLK_BUS_R_CPUCFG	8
+
+#endif /* _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
new file mode 100644
index 000000000000..de9ff5203239
--- /dev/null
+++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN20I_D1_CCU_H_
+#define _DT_BINDINGS_RST_SUN20I_D1_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_DE		1
+#define RST_BUS_DI		2
+#define RST_BUS_G2D		3
+#define RST_BUS_CE		4
+#define RST_BUS_VE		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MSGBOX0		7
+#define RST_BUS_MSGBOX1		8
+#define RST_BUS_MSGBOX2		9
+#define RST_BUS_SPINLOCK	10
+#define RST_BUS_HSTIMER		11
+#define RST_BUS_DBG		12
+#define RST_BUS_PWM		13
+#define RST_BUS_DRAM		14
+#define RST_BUS_MMC0		15
+#define RST_BUS_MMC1		16
+#define RST_BUS_MMC2		17
+#define RST_BUS_UART0		18
+#define RST_BUS_UART1		19
+#define RST_BUS_UART2		20
+#define RST_BUS_UART3		21
+#define RST_BUS_UART4		22
+#define RST_BUS_UART5		23
+#define RST_BUS_I2C0		24
+#define RST_BUS_I2C1		25
+#define RST_BUS_I2C2		26
+#define RST_BUS_I2C3		27
+#define RST_BUS_SPI0		28
+#define RST_BUS_SPI1		29
+#define RST_BUS_EMAC		30
+#define RST_BUS_IR_TX		31
+#define RST_BUS_GPADC		32
+#define RST_BUS_THS		33
+#define RST_BUS_I2S0		34
+#define RST_BUS_I2S1		35
+#define RST_BUS_I2S2		36
+#define RST_BUS_SPDIF		37
+#define RST_BUS_DMIC		38
+#define RST_BUS_AUDIO		39
+#define RST_USB_PHY0		40
+#define RST_USB_PHY1		41
+#define RST_BUS_OHCI0		42
+#define RST_BUS_OHCI1		43
+#define RST_BUS_EHCI0		44
+#define RST_BUS_EHCI1		45
+#define RST_BUS_OTG		46
+#define RST_BUS_LRADC		47
+#define RST_BUS_DPSS_TOP	48
+#define RST_BUS_HDMI_SUB	49
+#define RST_BUS_HDMI_MAIN	50
+#define RST_BUS_MIPI_DSI	51
+#define RST_BUS_TCON_LCD0	52
+#define RST_BUS_TCON_TV		53
+#define RST_BUS_LVDS0		54
+#define RST_BUS_TVE		55
+#define RST_BUS_TVE_TOP		56
+#define RST_BUS_TVD		57
+#define RST_BUS_TVD_TOP		58
+#define RST_BUS_LEDC		59
+#define RST_BUS_CSI		60
+#define RST_BUS_TPADC		61
+#define RST_DSP			62
+#define RST_BUS_DSP_CFG		63
+#define RST_BUS_DSP_DBG		64
+#define RST_BUS_RISCV_CFG	65
+
+#endif /* _DT_BINDINGS_RST_SUN20I_D1_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-r-ccu.h b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
new file mode 100644
index 000000000000..d93d6423d283
--- /dev/null
+++ b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_TWD		1
+#define RST_BUS_R_PPU		2
+#define RST_BUS_R_IR_RX		3
+#define RST_BUS_R_RTC		4
+#define RST_BUS_R_CPUCFG	5
+
+#endif /* _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_ */
-- 
2.32.0


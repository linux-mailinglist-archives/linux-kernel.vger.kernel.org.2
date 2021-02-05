Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD79E31023E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBEB3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:29:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232760AbhBEB3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:29:25 -0500
X-UUID: dd93b3b006514a36b713701e175db4e8-20210205
X-UUID: dd93b3b006514a36b713701e175db4e8-20210205
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 693790404; Fri, 05 Feb 2021 09:28:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Feb 2021 09:28:13 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Feb 2021 09:28:14 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>, Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 2/5] soc: mediatek: pwrap: add arbiter capability
Date:   Fri, 5 Feb 2021 09:28:08 +0800
Message-ID: <1612488491-6149-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612488491-6149-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612488491-6149-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1B280AB1C9C9BA49B43DDB587290C2781961180D188057B72F08B279C7F172AB2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arbiter capability for pwrap driver.
The arbiter capability uses new design to judge the priority and latency
for multi-channel.
The design with arbiter support cannot change the watchdog timer.
This patch is preparing for adding mt6873/8192 pwrap support.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v4:
- add pwrap_get_fsm_state() for better code quality.
- refine code about PWRAP_CAP_ARB capacity for better code quality.
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 64 ++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index c897205ad11f..a75019fa02dc 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -25,10 +25,12 @@
 
 /* macro for wrapper status */
 #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
+#define PWRAP_GET_WACS_ARB_FSM(x)	(((x) >> 1) & 0x00000007)
 #define PWRAP_GET_WACS_FSM(x)		(((x) >> 16) & 0x00000007)
 #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
 #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
 #define PWRAP_STATE_INIT_DONE0		BIT(21)
+#define PWRAP_STATE_INIT_DONE1		BIT(15)
 
 /* macro for WACS FSM */
 #define PWRAP_WACS_FSM_IDLE		0x00
@@ -74,6 +76,7 @@
 #define PWRAP_CAP_DCM		BIT(2)
 #define PWRAP_CAP_INT1_EN	BIT(3)
 #define PWRAP_CAP_WDT_SRC1	BIT(4)
+#define PWRAP_CAP_ARB		BIT(5)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -340,6 +343,8 @@ enum pwrap_regs {
 	PWRAP_DCM_DBC_PRD,
 	PWRAP_EINT_STA0_ADR,
 	PWRAP_EINT_STA1_ADR,
+	PWRAP_SWINF_2_WDATA_31_0,
+	PWRAP_SWINF_2_RDATA_31_0,
 
 	/* MT2701 only regs */
 	PWRAP_ADC_CMD_ADDR,
@@ -1106,18 +1111,25 @@ static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
 	writel(val, wrp->base + wrp->master->regs[reg]);
 }
 
-static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
+static u32 pwrap_get_fsm_state(struct pmic_wrapper *wrp)
 {
-	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+	u32 val;
 
-	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;
+	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		return PWRAP_GET_WACS_ARB_FSM(val);
+	else
+		return PWRAP_GET_WACS_FSM(val);
 }
 
-static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
+static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
 {
-	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+	return pwrap_get_fsm_state(wrp) == PWRAP_WACS_FSM_IDLE;
+}
 
-	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
+static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
+{
+	return pwrap_get_fsm_state(wrp) == PWRAP_WACS_FSM_WFVLDCLR;
 }
 
 /*
@@ -1165,6 +1177,7 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
 	int ret;
+	u32 val;
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
 	if (ret) {
@@ -1172,13 +1185,21 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 		return ret;
 	}
 
-	pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		val = adr;
+	else
+		val = (adr >> 1) << 16;
+	pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
 	if (ret)
 		return ret;
 
-	*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		val = pwrap_readl(wrp, PWRAP_SWINF_2_RDATA_31_0);
+	else
+		val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+	*rdata = PWRAP_GET_WACS_RDATA(val);
 
 	pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
 
@@ -1228,8 +1249,13 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 		return ret;
 	}
 
-	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
-		     PWRAP_WACS2_CMD);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
+		pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
+		pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
+	} else {
+		pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata,
+			     PWRAP_WACS2_CMD);
+	}
 
 	return 0;
 }
@@ -2022,6 +2048,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
 static int pwrap_probe(struct platform_device *pdev)
 {
 	int ret, irq;
+	u32 mask_done;
 	struct pmic_wrapper *wrp;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_slave_id = NULL;
@@ -2116,14 +2143,21 @@ static int pwrap_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		mask_done = PWRAP_STATE_INIT_DONE1;
+	else
+		mask_done = PWRAP_STATE_INIT_DONE0;
+
+	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
 		ret = -ENODEV;
 		goto err_out2;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
-	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
+	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
+
 	/*
 	 * Since STAUPD was not used on mt8173 platform,
 	 * so STAUPD of WDT_SRC which should be turned off
@@ -2132,7 +2166,11 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
 		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
 
-	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
+	else
+		pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
+
 	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
 	/*
 	 * We add INT1 interrupt to handle starvation and request exception
-- 
2.18.0


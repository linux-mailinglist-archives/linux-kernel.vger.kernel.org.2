Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81D363EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhDSJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:40:24 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54484 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238180AbhDSJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:39:58 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J9RHL2024710;
        Mon, 19 Apr 2021 11:39:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=mt7WvfN2Btmo/ZaNnjB5VDrsbrquImJLFtGfvSfZYp0=;
 b=lS31HPXhLpo8iotp73Yg5X8/8okPFqdbtEy9/q+cKQsMhvx00KUeK/ZyxJUDvP7FYBOp
 Wn4H8NbSTctZXg314t5CAWiytxaX0DsR6V9Bc7FEFrF+CWh3Jm2O+aqRDhwanPwVKSsQ
 hIZiRHTQOV0+KHB2NkW0ZO/KoAU9JxnsxpuYLMppOy4M1H5zXsXbBzql05uwBNZj1hrj
 iSJD2/ApPCytRzwP3YaV/J7SOmzrzpvfKEOd4Tn0Ze6EH0lvoUPQr4AWPdxhjCwGWXG9
 XKAI7sKmW74HGc1N9SUdATNKrD/tgxS4rOo7IkgzYjfBWQedB8LHN1cY88st08WqgMeS jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380wj62rty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:39:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA27D100034;
        Mon, 19 Apr 2021 11:39:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0E6220A07F;
        Mon, 19 Apr 2021 11:39:06 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 11:39:06
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/11] clk: stm32mp1: merge 'clk-hsi-div' and 'ck_hsi' into one clock
Date:   Mon, 19 Apr 2021 11:38:42 +0200
Message-ID: <20210419093852.14978-2-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
References: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_05:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This patch is to prepare STM32MP1 clocks in trusted mode.
This Merge will facilitate to have a more coherent clock tree
in no trusted / trusted world.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/clk-stm32mp1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index a875649df8b8..35d5aee8f9b0 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1657,16 +1657,16 @@ static const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
 };
 
 static const struct clock_config stm32mp1_clock_cfg[] = {
-	/* Oscillator divider */
-	DIV(NO_ID, "clk-hsi-div", "clk-hsi", CLK_DIVIDER_POWER_OF_TWO,
-	    RCC_HSICFGR, 0, 2, CLK_DIVIDER_READ_ONLY),
-
 	/*  External / Internal Oscillators */
 	GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
 	/* ck_csi is used by IO compensation and should be critical */
 	GATE_MP1(CK_CSI, "ck_csi", "clk-csi", CLK_IS_CRITICAL,
 		 RCC_OCENSETR, 4, 0),
-	GATE_MP1(CK_HSI, "ck_hsi", "clk-hsi-div", 0, RCC_OCENSETR, 0, 0),
+	COMPOSITE(CK_HSI, "ck_hsi", PARENT("clk-hsi"), 0,
+		  _GATE_MP1(RCC_OCENSETR, 0, 0),
+		  _NO_MUX,
+		  _DIV(RCC_HSICFGR, 0, 2, CLK_DIVIDER_POWER_OF_TWO |
+		       CLK_DIVIDER_READ_ONLY, NULL)),
 	GATE(CK_LSI, "ck_lsi", "clk-lsi", 0, RCC_RDLSICR, 0, 0),
 	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
 
-- 
2.17.1


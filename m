Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC532C1E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351105AbhCCTaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:30:39 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48424 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1386961AbhCCTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:13:07 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123Hf1Di021615;
        Wed, 3 Mar 2021 18:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=LYcJr357y+zbhIePaqUKe0mtTHJbvYGE/U/tfFKD+os=;
 b=OMZ05YXyNW4CL6eHEy7ArW5VQnNA9fWhiGJ1kvjKYwAQT4EiqRH1RrNx/89TV0Hjh/R2
 4u3yo1uiSqm4alJxazDd78TVm2Z/tXcrmbQ37Gc6Z8WYVBYTKoJ44kF5PZuk/xTsMn1j
 hHx0vOnrJBfIfLtbTVsOOd8S0CnILF+mk51dYIHSKGIn8w5Wbxs9X7J6M4eMOYi/S2Fh
 ZGMNdPjOKW15usBH72lQMWcdqDJ6XBqpeyoLj/6zhvdGV2FMNlPy0ehwieHlqaBWNzLb
 gJSdKeG4Sf0dD0Zc/FIl8Ifl/yeiuj2kEi73H5U9+1Dj1HlbN+QwGmBQaQaQ7DOrMFpA 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xehy56s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 18:52:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE7E610002A;
        Wed,  3 Mar 2021 18:52:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C13C325EA29;
        Wed,  3 Mar 2021 18:52:27 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Mar 2021 18:52:27
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <lee.jones@linaro.org>
CC:     <vilhelm.gray@gmail.com>, <alexandre.torgue@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@foss.st.com>,
        <olivier.moysan@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] mfd: stm32-timers: avoid clearing auto reload register
Date:   Wed, 3 Mar 2021 18:51:35 +0100
Message-ID: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_05:2021-03-03,2021-03-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARR register is cleared unconditionally upon probing, after the maximum
value has been read. This initial condition is rather not intuitive, when
considering the counter child driver. It rather expects the maximum value
by default:
- The counter interface shows a zero value by default for 'ceiling'
  attribute.
- Enabling the counter without any prior configuration makes it doesn't
  count.

The reset value of ARR register is the maximum. So Choice here
is to backup it, and restore it then, instead of clearing its value.
It also fixes the initial condition seen by the counter driver.

Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/mfd/stm32-timers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index add6033..44ed2fc 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -158,13 +158,18 @@ static const struct regmap_config stm32_timers_regmap_cfg = {
 
 static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
 {
+	u32 arr;
+
+	/* Backup ARR to restore it after getting the maximum value */
+	regmap_read(ddata->regmap, TIM_ARR, &arr);
+
 	/*
 	 * Only the available bits will be written so when readback
 	 * we get the maximum value of auto reload register
 	 */
 	regmap_write(ddata->regmap, TIM_ARR, ~0L);
 	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
-	regmap_write(ddata->regmap, TIM_ARR, 0x0);
+	regmap_write(ddata->regmap, TIM_ARR, arr);
 }
 
 static int stm32_timers_dma_probe(struct device *dev,
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607163AAAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFQFVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:21:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229912AbhFQFUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:20:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H5GwbR024540;
        Thu, 17 Jun 2021 07:18:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=wOdBXreJaHkgnJPvNm4hYfpoNn+S6pHPol0liOPRIiU=;
 b=z2FJjBB/w2uA5A+cWou9jrm6EYx+w+CADfX01bkmiFfpARBIZdKZimnWuhp8+mLUtM1l
 UMYGy5ARGz3af0xutqIioJPfOiARV4iuQKMwdaMFgJWDTa5NrLCc1lmzMlShe1V526rz
 BZl9n/jOaktT6Tn6yaZBKKUhqau/6KvmG6fM2ire7cPKMBrTem4QwqdnsX53nKiKRUDl
 ogHHykzDSKCoL2UOS0GJp0cFqM2MFfHWEBFfd970JfNMOou9PvYIVvBlQVT+jUrv1Jf7
 QFkHbk1LXgLw6djYai/X8/2gDr+vwvSjd+hYR321q1hW4TUMjqRG/4jI+mn5+4a0ieE3 EQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 397p55arr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 07:18:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40D1D10002A;
        Thu, 17 Jun 2021 07:18:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18095211278;
        Thu, 17 Jun 2021 07:18:20 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun 2021 07:18:19
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 00/11] Introduce STM32MP1 RCC in secured mode
Date:   Thu, 17 Jun 2021 07:18:03 +0200
Message-ID: <20210617051814.12018-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_01:2021-06-15,2021-06-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Platform STM32MP1 can be used in configuration where some clocks and
IP resets can relate as secure resources.
These resources are moved from a RCC clock/reset handle to a SCMI
clock/reset_domain handle.

The RCC clock driver is now dependent of the SCMI driver, then we have
to manage now the probe defering.

v2 -> v3:
  - use determine_rate op instead of round_rate for ck_rtc
  - remove DT patches from patchset to keek Kernel device tree as there are in basic boot.
     We will applied scmi clock phandle thanks dtbo in U-boot.
v1 -> v2:
  - fix yamllint warnings.

Gabriel Fernandez (11):
  clk: stm32mp1: merge 'clk-hsi-div' and 'ck_hsi' into one clock
  clk: stm32mp1: merge 'ck_hse_rtc' and 'ck_rtc' into one clock
  clk: stm32mp1: remove intermediate pll clocks
  clk: stm32mp1: convert to module driver
  clk: stm32mp1: move RCC reset controller into RCC clock driver
  reset: stm32mp1: remove stm32mp1 reset
  dt-bindings: clock: add IDs for SCMI clocks on stm32mp15
  dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
  dt-bindings: reset: add MCU HOLD BOOT ID for SCMI reset domains on
    stm32mp15
  dt-bindings: clock: stm32mp1 new compatible for secure rcc
  clk: stm32mp1: new compatible for secure RCC support

 .../bindings/clock/st,stm32mp1-rcc.yaml       |   6 +-
 drivers/clk/Kconfig                           |  10 +
 drivers/clk/clk-stm32mp1.c                    | 500 +++++++++++++++---
 drivers/reset/Kconfig                         |   6 -
 drivers/reset/Makefile                        |   1 -
 drivers/reset/reset-stm32mp1.c                | 115 ----
 include/dt-bindings/clock/stm32mp1-clks.h     |  27 +
 include/dt-bindings/reset/stm32mp1-resets.h   |  15 +
 8 files changed, 469 insertions(+), 211 deletions(-)
 delete mode 100644 drivers/reset/reset-stm32mp1.c

-- 
2.17.1


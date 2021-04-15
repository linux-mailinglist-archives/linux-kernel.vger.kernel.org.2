Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A03606C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhDOKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:32 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhDOKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:24 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FAAinD025292;
        Thu, 15 Apr 2021 12:10:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=MHemc9dIypROVxJM89Wnd08Ri31AtNoLRiSbLCCA4dQ=;
 b=R7b2D0kIdRD4UaDcHz2L0k/yinuw8rMDs4xxLItoy2F69/2iyoqr2sybIqx4+WOoWRRm
 ewUUYx/S0I8BDdCUqd7c+NarMUQdy7l3XGljZrbXMRHSN4ls9E/RQogtEdtpvxFZl/Ex
 eK6WWJxpYohkVv6LLaz/xb7XLe8O9cBWHHS8d0kgt/nRlYtaY8OIkHiRAarm0HdIRa4j
 7tK7ab/wKbnsbtFm6YHoKljdh6TLCEqyWxZU0G4FYwuzxQ08OqBC2GqQq61doKLlSg23
 tbGMH/dMKvLRHNwinBaTxWwAXSFnBkAAdWku+9FlTq64eRdI/4QN5u1RbJUXV7NJ/4wK zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0t5yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3A7A10002A;
        Thu, 15 Apr 2021 12:10:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C812A226377;
        Thu, 15 Apr 2021 12:10:39 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:39
 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
Subject: [PATCH 00/13] ARM: dts: stm32: fix "make dtbs_check W=1" round1
Date:   Thu, 15 Apr 2021 12:10:24 +0200
Message-ID: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First round to cleanup warnings and yaml validation issues seen running
"make dtbs_check W=1" command for STM32 platform. It concerns all SoC
(MCU: f429/429, f746/769, h743, MPU) and all boards (ST reference boards,
DH, Engicam, LxA ...).

Main fixes are done in device tree files but some imply a change in yaml
dt-bindings file.

regards
Alex

Alexandre Torgue (13):
  ARM: dts: stm32: fix gpio-keys node on STM32 MCU boards
  ARM: dts: stm32: fix RCC node name on stm32f429 MCU
  ARM: dts: stm32: fix timer nodes on STM32 MCU to prevent warnings
  dt-bindings: mfd: stm32-timers: remove #address/size cells from
    required properties
  ARM: dts: stm32: update pinctrl node name on STM32 MCU to prevent
    warnings
  ARM: dts: stm32: fix i2c node name on stm32f746 to prevent warnings
  ARM: dts: stm32: move stmmac axi config in ethernet node on stm32mp15
  dt-bindings: net: document ptp_ref clk in dwmac
  ARM: dts: stm32: fix stpmic node for stm32mp1 boards
  dt-bindings: mfd: add vref_ddr-supply to st,stpmic1 yaml
  ARM: dts: stm32: fix LTDC port node on STM32 MCU ad MPU
  ARM: dts: stm32: fix DSI port node on STM32MP15
  ARM: dts: stm32: fix ltdc pinctrl on microdev2.0-of7

 .../bindings/mfd/st,stm32-timers.yaml         |  2 -
 .../devicetree/bindings/mfd/st,stpmic1.yaml   |  2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml   |  4 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml  |  6 +-
 arch/arm/boot/dts/stm32429i-eval.dts          |  8 +-
 arch/arm/boot/dts/stm32746g-eval.dts          |  6 +-
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi        |  2 +-
 arch/arm/boot/dts/stm32f429-disco.dts         |  6 +-
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi      | 72 +++++++++---------
 arch/arm/boot/dts/stm32f429.dtsi              | 10 +--
 arch/arm/boot/dts/stm32f469-disco.dts         |  8 +-
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi      | 74 +++++++++----------
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi        |  2 +-
 arch/arm/boot/dts/stm32f746.dtsi              | 12 +--
 arch/arm/boot/dts/stm32f769-disco.dts         |  6 +-
 arch/arm/boot/dts/stm32h743.dtsi              |  4 -
 arch/arm/boot/dts/stm32mp151.dtsi             | 16 ++--
 arch/arm/boot/dts/stm32mp157.dtsi             |  2 -
 arch/arm/boot/dts/stm32mp157a-dk1.dts         |  8 ++
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  5 +-
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  7 +-
 arch/arm/boot/dts/stm32mp157c-dk2.dts         | 12 ++-
 arch/arm/boot/dts/stm32mp157c-ev1.dts         |  5 +-
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  3 +-
 .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi |  5 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  5 +-
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  7 --
 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi      |  7 +-
 29 files changed, 130 insertions(+), 182 deletions(-)

-- 
2.17.1


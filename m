Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7A397198
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhFAKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:39:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53050 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232569AbhFAKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:39:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151AVmNg029022;
        Tue, 1 Jun 2021 12:37:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3biXO/fpJflq2AcQCK76xAJA1BbX58Bg7funY9JCbm8=;
 b=gVGcDWpmFLi2vkt8ZSC1ZkyNDcWZlIPGQDgMzMN51/USVOX7Ci4eZovrXm/mWC7srra3
 7cKLpT5ixlVZQ1QzD4IAe/Ui68Brj7h1s6D+6S3Yv4o3eV3deR62/mKPAB2dPjSImVD2
 bKeA4Xhb8y94aO96qM2Gs0EsI/QJ6pqxwv/hoFiC+Ytcs+GHkzPHxi+v2wwIzJP+FQz0
 lbrNA2HFD7jGPmKX4/KwFcsE2eaJF3qLXhKcyzO/ndkxzRgqcCwtFsKW83PQRc0MoWzt
 O5oWJZw9awpOuUqE8clBzM6KDu/f5W3g8M23pNaMZuX4di3SQlYMaakCJj7zUwscVjmP Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38wjdg0aps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 12:37:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA73410002A;
        Tue,  1 Jun 2021 12:37:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D82721B514;
        Tue,  1 Jun 2021 12:37:11 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 12:37:10 +0200
Subject: Re: [PATCH 00/13] ARM: dts: stm32: fix "make dtbs_check W=1" round1
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <a5a76fa8-fac5-556d-f272-4c471f3e7913@foss.st.com>
Date:   Tue, 1 Jun 2021 12:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/15/21 12:10 PM, Alexandre Torgue wrote:
> Hi,
> 
> First round to cleanup warnings and yaml validation issues seen running
> "make dtbs_check W=1" command for STM32 platform. It concerns all SoC
> (MCU: f429/429, f746/769, h743, MPU) and all boards (ST reference boards,
> DH, Engicam, LxA ...).
> 
> Main fixes are done in device tree files but some imply a change in yaml
> dt-bindings file.
> 
> regards
> Alex
> 
> Alexandre Torgue (13):
>    ARM: dts: stm32: fix gpio-keys node on STM32 MCU boards
>    ARM: dts: stm32: fix RCC node name on stm32f429 MCU
>    ARM: dts: stm32: fix timer nodes on STM32 MCU to prevent warnings
>    dt-bindings: mfd: stm32-timers: remove #address/size cells from
>      required properties
>    ARM: dts: stm32: update pinctrl node name on STM32 MCU to prevent
>      warnings
>    ARM: dts: stm32: fix i2c node name on stm32f746 to prevent warnings
>    ARM: dts: stm32: move stmmac axi config in ethernet node on stm32mp15
>    dt-bindings: net: document ptp_ref clk in dwmac
>    ARM: dts: stm32: fix stpmic node for stm32mp1 boards
>    dt-bindings: mfd: add vref_ddr-supply to st,stpmic1 yaml
>    ARM: dts: stm32: fix LTDC port node on STM32 MCU ad MPU
>    ARM: dts: stm32: fix DSI port node on STM32MP15
>    ARM: dts: stm32: fix ltdc pinctrl on microdev2.0-of7
> 
>   .../bindings/mfd/st,stm32-timers.yaml         |  2 -
>   .../devicetree/bindings/mfd/st,stpmic1.yaml   |  2 +-
>   .../devicetree/bindings/net/snps,dwmac.yaml   |  4 +-
>   .../devicetree/bindings/net/stm32-dwmac.yaml  |  6 +-
>   arch/arm/boot/dts/stm32429i-eval.dts          |  8 +-
>   arch/arm/boot/dts/stm32746g-eval.dts          |  6 +-
>   arch/arm/boot/dts/stm32f4-pinctrl.dtsi        |  2 +-
>   arch/arm/boot/dts/stm32f429-disco.dts         |  6 +-
>   arch/arm/boot/dts/stm32f429-pinctrl.dtsi      | 72 +++++++++---------
>   arch/arm/boot/dts/stm32f429.dtsi              | 10 +--
>   arch/arm/boot/dts/stm32f469-disco.dts         |  8 +-
>   arch/arm/boot/dts/stm32f469-pinctrl.dtsi      | 74 +++++++++----------
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi        |  2 +-
>   arch/arm/boot/dts/stm32f746.dtsi              | 12 +--
>   arch/arm/boot/dts/stm32f769-disco.dts         |  6 +-
>   arch/arm/boot/dts/stm32h743.dtsi              |  4 -
>   arch/arm/boot/dts/stm32mp151.dtsi             | 16 ++--
>   arch/arm/boot/dts/stm32mp157.dtsi             |  2 -
>   arch/arm/boot/dts/stm32mp157a-dk1.dts         |  8 ++
>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  5 +-
>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  7 +-
>   arch/arm/boot/dts/stm32mp157c-dk2.dts         | 12 ++-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts         |  5 +-
>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  3 +-
>   .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi |  5 +-
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  5 +-
>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 +-
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  7 --
>   arch/arm/boot/dts/stm32mp15xx-osd32.dtsi      |  7 +-
>   29 files changed, 130 insertions(+), 182 deletions(-)
> 

Patches 1 to 8 and 13 applied on stm32-next. I will send a v2 for 
vref-ddr supply. There is still an open point about #adress-size/cells 
check for DSI / LTDC ports.

Rob,
Can we consider to have "#adress-size/cells defined even if only one 
endpoint (child) is defined ? and then is it possible to update the 
checker ? Or do we have to keep patches [11][12]
and update #adress-size/cells in board dts files ?

Thanks
Alex


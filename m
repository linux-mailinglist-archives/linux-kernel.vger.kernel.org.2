Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054F3E46DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhHINp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:45:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:34906 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhHINp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628516737; x=1660052737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oIIhO5Fu8GvdFVb5Lyvx66v0sHtOf2NnOJazlM74dk=;
  b=toUeWQG2xoCdnPZ5kROT2SPFwW2J/5gUWqPhQOXObWf75TgJsBgBbaoE
   +SUQAXrv+7UBtBbp9raF9UMLagRLCrCmcOgNsIPOQxyAzL3GsU5h8H52p
   m1fjEuNB3P0v0lj4BwYbNDz9oENx/JLV3O4ko2O45wAxuDtjKNNaEFGkR
   c3UjIEy3A4kkOSRz+1PkC7/yIQ0RtQORzZrHg+KVYgDsIYkxYz8IDPfy0
   dfZ8cwzuEKSeixZTKXLe9oH1IttDb2FFbpROCxGxpKf31FQSZSafgw5YL
   VnfiyRhU4bZgxFmPzmPKThMIQWAPNjGvqA82L1+iCrtl9QNgk05st4G0r
   A==;
IronPort-SDR: 1ZxTEx2HGugTM+LJDRVUhmoFTW3u/14G+7ktp9lJpnkR+cXqR6tIx9oiOZz9Wdx/ELcNt5SNts
 bfgBmnzczVrjuHduFytyq5KHay2Vu8lpcnZHy8UjtgcoS9Vj1QETxLtwBDeucmqagng3/m6cet
 0kyrTh34dKXPHiXZZhr9/4ohplyN4erTfQFrRjlz+42H/a2NOlzCxlWdDcyYdtidbYruzH8n2N
 m9CRuLezykSF6Lt//mCktDRg6cVUhlpv79L+xYnbllFGLlvtPpPFCX/zGefUjL8dgUHrgXqwh4
 UGZmEXp/SFAVgPnw4/Wb+dyr
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="127592839"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2021 06:45:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 06:45:35 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 9 Aug 2021 06:45:32 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [GIT PULL v2] ARM: at91: defconfig for 5.15
Date:   Mon, 9 Aug 2021 15:45:21 +0200
Message-ID: <20210809134521.10155-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
References: <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is the second attept about defconfig changes for 5.15 which contains
addition for SAMA7G5.

v1 --> v2:
- add more information to the tag message for explaining why we prefer
  a new sama7_defconfig file.

Thanks, best regards,
  Nicolas

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.15

for you to fetch changes up to b62869dcd4bcf341d3750a2bcad9a80c6d5562a8:

  ARM: multi_v7_defconfig: add sama7g5 SoC (2021-07-19 15:25:42 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.15:

- add defconfig entries for new SoC: SAMA7G5
  - dedicated sama7_defconfig which avoids having to carry older drivers
    and dependencies from the sama5 family:
    CACHE_L2X0, CAN_AT91, TOUCHSCREEN_ADC, AT91SAM9X_WATCHDOG,
    VIDEO_ATMEL_ISI, SND_ATMEL_SOC_I2S, MMC_ATMELMCI, AT_HDMAC, AT91_ADC,
    REGULATOR_ACT*
    Addition of new drivers that are not part of any sama5 SoC:
    SND_MCHP_SOC_I2S_MCC, SND_MCHP_SOC_SPDIFTX|RX, MICROCHIP_PIT64B
    plus upcoming MIPI pipeline, audio sample rate converter, ...
    It also maintains both sama5 and sama7 defconfig tailored for their
    respective families and easy to identify.
  - addition to the generic multi_v7_defconfig

----------------------------------------------------------------
Eugen Hristev (2):
      ARM: configs: at91: add defconfig for sama7 family of SoCs
      ARM: multi_v7_defconfig: add sama7g5 SoC

 arch/arm/configs/multi_v7_defconfig |   2 +
 arch/arm/configs/sama7_defconfig    | 209 +++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 arch/arm/configs/sama7_defconfig

-- 
Nicolas Ferre

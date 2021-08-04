Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1805D3DFD38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhHDIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:46:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24369 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhHDIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628066803; x=1659602803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4pYMkRlX38NNd5ekcHCNDs7b0kdlhQPRaRpUCPO9W/I=;
  b=GaVdyMs74RV6RpOTEe5gLN1LpyWhSr4zcnnkcL1NF4adhz/SBVKkmM41
   /O2XEBt4Td7QXBp/0xtLGkVwfRI9J+7h7NStBXGrJhCeMvxJZ26dkIFJP
   yoADUeYFU9Ih2X6Jfmv4QChjIBSt/lHKTHejNBbwHKB02a44kBy/fBLrC
   A76ywdqm33fIUizFEYvW7FHhvf83iuP9jNoC0uBdcDcRzoQRnmItLvPEy
   EFd3tBxAxxIPOSiaZMp+JiWtCcqeIOGJNdk1mA7AfI1UZiSyEFtYcgBAv
   OYfw7gqBIEoPaHqz861lpM77PBGZamPOqlELVAEHWdXflhyLQEX0a7+aj
   g==;
IronPort-SDR: 9avkbVS1wlSP3hKoTjJ6W3uD/yjWK22S09qLRA7utGzaXXmCP0bw6hfH7BJmV2sqNGmX7oafEV
 pmguns90+qXB5DlMIiObPHfzro8tyWjUr+ItgPEQ5Mx7uzO9u1JNlmoX7MV5UKnzpB28AmPfbi
 Rc/zJLtWh51iHq9GzePhjYsn2iawwDEkxcDiI+s0+HkFY5/WqwUXTH9EJw8ztYLFZMvezE4mSk
 kMirjDp0sgQefxM1dZlAt4IeDby6D2DJd/zmta6s1TjOEtsKbOQr/6AS6WIkoCvxsYdIgXku0J
 C1LJIjpxZbZUlo7dfOI8DnXd
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="138755645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2021 01:46:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 01:46:42 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 4 Aug 2021 01:46:40 -0700
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
Subject: [GIT PULL] ARM: at91: defconfig for 5.15
Date:   Wed, 4 Aug 2021 10:46:31 +0200
Message-ID: <20210804084631.12934-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the defconfig changes for 5.15 which contains addition for SAMA7G5.

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
  - dedicated sama7_defconfig to match the needed peripherals and
    dependencies
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

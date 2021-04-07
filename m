Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95D356B79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhDGLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:44:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2116 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhDGLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617795865; x=1649331865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rmI8sOYp6dN8KOCJhrdk1xqp58BimrU3uwoH1pcF7KA=;
  b=Qm3mWxXEPFglew0YsztcFdzhxKTW8fN1/VdYbFpTpfNk8fiuWPl8NnMn
   F9fF4jFJP37v49KkShmKrsHfTQhUSplCArPNHJS53p4t1m7QPij4yEOOT
   4wnwmmceQKkxrGN43WHm2Y0UTvfiRSF51xMFU7UzQe3XTu7U/uOg2p/El
   96tDQnGNMJ3W+j/TO7/McRBJQiXjDrPVXwWD1APFr6iUSun7hbP2dmPbF
   oudiiidPxxDwnVgblXi2NvJhRd9sRZFZgq4zrr4eDjIhPKLVw4VIVcN49
   yAWPcrzBf5wUOVpOL9esu2C5+LOpFNZvgrXmAHuRWok1W8Zwnsmt9kdIc
   w==;
IronPort-SDR: V8qZJ52OkEAs7TMMqaQ1BLAll3Fii+xHudin2rgYC8dMTCKIGPg8Z/1mtCY3iZ7S2j2CQlfKGX
 rlKfEGnt6fuQ+vQJSxJEC3Q4ioBA5quBp8ZKYX5bWNMNpExEucP6rdyofNucBRjBjPprNgOqN7
 BkKP4SXq7xhkcuNiKdnvp9714tSiV6OYR7Xt8VArY/Tyx4xRdDzBs3HRc9qp74ToKuhcM7OmBM
 MX9QsITq6+acTq6QjW0ai4XC2XQ5qcNKEo9za1vnNpbwhILI7yV0CmYDGtisdiSQb6zmUKtFm+
 F98=
X-IronPort-AV: E=Sophos;i="5.82,203,1613458800"; 
   d="scan'208";a="109962106"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2021 04:44:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 04:44:24 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 7 Apr 2021 04:44:22 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.13
Date:   Wed, 7 Apr 2021 13:44:15 +0200
Message-ID: <20210407114415.13180-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is first batch of dt changes for 5.13. Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.13

for you to fetch changes up to 4d930c421e3b4f5bb3a9dd6b2eba2b15d458fcb5:

  ARM: dts: at91: sama5d2: add ETB and ETM unit name (2021-04-07 13:33:19 +0200)

----------------------------------------------------------------
AT91 dt for 5.13:

- two little fixes (typo, W=1)
- a change in gpio button keycode for recent boards

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      ARM: dts: at91: Fix a typo

Ludovic Desroches (1):
      ARM: dts: at91: change the key code of the gpio key

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2: add ETB and ETM unit name

 arch/arm/boot/dts/at91-sam9x60ek.dts          | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 3 ++-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   | 3 ++-
 arch/arm/boot/dts/at91sam9260ek.dts           | 3 ++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   | 3 ++-
 arch/arm/boot/dts/sama5d2.dtsi                | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi                | 2 +-
 11 files changed, 21 insertions(+), 12 deletions(-)

-- 
Nicolas Ferre

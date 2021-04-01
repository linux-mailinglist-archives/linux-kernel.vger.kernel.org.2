Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F645351D20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhDASY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:24:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62179 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhDASEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617300265; x=1648836265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+Damo6lBLTec0MqdYsAZG21XEfwTrUjDwnQIVPgrfg=;
  b=y4wmYYSboVKZsXGNac69x72cISxvrjOB4bQdyjorWjWAPos6c7+5QCti
   lapoCTc4ffzAUd/tiKtJcaiGaXWQtwibbFJiseRZ0vlyBndgAS8fnPQm/
   GQogQShNOIWgqaCSyKBx36Y5NQK1LNBxECg/P3F25WXnA4SYCb7ASiOYi
   D64JNMHbPfmKM8HgDHc0B4OIWmc1svkgNwaD7JxNmXPzTq5Xav+ON6WdM
   RdfXLZwyMPWpUilwj4/m+oZmY+ERgy/fQvqUNCEXfJZGo+WgVgXaBL6bK
   erGDEJYt/PMxIcCSa9lcJ/Y6te9PM2+Uxsr2HCioz6QIFFvpg2TUpH9UZ
   A==;
IronPort-SDR: 5Ng5NM1EzbpwR/HTQNvjcYL+q3V6cpSEYUklwZ7HK057B398VMKy7ww3FQCX3PxiL+u3xAMd55
 MXUshv32BekJnKyET4D489sAzSpIGtg6eqmR/LYgGcT6AHFfvCai4HxPcgvH9jkVRiHUF/VIkt
 dapG1mATxs46C4ElHH7FoXFGb2vgTzPrbx4ZDVrZFsWtf9Rl2B7ZyXbTLXgeDXK/GIiVarPOXS
 7aLrbtkGK+ZQOXfye16SXvY8kG+hwYf9n6Pv9gbrVw9Db3edYDVLcvqt7Z6pcSNs0fjKoo+ZT+
 eQ4=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="112171420"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 10:49:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 10:49:54 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 10:49:52 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.13
Date:   Thu, 1 Apr 2021 19:45:44 +0200
Message-ID: <20210401174544.32193-1-nicolas.ferre@microchip.com>
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

One single patch for now on our SoC branch. Stakeholders agreed to make it
travel with at91 -> arm-soc.

Thanks, best regards,
  Nicolas

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.13

for you to fetch changes up to 41dbf4a146a06443d1cbf39e238f02fa1ca9d626:

  ARM: at91: pm: Move prototypes to mutually included header (2021-03-26 18:20:49 +0100)

----------------------------------------------------------------
AT91 soc for 5.13:

- Fixing a W=1 warning

----------------------------------------------------------------
Lee Jones (1):
      ARM: at91: pm: Move prototypes to mutually included header

 arch/arm/mach-at91/pm.c        | 19 ++++++++-----------
 drivers/pinctrl/pinctrl-at91.c |  2 ++
 include/soc/at91/pm.h          | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)
 create mode 100644 include/soc/at91/pm.h

-- 
Nicolas Ferre

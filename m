Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2043351D25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhDAS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:27:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19898 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbhDASEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617300265; x=1648836265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mPIkwjQD5YnDveLgKJWb0Q8rKtmMJ9ReFqXZsU3nKaU=;
  b=2H2Cz/fGTpkSRRTHmqKfKHm6nWqQhqmsXWi8VwnJj6mHiOSsitTPymHa
   MkySlA+EJs6XYryzU3Hkuvs32csa/E0ndn7Sg5v1QBMeWi5sLjsRaA/HM
   es3Duc/Zo4QRQnyY+O9LsW2QZHmSkgY/fh/YGTQqxpN5n5paaMZlEGDC0
   r/oNhpKgykClYPGxzio6qQtPyp7OcJc3O2Wvw/b/DkjcNI/7/+rQJ8HfO
   mNsXjecEGr6ZLNnZaqXF9NqQwZGwwgl3jb/jdSeEfJL7VWMbi4JwFseIW
   caVjRWe3Rd2QP2aLCqWotrVpADiqRw2N//IAKhHbwMzAGkO3CVZxWKR6v
   A==;
IronPort-SDR: qhXlHQJy4oJtmkri0qncFVEdMT5iG+XH8L8JyrM+PXWaQDlsH3zzQVgdrv8oNOGk6s16oGs5fz
 Bk01o4eH/KjvfR4OnCBICd310G5Fc2vmsRV1Q2XKYa4k0xDe5BZkFYoczu4JU78D2y92NIh+gH
 ej7c8T18NtstEDan6vRRalQhaG2EZ1g8ira50fmwxWtCocfbfIc7PCrqT0UkG06ZB5YOS887Kz
 vvI6w8jVj7PJiMAgtIR942dOY16DjH2kkXyOX44U2BjLgxBzZhnWo50YeerIkppj2OYfbjLeQM
 lGQ=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="109371184"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 09:26:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 09:26:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 09:26:21 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.13
Date:   Thu, 1 Apr 2021 18:22:07 +0200
Message-ID: <20210401162207.29299-1-nicolas.ferre@microchip.com>
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

Here are the defconfig changes for 5.13 which is bigger than usual for aligning
with options that we use frequently and some changes which will be beneficial
for CI.
There is an update with savedefconfig included, tell me if you prefer the PR
without this first patch of the series.

Thanks, best regards,
  Nicolas

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.13

for you to fetch changes up to 4136c4443efce6f028eca74885870ac649981da1:

  ARM: configs: at91: Modernize UBI defconfig part (2021-03-29 11:27:14 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.13:

- aligment with recent kernel for sama5_defconfig
- move of 2 options to built-in
- addition of useful modules for validation and CI
- addition of Hantro G1 VPU from staging

----------------------------------------------------------------
Codrin Ciubotariu (1):
      ARM: configs: at91: sama5: Add audio MIKROE PROTO board

Emil Velikov (2):
      ARM: configs: at91: sama5: update with savedefconfig
      ARM: configs: at91: sama5: enable the Hantro G1 engine

Nicolas Ferre (4):
      ARM: configs: at91: sama5: MCP16502 regulator as built-in
      ARM: configs: at91: Add mtd tests as modules
      ARM: configs: at91: Add USB Video webcam class
      ARM: configs: at91: Modernize UBI defconfig part

Razvan Stefanescu (2):
      ARM: configs: at91: sama5: PIOBU as built-in
      ARM: configs: at91: sama5: Enable LAN78XX as module

 arch/arm/configs/at91_dt_defconfig |  5 +++-
 arch/arm/configs/sama5_defconfig   | 51 ++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 23 deletions(-)

-- 
Nicolas Ferre

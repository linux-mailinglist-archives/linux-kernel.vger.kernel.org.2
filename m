Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025DF3A4287
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFKM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:59:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61823 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1623416226; x=1654952226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZmDcLeDM+mKZKjjsmFu5tdV39OQUBI69egq4Sidx8s=;
  b=rObmvoad8GrA/O+/O9njWPmavwYlov1TV9ZBuCkDhw0ehylDJ/P0pMA4
   8SopVNDtXG6cCTxIUvN1jC/K4LGz5DnNvuoAJKUT4uQRz9j1lDl329X6P
   2WRpIqNDnREGgBECHNwZQ7GFB3Rphu9GNKYC8ovCpTsTBADPKxvk6QHIE
   3vdQXlGNxZCHN1K0+gVNiqfZ9HAMvo9mjXROPbW+7xopV2c9zurJfDb5a
   5c/8vp5N/yp2ZEh5hknuapSplQ0H4KKY0gUzPmT/pguPBAg2xOgUQNRNO
   adiPpEetcUwCYHEJpGEl4UFPgzAIpqLOaf8Qc0AxUzxJ1qc1vc5RvcwFK
   Q==;
IronPort-SDR: qxYOHCM/hY9V0HbXUG+Zh0qzt9aHe84/UhcY9AlVImyWeLX3VwAH2D3HJV2IZf5xaTGbtJJ1cP
 J672d+us8qFP+E5/mDVkQ5iuGYqT73MJ8NR54nvXU676i1oOm1kJNDmjtVnNhaDbDGA7/V5q9J
 043E3GC++hjEtRBoh7YQGsbAr/FaqwJvoTBrPap5La/dArfaeicZDWMYJPGcR/K2JAUgxMbdK+
 XufpurzChEIrNxlMfUEED6EQmFkL+SPyG5+J+4LX7X+z7IqcM8H2OqMRIMPgvofibe5yyF7Kd8
 +wQ=
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="120963641"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2021 05:57:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 05:57:05 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 11 Jun 2021 05:57:03 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.14
Date:   Fri, 11 Jun 2021 14:56:59 +0200
Message-ID: <20210611125659.25590-1-nicolas.ferre@microchip.com>
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

Only one patch for this PR: take as a patch if you prefer.
We have other defconfig patches in preparation but not ready yet and as it's
getting late, I send what I have now.

Thanks, best regards,
  Nicolas

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.14

for you to fetch changes up to b249d97825ff461747421a5009794f395e99a032:

  ARM: configs: at91_dt_defconfig: configs for sam9x60 (2021-06-07 12:02:36 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.14:

- Add the use of tickless and HR times to ARM9 defconfig

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: configs: at91_dt_defconfig: configs for sam9x60

 arch/arm/configs/at91_dt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
Nicolas Ferre

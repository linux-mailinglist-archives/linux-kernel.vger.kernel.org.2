Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801D3342B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCJQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:11:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54347 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhCJQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615392657; x=1646928657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5jeKypV2ExKtHu5QJ2ITrvif4oyKitUExTdelTu/Qo=;
  b=NxxUXGvRrwdXl82cA2Srn+8SsGEDjT29DOVosVaqfH9nXFQbQrQA7oKV
   6xqtjL5WDM+RKcouS/BLUL5TN+SCqQNzjG1TbyVIfl7zr0d4NaR8C5lmv
   hwkJsMTFttH5xCqeRfghRBYvF4IisIyu3il/Dx8S1PTxG1ysQlBnG5kI2
   ulbvdtypzaaeevvIzeF42nEKquScTldZmH0yCIP525iwZPQ/VOP1wIPpX
   Nhf24ip4nw2et8AgWv67C4NsHJpMhS1y7g1RkDvAWYcPAxXGIR2++D6qd
   xEaI5pZ4ca9YGtv4NJGDrWqptj1Ep+zesNSiKCelzK2bZUsl3l/j8JAWf
   g==;
IronPort-SDR: nEaPGjPgYT3WDxBsCTOOdsRUMVINyPtJBcEgKTRUNDp9FEeYRZcDojqs1/h6MdrlEmC0BmQCOz
 gp3dxzKAy+omQxtr+rD/OgcSJ4MbdKHAPQnUzAuGSaP2JxRNi2EJ2djotDRutXic9la4Lf3bEY
 ULgI0r2JqdEjEpkWvHN/auHfDKLmO6KgBnp4cYoAAJTjIFHqcm5F8MOIlSPBPhYaQEyrPBrQ5e
 HTh4Ft5XMYDgQ5SyVjSz65qaCYeXsJDSK0Np+WG5etgvAyD58cB1MiBD+RK+0n+DKqVt97Ho3u
 e2w=
X-IronPort-AV: E=Sophos;i="5.81,237,1610434800"; 
   d="scan'208";a="46983116"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2021 09:10:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 09:10:56 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 10 Mar 2021 09:10:53 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: fixes for 5.12
Date:   Wed, 10 Mar 2021 17:05:47 +0100
Message-ID: <20210310160547.55382-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are some fixes for 5.12. It's not regression vs. previous revision, this
is why I send them early in the cycle.
I based my branch on top of 5.12-rc2 because I noticed that your "master"
branch was pointing to it (and of course the "-dontuse" suffix from Linus).
Tell me if you prefer that I use a more usual "-rc1".

Thanks, best regards,
  Nicolas

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.12

for you to fetch changes up to 2c69c8a1736eace8de491d480e6e577a27c2087c:

  ARM: dts: at91: sam9x60: fix mux-mask to match product's datasheet (2021-03-10 16:38:15 +0100)

----------------------------------------------------------------
AT91 fixes for 5.12:

- only DT changes
-- wrong phy address that blocks Ethernet use on boards with sama5d27 SoM1
-- restrictive PIN possibilities for sam9x60

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: dts: at91-sama5d27_som1: fix phy address to 7

Federico Pellegrin (1):
      ARM: dts: at91: sam9x60: fix mux-mask for PA7 so it can be set to A, B and C

Nicolas Ferre (1):
      ARM: dts: at91: sam9x60: fix mux-mask to match product's datasheet

 arch/arm/boot/dts/at91-sam9x60ek.dts      | 8 --------
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 4 ++--
 arch/arm/boot/dts/sam9x60.dtsi            | 9 +++++++++
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
Nicolas Ferre

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE63BBC38
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhGELfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:35:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47802 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGELfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625484790; x=1657020790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvRMbur9pt5uXhFso/xB2HzdXwsghemNFczmpUlqogo=;
  b=VsksUSwVrF3FRhE1tbgglp5t9HQPQHdAWSkGzs7iYLugmsFSd2u16xX2
   yfe0Eu0//5eDOx225NqiKO1PTYyxCTM3Y/gulm1/ZwXnQIdTlRIdvvBm8
   UufDy/AIVP3p0kaofScSoumrEHCnbOi+xKJMBdkqnEyEytPNO3HNbhaF+
   5SdisrQwZpkF0MleThl8cZnVvwfmz3odWJmTtfQzZsF564A+IIvmo9HQR
   73/35t7lhGzoe2KG3GYZ5dE+BoJQFbb0v+9pVHouf3ZvUwLTX/tbYyhKn
   eD+HN2+pdo9KeFAyi/yEuxXkemygryhIcl81ORBmv7ADvyEYfyw/NN5oM
   g==;
IronPort-SDR: TmjVHbHOrE9Rhj/HXPbWBGgkKpkdDNo/2L6LnMgqVedwc1c3q4UwMgskelRGLthJty2+yTbaLI
 unrCTcYrwSJ4jgkDkW9jsCi6SWSsDBJz6H5Dc2R5oZb3xTquXvOrRxzcoy9OwYr/A3PkesNjzV
 gW/8B1mxDjHkGkAj7zfvJdaruN8bns8uy0bIL4M6woxBZTbnpGzGaRUz+Ct2Z4dGsEWInDpXnn
 zCNTgBCFKSUoIakEzILHlFEc6O7vjDMpAL6HUKl5styxdHmfXOpQbfeaKpmqTLq7ajF6BKVeb8
 ht0=
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="134613662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2021 04:33:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 04:33:09 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 5 Jul 2021 04:33:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] mfd: atmel-flexcom: add a fix and code cosmetics
Date:   Mon, 5 Jul 2021 14:31:02 +0300
Message-ID: <20210705113104.579535-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this series:
1/2 - use __maybe_unused around PM code
2/2 - fixes the PM

Claudiu Beznea (2):
  mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
  mfd: atmel-flexcom: use resume_noirq

 drivers/mfd/atmel-flexcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.25.1


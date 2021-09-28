Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35A641AAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhI1Iou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:44:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60831 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhI1Iot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632818590; x=1664354590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hSry/OKp7srb1dwiYjqC0zqZv+vjXLgVeZwSfowFews=;
  b=0T9kuK9L8GJnhvlxXR/ur/XKFKaB1wG9LJTmmNeNp0+e2vroyU8Uv4Or
   zZgOuf4NKj4DPOClwa40MNpa0H85mlSShvMlOPoAEpnyTCk9SmrsFDK5C
   bYyDW+Tj0LcQ4ljVLqbPOrhuwuEMyh7gT3V3ytWURk+O1AQuEiot8vUS+
   n81Gt2+QDvdTvcPQ297LbgEGAUoYyz8VppiSV1usbIlwqzOIYCYKKYbqm
   J1yup8eR8yeDlpjYaBkPPiEEU3A7GTUefQVw/oceIGpxI/FRw50nEg8nK
   b90MWshZJ3FrweBcvjS2Hx+LUUOLvrluHgvEZeU6z35UFn5GZhC363xqS
   w==;
IronPort-SDR: hU5Ju+4iWorQsAHSvhuWAyPDwpMFvgmTQZ/QoMeD8C+8CzbbjHX6bDSxdO2tyJhD0Ug0PoyuYE
 lIU4d0fPyWxjPW+0SJ1mdxD/VHnxv8v9bEImCJjX/xsoY+y27bz1k3Os9PhPqZ108uX9r6Mgg+
 dgz1WG33Mzx/kPBL4g/d8jV6p68EJA+MgJsexP4/QQrjZW1eemwvCJtP+9C2vRV47SuROjpd5K
 zbzfYZApqtVn8DNJgyng2E09QpMync7azvtAGkcnhI/RKLAxw7YdlyLOprlbnDzmZwccbrZW/x
 CdOIaaalmO9YL07fmHVBIXO7
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="138224976"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 01:43:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 01:43:09 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 28 Sep 2021 01:43:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] ARM: at91: pm: fixes
Date:   Tue, 28 Sep 2021 11:42:54 +0300
Message-ID: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series adds fixes for AT91 platform power management 
code.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
  ARM: at91: pm: group constants and addresses loading
  ARM: at91: pm: preload base address of controllers in tlb

 arch/arm/boot/dts/at91-sama7g5ek.dts |  2 ++
 arch/arm/mach-at91/pm_suspend.S      | 42 ++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.25.1


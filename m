Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54F43FC30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhJ2MWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:22:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhJ2MWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635510020; x=1667046020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GH9CUITwRufk4xnD31PbwjH6SiZ6yCHMETPuYDf1vk8=;
  b=swAuMjbBQ4NA/OsnY2w3hp974AvKa1iCqHMzFRsU2HrbsbCAj/+79exe
   luhJJIe5VRizh6QeZSvkOGpRU30ajU1qYTMjL83TPDC8ryJk6gpt10JvJ
   OU3oEwcDPW3nEiaQhLeesD/vM8dFz1YOt8xJY3z5Lzs3J0j37o9IzAczl
   Btqjlat+MoI9atyopgs80ggjRNauwlaJd7EUhuA5SnOBD+mzO9wHw/nMS
   ChLieZag1WNvRfFQHSL/Dik9Q7pKusoe9Jvdaie7w82Sfzwti8qjnKCH1
   sBqVP+0oj73Fh+f4gPVtkMD+J6t6n1uwJ0inUGreYSnwJjXmERusFPuL+
   A==;
IronPort-SDR: PUco+yRvZamRV2pgyG27WadXduE9srN709E+aK8FD7SuFB/Ul5MCZ/FHtPLz1xOPbVum365pnT
 xQTeKQe6AZwQRmScsOIOb270lxcJ0NGPEsrRuRWwUjEFC4Mh/NbiSBMposnkdX57AbreKk6V1v
 31TDlY2sUH8YBqvMSFafNKW6F57+Ixga6jNM/P/gG9XaCW83x9sVdyjPzjJia40p+edWT9bBYU
 PECoSiN1ZcCkDIMCswTc8nBI1200H3SYDS7I+w9rUb9omvunVGvg0gzrh4hLN7JEsP2WaNXBlD
 s/hwkWmbO8W+rIBi1K2joW0W
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="142144831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:20:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:20:19 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Oct 2021 05:20:17 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v2 0/3] Extend lan966x clock driver for clock gating support
Date:   Fri, 29 Oct 2021 14:19:26 +0200
Message-ID: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on the following series, therefor keep it as RFC.
https://www.spinics.net/lists/linux-clk/msg62795.html

This patch series extend the clock driver to support also clock gating.

v1->v2:
 - add Acked-by tag for patch 2
 - make the resource for clock gating as an optional resource

Horatiu Vultur (3):
  dt-bindings: clock: lan966x: Extend for clock gate support
  dt-bindings: clock: lan966x: Extend includes with clock gates
  clk: lan966x: Extend lan966x clock driver for clock gating support

 .../bindings/clock/microchip,lan966x-gck.yaml |  3 +-
 drivers/clk/clk-lan966x.c                     | 78 ++++++++++++++++++-
 include/dt-bindings/clock/microchip,lan966x.h |  8 +-
 3 files changed, 83 insertions(+), 6 deletions(-)

-- 
2.33.0


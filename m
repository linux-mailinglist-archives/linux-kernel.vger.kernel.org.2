Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DB40391F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349296AbhIHLuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:50:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:6832 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhIHLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631101731; x=1662637731;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AFf5gXO5hPidNz1BwQAFkSOB7zV5qHba7OdAt6PW39A=;
  b=w2C2ubHM3G1lF3yUILuG5DiTvgTpS2/+MCjPLrLtXrAsybnAnitBfZxB
   WOhLDuABPEqx2MAPEI4gkVF4MxVowx8urNJfLSo6g2gJyatYBAEPU0X4R
   qakO2l8awPyk8K7rbnTwlOw+2us3cOdKuu3IaGmmaUbQskdvPw2di+WCP
   O4dMttXGoEJrwHUO5k+StoY2SSgkimdVM+su5LwXxBjnm3QI42eEAn745
   FmEsRhWrI6osPQtW0VYm/NlbFXircy43EKI3hkvD0pGVYGUnY2sfHBzZG
   HtStgA0swg6ieJ0S9VhsKyV3x4tkQtFV9guVZYoz95MSPublGZLS2DypT
   Q==;
IronPort-SDR: //JpOrraKTS+6uxMjCqOZr2n+O7/Uotbuu9pXcpiI/f+JhB0yGF1hjfFAM5Q6Vu429a6kdDZwA
 s0GoOk1Xr9OVFA/RrzLEkl3nOHEJBLtOZjKx4ENr5FXwxhr38bG3ITw38SAsh1E6mf7sjaH+LT
 sqltiGlpLTPyEYpEq5yOJB0dWRbnqusKFYvWnrBkpDfUpPDFbWJXjwLT/p8IZ11hC7lRgfN08V
 Po2mjbVQjSOiMswNL/0kwodSKNGUJ5gj0w7uO5dpKXRv4R4ZTY7h0c3OtNEf+jHPaddZml950p
 3CXj3k+mtCLzE167U1F8sW4V
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="68603220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 04:48:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 04:48:50 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 04:48:46 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v2 0/3] Add driver for lan966x Generic Clock Controlle
Date:   Wed, 8 Sep 2021 17:18:41 +0530
Message-ID: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v1 -> v2:
- Updated license in dt-bindings.
- Updated example provided for clock controller node.

Kavyasree Kotagiri (3):
  dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
    clock IDs
  clk: lan966x: Add lan966x SoC clock driver
  dt-bindings: clock: lan966x: Add LAN966X Clock Controller

 .../bindings/clock/microchip,lan966x-gck.yaml |  64 +++++
 drivers/clk/clk-lan966x.c                     | 235 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 3 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC33FEB42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245640AbhIBJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:30:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25273 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbhIBJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630574945; x=1662110945;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vQ4X9z4tHLKdmthSbVHCo0tWJrsm7gSjdJTbGvnjpyI=;
  b=GBA2CiKk5tLQV9G8CLe8nAkATxRpWllOerVrjXFLE86Wcxy6Bo5CJ3mu
   iw4SaW3Ye/Cvo59b0mRfohK7ritbMPoGc6WJXwA2tUzM37uH/ucLdxoo4
   YMABEGJK3+qDcxpcKLy7tdak6NFsjcta2psOdgpizzgmPA2d/azx7flzJ
   Cddh/2yGEO3RyOxF61CL4IPVUs05XXytg0TN2RaDuyi2ASEZnL/VWU56V
   tJU8VjR3gcZ6egpZqsQADSUXRSQEJlcQA80nLoxOdEw/PWh1B0g/QO+Jk
   7mL9AuvweypN2MM7dIApn1UjZDgNcmbiKTzu30aUiChF+kGTJoww99321
   w==;
IronPort-SDR: 4e50H79fh1PFYlK1zr2K6tGjSTPIRFCLRWgvJcgMU1sFpNzVGAMTuMJ8Sr8yNzJwvCsvlSJvT7
 512jKc8jXi6M4TXeSASREqrSP0WmyQiSEyRENX4M4vM8OsCjZds4gcvbelfLcpcLjf2NNwVoI/
 7CVFlw67YziLTtu6U5P4FnlNLlsT66BE/CECVRMFaU5uQe4g4GuQTauTUAZnaQnHo65ZIV1IaL
 pyHzVT+/4QOLpUJsPbLaB8TxqA8gtfx9JUtWq40WjxqYJd1Bxev5UFs31YCYZw+bp9O/80UcOQ
 RtH0Hs7VZyACPEKECntR1qqz
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="134575441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 02:29:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 02:29:03 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Sep 2021 02:28:59 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 0/3] Add driver for lan966x Generic Clock Controlle
Date:   Thu, 2 Sep 2021 14:58:36 +0530
Message-ID: <20210902092836.28217-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

Kavyasree Kotagiri (3):
  dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
    clock IDs
  clk: lan966x: Add lan966x SoC clock driver
  dt-bindings: clock: lan966x: Add LAN966X Clock Controller

 .../bindings/clock/microchip,lan966x-gck.yaml |  46 ++++
 drivers/clk/clk-lan966x.c                     | 235 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 3 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

--
2.17.1


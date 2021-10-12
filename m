Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C342A383
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhJLLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:43:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:32188 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhJLLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634038875; x=1665574875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jjozcOuBaeFsR2Z2sJK/kBEF2nS01PkWYHdjzZusQYE=;
  b=JlhtK7LOVOIFSFqKctZEfJ4PCQnE71dyWpf6jPDD88QJXnka6/EGJed1
   E3HsyYQSRFIwR3ppfIkTsnNzpis4NYcqVT/URZvfai5kWiPb2MOOiwrQ5
   MhgBEep2i8ieQ4WM64s1TSJCcszMqLGvljAVEUaz7LNt8IreAerQaK6xS
   z6yFwjr4vQLcmYxxP+AnbjOCD2ATFxZQNaxw852vUFpr9UjPiGFXexWN/
   FTn+XOsx9Dwvk0+G6h2PffbrvS5Y9SZ5PZlj4yA/ZK8p6GUJ0xXEY9znU
   8H8aeDGFEiEAWnTIyhTOO1yb6Pe82oGUR2l3toGV+k9TzS8NEi8I2tFhP
   Q==;
IronPort-SDR: vA50VgQCaJsYLGNNEzj6Hla0KfALIC9NRdwhfjM1bQTa7cn50onslcDLu7w4cYMe+jXlQUcIXl
 MIlZo4yM8rXxTKlykK0ySXzXDfuS4sQNEEGbGuMIuXn5t3yc7s1l3DkuabC77aw+7/evjTePTD
 W4ssIsSasOZMjz2a4V7wQs5OGoEuJNcm5VfQTljyFngTEnpmuJtfgm6cw82/DkUaxXY/6TZmNN
 6w9412XGlbA9eHIbj4tqg/QkRnnPzRneRB3L7O9+qBHc8F/HGw5Mv2Vm2AeAw9WKFjvAuV8yBU
 8c63p3NQo6291TpA7FJFqXLg
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="135221662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2021 04:41:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 12 Oct 2021 04:41:14 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 12 Oct 2021 04:41:12 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/2] Extend Sparx5 switch reset driver for lan966x
Date:   Tue, 12 Oct 2021 13:42:36 +0200
Message-ID: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie extends the Microchip Sparx5 reset driver to support
lan966x

v1->v2:
  - add reviewed-by tag
  - extend driver to be able to release the reset also for external PHYs

Horatiu Vultur (2):
  dt-bindings: reset: Add lan966x support
  reset: mchp: sparx5: Extend support for lan966x

 .../bindings/reset/microchip,rst.yaml         | 14 +++-
 drivers/reset/Kconfig                         |  2 +-
 drivers/reset/reset-microchip-sparx5.c        | 80 +++++++++++++++++--
 3 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.33.0


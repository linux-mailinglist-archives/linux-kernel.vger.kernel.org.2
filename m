Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12E433528
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhJSLzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:55:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23123 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhJSLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634644375; x=1666180375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUCRn09UPGtN+bSxExgJVKlx4ifk9pQsioRogdF8N7Y=;
  b=qyC7Dhn5DxezLQCs8dI6eLEwMZnj1zv3LuBiwNgiuum2zzs+oWIimJ3a
   JBbRic85naeG9mHns2aY4YVXuYBl8M2DJWPMzXu5T6LhMGl2QB3RaCwMv
   Y7UU2JnNGLTUzRUWemLECpDxsy4uC9N/paAA5eqrxuA9CHuL+Si0avXvd
   v+0IWSQV9fOyz/cbQTLI/gcuQHZY5QmAo5tl812MkPOQWcDFOjw98K3Y7
   Bx786i2aPE/zfpfdaE7GMrVY2hDsOsGjJmrNxHjYR6ju0B1a59ibj78rJ
   BofLtJQdUNhNJnwYWLxASs1C3sWQSNIFlCt4WrQK6F+0SKF/b7e2OzJqM
   w==;
IronPort-SDR: dRwgedZuS6INEAHrBTKoSvpP7flt7RpH7ePRDnc3J63ki55bSO0R94sWEbpcDV+ZknueGWlTH/
 dIqFyQcYzvzDA52kgDNJRpu6zV66L8kNC+6eE8q/d1kwDXmbsIzju+dswQdKCURQQQtXN3Mixk
 +ofmRMPvvQiSGU1LqbdXq4PpsH3apk0UPbZtnq/Lo1RfrMO9xVyMDY4UGuADf64G48CFEkcBTo
 lR7Rmk/7/u+cqrYRxbLDWHTZu9zU7FSxc2ofaWZIesT4cRtPGB38rUUGa9NmDQYZy3oKzM9DTh
 PKfDbpIBO6Rt0TRR1Mz2b3GW
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="136094496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 04:52:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 04:52:49 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 04:52:48 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] reset: lan996x: Add reset driver for lan966x phys
Date:   Tue, 19 Oct 2021 13:52:03 +0200
Message-ID: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lan966x switch is reseted using the 'sparx5-switch-reset' but the
PHYs are still keep in reset. Therefore add this patch to release the
HW reset of the PHYs.

Horatiu Vultur (2):
  dt-bindings: reset: lan966x phy reset driver bindings
  reset: lan966x: Add support for the phy reset on lan966x

 .../bindings/reset/lan966x-phy,rst.yaml       | 53 +++++++++++
 drivers/reset/Kconfig                         |  8 ++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-microchip-lan966x-phy.c   | 93 +++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-lan966x-phy.c

-- 
2.33.0


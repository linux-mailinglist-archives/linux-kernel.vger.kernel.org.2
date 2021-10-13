Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646BB42B948
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhJMHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:38:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46734 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhJMHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634110602; x=1665646602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e35QBy/Nqe9ylZ3RnAZciYD44FsyH163wDVKXigV+iY=;
  b=c8vvJzdLsfesbFeH4HUtlgOU6O9s8I2JPrKPwtPFQkpZsEt1Y7xTXX4c
   /oGuX9z3n1lYhM+IjmppCS2p16G+da9LahWinp7biq7nF2p2sqU21iZc5
   9YyMuTXa3tYBD/XjR4jDA2boAKBCyoQb/pHYqTlcT3KqnpFAynblkHTHE
   njb/9sVn4sJt6WcoCso8uAoVjVhU5eqXtVGXxyY6ywUdlctDHtWG1cdG9
   eAFjsy8TGh5zUhCnFzQJYtaB6V08fjfeqMF0RJeQvQnm6+Ae7GP7KTwnI
   tbtNF+XIGsroFHuZDm88nYCYsIApn21HzTt7PBeQUr9NvEY+bzIvis9if
   A==;
IronPort-SDR: YqsXxA8KmfXPnYvm60pzrd5WkM6pI7C+dSXCPb70cxS3GCfdi5YrPwncoaJFD34bV/OnSpO3V0
 vXJko/802wqzEivnEoWSLqweGR3wEPn/yuv/majApj2KTpOYwvkJQTJwQ+4gESnQIlct1D1jh7
 pO7R+Fn+/TLAGdejEzhs5RFo0sS2RVyFyTvNd/LSldkq8ewMmQLpHRuEzP+HZuE92HfFblv+f0
 7/g+egnUAY9ZdNfn2GOIQSb2gSgPDKJz7JkIsYsgv9MwZPGNMydEUQZXK1czcwTDvi31rVauHu
 YOskR8tozuhOgCzpB+nlW4W6
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="132818364"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2021 00:36:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 13 Oct 2021 00:36:40 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 13 Oct 2021 00:36:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 0/2] Extend Sparx5 switch reset driver for lan966x
Date:   Wed, 13 Oct 2021 09:38:05 +0200
Message-ID: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie extends the Microchip Sparx5 reset driver to support
lan966x

v2->v3:
  - rename variable reset_gpio to phy_reset_gpio
  - rename gpios property in documentation to phy-reset-gpios

v1->v2:
  - add reviewed-by tag
  - extend driver to be able to release the reset also for external PHYs

Horatiu Vultur (2):
  dt-bindings: reset: Add lan966x support
  reset: mchp: sparx5: Extend support for lan966x

 .../bindings/reset/microchip,rst.yaml         | 14 +++-
 drivers/reset/Kconfig                         |  2 +-
 drivers/reset/reset-microchip-sparx5.c        | 81 +++++++++++++++++--
 3 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29052373765
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhEEJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhEEJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:23:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03550C0612EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 02:20:41 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1leDhn-0005Xa-20; Wed, 05 May 2021 11:20:31 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1leDhj-0002d3-P8; Wed, 05 May 2021 11:20:27 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [RFC PATCH v1 0/9] provide cable test support for the ksz886x
Date:   Wed,  5 May 2021 11:20:16 +0200
Message-Id: <20210505092025.8785-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches provide support for cable testing on the ksz886x switches.
Since it has one special port, we needed to add phylink with validation
and extra quirk for the PHY to signal, that one port will not provide
valid cable testing reports.

Michael Grzeschik (3):
  net: phy: micrel: move phy reg offsets to common header
  net: dsa: microchip: ksz8795: add phylink support
  net: phy: micrel: add patch for erratas on port1

Oleksij Rempel (6):
  net: phy: micrel: use consistent indention after define
  net: phy: micrel: apply resume errata workaround for ksz8873 and
    ksz8863
  net: phy: micrel: ksz886x add MDI-X support
  net: phy: micrel: ksz8081 add MDI-X support
  net: dsa: microchip: ksz8795: add LINK_MD register support
  net: phy: micrel: ksz886x/ksz8081: add cabletest support

 drivers/net/dsa/microchip/ksz8795.c     | 110 +++++++
 drivers/net/dsa/microchip/ksz8795_reg.h |  67 +---
 drivers/net/ethernet/micrel/ksz884x.c   |  70 +---
 drivers/net/phy/micrel.c                | 416 +++++++++++++++++++++++-
 drivers/net/phy/phylink.c               |   2 +-
 include/linux/micrel_phy.h              |  64 ++++
 net/dsa/slave.c                         |   4 +
 7 files changed, 586 insertions(+), 147 deletions(-)

-- 
2.29.2


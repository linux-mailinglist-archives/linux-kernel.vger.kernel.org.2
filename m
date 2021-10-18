Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64E43130C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJRJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:17:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53182 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhJRJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634548479; x=1666084479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EthqdF0WURJPQ6gp/6rS+J0VsWkJfQK9X5QrE1WEVvQ=;
  b=bEZNHCGM6Q6M90+B1hu00WEXTqKeTnyRLnGNuy7TJhRfGT35C7bQ3sQB
   pN5uCxh2fMddkE2B65pcbbrW/QUlTsQ8yU3uQ6UVDryTPq6h3oS/XasUY
   2jys93AfZSgMeNuIcJWr31/ChKPS2Cu5ViXUKjesFZ8dsn5DQVEZ8v2NR
   Xpg84s5lWe4dWAK3CEqwD2NVTzRyLlajrlmiZdefNIllBmUUQBIHHGQQS
   sYnHhZG+ylQq2F1G8mAoWwmdqAPBBj/sToLtAuudvQYFmVdxb08poT0ha
   HhLrDA4GC3sv0kKRlOkh0df/9mpb5uhjMflK/1enj8yeNGCPN4ztQVYMC
   Q==;
IronPort-SDR: fU1Zkm+QLxHdXUDXySFWAQT6nwL+7OmoP8pVj440pQSQsK2B+vpMyFTR3wxdnpfG4cl1RZcLvj
 squ2J2VWWtWPAPIAAU6hc2pPnUxpfhVIYpNFvZ78rzdjpXisPFZfsYbBfi67re8LTjL0dlwT9v
 jhJ7hSZzdRuh//HH0+9L5vA5c0LrznSjQUN8W661lfJ7NMbew3J5at2cG+dYdUaFiksziR00+2
 epCL5kPuAK9eBJx/z7lDgXVIuhnLlSmx7vXYH+SZvDhfjOFgXTQ3piP0mpjgDvZMOUy/ElgrTZ
 tD9s0N2kaUP5TjHeKCPDJ8xQ
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="140706368"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 02:14:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 02:14:38 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 02:14:36 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 0/2] Extend Sparx5 switch reset driver for lan966x
Date:   Mon, 18 Oct 2021 11:15:20 +0200
Message-ID: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie extends the Microchip Sparx5 reset driver to support
lan966x

v3->v4:
  - drop all the changes regarding the phy reset.
  - use enum instead oneOf in dt-bindings

v2->v3:
  - rename variable reset_gpio to phy_reset_gpio
  - rename gpios property in documentation to phy-reset-gpios

v1->v2:
  - add reviewed-by tag
  - extend driver to be able to release the reset also for external PHYs

Horatiu Vultur (2):
  dt-bindings: reset: Add lan966x support
  reset: mchp: sparx5: Extend support for lan966x

 .../bindings/reset/microchip,rst.yaml         |  4 +-
 drivers/reset/Kconfig                         |  2 +-
 drivers/reset/reset-microchip-sparx5.c        | 40 +++++++++++++++----
 3 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.33.0


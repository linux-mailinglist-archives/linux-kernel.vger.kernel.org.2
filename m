Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE942099A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhJDLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:01:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58706 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhJDLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633345173; x=1664881173;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=sY3JuSWm5dqpNxNWJutgaub/7ehHkkM9QZqB37262hs=;
  b=itzGx4flokIUDe4QxKjjx1KWiY9r0B1ihNl/a46VlbK9lko+ZulkUd8g
   AnN9Ww+bN9WEM2mYVufwUmsuzpnLR9TPY7Is41dlpQTad9w5PlgDOMeSk
   W/P6Gg6cNdTC7IEYwB8rXKpnu1mgNMXRQTNePsJGnS5cd10qwlB22tB/o
   RFjBB2qWOo7tAEk8ZJo1P+WJJrGprXMfERhYUDxv1So1+28xhWmySEvO7
   +uJ9ntUfDfIGXGLmxFszfDeSUT7iSjF+tFjgLiaW7gg1L3v8zGEcPP/5K
   8uW0OXqFYfLsFhY6iC09pAZ1j8IrwbLG7uB0hAvoD+TDmzkf7JrbH1K9p
   Q==;
IronPort-SDR: 2wQxoCgecm4avEU7jkbWcbx3dPYLOt2D2q8sRAn/M0aRzUbiWdK1E7f56SnjtoTI3bNQ9ChLcQ
 8gr6m4xJ8TSCeq6exyCQaJM8xH3M6pgkEAP5hSHaoMVqPjWqzzhnm9kY/tCQHVHHfwDpnfC6/N
 EyrGuC4l/2B+fxF/dtpN8gg6wOnBstsd1CnHGy7a1+baif6ei9bNH9zCbl8cxjMkSCOEbT1k7j
 PgvPzA+ubjF6+3a6anLYzmmTPtmWMf1uCTTqQRcYRU1BwepiYRtvhgvtKmR2p3djgsWW5a5KNn
 9iYUf8XcDMpwN1SqxwuhC+4k
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="131634534"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:59:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:59:33 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 03:59:28 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 0/4] Add lan966 documentation and remove lan966x.c file
Date:   Mon, 4 Oct 2021 16:29:22 +0530
Message-ID: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series modifies Kconfig entry, adds documentation for
lan966 family and removes lan966x setup code file as it is not 
required. 

These patches are generated from at91/linux.git
I had agreement with Nicolas Ferre that he will merge these changes
into existing patch.

Kavyasree Kotagiri (4):
  ARM: at91: Kconfig: use only one name SOC_LAN966 and merge options
  ARM: at91: Documentation: add lan966 family
  dt-bindings: arm: at91: Document lan966 pcb8291 and pcb8290 boards
  ARM: at91: remove lan966x file

 Documentation/arm/microchip.rst               |  6 +++++
 .../devicetree/bindings/arm/atmel-at91.yaml   | 12 +++++++++
 arch/arm/mach-at91/Kconfig                    | 12 ++++-----
 arch/arm/mach-at91/Makefile                   |  1 -
 arch/arm/mach-at91/lan966x.c                  | 25 -------------------
 5 files changed, 23 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-at91/lan966x.c

-- 
2.17.1


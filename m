Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282A32A493
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441987AbhCBKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:53:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48362 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382323AbhCBKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614681053; x=1646217053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BzCMYxPDMNs+TrnvwJzb5+Z9IhuKZjZB5Ja/IaNeADw=;
  b=Fmh4a39cZyaZR74Kj9ohvQ1Lxk3/KzqaFf6QXtdns+Bb7X5lRag8kU5P
   stCuw9GLycbt5crLX12vH2obehr+Bd2pAaXfrfeKLhwLeRSlXiKKnixiA
   pU/0Sm8UznaXoAXPzK26QbJeImofDfGctDK5M6q4+/qqZxrdiEg+Nm8ac
   wis3Wn7KbJLMgmAifW5rouZ7nFmQsIxlvqxV7OfGxa0xSt3L8zfWpAb7k
   7aVhB0sxy/7t6CxuOG2I+GrJOlGvlvG+xg7+1y115ljUvNsAG1KJWa+n7
   mxXT4geh86ti39bNs3h1UwxbOegM+O+gknxlGcKXMbhVXwgdl27iioshv
   g==;
IronPort-SDR: UJ1EvvBJaloGn/vIX5DoifGEyptYWTD+mUU2fD4NsF6zCdc4M6XBU3lhpt0/QFDHuiVgRDoaon
 f4PXXVsz6b/CxZScOeLJhE2FpyHrUwsLTJWEIkfuSunmmuH1C4E5o7Hb96TK0j/BSIKgwei+yv
 bqyYp2DlKEhm2d4wmbMGT98Vd4VIqd35wBZggyCycq22iVkh8Hc8wYpUKLjXKo3ueOI8mJyo8C
 /aXSBhveU5HaUmDf7GKWsm4oGkVRC8hBgUj0aXoN4pjErphyh51rVmI4nGnNYrWbUBD8+X4sJT
 Yp0=
X-IronPort-AV: E=Sophos;i="5.81,216,1610434800"; 
   d="scan'208";a="117184912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2021 03:29:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 03:29:17 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 2 Mar 2021 03:29:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Tue, 2 Mar 2021 12:28:44 +0200
Message-ID: <20210302102846.619980-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for Microchip External Interrupt Controller
present on SAMA7G5. The controller supports for 2 external interrupt
lines, glitch filter capabilities and is connected to GIC as follows:

pinX   +------+ EXT_IRQ0 +------+ int 153 (for pinX) +------+
------>|      |--------->|      |------------------->|      |
pinY   | PIO  | EXT_IRQ1 | EIC  | int 154 (for pinY) | GIC  |
------>|      |--------->|      |------------------->|      |
       +------+          +------+                    +------+

where PIO is the pin controller.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  dt-bindings: mchp-eic: add bindings
  irqchip/mchp-eic: add support

 .../interrupt-controller/mchp,eic.yaml        |  74 ++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-mchp-eic.c                | 350 ++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

-- 
2.25.1


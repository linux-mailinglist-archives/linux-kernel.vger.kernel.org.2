Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A5406FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhIJQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:40:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29703 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIJQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631291942; x=1662827942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FG4F9AHliHxLxK/y5CCBUjSR7y8/aiJXPTiBJikbKvI=;
  b=0g+IWNcHH6wRtHfcwWlZLo3o82sZF2xfNuAZu3DQd/PWhg3Y+WIvLO23
   NfNbeLmajhyOxVfzd6mUmAKLsioanOBfQMv+bmYUmtZa/PYuxfqZ6zUb+
   iNYaUhFiThfUYTURx4/ElE4ddjfo9h5NnhZquL3dYPmcMbpixslvFgw+n
   HCls4JuKFHnAfzC8nplUchXFX37LKnNVDwVthpQ5ynXuacVomffRqC4Ai
   B8n6l3tNXSlb+AJvNtRK586L47OfoekGDOwsVsVgSlI4NP+BBG4jvTynt
   vv/rsbtj1E0UW1a0tEgaQoQ/iVetlvFChp0/cFXYhCV6Ik4ZwZuUCJiRb
   w==;
IronPort-SDR: RFwtCQ4I4XBaPr4fzIbY2L49gJz+XBbaOb2aUWuJ8RK2+mAnv76tf8Qn1iOUdEwhyC3ILG1RD2
 ewGX+cZjY0szC6g6P0cv+p/WFwXiKmt1vWAoXYfi43snH9gfZCvVud722XNwkYolLgG4Pzj55y
 3RgeNZeJAfSxKSC8wwuwwca2UA71l/9HfpiKOrTzhur8UrLwyY1s88Im+7+51LEJgaEqn//OeS
 N2u6YeV4bXyVmx1X+HlG5Kph2BtjN1paIKMFY9gH3+BG9qXLepJyBG4gtz2JxAPyACyDhLNVBR
 zrwlQL/EQfhvhYkaXlUr50ha
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="131418049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2021 09:39:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Sep 2021 09:38:59 -0700
Received: from plexus-g.actel.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:38:57 -0700
From:   <cristian.birsan@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <ada@thorsis.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 0/2] USB: host: ehci-atmel: Enable HSIC port on SAMA5D2
Date:   Fri, 10 Sep 2021 19:38:40 +0300
Message-ID: <20210910163842.1596407-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

On SAMA5D2 SoCs, Port C of USB Host contains a High-Speed Inter-Chip (HSIC)
transceiver. It can be used for USB chip-to-chip interconnect with a 2-signal
(strobe, data) synchronous serial interface using 240 MHz DDR signaling.

External cables, connectors, and hot plug & play are not supported.

This patch series enables this feature.

Cristian Birsan (2):
  dt-bindings: usb: atmel: add USB PHY type property
  USB: host: ehci-atmel: Add support for HSIC phy

 Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++++
 drivers/usb/host/ehci-atmel.c                       | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
2.25.1


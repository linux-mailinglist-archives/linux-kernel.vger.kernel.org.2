Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51F434D9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhC2Vem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:34:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59118 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC2VeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617053658; x=1648589658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2kTOQKtN0t9m6S1C1pzGz3PzM5EesinMEa6hjWzfgDY=;
  b=kxaO3nsASkgb20dQ9qR8HFy6g6oJj+C4559h7sjvBOo1a9S+kuhREMHM
   QseiTMFEfvgWPOP1iY6NfqcBS/ITU0jrvvkCkHmtni3+Lwk7bu+Lqss13
   LeO1FJ0KO7l+P4UmLuRxP++1Xx/1ZNpCxcNfPnf0GmFXERwavmIWg3XJm
   0iUlvUDu/07VTUk7iLFibFJ4Q0C5+1Fyqt2p2U8knGljExiPO0of84Cbs
   XE3OHNPWy5h0X1FDIU/1Zs9pAomN4eYHbLMscuiTQSgcqGoU56ZCo+XGX
   Dsvdd4OzS0tXqZpbEr4JfU/bmedbeMoIDRBpK2PW+u3BNe849RJ9sJAdX
   g==;
IronPort-SDR: UCF/K/3Bzx1tQnCR0a0OpheQyJ5HyNk4EBJkUnwMqtphT9lMSwdNvYB8BjLv1ZWU1tTjM+jcif
 SkwiJiMWowts4FeIxJV/J+32skB0dbG4tDkHAT6lg68sZp/8jjly8OMry3/G6RAFJ4k9CbIr5i
 ynPvtFSKl3g7fvf+Reu0OEeK4q/XaFRGmlOWMTA0k1nm24J6aN7Xrqy0Kq/jAxBdf4+lx5dlsC
 bchp3ssUON9u+wcM4hq+IXMJOmtgwppbyEbI7UZ6OKvvWfQGaaWMI/ktCjY3S5eSUVQHeSF5BC
 VcQ=
X-IronPort-AV: E=Sophos;i="5.81,288,1610434800"; 
   d="scan'208";a="115079626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 14:34:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 14:34:17 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 14:34:15 -0700
From:   <cristian.birsan@microchip.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [RFC PATCH 0/2] usb: typec: Add driver for Microchip sama7g5 tcpc
Date:   Tue, 30 Mar 2021 00:33:55 +0300
Message-ID: <20210329213357.431083-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch set adds initial driver support for Microchip USB Type-C Port
Controller (TCPC) embedded in sama7g5 SoC.

The controller does not implement power delivery and the driver uses dummy
functions to register the port with TCPM. The current silicon version is
not able to trigger interrupts so the driver will poll for changes on
CC1/CC2 lines.

Support for sink is implemented and tested with an USB device. The plan is
to extend the driver and add source support.

Cristian Birsan (2):
  dt-bindings: usb: Add DT bindings for Microchip sama7g5 tcpc
  usb: typec: sama7g5_tcpc: add driver for Microchip sama7g5 tcpc

 .../bindings/usb/microchip,sama7g5-tcpc.yaml  |  80 +++
 drivers/usb/typec/tcpm/Kconfig                |   8 +
 drivers/usb/typec/tcpm/Makefile               |   1 +
 drivers/usb/typec/tcpm/sama7g5_tcpc.c         | 602 ++++++++++++++++++
 4 files changed, 691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
 create mode 100644 drivers/usb/typec/tcpm/sama7g5_tcpc.c

-- 
2.25.1


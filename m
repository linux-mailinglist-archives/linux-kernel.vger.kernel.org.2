Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732F634F294
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhC3UzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:55:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40359 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhC3Uyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617137694; x=1648673694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WDeyWZ+/Bo0B6egkKV7o1Q2mWeGTUV4+RWIdJ6r1dLA=;
  b=T2iy1pEzToXjSQ0zMAZs9lRWjy0fVypOeEF6US8XN/mRmxDj4wdCfnDs
   6cFxtPH9Gg8rac5nqWs7WoXgUZneFqX9bE3Wu5UARL/ZcBfFuOXcao6oC
   mMoWGel0jvlZqaKu4Gj73avPdzDWfe8R40klxDRq9entkv0CQSdBHJ+v5
   hNxI3Hyy17+UX66XbIt3HPVCFUUXrCIeI4P5lguTpHXCQuMadFBnHWmol
   RKMIT4npLLKcRt5Q5DxhMq3yJ5FFVubEB/WWgQmscLZslI0jPw/YxAW1Q
   axaOvx19m5Vj0MRl1j0L7oCGI/LnziJPdpWjkcVxHpDQH5bw+/OZ78WIt
   A==;
IronPort-SDR: ypNLkrgT2JTu/IBzsBFFkMdwgCybxrjMyyAV4nfPua5ujpGX/zMc9ZEqzP0rtpJJABKvvqplN9
 DK9NwZNfcar4hhyQpcWWqkWuHMHyU/XmZDvRwVSuvQ7jfKQi1Mjoe7fGJeMUYqfqiNRbvEZXvk
 EqvfsX8Q8dlWLa8/v+ORt6usUxrWZWV+uW5/KdDeNPQq8Fu0UbTPB0xNqiw7mgnWwg+mL6yJqQ
 PimcXxMBVUDZfWX3TKyMZB2PAJn3MM/qt2HaON+3HareYzAenII+Nl55TkS/xreAwPaBL/ufWZ
 Y/I=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="111925320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 13:54:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 13:54:52 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 30 Mar 2021 13:54:50 -0700
From:   <cristian.birsan@microchip.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [RFC PATCH v2 0/2] usb: typec: Add driver for Microchip sama7g5 tcpc
Date:   Tue, 30 Mar 2021 23:54:40 +0300
Message-ID: <20210330205442.981649-1-cristian.birsan@microchip.com>
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

Changes in v2:
- fix DT bindings yamllint warnings/errors
- fix compilation error reported by: kernel test robot <lkp@intel.com>

Cristian Birsan (2):
  dt-bindings: usb: Add DT bindings for Microchip sama7g5 tcpc
  usb: typec: sama7g5_tcpc: add driver for Microchip sama7g5 tcpc

 .../bindings/usb/microchip,sama7g5-tcpc.yaml  |  90 +++
 drivers/usb/typec/tcpm/Kconfig                |   8 +
 drivers/usb/typec/tcpm/Makefile               |   1 +
 drivers/usb/typec/tcpm/sama7g5_tcpc.c         | 610 ++++++++++++++++++
 4 files changed, 709 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
 create mode 100644 drivers/usb/typec/tcpm/sama7g5_tcpc.c

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF71360C76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhDOOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:51:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46748 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhDOOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:50:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13FEnqjo001444;
        Thu, 15 Apr 2021 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618498192;
        bh=dtU7yZZCXXN3KU4xhLoqZPhQYRi1AWdP0Mnfpha+Ma8=;
        h=From:To:CC:Subject:Date;
        b=w0PZWJbgd6z7XWw0Y0390BG0W3uy8yzBy/f45NNHjVujPK9SawGUHvgwa+cqhW8si
         l2g/mCo0OjtfnXxlYke1/GFHPDr1CG09uCl5lEb18Kjs5dbUCn5gFRh0sgt/RA2UPR
         kzzJO9srFthW5W2a3dGxn1mui2tJnBnomn22wuL8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13FEnqX1102388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 09:49:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 09:49:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 09:49:51 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13FEnlS5037772;
        Thu, 15 Apr 2021 09:49:48 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-can@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v3 0/4] CAN TRANSCEIVER: Add support for CAN transceivers
Date:   Thu, 15 Apr 2021 20:19:43 +0530
Message-ID: <20210415144947.4725-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for CAN transceivers.

TCAN1042 has a standby signal that needs to be pulled high for
sending/receiving messages[1]. TCAN1043 has a enable signal along with
standby signal that needs to be pulled up for sending/receiving
messages[2], and other combinations of the two lines can be used to put the
transceiver in different states to reduce power consumption. On boards
like the AM654-idk and J721e-evm these signals are controlled using gpios.

Patch 1 rewords the comment that restricts max_link_rate attribute to have
units of Mbps.

Patch 2 adds an API for devm_of_phy_optional_get_by_index

Patch 3 models the transceiver as a phy device tree node with properties
for max bit rate supported, gpio properties for indicating gpio pin numbers
to which standby and enable signals are connected.

Patch 4 adds a generic driver to support CAN transceivers.

changes since v2:
- dropped 5 and 6 patches and to be sent via linux-can-next
- added static keyword for can_transceiver_phy_probe()
- changed enable gpio example to active high in patch 3
- Rearranged the file names in alphabetical order in Makefile
  and MAINTAINERS file

changes since v1:
- Added patch 1 (in v2) that rewords the comment that restrict
  max_link_rate attribute to have units of Mbps.
- Added patch 2 (in v2) that adds an API for
  devm_of_phy_optional_get_by_index
- Patch 1 (in v1)
  - updated MAINTAINERS file
- Patch 2 (in v1)
  - replaced m_can with CAN to make the driver independent of CAN driver
  - Added prefix CAN_TRANSCEIVER for EN_PRESENT and STB_PRESENT
  - Added new line before return statements in power_on() and power_off
  - Added error handling patch for devm_kzalloc()
  - used the max_link_rate attribute directly instead of dividing it by
    1000000
  - removed the spaces before GPIOD_OUT_LOW in devm_gpiod_get()
  - Corrected requested value for standby-gpios to GPIOD_OUT_HIGH
  - Updated MAINTAINERS file
- Patch 3 (in v1)
  - replaced minItems with maxItems
  - Removed phy-names property as there is only one phy
- Patch 4 (in v1)
  - replaced dev_warn with dev_info when no transceiver is found
  - Added struct phy * field in m_can_classdev struct
  - moved phy_power_on and phy_power_off to m_can_open and m_can_close
    respectively
  - Moved the check for max_bit_rate to generice transceiver driver

[1] - https://www.ti.com/lit/ds/symlink/tcan1042h.pdf
[2] - https://www.ti.com/lit/ds/symlink/tcan1043-q1.pdf

Aswath Govindraju (4):
  phy: core: Reword the comment specifying the units of max_link_rate to
    be Mbps
  phy: Add API for devm_of_phy_optional_get_by_index
  dt-bindings: phy: Add binding for TI TCAN104x CAN transceivers
  phy: phy-can-transceiver: Add support for generic CAN transceiver
    driver

 .../bindings/phy/ti,tcan104x-can.yaml         |  56 +++++++
 MAINTAINERS                                   |   2 +
 drivers/phy/Kconfig                           |   9 ++
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-can-transceiver.c             | 146 ++++++++++++++++++
 drivers/phy/phy-core.c                        |  26 ++++
 include/linux/phy/phy.h                       |   4 +-
 7 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
 create mode 100644 drivers/phy/phy-can-transceiver.c

-- 
2.17.1


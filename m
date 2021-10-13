Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD15642C1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhJMN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:59:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34282 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229794AbhJMN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:59:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDJ3bw011456;
        Wed, 13 Oct 2021 15:57:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=jk9HmVTNPozZvoLnBaAhZvrKr/gYwzJK/FBiSSgoo7k=;
 b=NoVaYugwkRoxBLqBswZnqLhcEqvBEMpzFLT3W/uXvYH3cdkb0H7VMKMDcYPSPa14P84F
 pE/kcTBJAFfKp6cYOaHNtCHM5PE5munqkyMP+9wNmmnrCmVKJedCuFIGZQk5+uadp5qq
 mpZMxfmBG8hyzBkPFpolvyC/OSG5oKVvAxo6YZM/90+aeQ87j5VUACP7P9IWK5TArtX9
 46pDPSc6mRQxTCzVOLPY6PvJZmvTzlF7sDUXsfuWL0wvVa3TQ5QA5JP553u8ob6g7Wdn
 jWDUjmJCj0ArmI2nwe8uzENW1evZwp9j/1OJrOSMdsQG4RG/oEX/95/FQVMTDLLz3bGs Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bnuxttamk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:57:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE46F10002A;
        Wed, 13 Oct 2021 15:57:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6069922F7C9;
        Wed, 13 Oct 2021 15:57:23 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct 2021 15:57:22
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 0/4] usb: dwc2: fill in gadget caps, configure it for stm32mp15
Date:   Wed, 13 Oct 2021 15:57:01 +0200
Message-ID: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fills in 'otg_caps' of the usb_gadget structure, and
configures it on stm32mp15.

When dwc2 is configured as dual role (OTG), the USB gadget descriptors
(device mode) are configured via configfs. This lead in calling
usb_otg_descriptor_init().
In usb_otg_descriptor_init() (drivers/usb/gadget/config.c):
- If otg caps structure is provided -> use it
- If otg caps structure isn't provided -> HNP and SRP are enabled by default

This could lead to a configuration mismatch beetween:
- OTG controller: HNP and SRP aren't enabled
- gadget descriptors: HNP and SRP are advertised

---
Changes in v3:
- Add dt-bindings patch, as adding properties from usb-drd.yaml is
  currently not handled in dwc2.yaml. This lead to have
  "make dtbs_check" reports errors like:
  ...'otg-rev' does not match any of the regexes: 'pinctrl-[0-9]+'
  From schema: /local/home/fgasni00/baseline/linux-stm32/Documentation/devicetree/bindings/usb/dwc2.yaml
- Could/should the dt-bindings be ported to stable ?
  (the DT patch for stm32mp151 in v1 got merged already)

Changes in v2:
- replace otg_cap bit field by otg_caps structure.
- Fix build issue when HOST only mode is selected [1]
- DT patch for stm32mp151 merged in v1, so not resent

[1] https://lore.kernel.org/all/000000000000b01f1505cda8e03c@google.com

Fabrice Gasnier (4):
  dt-bindings: usb: dwc2: Add reference to usb-drd.yaml
  dt-bindings: usb: dwc2: adopt otg properties defined in usb-drd.yaml
  usb: dwc2: add otg_rev and otg_caps information for gadget driver
  usb: dwc2: stm32mp15: set otg_rev

 Documentation/devicetree/bindings/usb/dwc2.yaml | 16 ++++--
 drivers/usb/dwc2/core.h                         | 19 +++----
 drivers/usb/dwc2/debugfs.c                      |  4 +-
 drivers/usb/dwc2/gadget.c                       |  1 +
 drivers/usb/dwc2/hcd.c                          | 12 ++--
 drivers/usb/dwc2/params.c                       | 75 ++++++++++++++-----------
 6 files changed, 70 insertions(+), 57 deletions(-)

-- 
2.7.4


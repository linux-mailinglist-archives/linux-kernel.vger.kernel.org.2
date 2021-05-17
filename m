Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2299B382BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhEQMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:10:24 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35937 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhEQMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:10:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HC6oQ1010202;
        Mon, 17 May 2021 14:08:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=bavnRqI5ucsHk4llNawSfeoyU7Pikb9myCdrZ4Z3/yk=;
 b=VMttQHmqLNPUAXUcp8GfM0viUsm2Z02Gp5aoXvDlmVR+e5Mn4s5nLrwo4UO8m1EPfskI
 hidvTEtd505cIVivkEAxIiCPwKeav4fNkKBpkTx5QWxokarMEEVVczOca5Xjk7TPZDke
 Ubv9jlkYYIeqr4aLutoFiNVCrtKx3q68QIB7hu/zQkW5h8O7Zv1RsLFRIj7TS5DYfsBW
 /VWDeV2lxUH0B9i+aWT2cht/hOf21LVyqPcJ7uT6uT76/g5rJujiOutGUtAu07/PH5O8
 mTzkZ4lhv0i9T2fxdp25Rjrasw/HzX115vs+PAl15+pwMPlUnID5GU3a2pIMfalDXhbU 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38kmb2sf3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:08:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9440100034;
        Mon, 17 May 2021 14:08:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B670122D636;
        Mon, 17 May 2021 14:08:24 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May 2021 14:08:23
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v2 0/2] STM32 USBPHYC vbus-supply property support
Date:   Mon, 17 May 2021 14:08:19 +0200
Message-ID: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_04:2021-05-17,2021-05-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC provides two USB High-Speed ports which are used by controllers
with Host capabilities. That's why vbus-supply has to be supported on each
phy node.

---
Changes in v2:
- use connector node vbus-supply property as suggested by Rob
---
Amelie Delaunay (2):
  dt-bindings: phy: add vbus-supply optional property to
    phy-stm32-usbphyc
  phy: stm32: manage optional vbus regulator on phy_power_on/off

 .../bindings/phy/phy-stm32-usbphyc.yaml       | 11 +++++++
 drivers/phy/st/phy-stm32-usbphyc.c            | 31 +++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.17.1


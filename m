Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0618742F7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhJOQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:16:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35376 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237282AbhJOQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:16:56 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCxdoX023022;
        Fri, 15 Oct 2021 18:14:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=A4tqsFWtDMZnl64khjFES9apGihKCVelBIildCe0RfQ=;
 b=GIbJF+8oxrYj/kHYTpZH2zyhaZmGkR0WIgj+IIzYgKHavgDtND9OldHkkXW8dXjPoANl
 DdfT/EXBSojxc+HxkDwpLHzvlP27LcEMqAbX8v49BHJiq5A02kRUwFluiBWbZKAd+bJH
 w4LoauIHbub8tp75iA1HmFFw1vwg6cspp+dboPguAXJpFZbm98C/Xeffrfg7VkWbsuVS
 g6PzspigNDh9Sgz1/BKjp6God2KVm3iN0d+WEZ87UCyap7qWwFqmtGnnQAXoicPyl6TX
 7YCqa3feu6t/SyNhUtGYvWe4TA2On8EZ5URqusJhfweJ/n5sksz42ac9VRaW7mvjhT1Q QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bq5apk4b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 18:14:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CA3E10002A;
        Fri, 15 Oct 2021 18:14:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00A0B231513;
        Fri, 15 Oct 2021 18:14:37 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct 2021 18:14:36
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
Subject: [PATCH v3 0/3] phy: stm32: add phy tuning support
Date:   Fri, 15 Oct 2021 18:14:24 +0200
Message-ID: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_05,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings phy tuning to stm32-usbphyc with new optional
device tree properties.
A prior patch add resume routine, which is used to restore UTMI
switch and phy tuning configuration, as they can be reset if
deep low power state is achieved.

Amelie Delaunay (3):
  phy: stm32: restore utmi switch on resume
  dt-bindings: phy: phy-stm32-usbphyc: add optional phy tuning
    properties
  phy: stm32: add phy tuning support

---
Changes in v3:
- Use -microamp for current boost
- '|' added after 'description:' on each properties needing this
Changes in v2:
- st,phy-tuning + usb_phy_tuning node removed
- properties are now in phy child nodes

 .../bindings/phy/phy-stm32-usbphyc.yaml       | 129 +++++++++++
 drivers/phy/st/phy-stm32-usbphyc.c            | 203 ++++++++++++++++++
 2 files changed, 332 insertions(+)

-- 
2.25.1


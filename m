Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9835422C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhJEP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:27:20 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46324 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236085AbhJEP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:27:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195DGbq1021117;
        Tue, 5 Oct 2021 17:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=77QYGY7BiuwUpHd7MHzy7GqNWdzhJ3VP18VxSYvCOIs=;
 b=cEimbhrxrCF+RDJicHYS7Sc9QWp9vIouda4DYGTpP9hOr3m/yD/xjd7dXXJsJMWuPkxu
 hBbIdmP+RHuXWqM+2Z7hAq7iUpmGsIovu4/I/+XYXP/n5A38ZxbrNmVFk4GZrqOU/ogt
 Ft1sZfIBRrzuCOKGR7+ZucT683OW3REDcyj/O3wzTQHUhqm8CLYFQXmY/jjWDp2s8uUS
 a+5JIKdnxQwfZ8w9gT6+GRFssgNzN+RyB2dogZ6iS9P5MOgDxJmUOpKHwe6UyZxc7OU/
 5Yw/9uKn7aZb0bXbUSw3jQK/YJTzdyuaHNS5nr6KboHbmhzviZTIUtdsfrDlIDexjYxU MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bgjt8th0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 17:24:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87B8410002A;
        Tue,  5 Oct 2021 17:24:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FAD6229A8E;
        Tue,  5 Oct 2021 17:24:56 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct 2021 17:24:55
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
Subject: [PATCH v2 0/3] phy: stm32: add phy tuning support
Date:   Tue, 5 Oct 2021 17:24:50 +0200
Message-ID: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_02,2021-10-04_01,2020-04-07_01
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
Changes in v2:
- st,phy-tuning + usb_phy_tuning node removed
- properties are now in phy child nodes

 .../bindings/phy/phy-stm32-usbphyc.yaml       | 126 +++++++++++
 drivers/phy/st/phy-stm32-usbphyc.c            | 204 ++++++++++++++++++
 2 files changed, 330 insertions(+)

-- 
2.25.1


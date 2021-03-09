Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E5332087
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCII1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:27:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22532 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230118AbhCII06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:26:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1298QjaI014685;
        Tue, 9 Mar 2021 09:26:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6useEKFTe+Bqa/XiaAvxpMZHpCqKWtSJwAWFIVF7tLg=;
 b=d4MsmYodNPFER5m32lmOBHOKdVKRFxt/vRlyik7Wxi6oOhIura9YjnnrbJV3ca6FwsDp
 jp83t4vcfh4EIBdtECWre3p9mGeqaKL6eHJNYb/O/ncBxY4LBtf+5EevUIPUhwZyRU0/
 RoyfFpZPU1Gyin+4BDeL8gqzv50YM9YUYka542Dz7hrrDlyICUTY8/iHqgUo/2TN6kpa
 7IFxMhnZyx+YbZx+v0DP7Npn5eqR1epRs8S5FskheVfwy0BuxNeat9ZEP8QR8y/3Wq4T
 GthSzOC2o2W3zVVRRdKJZUj8VN9KbkIYx6eu1SlVr6MHVtDmSx53iEajoiDJt+0IOm2c ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 373yreh0r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 09:26:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0BD410002A;
        Tue,  9 Mar 2021 09:26:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB1C9221794;
        Tue,  9 Mar 2021 09:26:38 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Mar 2021 09:26:38
 +0100
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
Subject: [RESEND PATCH v3 0/2] STM32 USBPHYC ck_usbo_48m clock provider
Date:   Tue, 9 Mar 2021 09:26:31 +0100
Message-ID: <20210309082633.8213-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_06:2021-03-08,2021-03-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC provides clocks to STM32 RCC pour STM32 USB controllers.
Specifically, ck_usbo_48m is a possible clock parent for USB OTG clock,
during OTG Full-Speed operation.

This series registers the usbphyc as clock provider of this ck_usbo_48m clock.

---
Resent with linux-phy ML in cc
Changes in v3:
- remove #clock-cells from required properties
Changes in v2:
- fix COMMON_CLK dependency issue reported by kernel test robot
---
Amelie Delaunay (2):
  dt-bindings: phy: phy-stm32-usbphyc: add #clock-cells property
  phy: stm32: register usbphyc as clock provider of ck_usbo_48m clock

 .../bindings/phy/phy-stm32-usbphyc.yaml       |  5 ++
 drivers/phy/st/Kconfig                        |  1 +
 drivers/phy/st/phy-stm32-usbphyc.c            | 65 +++++++++++++++++++
 3 files changed, 71 insertions(+)

-- 
2.17.1


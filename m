Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160C32D765
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhCDQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:06:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34858 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236374AbhCDQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:05:57 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124FpBRl023360;
        Thu, 4 Mar 2021 17:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=w86J0gge9QVsrPFtN797NjGqHob5AHd2hTJorobuIx8=;
 b=ahI6NK5K25ZDiAuDUaE1DklQjn6ntjbrMeNwGGc8+YX9STLs/x8wlqoGVgdbehLHoLXo
 FRhEfj6kQLdxBfNXdOwuKykC47APomdNnH8rBoOYdSh6LiMs2EkiOgF00uw9mKigOMzQ
 63689RT1haoVUGEqX337cQ8UrhqUr3E1f95kPd+6M/+GypFnMZLXpTFhT7hVRqIuTIDG
 fpWWOE9xwQz8p50W+pH8w5drddi2y6iSRzEflg53i8I6WOun5PiurgkOVWoTgpvchHz4
 PQ5lkceh/zWd9OiUMUHXlx67U0GqK5XW2tU0CHC3BxythV525hzOuinJxwpJ0MWCwUHy AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xej57t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:05:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 784FE10002A;
        Thu,  4 Mar 2021 17:05:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 649D52073BB;
        Thu,  4 Mar 2021 17:05:00 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:04:59
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v3 0/2] STM32 USBPHYC ck_usbo_48m clock provider
Date:   Thu, 4 Mar 2021 17:04:38 +0100
Message-ID: <20210304160440.27612-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC provides clocks to STM32 RCC pour STM32 USB controllers.
Specifically, ck_usbo_48m is a possible clock parent for USB OTG clock,
during OTG Full-Speed operation.

This series registers the usbphyc as clock provider of this ck_usbo_48m clock.

---
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


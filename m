Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356DF33F530
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhCQQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:10:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232419AbhCQQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:10:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HFlk8E009540;
        Wed, 17 Mar 2021 17:10:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=Iz7+Lyw7xDy/yfHdJRZxvAco5e3gTiWzHz1ThRW4Ph8=;
 b=s8ZHEx63Owo1nhicnpGs4gsRTuS6gbMUnRAnLO154i+Gx+HMNjbtGuujGvbDG69yZc45
 ers4wZEWIFGmyOkNlKrNaWGqf3or8ZX0B0niT05LWvdTbwn1/8qPg4s6o9Qmy+HZtbCy
 PlqKAayRxWKx+UWhRy7E1Ue1KS39TCZ+hPANetszjw5/CtLcQL4rPMveNnq7Z8SRLa3r
 g057Sg70FEnURZt58w5bkInwmulHwhkXo36KzPO3R16ke8LDn/J78IS5Ul2igyMpofMu
 4kTbdWwjCTq8NPhVO5I9RO93Y3+6i6VwFHnTGFoXvWMUdGXxOyXqMhBMZkYfmRliOLXz 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37a8pr67jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 17:10:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF17E10002A;
        Wed, 17 Mar 2021 17:10:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9939A23E915;
        Wed, 17 Mar 2021 17:10:05 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 17:10:05
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
Subject: [PATCH 0/2] STM32 USBPHYC vbus-supply property support
Date:   Wed, 17 Mar 2021 17:09:52 +0100
Message-ID: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_10:2021-03-17,2021-03-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC provides two USB High-Speed ports which are used by controllers
with Host capabilities. That's why vbus-supply has to be supported on each
phy node.

Amelie Delaunay (2):
  dt-bindings: phy: add vbus-supply optional property to
    phy-stm32-usbphyc
  phy: stm32: manage optional vbus regulator on phy_power_on/off

 .../bindings/phy/phy-stm32-usbphyc.yaml       |  3 ++
 drivers/phy/st/phy-stm32-usbphyc.c            | 31 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.17.1


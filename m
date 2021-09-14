Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401B40B224
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhINOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:54:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233309AbhINOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:54:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EBDrHY000403;
        Tue, 14 Sep 2021 16:53:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=+qFVp4UXzkSb0mMkpWZLVTLTNn7vjALA3GybZVUT//I=;
 b=h1L0OUknaHle3dCsARhQ1qyqg2RaznxiQUGVKwjzkVE1esr8DbMjZWUkzYBtcsZ8FgGe
 OQxSh/+/4OKF6Saxyki18O/fNnN28uVC7ZxTnRmV7Um+WMgedZCvOgjPr3JMgGx107jp
 NBxSOfqpyxeSIIV/g+J4iVTxlKDiAv+1zeiHd8xbw7fVr9mv+GoJKxd19MlIw/dNt+K0
 gQ67n7Z/F45TMRWfVwUhu0sPiwvUCIacaeDovBuP8YP6x0irhat6mCfUiV46U0SpB8de
 1rdcaAUTSxLpSa5dC7hP4p6gH1e5NwRHmCbhXjEdGLLejEsh6hhDd1JdieIjsxhrW7QE cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b2tpah6jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 16:53:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB60C10002A;
        Tue, 14 Sep 2021 16:53:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D83A421A229;
        Tue, 14 Sep 2021 16:53:12 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Sep 2021 16:53:12
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
Subject: [PATCH 0/3] phy: stm32: add phy tuning support
Date:   Tue, 14 Sep 2021 16:52:53 +0200
Message-ID: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_06,2021-09-14_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings phy tuning to stm32-usbphyc with a new optional
device tree property st,phy-tuning, the elements of which
(st,phy-tuning node properties) are also optional.
A prior patch add resume routine, which is used to restore UTMI
switch and phy tuning configuration, as they can be reset if
deep low power state is achieved.

Amelie Delaunay (3):
  phy: stm32: restore utmi switch on resume
  dt-bindings: phy: phy-stm32-usbphyc: add st,phy-tuning optional
    property
  phy: stm32: add phy tuning support

 .../bindings/phy/phy-stm32-usbphyc.yaml       |  68 ++++++
 drivers/phy/st/phy-stm32-usbphyc.c            | 208 ++++++++++++++++++
 2 files changed, 276 insertions(+)

-- 
2.25.1


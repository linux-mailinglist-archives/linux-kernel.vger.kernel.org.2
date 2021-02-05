Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494C431097A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBEKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:48:42 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:8700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhBEKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:46:12 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115Ac85R026438;
        Fri, 5 Feb 2021 11:44:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=BuMCGD8sDkpe/8V/Cj88u52ylQufeUc03qiQXLfMh1w=;
 b=Q/wOwdSOSrDXElDNZUOOcyzgRN3O2ATyE81NToSsi5pGAgY3zQyHfLykJMZofFLkahmu
 4TTQCAwHi6GIJiLgJYUZSqJJpxvfiKj15mERXHrCIYUtKv1gw8JYxFyqrWsih5QMEXS4
 KtEMYRWj4T6t/6F15izo/C53HjhSY/dwV5IF+aWPlc+Qar5jA0XJPCCGEjIfT8aHfoqc
 Y3YM5+vn4IOrF32747Act68NRJRoJFEFt44lvRUbT+TggzDcaIDswFHgaSxVj56+EM66
 wO2oqwavrxAhqJK7R+f7w4IR/egMI9+toko1sPsPBAGjsbOE0ZLJ/MJrESsH/xxyBwmj 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fse4qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 11:44:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4ED8A10002A;
        Fri,  5 Feb 2021 11:44:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 988DD2298CD;
        Fri,  5 Feb 2021 11:44:20 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 11:44:20
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        "Rob Herring" <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [RESEND PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Date:   Fri, 5 Feb 2021 11:44:02 +0100
Message-ID: <20210205104404.18786-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add master clock generation support in STM32 I2S driver.
Resend of patch https://lkml.org/lkml/2020/9/11/264

Olivier Moysan (2):
  ASoC: dt-bindings: add mclk provider support to stm32 i2s
  ASoC: stm32: i2s: add master clock provider

 .../bindings/sound/st,stm32-i2s.yaml          |   4 +
 sound/soc/stm/stm32_i2s.c                     | 310 +++++++++++++++---
 2 files changed, 270 insertions(+), 44 deletions(-)

-- 
2.17.1


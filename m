Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1C3DEE17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhHCMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:45:47 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42284 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235944AbhHCMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:45:41 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173CVPsG006658;
        Tue, 3 Aug 2021 14:45:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=SxjmlgjZIeZyGGpM7p5YTE2fctkmpue8VWW/bRT6hKs=;
 b=twqFbzRcpRv+m6Jn/oOf2udthohO7+dQNgdRfCaW1LAa7UrFk281VrJxF0KD12qP/2ai
 4ytzDFP9VoBkyd1vWbvTMfCSbdJ5s45Q1sXECy3sqDB6Qdm5Phz4SW5vbJfGNHS6nLQH
 9OrqAPfAs8vf7GYa54gwI+SJmURpH2zfMiv713OeyWJ+4G621q/okcoTpeWmcCKN516d
 BQx2M6GGIgDRflHs96Z75V8qk32Nux20nGnqugWt0DowUVsuvxSufKDTRjWKS8kz4fu2
 Z2i8PpB0+1Rc3xgffjvfv2DnspHibfJYQo/YUHc4ZxfetMejm2BOTWV7iiCLuqE1ciso 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a6tqkkahb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:45:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB78310002A;
        Tue,  3 Aug 2021 14:45:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A2E1222C86;
        Tue,  3 Aug 2021 14:45:16 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021 14:45:16
 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <soc@kernel.org>
Subject: [PATCH 0/4] ARM: dts: sti: remove clk_ignore_unused from bootargs
Date:   Tue, 3 Aug 2021 14:45:02 +0200
Message-ID: <20210803124506.23365-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Remove clk_ignore_unused from bootargs from STi boards DT.

Patrice Chotard (4):
  ARM: dts: sti: remove clk_ignore_unused from bootargs for
    stih407-b2120
  ARM: dts: sti: remove clk_ignore_unused from bootargs for
    stih410-b2120
  ARM: dts: sti: remove clk_ignore_unused from bootargs for
    stih418-b2199
  ARM: dts: sti: remove clk_ignore_unused from bootargs for
    stih410-b2260

 arch/arm/boot/dts/stih407-b2120.dts | 1 -
 arch/arm/boot/dts/stih410-b2120.dts | 1 -
 arch/arm/boot/dts/stih410-b2260.dts | 1 -
 arch/arm/boot/dts/stih418-b2199.dts | 1 -
 4 files changed, 4 deletions(-)

-- 
2.17.1


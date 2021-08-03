Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FDA3DEE15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhHCMpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:45:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235782AbhHCMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:45:39 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173CXHV5031609;
        Tue, 3 Aug 2021 14:45:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=F3Iber66wxHC8yp4YlF0yF2MurN5WaDFmHsY42flK50=;
 b=WmOTEqQgLDPyh/XJ3FrvO7kV1VjjvgZ7ClZCIB0KooB+ql+NjMMXFCBib/+2ExYI2hWM
 8unAVnka+0fK/xk+bPUY/PEu3dgG9/4yOMIo/tSPTC2HxievXRZJ+alhLLVfAJXT5127
 hZnZNdKkPjX2jBJeZtkAaWiDnSTbsiQGwTbj/rkMC4Kp5PGL8l4DGUodtBXbXsElpY/h
 Y7n8OkwJQULYaXKOKnynQNNagvPi198408TB92ngbuwb2hGPi1Rc3VSK4sMMuyDWax+c
 SiAiLvEzVYGRY/Au0+fG20DmnDE4ydfGj2BmMPqfFFLEp5lmWKKBujccpa6UCxXP3FE/ 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a74mx8e27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:45:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCB5410002A;
        Tue,  3 Aug 2021 14:45:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0FA2222C87;
        Tue,  3 Aug 2021 14:45:19 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021 14:45:18
 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <soc@kernel.org>
Subject: [PATCH 2/4] ARM: dts: sti: remove clk_ignore_unused from bootargs for stih410-b2120
Date:   Tue, 3 Aug 2021 14:45:04 +0200
Message-ID: <20210803124506.23365-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803124506.23365-1-patrice.chotard@foss.st.com>
References: <20210803124506.23365-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Remove clk_ignore_unused from bootargs as it's no more needed.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/stih410-b2120.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 158b2268748e..9d3b118f5f0f 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -11,7 +11,6 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
-- 
2.17.1


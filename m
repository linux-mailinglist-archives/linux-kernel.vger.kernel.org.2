Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7073D7B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0QuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:50:01 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34114 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229453AbhG0QuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:50:00 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16R55XUZ003859;
        Tue, 27 Jul 2021 11:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=GayR9Rb9CjLVvh0msnLoqI/hMiOp1kLBQ2C3vuVoDUo=;
 b=lTofL2nmuwG+baVe9p9SwdnPZ/lDe09AzlNYk62qT5FARwps2WM9DcpzjjS8gKrT4obP
 ViPnqdV2QpsE2sGZ8cXxF4D04WCSLCUpgcSrMhQ/V3uXMmQLpJIbYtLolyMFPBl1cklO
 stS8fhszQskacetg8DbZHXyiFnY9uI5QdxlX4aW9k58H076E4ymrpB0GG5uNXmljOo4u
 af4Pvat9jUqF7AADTcy2FkkEkA8SHbdXDoR8TjGxi7NKRvi1SS+WlXkVa/13VieEYmaW
 4x1R8sTklFYFFXoao7rslLkQqBnam0vV4H71kHnNgWaY88C1uuGEnJf4rlUDHrnoZ3M3 Ew== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a233y9bx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 11:49:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Jul
 2021 17:49:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 27 Jul 2021 17:49:51 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.56])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C00EB2BA;
        Tue, 27 Jul 2021 16:49:50 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] MAINTAINERS: Add sound devicetree bindings for Wolfson Micro devices
Date:   Tue, 27 Jul 2021 17:49:48 +0100
Message-ID: <20210727164948.4308-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TDLcE9aZT1mRIR7akA1AiqBB0LzXAu7b
X-Proofpoint-GUID: TDLcE9aZT1mRIR7akA1AiqBB0LzXAu7b
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=838
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107270101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include all wm* sound bindings in the section for Wolfson Micro
drivers. This section already includes the actual driver source
files.

Also update the existing entry to match all wlf,* sound bindings.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19135a9d778e..d8282bb8a7e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20009,7 +20009,8 @@ F:	Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
 F:	Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
 F:	Documentation/devicetree/bindings/mfd/wm831x.txt
 F:	Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
-F:	Documentation/devicetree/bindings/sound/wlf,arizona.yaml
+F:	Documentation/devicetree/bindings/sound/wlf,*.yaml
+F:	Documentation/devicetree/bindings/sound/wm*
 F:	Documentation/hwmon/wm83??.rst
 F:	arch/arm/mach-s3c/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
-- 
2.11.0


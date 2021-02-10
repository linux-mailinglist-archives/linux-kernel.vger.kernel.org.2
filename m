Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41E316485
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBJLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:02:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11366 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhBJK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:59:50 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AAt7B1001434;
        Wed, 10 Feb 2021 05:58:57 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw8v8hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:58:57 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11AAwuIg036980
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 10 Feb 2021 05:58:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 10 Feb
 2021 05:58:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:58:55 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AAwrQR020519;
        Wed, 10 Feb 2021 05:58:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] MAINTAINERS: replace my with email with replacements
Date:   Wed, 10 Feb 2021 13:01:16 +0200
Message-ID: <20210210110116.49955-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=944 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email will become inactive in a few weeks.
This change removes it from the MAINTAINERS file and adds the people that
will be responsible for the parts moving forward.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e697044d34d6..97a91fd7948d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1016,7 +1016,7 @@ F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 F:	drivers/mux/adgs1408.c
 
 ANALOG DEVICES INC ADIN DRIVER
-M:	Alexandru Ardelean <alexaundru.ardelean@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -1024,7 +1024,7 @@ F:	Documentation/devicetree/bindings/net/adi,adin.yaml
 F:	drivers/net/phy/adin.c
 
 ANALOG DEVICES INC ADIS DRIVER LIBRARY
-M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
+M:	Nuno Sa <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/imu/adis.c
-- 
2.17.1


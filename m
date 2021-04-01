Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA1351F82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhDATU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:20:27 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:23830 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234646AbhDATT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:19:58 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131GLGpm006155;
        Thu, 1 Apr 2021 12:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=A/BMCl4N0zrQ4cXPa1A45jW03lKOGqB4eSKvTyMHfII=;
 b=MKq3MumvYm1UJtV7jwkd9AQVju7DqlAQ433ToOdaFIz4M5a5Hn533QMUKi3BO291Ejbv
 G/qQecg0x6MZmus9UvzxLrBOWRvUGWINqwhCT1yjLvjrXH16sVaaryKNeCUwjNEIFism
 qFl4Wb9OMK4N8/S4j62Yl1pOaj5Pxkv1s+uyh5MGMENLcW2a3w7+ATI3piGtcWYCiD0P
 r5EXSPIKHOmNWA7EaocdPF5vREm0f54nUfyz5l3mUO05zgG+MVuTIQ704Uatxya5YTq3
 yK7oNEOQcY3ryy9h8JavHMuAPUBXXlmaWT+X6blsZeo0YnVnoMNC3zTOdHrlpBT4XHfk pw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37n29gu4q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 12:22:24 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131EJwVN141020;
        Thu, 1 Apr 2021 12:22:24 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 37n6cem6k0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 12:22:24 -0400
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,296,1610431200"; 
   d="scan'208";a="618976140"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@outlook.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 2/3] MAINTAINERS: Add missing section for alienware-wmi driver
Date:   Thu,  1 Apr 2021 11:22:05 -0500
Message-Id: <20210401162206.26901-3-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401162206.26901-1-mario.limonciello@dell.com>
References: <20210401162206.26901-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_03:2021-03-26,2021-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=988 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010093
X-Proofpoint-GUID: l199nbf44zqYmH5oSTc7I85u4uE1JqtV
X-Proofpoint-ORIG-GUID: l199nbf44zqYmH5oSTc7I85u4uE1JqtV
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is maintained by Dell, but it was missing in MAINTAINERS.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 MAINTAINERS                               | 5 +++++
 drivers/platform/x86/dell/alienware-wmi.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46c8fadb59c3..3649e04c3b73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -697,6 +697,11 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIENWARE WMI DRIVER
+L:	Dell.Client.Kernel@dell.com
+S:	Maintained
+F:	drivers/platform/x86/dell/alienware-wmi.c
+
 ALL SENSORS DLH SERIES PRESSURE SENSORS DRIVER
 M:	Tomislav Denis <tomislav.denis@avl.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 5bb2859c8285..0d03e6b7b40c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -2,7 +2,7 @@
 /*
  * Alienware AlienFX control
  *
- * Copyright (C) 2014 Dell Inc <mario_limonciello@dell.com>
+ * Copyright (C) 2014 Dell Inc <Dell.Client.Kernel@dell.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41F31F05E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhBRTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:47:37 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:2954 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234247AbhBRTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:18:14 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IJD5So010291;
        Thu, 18 Feb 2021 14:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=iUVRd1Dew3Yl0r8pCqPyu14KJjwaP3ceR2N+ILkEPNI=;
 b=XPfnJaKeU6jhQZHS4pIaFDf8dIwrgmUzSP9hGgtsZJpUXvBYPgj4+Q4Xd5+aeDalJg8r
 jGZ98c2O7Hr2l6WFnJe5YL1Ier1eU+ey6VTTK7gjxBO94mGPOEfpMn8IlXgTmdanggE5
 EJJtrTxv5kB0GgH7AbpTVd3USZ7HT4KudS2XkpDD0OF90CDvLrSZgXoofrEIPupmNuMd
 pwCEJlKS4/gUPZSCbPeRVoDDTRJwhBFpb3fZMP1pyWeJZJY+eghI1QNjr+/uHZJeGpDK
 BndpuZZ/wIjO1sRfpEg4lX39rwAseX9OR+Vj8+gLNucnHR9m6FsgXy9Z35uEPBWHAhJ5 5Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 36paq99fv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 14:17:32 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IJEhH2155509;
        Thu, 18 Feb 2021 14:17:32 -0500
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 36pvxgp3rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 14:17:32 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; 
   d="scan'208";a="577970456"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Divya Bharathi <Divya.Bharathi@Dell.com>,
        Alexander Naumann <alexandernaumann@gmx.de>
Subject: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization failure
Date:   Thu, 18 Feb 2021 13:17:23 -0600
Message-Id: <20210218191723.20030-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell systems that don't support this interface the module is
mistakingly returning error code "0", when it should be returning
-ENODEV.  Correct a logic error to guarantee the correct return code.

Cc: Divya Bharathi <Divya_Bharathi@Dell.com>
Reported-by: Alexander Naumann <alexandernaumann@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c     | 4 +++-
 drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c | 4 +++-
 drivers/platform/x86/dell-wmi-sysman/sysman.c                 | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
index f95d8ddace5a..8d59f81f9db4 100644
--- a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
+++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
@@ -175,7 +175,9 @@ static struct wmi_driver bios_attr_set_interface_driver = {
 
 int init_bios_attr_set_interface(void)
 {
-	return wmi_driver_register(&bios_attr_set_interface_driver);
+	int ret = wmi_driver_register(&bios_attr_set_interface_driver);
+
+	return wmi_priv.bios_attr_wdev ? ret : -ENODEV;
 }
 
 void exit_bios_attr_set_interface(void)
diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
index 5780b4d94759..bf449dc5ff47 100644
--- a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
+++ b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
@@ -142,7 +142,9 @@ static struct wmi_driver bios_attr_pass_interface_driver = {
 
 int init_bios_attr_pass_interface(void)
 {
-	return wmi_driver_register(&bios_attr_pass_interface_driver);
+	int ret = wmi_driver_register(&bios_attr_pass_interface_driver);
+
+	return wmi_priv.password_attr_wdev ? ret : -ENODEV;
 }
 
 void exit_bios_attr_pass_interface(void)
diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
index cb81010ba1a2..d9ad0e83b66f 100644
--- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
@@ -513,13 +513,13 @@ static int __init sysman_init(void)
 	}
 
 	ret = init_bios_attr_set_interface();
-	if (ret || !wmi_priv.bios_attr_wdev) {
+	if (ret) {
 		pr_debug("failed to initialize set interface\n");
 		goto fail_set_interface;
 	}
 
 	ret = init_bios_attr_pass_interface();
-	if (ret || !wmi_priv.password_attr_wdev) {
+	if (ret) {
 		pr_debug("failed to initialize pass interface\n");
 		goto fail_pass_interface;
 	}
-- 
2.25.1


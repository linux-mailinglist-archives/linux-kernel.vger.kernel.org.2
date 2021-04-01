Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3033519B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhDAR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:56:04 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:62152 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235559AbhDARm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:58 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131GLiPB026323;
        Thu, 1 Apr 2021 12:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=smtpout1;
 bh=HWGwDsNnhDjT8V85x8WJx5kCS8sTk0lGILmtYmi4DQ8=;
 b=KbP33CzddsmSmiFqFBH3NvlRhDEfzH4vB5QXgC0k9e4m/mPu323pTS9vqpgp2BlXCcou
 XMFihk4cwS1zPLxFcNufzpGhzgY3mpHpj9mrvjjpX4CLSIV6fLlmHaxYCDqVIOE3Q5T2
 pdgvFAASQjjNEEQ2uUx9bSA9iM99vo4IsJeGX89wLQW+1+cCRKfWtHzUOd8tENp/u5Z3
 cXAEO5CE9EUJXKHmJuV0aWmDIr/S82EjwYEiylO7gevMNeYzsk30xceIvon/x3UInnp3
 +gGjhSUP03OsANQym4y3NHICyGG1jkOy6MQ+8ZllFhZrkp0qr5EvbyM+5ROEVLJb7bNa kQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37n28su41e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 12:22:24 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131EJwVM141020;
        Thu, 1 Apr 2021 12:22:24 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 37n6cem6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 12:22:24 -0400
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,296,1610431200"; 
   d="scan'208";a="618976143"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@outlook.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 3/3] platform/x86: Adjust Dell drivers to a personal email address
Date:   Thu,  1 Apr 2021 11:22:06 -0500
Message-Id: <20210401162206.26901-4-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401162206.26901-1-mario.limonciello@dell.com>
References: <20210401162206.26901-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_03:2021-03-26,2021-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010093
X-Proofpoint-GUID: nfFOa_xC1egnxY6i2N4MnO846gH1eO6Z
X-Proofpoint-ORIG-GUID: nfFOa_xC1egnxY6i2N4MnO846gH1eO6Z
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that I can always be reached in the future if necessary, add a
personal email address.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell/alienware-wmi.c          | 2 +-
 drivers/platform/x86/dell/dell-smbios-base.c       | 2 +-
 drivers/platform/x86/dell/dell-wmi-descriptor.c    | 2 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 0d03e6b7b40c..f21248255529 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -26,7 +26,7 @@
 #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
 
-MODULE_AUTHOR("Mario Limonciello <mario_limonciello@dell.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 3a1dbf199441..fc086b66f70b 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -647,6 +647,6 @@ module_exit(dell_smbios_exit);
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
 MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Common functions for kernel modules using Dell SMBIOS");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell/dell-wmi-descriptor.c b/drivers/platform/x86/dell/dell-wmi-descriptor.c
index a068900ae8a1..91637c4a03b3 100644
--- a/drivers/platform/x86/dell/dell-wmi-descriptor.c
+++ b/drivers/platform/x86/dell/dell-wmi-descriptor.c
@@ -201,6 +201,6 @@ static struct wmi_driver dell_wmi_descriptor_driver = {
 module_wmi_driver(dell_wmi_descriptor_driver);
 
 MODULE_DEVICE_TABLE(wmi, dell_wmi_descriptor_id_table);
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Dell WMI descriptor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 7410ccae650c..98f2b6ba3916 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -604,7 +604,7 @@ static void __exit sysman_exit(void)
 module_init(sysman_init);
 module_exit(sysman_exit);
 
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_AUTHOR("Prasanth Ksr <prasanth.ksr@dell.com>");
 MODULE_AUTHOR("Divya Bharathi <divya.bharathi@dell.com>");
 MODULE_DESCRIPTION("Dell platform setting control interface");
-- 
2.25.1


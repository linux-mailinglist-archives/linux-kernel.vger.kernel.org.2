Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFA351F50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhDATFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:05:25 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:20446 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239459AbhDATEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:04:00 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131GLxRp026520;
        Thu, 1 Apr 2021 12:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=smtpout1;
 bh=iBPTbuhFjQOOjvwt1aCiV3+hr34oV8Ho0oel20VKu1A=;
 b=ExgZa5CMe+r8oIDOZdAPw1fR10JDuu6ePuBJvBpFHKJ1GN9LtEbxX1Wmv4NNxZOOXieG
 0lST7AWb4HpzMHZlGUkjaejUqE/9K2ZE9+QWAUITy1/JoxqfH5kL+9itkXBvGT3Plwlt
 GFxmYb5rAvXUrlWPnTm+uhkWUBwbi+EEstJ7Dyi+XVFJP+IBhO6dxbS4Ekun6tQhRKGz
 UyYQqFGfG9Cg5VxZ+gnWopdvqWPaCgCsiTiZE4/0eGXLA2rcN4nFJiBhEIjzFfGwKJ4S
 nZEYDjT7ik95EqYcxy1vsjPOlRsXAQyJMMsozzK/8DZEKbxl2NcTbMbygUxCHsM9LNib BA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37n28uu4ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 12:22:25 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131G5iZt037646;
        Thu, 1 Apr 2021 12:22:25 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 37n2arns7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 12:22:25 -0400
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,296,1610431200"; 
   d="scan'208";a="618976139"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@outlook.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 1/3] MAINTAINERS: Adjust Dell drivers to email alias
Date:   Thu,  1 Apr 2021 11:22:04 -0500
Message-Id: <20210401162206.26901-2-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401162206.26901-1-mario.limonciello@dell.com>
References: <20210401162206.26901-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_07:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010106
X-Proofpoint-GUID: 6NsWL5aTBH0r1KDaDVRH-69IklVTBuwl
X-Proofpoint-ORIG-GUID: 6NsWL5aTBH0r1KDaDVRH-69IklVTBuwl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A team of engineers will be helping to service these drivers in
the future rather than just one person.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e91994b8d3b..46c8fadb59c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5034,19 +5034,19 @@ F:	drivers/platform/x86/dell/dell_rbu.c
 
 DELL SMBIOS DRIVER
 M:	Pali Rohár <pali@kernel.org>
-M:	Mario Limonciello <mario.limonciello@dell.com>
+L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-smbios.*
 
 DELL SMBIOS SMM DRIVER
-M:	Mario Limonciello <mario.limonciello@dell.com>
+L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-smbios-smm.c
 
 DELL SMBIOS WMI DRIVER
-M:	Mario Limonciello <mario.limonciello@dell.com>
+L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -5060,14 +5060,14 @@ F:	Documentation/driver-api/dcdbas.rst
 F:	drivers/platform/x86/dell/dcdbas.*
 
 DELL WMI DESCRIPTOR DRIVER
-M:	Mario Limonciello <mario.limonciello@dell.com>
+L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-descriptor.c
 
 DELL WMI SYSMAN DRIVER
 M:	Divya Bharathi <divya.bharathi@dell.com>
-M:	Mario Limonciello <mario.limonciello@dell.com>
 M:	Prasanth Ksr <prasanth.ksr@dell.com>
+L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -9242,7 +9242,7 @@ W:	https://slimbootloader.github.io/security/firmware-update.html
 F:	drivers/platform/x86/intel-wmi-sbl-fw-update.c
 
 INTEL WMI THUNDERBOLT FORCE POWER DRIVER
-M:	Mario Limonciello <mario.limonciello@dell.com>
+L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	drivers/platform/x86/intel-wmi-thunderbolt.c
 
-- 
2.25.1


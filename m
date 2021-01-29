Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756DE308B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhA2R37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:29:59 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:16278 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhA2R1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:27:42 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TH75VD000990;
        Fri, 29 Jan 2021 12:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=KwlYpS/ToymAB8CCmHhiKXtlvSgOqjCLZGg3QKK2b4M=;
 b=Lnrk4UhsQFsWmUGo/loD/ZEmJEBz4gStUP6882CI4JUkFxW1s3mVAyOJGGbSFZCetuqs
 vH765wA6q/au+ZkTZsoUShEAhOh+QgVix8mmI2APLXgKkhth1LFSZElSfZnok79euwEY
 Yd+xK6LF9SpNaPyebd+YPQHmC8vglBlfOVnpMFm/1d7pkITJgcKr1Rdv5KLFTu/QDyA4
 DmYP5TJ8eJGVGf25/X4OJxSVBiCvO1axvKmJPxj37ezDOFDjpKzEu7ETaYQT1arPIleu
 KVOJG+P/CiywcxHpeZHDIIR/bApQql78jUHnVVgQR6ZgRhQf8qoI3uM8eYdhj1O/vMUa CA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 368fr8dmqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 12:26:58 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10THOojE041082;
        Fri, 29 Jan 2021 12:26:57 -0500
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 36931yngyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 12:26:57 -0500
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="651593856"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer dereference
Date:   Fri, 29 Jan 2021 11:26:54 -0600
Message-Id: <20210129172654.2326751-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_06:2021-01-29,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290085
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An upcoming Dell platform is causing a NULL pointer dereference
in dell-wmi-sysman initialization.  Validate that the input from
BIOS matches correct ACPI types and abort module initialization
if it fails.

This leads to a memory leak that needs to be cleaned up properly.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-wmi-sysman/sysman.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
index dc6dd531c996..38b497991071 100644
--- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
@@ -419,13 +419,19 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		return retval;
 	/* need to use specific instance_id and guid combination to get right data */
 	obj = get_wmiobj_pointer(instance_id, guid);
-	if (!obj)
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
+		release_attributes_data();
 		return -ENODEV;
+	}
 	elements = obj->package.elements;
 
 	mutex_lock(&wmi_priv.mutex);
 	while (elements) {
 		/* sanity checking */
+		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
+			pr_debug("incorrect element type\n");
+			goto nextobj;
+		}
 		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
 			pr_debug("empty attribute found\n");
 			goto nextobj;
-- 
2.25.1


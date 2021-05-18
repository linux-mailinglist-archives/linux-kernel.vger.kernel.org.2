Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3693897F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhESUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:36:22 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:17428 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhESUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:36:21 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JKXiVw016961
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=resent-from :
 resent-date : resent-message-id : resent-to : from : to : cc : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pps0720; bh=MclP/KRxcwkRcbyk//tjKKr0YrJV6Jftbrq3jUUFzOI=;
 b=VRYAg1xrVSJNi/c1TnsJCCvkRfy3jaSNQE6Bmbgew8/9y/KqK/w6zBYBLY1SWbcbEiS0
 Q1O7oWGIpTn0Y00f/kmQDGFHus/iX1eVLd89VSIktbtLzC/rlY/FB+dJOawHC2YvoAyu
 A/loAmJ138SjKYg/kPiloqd4I2+wIPVBSsmEO2V1Be0rl75As+++pE8MImggMm99fBHI
 a0tRQHrHZVnPaWbu+CxbJAx498wDDciKNVFc9hewWQBMnCDs00a29DIRvdGI4lwXQzd/
 kDd5e36Lse1Xeu9xxT9CP67CRGUXMTCfBr01aFJo6Jox9/bFRFEtFcu/JgaMOeJ+FwOC XQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 38mjh43715-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:35:01 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id DC3916A
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:35:00 +0000 (UTC)
Received: from hpe.com (unknown [16.99.165.74])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 944B34A
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:35:00 +0000 (UTC)
Received: from localhost [::1]
        by new-ben with IMAP (fetchmail-6.4.19)
        for <rja@localhost> (single-drop); Wed, 19 May 2021 00:10:12 -0500 (CDT)
Received: from CS1PR8401MB1205.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::7) by DF4PR8401MB0507.NAMPRD84.PROD.OUTLOOK.COM with
 HTTPS; Tue, 18 May 2021 19:36:26 +0000
Received: from DM5PR2201CA0003.namprd22.prod.outlook.com (2603:10b6:4:14::13)
 by CS1PR8401MB1205.NAMPRD84.PROD.OUTLOOK.COM (2a01:111:e400:7514::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 19:36:23 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::c5) by DM5PR2201CA0003.outlook.office365.com
 (2603:10b6:4:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 19:36:22 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of dog.eag.rdlabs.hpecorp.net: DNS Timeout)
Received: from G9W8453.americas.hpqcorp.net (15.211.195.19) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 19:36:20 +0000
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 19:36:00 +0000
Received: from g4t3433.houston.hpecorp.net (16.208.49.245) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 18 May 2021 19:36:00 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CD71345;
        Tue, 18 May 2021 19:35:59 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 7BD41302F481D; Tue, 18 May 2021 14:35:59 -0500 (CDT)
From:   <kyle.meyer@hpe.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
Date:   Tue, 18 May 2021 14:34:55 -0500
Message-ID: <20210518193455.192796-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-OrganizationHeadersPreserved: G9W8453.americas.hpqcorp.net
X-MS-Exchange-Organization-ExpirationStartTime: 18 May 2021 19:36:20.8976
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: 78daac90-5c72-427f-88ea-08d91a3436c2
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G4W9121.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-Office365-Filtering-Correlation-Id: 78daac90-5c72-427f-88ea-08d91a3436c2
X-MS-TrafficTypeDiagnostic: CS1PR8401MB1205:
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-Organization-SCL: -1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:15.211.195.19;CTRY:US;LANG:en;SCL:-1;SRV:;IPV:NLI;SFV:SKI;H:G9W8453.americas.hpqcorp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 19:36:20.5568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78daac90-5c72-427f-88ea-08d91a3436c2
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.211.195.19];Helo=[G9W8453.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-AuthSource: G4W9121.americas.hpqcorp.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1205
X-MS-Exchange-Transport-EndToEndLatency: 00:00:05.6441532
X-MS-Exchange-Processed-By-BccFoldering: 15.20.4129.031
Keywords: Old
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(750129)(520002050)(706158)(944506458)(944626604);
X-Microsoft-Antispam-Message-Info: 29Drlo+sGi39nnOosQIwng2b/JiKI3qW4I2tj2jUpZNOzAsgP+QXDvVXo3zSXXHyrkEibCm3c9E5NvqqPHyfCeBB3jsq8fUGEhRmNRh14B2NxfedUY7T26w+zBKG9V5RXsM/I4OaEnnD5ebuLtSMSjCdomrv4omRSIeN+6Mh7yHTuu5T23rh/6hxPzjkWHP1GAn5LMfWF+snIVA3E3aZAYqnB7icKBSmc4g3lTaYf4+8oHUVARaGCPYxRc9B/rB92quml8g22GcHOG05AfRIWRwthuwwAiT+AGs+7SKT479RBG92B7B4ux7+WkcNFdjjvw6bn63J9B7ygxRWoso36r+Hl7L510PhQfzYLemdRflRllszrroCgitQjC9n0uHv67bI2nllyYZnw5Gr71AQD61EznbhPMZwuC0qTQSPieIuwfgBXKuupV+ycLiTyWd7C6CyHPqoBzR+y1aaGWDOBOUlpa+cWlipxpsrPlXHyXC/icE4RXnSPO5bS9j/paLqolUWGVeybmDkrYvP1R5PeyEMW1cfUOQKtcSPaSsQNhU=
MIME-Version: 1.0
X-Proofpoint-GUID: wO_U-406pUi8E56t2eFQMXfuoXrDfITY
X-Proofpoint-ORIG-GUID: wO_U-406pUi8E56t2eFQMXfuoXrDfITY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

Revert part of commit 75c0758137c7a
("acpi-cpufreq: Fail initialization if driver cannot be registered").

acpi-cpufreq is mutually exclusive with intel_pstate, however,
acpi-cpufreq is loaded multiple times during startup while intel_pstate is
enabled. On systems using systemd the kernel triggers one uevent for each
device as a result of systemd-udev-trigger.service. The service exists to
retrigger all devices as uevents sent by the kernel before systemd-udevd
is running are missed. The delay caused by systemd-udevd repeatedly loading
the driver, getting a fail return, and unloading the driver twice per
logical CPU has a significant impact on the startup time, and can cause
some devices to be unavailable after reaching the root login prompt.

Load the driver once but skip initialization if a cpufreq driver exists by
changing the return value of cpufreq_get_current_driver() from -EEXIST to
0.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7e7450453714..e79a945369d1 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
 
 	/* don't keep reloading if cpufreq_driver exists */
 	if (cpufreq_get_current_driver())
-		return -EEXIST;
+		return 0;
 
 	pr_debug("%s\n", __func__);
 
-- 
2.26.2

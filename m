Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434D04561C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhKRRyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234210AbhKRRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHLd3g019322;
        Thu, 18 Nov 2021 17:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5jwlufmyT6lqSyicsMV+kpxVq/ifVeRzNQowa809TS4=;
 b=B5WV8P1mrpJTkKmN5EFRwr7hEHWdwaJUGzm9abxqC+XqKbwXjSUVNgm1O9WKULEcuz52
 riOwnz9wn22Kc55XEi6AQxRSKkC5U5/w4oBd00sOew+djipUfj6EQjZEyRDyZPW6c0l5
 vQvJ6vO0oLu3Q6oY4GhrDsINZhyhOYtT+zl17M9rK3spt3pUXS2e9y8S+mNjznlSw+KX
 FnnKzbwYYzmeXy6cvzK7uIJkTgTTQe9RX5Td8p9DRcAf3Thl8I0brMdUe91BNcCqgwrA
 1yyRgo7qoRfQQCQpvrq44PatpEL8sHE42OrAKJ/l2r6aIlgCIQKyF7SImaQXsOrYZ6xI cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2w90q4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHjBpT192592;
        Thu, 18 Nov 2021 17:50:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3020.oracle.com with ESMTP id 3caq4we971-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9ilV5IXodlm/quDnnGqoVcaxyz8oYJNfHX8HB7RlC3EUD5uyKI8+J9BOM+S02Bf5TgW6unQAwpEHYBCHHP/hp++IlM4Sl/R02A1S9vQfl0jFuG/C1dN9P/tPyjRdJGugUjZ/edR66i+Ru3HhbmIwr2nkkCWhJUGRjiqIzlDeQQOVoNAX3tr3WmfWDXdLEXviWzHKZ5HRalQtT83KEK9/QpCq8FngFAhb5lWgSbVpRAiHMED4dCfOePGQazRbBowrjHBNSNL/4vkCUgHY/GER0rl97mpNgNF31F3R1LxupTmwk4b8zVZW9Ij5anGG7XWwLXNOcjCUFOgxGikoBgyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jwlufmyT6lqSyicsMV+kpxVq/ifVeRzNQowa809TS4=;
 b=lK6C588Ije238JzosUNxRqTMI6VP9Hdz5fLsj/JTJeweYw3PbQI4hJz9hp/gUXAQpG89lBsBUAEDaOX5fxwP8lNdxE0xKFDpF6HWudylN20nhTR4Y3BW9JkU0zGC1CzyPpaynV6blYISWv3Mu4IjVX/3fkq+94jtX9dLnv0CStYnjbe8sD/UVyjlBLcLeNlsvF//+iVivD6AZO6dupSOJN+plS58gblZ09b7CnT1e2dBini1Tpw1rGXQDxmhdfaHOy3Gy4gzwIafT2j0TpIiSC+Mq0o08T76Aaaf1MLqoisAslcOXUDFXsHAu4a9DCbvNNWW6HUzZXE0x5SF5S7p8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jwlufmyT6lqSyicsMV+kpxVq/ifVeRzNQowa809TS4=;
 b=Lxa8tWe7An00t98QLYR10TNhmbDT5JXcNvqO7U/C+OId/iXU9aEyFJe3GQCAzraVUQAhoHZD3AFdU7q7C1x/9rXxTD1Pf+4kS/DHCQ8CaYXa6/5QI709ZltT7iWPlJijVLcdV++1YhtDPEB6PwrvLNjC8QmfielXdRZyoBb8Qr4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2045.namprd10.prod.outlook.com (2603:10b6:300:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:50:15 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:15 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v1 4/8] crash hp: generic crash hotplug support infrastructure
Date:   Thu, 18 Nov 2021 12:49:44 -0500
Message-Id: <20211118174948.37435-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff74cab4-b53f-42fc-d95d-08d9aabbe04b
X-MS-TrafficTypeDiagnostic: MWHPR10MB2045:
X-Microsoft-Antispam-PRVS: <MWHPR10MB2045C67E0F3AACFF5D0693C5979B9@MWHPR10MB2045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io9SzE+yN3i5uNPPW0KKME/OQ744Z9uQ7e9R6NmBZl8gP9eKK3YM/Pld7aXBHg03bQJPiZV+VV4bn0bfg/ItbqtZNJ8pFcDkgbAF3qIKJ+Tr0b3QRgSF9Qln905zyUW3iXy7l+lvyyR7FLrPdfAx1LQeORCS6hqqSW/x65uyIVS8dNNFs5nJw8A/ZWA30xPvk2aQZK2397gPtffnCnVs3NhxXtGIQYHxkizBv1FOo9I1s/vIJTOxryUDJKPYZLYAw5BkuI9X0q6s9itfuYPEtmJQrysSVZWNkDbeRSgziHw4YohnGUOVHoEa1rkasqXu55neHrESiBmEe5o4pMesTEWQ7I7o9kL8MBMwVzYZmDCPKiQpSMDXzGIyDuwVpTyQd0aT1Ppz6dR3tWbM7aFx0K9sGnkSRx/yNGD86phT//pB7HwBqr55nhNoEUoNGlomRywGWhnpCS37u/t/FcCjKgWnfBRxlUUxvAgaQGM/IAuUlUw2eyiMiAqgk05+2kyWX5Y2tVF4Zr/N8cXAtAbf6JfYUCWLrM9p0i7cYwRCJMWSaeQ0UePiSOl5dK6VO83j127/hskdahe484u7G6rn8tKtETzj+jsnpFw0QZEg5svBwPpWzaDCVM8sPz/EM0ttVfBP8WlaG7U1oWIPGYtxgB6xbLHgQH20wwpMln2A7e/cLN0wXHEZngTb2LT0ulqGRa7T2U5TLrGTSHB0csTUJe6xhG5wRHsTBzvXM2/r4hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(6506007)(5660300002)(186003)(956004)(36756003)(4326008)(38100700002)(52116002)(38350700002)(107886003)(6666004)(8676002)(86362001)(316002)(6512007)(66946007)(508600001)(66556008)(66476007)(6486002)(26005)(8936002)(7416002)(83380400001)(1076003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/u2AD+oy9S4D9hJkt0UYOK3FzL84p2fRm7AnbTNa+HREhSjEpjEG0R7SYSnv?=
 =?us-ascii?Q?ZppAY0Q07kECmL0b99flZZd3r2H5Rk9KOfK9ftOhvsxrlvq5uJtBzmx3/Xal?=
 =?us-ascii?Q?lHJM8nGQKLTbJpv0WOOVZYGK0pp59J7BkqSXpmdM6T++XCWy0FYoQctDvHmx?=
 =?us-ascii?Q?FYEaktcmafS8V6djkVI/bYq4fobAd4twguXDpGlXiW6qxy+mJVo9kKCBeEyQ?=
 =?us-ascii?Q?A/kFuBRc8YVuwJFgw9HXGrlFR4yYZa1UxskIMXs+6PaDwKOm1r7q7tPx6yKq?=
 =?us-ascii?Q?qWJRpiBwg2jVFDkda2JRz5UmIMHfImXXtfyHetJMjm1Rau8ch55YIuxvKyPj?=
 =?us-ascii?Q?wRNe+kmBSyNGDkmK9eMmo+QrOdRegesu+/szdmO/ZN+mW65fq0QC2t1T6WKj?=
 =?us-ascii?Q?orwGcvB4n/sa2LY/OyX1K3nN8IXibfsWS6xDOtHVpUri3KlJ8Q3peo2PkEmf?=
 =?us-ascii?Q?5x76Nbt1ID+vroZzh21Iyt88FahVKS+I8fX16SzvkajFAvXE5hP+pdVMbyAx?=
 =?us-ascii?Q?UexbdNcwMGGXw9LtfH/nxiJwoUUS+LgfBisQkf5hX/ZDzVIrc+6NG5Pxxeol?=
 =?us-ascii?Q?BiEYYAFLnZWY73c/ElepGQ1ACwCOBdSECbGSRwvsEiDkv/hciVivsDGsJKjQ?=
 =?us-ascii?Q?GvQHu3SuZBlSCNxcXUmCt+lQ8+rh0CyScrTlps8Ad3cjfdZQxAY/zQZJ0zQ9?=
 =?us-ascii?Q?jeBajOD4xe9e7Vij4NbwVrXrqoNZE5xZFqPP4IEonUDK7o8bR0bJBVeVVtqq?=
 =?us-ascii?Q?LH4mW/d6ZkUI7UGsHjqIhiY3+Iujdh3RgaWoRD3sgYWiVW/H0Ot0pVbcxhjU?=
 =?us-ascii?Q?RN5HuP8BhZgXE75hfZb7cBDRRHvX8dPJTJW092McsQ6lWV+Taux/cQzl8KZf?=
 =?us-ascii?Q?7zs5fkDzg+VKq1qKNvDRQOa+s5QNOMbAnLn8hCIBtRHobWijX6VAZNzMo8i+?=
 =?us-ascii?Q?NRA0sZIUllC04Qd6BrIg6s+tvNejjqodJCj/hAV5b17HKddcWIFGiEuRWadw?=
 =?us-ascii?Q?hAniaY8AFzjhv1jxWxgEwaL3YHidjFzLY9R0/dE2L6ZK2G89drfaPEccFeJv?=
 =?us-ascii?Q?KBNshlSq2EPL92Hq6ROtLbJYnxIntfOQvdvCrKPfnUMXzg5xNKh06pkC54be?=
 =?us-ascii?Q?sgfVt5F+mPdIvhOY5CkmlLASfG4XAicda2mBK39NuysEHc9NH7WlfXT1xi31?=
 =?us-ascii?Q?3hbueD5M6G09Nb6CMiXezPrEhUzdBQZDfMZ3cnfmXL4Nnz9x/nX1sPq+Xidc?=
 =?us-ascii?Q?wloiqxTYFBbdywY/sPmeG0el4bX0yAAqq3MN55n4+bkaXXs04IEm58AVQyKa?=
 =?us-ascii?Q?+Yj8RRzWrBi4I/ygcqMD5GniWbqBn4fQEE2LSlaOVZ4ynGNVNJWM4GzmmKFz?=
 =?us-ascii?Q?MID73U7rsK6PoQgIHBUWa579e7aD/AreXLq/RErDodD15DbQpFZH7kwGfFdb?=
 =?us-ascii?Q?7NhsEyg9JDzNwsjXPdtB8Y983LeB0rhdWODDarc4KhZjXoPkhiCcxOx1DcuU?=
 =?us-ascii?Q?jkVcdtOsxuTmNqYrYSK+1JMulW6cOJLc9CMbxL7uJdh9MXs4v8Zilqwzc+Hv?=
 =?us-ascii?Q?Cj8RXWTopnb7BjyjKOHdbWMMIV07lOfCScsNKs9QThZ8KHQOk4NyWX9mLyrl?=
 =?us-ascii?Q?JgrItwcdue0EI0/sIgZR6+RS4RznGyGvJsNBOPHL9K+P8PYki15uaW7i/9LW?=
 =?us-ascii?Q?8isYsg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff74cab4-b53f-42fc-d95d-08d9aabbe04b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:15.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK1xPTVMpeQTLYU6Zqi6t9W3qob7126OZoXFENsKy9iei3fBDWssYljnbJSGI5GUwZVJ+152P3/dOABnyACMH3mQhvj92siRHiITUPftk2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-GUID: uyOuuPTSoifsjEJFOJXtKGi5PnZNgKK8
X-Proofpoint-ORIG-GUID: uyOuuPTSoifsjEJFOJXtKGi5PnZNgKK8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a generic crash hot plug/unplug handler for CPU
and memory changes. This crash_update_elfcorehdr() handler is invoked
upon CPU and memory changes.  This generic handler obtains the
appropriate lock, does some important house keeping and then
dispatches the hot plug/unplug event to the architecture specific
handler arch_update_crash_elfcorehdr(), and when that architecture
specific handler returns, the lock is released.

This patch modifies crash_core.c to implement a subsys_initcall()
function that installs handlers for hot plug/unplug events. If CPU
hotplug is enabled, then cpuhp_setup_state() is invoked to register a
handler for CPU changes. Similarly, if memory hotplug is enabled, then
register_memory_notifier() is invoked to install a handler for memory
changes. These handlers in turn invoke the common handler
crash_update_elfcorehdr().

On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the regeneration
of the elfcorehdr, thus the need to explicitly check and exclude the
soon-to-be offlined CPU in crash_prepare_elf64_headers().

On the memory side, each un/plugged memory block passes through the
handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
memory events, one for each 128MiB memblock.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c9..d567839b476c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -8,12 +8,16 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
 #include <crypto/sha1.h>
 
+#include "kexec_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -480,3 +484,117 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void __weak arch_update_crash_elfcorehdr(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_update_elfcorehdr(unsigned int hp_action,
+	unsigned long a, unsigned long b)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
+			a, b);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = 1;
+
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the present list. Must
+		 * explicitly look to exclude it when building new elfcorehdr.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				(unsigned int)a : ~0U;
+
+		/* Now update the elfcorehdr and friends */
+		arch_update_crash_elfcorehdr(kexec_crash_image, hp_action,
+			a, b);
+
+		/* No longer in hotplug */
+		kexec_crash_image->hotplug_event = 0;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_memhp_notifier(struct notifier_block *nb,
+	unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	unsigned long start, end;
+
+	start = mhp->start_pfn << PAGE_SHIFT;
+	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+
+	switch (val) {
+	case MEM_GOING_ONLINE:
+		crash_update_elfcorehdr(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+	case MEM_CANCEL_ONLINE:
+		crash_update_elfcorehdr(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			start, end-start);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_update_elfcorehdr(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_update_elfcorehdr(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
+	return 0;
+}
+#endif
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	register_memory_notifier(&crash_memhp_nb);
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"crash/cpuhp",
+				crash_cpuhp_online, crash_cpuhp_offline);
+#endif
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEC4561CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhKRRyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62740 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234213AbhKRRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHZwE5020979;
        Thu, 18 Nov 2021 17:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=m2YqymKo2ZcIP1IutqpwR8/YREzsIP6wrDVVOSBw1IY=;
 b=oG5BgP2WDtiuhVqWajqnZp2zIniIcVNuH0v2668yVd5uUVs8Y2lK3EjAq15uMNAsZ8uh
 dyUCsS2+tOMr1FY24HLQSMCvWYaaD53BsVfUmMCuJI58eOEmYBw/yGBHdPBve7S/xc4v
 YJ/BdagjSPErWqlFRTL3iVEGUiAQvkIzDvt1SaDaBkv/fGNILYqQ5UegFhf9BYFmvuU+
 A1tqkjOFBPsEmPTKIMIsyI/OqmzFivitjVAs8BfPo3zrqa65WfH23FSXOtQrS9tz0E6u
 ylSaHMWHx9ER51qNXKYVvx4im6pl1/yjwdnXf+FWxwtceZINsjWy01Icetwez66kQ0D4 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qyr97r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkK0w102713;
        Thu, 18 Nov 2021 17:50:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3ca2g0vmkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt3n6twlp2wcukXYpOHJ3sO+GtPrhJzD11kXlUSY8XPYdLCYehWWszhbPMc151tW4Xc0lIsDtf9AMD0Leb+fVpEgrWIuJ3lBoPIzNfy2LLvG3ppZDMvjS3wAUYe+bb4ON7V8NPxCgy7L5Dr4UD3Ph/TwtJ90RE/kwyyHNJv3Rvr4Z1U3mU8sQfXW4A5v6Ydsa37NXbytcR66grqBTEkzgbjy6Jp1YeZsTRIkjXmq+gjojbkFjgpahZ4Lbwj/DCn+WTG9ZtF/6VJLAGYurFFQl/fqVYc59QjS/X/2o/H+XI24H32JmhobVFGHb/zP886T1yf68d2f85ZOzLF3dkxxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2YqymKo2ZcIP1IutqpwR8/YREzsIP6wrDVVOSBw1IY=;
 b=dxR0yjSkDPx24/QemzAc19A6oCg2hEGb2eXl431awVjPAtDIA/SFuAM4uJ9f+HuJwkLfUozYp6Oa5r9rWLRd/Lj4G66j5RAueg1D4QVahvyv6XGJQJMWdaMsrU0ZwBrMF6qWZjJ77R87JW9fPk+ct8AJpEunPo1KCdXpzZZ3CZXxv5eKU1NaKPJZ4l2lLLlE+XUPsy20Pklb0qPnp8fRYKuOjvHWqYF43g/wnTDqgm3xuQireIx6/02N8s7E0o7073LV3KgSPrl8WOd2sdK+anzHzgxywZdrjP677mwegAqX2dYYwMyDmk5clw2tvmNpAvY8FyUWzZAjQ57No9mAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2YqymKo2ZcIP1IutqpwR8/YREzsIP6wrDVVOSBw1IY=;
 b=XxtYOMS8W10I2UAtKF6eeM+LXDxeVjNPgyBDL622Lz/9nSzJ19fsyOh1Y2xXaJ1jlSRn45OZbxismtnGP9N2Q8DLaMPnBTc8a+IA+fuX1zuJy5J2MKuEdxn4O9RvRONjWS5uZTMJOApbJOffjuoVMggdouhpyt0AKbI1QFfkNF0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2045.namprd10.prod.outlook.com (2603:10b6:300:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:50:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:18 +0000
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
Subject: [RFC v1 5/8] crash hp: kexec_file changes for use by crash hotplug handler
Date:   Thu, 18 Nov 2021 12:49:45 -0500
Message-Id: <20211118174948.37435-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b903a3aa-07a8-460e-cf36-08d9aabbe203
X-MS-TrafficTypeDiagnostic: MWHPR10MB2045:
X-Microsoft-Antispam-PRVS: <MWHPR10MB20456CF64ADD3CF48270423E979B9@MWHPR10MB2045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEGVj9epfN88Ywd8bzLtqBdMCvGvQvbRN9CyH5LkzaC8GAwqbfHoVV1LohQHCWRhro6To2krCPvulTMiDsfi0xB42Y+cB0cK4VnHe6lV0pUQ7prZvExaS6wPSooGcBHQez3/W0jmwRyevVGWWjkiTS47ji3D8zjufEgaC4sT3VeLwFMViHRR4kg5QCOG2MUtrz0V2J1ewnSZTvwzCf71zzq/lTOddKrOFBBAHB6tZDklihKPtvLIHe820O4HfwOtda1zEBPOGnCojZBHmeIUxIz4DLoFn24TevAhnY93INCnWdUrihnamfRa0xZT/9SLP7YGAvVDfvf+seqYRTn3BXR2LROoK/g+JRJqqJkt+Sh+Rmu99sEU6N7SIGtsIJeWetsVdWR47V/eGy5qbyONHeapGbLkV785dsdieCtw/FzebctuYnGUp8zUvUCbN0ocgylIAE3vqKa7l2eGHFl7lowqxR8NG99j+GD5h97ZeHG21Jkv0698T4V3/Hpzj0Q8dsvyxs3PCgkvjSmfztDiKrTokkjRgnn6n7QQ+caw8GyVFsh5Utzqb+683kEi8pjSYt0SGvYwwAXCyZ8O33LCayWgiIAajiahcedaVYpBPDAudnJHl8KWOoCzZWt7tz5gZHNii11PfVm7urRl5EjLop8RwcNcYlrqu8qnWXGvp/O/3audeT4hQlTpCy3d7tKwoux8az1tyQY4kt/EcpA5gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(6506007)(5660300002)(186003)(956004)(36756003)(4326008)(38100700002)(52116002)(38350700002)(107886003)(6666004)(8676002)(86362001)(316002)(6512007)(66946007)(508600001)(66556008)(66476007)(6486002)(26005)(8936002)(7416002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1ifCmjDaTwN9sVtSjy+8xGq4PSa38N1+BdtUuUAuYIltOG8m/waT91PArAy?=
 =?us-ascii?Q?Pcyg3qKv4BVohRvEZHMIyA1fHxdIFQpnz6ncHMUhNTK9kaQVaE9Jq+uoc2Fw?=
 =?us-ascii?Q?i5HeKzPjVvsxue1371w2HRY6UYkWOzy1WtiKiUgr8gbq9cBSTkNN4FvmiCwS?=
 =?us-ascii?Q?jbIPMu6QJaQ6/X/CpBh9QAiIJXF/RbrwwJKiiqQKJ9n6nO+QDTvLpWj22b7e?=
 =?us-ascii?Q?ws0RZMAjUbhgS1b47pBGSDNCspd9n49ouOcov9Poktekk0ScuqpuuQQ1v6Zb?=
 =?us-ascii?Q?ERCtNCL/wpYucgVlyS7r+0RS+Z/7P73O5sOtwz15LecE7qQjlNJ6YuaKN5RE?=
 =?us-ascii?Q?tzcAmN/yhNoVX6ASIPyI1vUWpKJoewd4E1+cPCwV1MBDQW9gScTbp8ZSkIFn?=
 =?us-ascii?Q?1TjEf1wA0Lx4HJLHlyLAZ6kzAMu24ZbiTpx8GriFnEjTLMeViokIJTygNlZC?=
 =?us-ascii?Q?y3jDwGceE84lF0ocLBbfeuzWh2O+PukxEexRj+vswihzXfLYbVmkb9jtW9ca?=
 =?us-ascii?Q?wC9BmXwek+CblHXbYBMtl/9+X7YUQL3P1rf+pTVvv6bUd1ph2+gEPIHdrDgg?=
 =?us-ascii?Q?yVkyVeNdl99bHzc2T/tqttlBYW+L7MggXJC8nPFCWgpccFe5Ap/WGpyMsrYD?=
 =?us-ascii?Q?IsyTShRYluU2JVVpL3mA3uvfK1rY24/h1iKbg65gDt8Ls80elRynDqSM7rvj?=
 =?us-ascii?Q?SKxNfb5vD5Zbeut9K6a2m1hPHMOLS78o8eYUNTVA/X3ZVb+FM1xIMdQHMdtH?=
 =?us-ascii?Q?JIFaIab3z5K2atMTBTytRBxPTmS1lblAdd7EFtS6ODtuTfCwWeXxT1j65N7t?=
 =?us-ascii?Q?xIk2awzCUD27kDWDlcB5s9Hcjn/ht2s/bz+Zdpq2YLCfP6zIuyxjDegBRJ4B?=
 =?us-ascii?Q?1C10zIDZVDXpUk6LFvsrVnA6jPoT0iWqPeXlLGpyE2oSimS3qrW8AwUvM5Rj?=
 =?us-ascii?Q?Rqsg1M7sq/IfMJdDp4UPwsCYYeMFc8phky6T6snIKGcHUSGHTYDl03igfaZK?=
 =?us-ascii?Q?9EX58PPRHfVmG06hmW7qVMmFJJHAp0KWyDl2r7nBbc/CWdrHaX3uyhmzfJ1e?=
 =?us-ascii?Q?oR/8Nc0TIyyp6Dj13TsWdkxuM64Pz+zo5YHp702oGnmwV3pYkPAPKFY064h5?=
 =?us-ascii?Q?DtMRmiYRGeskX6YzXYqcYlNNz+UT8KCUNhyXV0VORE/vwzwOiLsmG5KmLNTl?=
 =?us-ascii?Q?3vthVNyqYka0MH7XuEs0aZD1n/Au847AMTF2b/y4Siu8KzTk1nUeZpjDe2E1?=
 =?us-ascii?Q?4+dZjkZ6S5iMMFP4o/GAJnjvNJoJEkn8GbX4/GShvDrtQ38fo3CmTndbjkuw?=
 =?us-ascii?Q?UN+fNLWSwVeMl5/W4B2VlrG/+3MZ+MSGqchm2PX5Cu1uW8FBZSa0KjAyVF+C?=
 =?us-ascii?Q?Pm8r+SjDJB6WWjjivKBuDYfcM+/PLRhW8BsDqVaGa4c821i4ct1yjlRYTPjB?=
 =?us-ascii?Q?0aiXK+3JbKQOj/lzFMs3fAh4tWI3N46Or4gZsGul7my/2AeyXgGB4FmtVCet?=
 =?us-ascii?Q?xm145n1j5X4sgE0JiByEr/U+2837UiRSeG8Gd0SOGdOPwEvpafut/DXVlrFI?=
 =?us-ascii?Q?g8BPOktqw1wVh3vR4nizzFw8Xg2RCOLo68G9RFjnpHRWyvcA2bI6g8SuupXa?=
 =?us-ascii?Q?vceqIzDlHVejDbnC3Ym5jVTQaT4cEdUqpvhzvQ977AM5BITg6xu+tLEv7qJs?=
 =?us-ascii?Q?kEznHA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b903a3aa-07a8-460e-cf36-08d9aabbe203
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:17.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HCwPPiRkwE8owWEHd8UkUkQalcDfsDeC3UQlOuJGC9vVJ5wjPcb6JsFSE5K0imlAl4JdWOLiEw+F7KOmLjxe5aHzlRFHOqQdSrvkSGYjt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: 9TxzGJaxfALMGtXnfm_AA5DuS7KFKezB
X-Proofpoint-GUID: 9TxzGJaxfALMGtXnfm_AA5DuS7KFKezB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three minor changes are made to this file to facilitate re-using
the functions from within a crash hotplug handler.

The prototype for kexec_calculate_store_digests() was hoisted to
linux/kexec.h and the function made non-static.

The crash_prepare_elf64_headers() had the struct kimage parameter
added so that the check for the offlinecpu could be performed and
this routine re-used by the crash hotplug handler.

Finally, kexec_add_buffer() changed slightly so that it does not
attempt to add the buffer to the kimage when being called from
the crash hotplug handler.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..c9e8e5b94382 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,8 +29,6 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
-static int kexec_calculate_store_digests(struct kimage *image);
-
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -674,6 +672,12 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	struct kexec_segment *ksegment;
 	int ret;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* When servicing a hotplug event, do not add buffers to the image */
+	if (kbuf->image->hotplug_event)
+		return 0;
+#endif
+
 	/* Currently adding segment this way is allowed only in file mode */
 	if (!kbuf->image->file_mode)
 		return -EINVAL;
@@ -713,7 +717,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 }
 
 /* Calculate and store the digest of segments */
-static int kexec_calculate_store_digests(struct kimage *image)
+int kexec_calculate_store_digests(struct kimage *image)
 {
 	struct crypto_shash *tfm;
 	struct shash_desc *desc;
@@ -1260,8 +1264,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
@@ -1308,6 +1312,11 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0


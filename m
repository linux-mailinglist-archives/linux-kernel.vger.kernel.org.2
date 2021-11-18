Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13374561D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhKRRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61026 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234274AbhKRRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:54:55 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHRoLr009987;
        Thu, 18 Nov 2021 17:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7qOeGdx+I528mY3mQF2uIPBLRfHE/tvPcEFGcTU1fx8=;
 b=AfmKEyeXljMIblx3UVVdNPDQpF8mlu1OlcdFM7L8DfTbRRmHfiGiCOlbmJp5+xhczapY
 IkTNdf/rIwVtxCRjjT24AFkKBU9blpxxRSjEU6xAMSI2KJh+SyHQXegSbPYROG5I6uWK
 3Rj+RFxaBiRJm1oiH+iylPCE+6dSfFZijVW4Sv1L3/nIkdCRPMLclzlkXtDbuJ5Dl3r3
 YgE3HZ5O9sPydggfQqJJMSTmSKc92/VSqGFsLSwhG+2HitGYalegatr1XNIGIsD8Kh7y
 bicu3tc/CrU+4SU2sb/yAO6g93B+I70azgZRTx40/ZVflG4on+i2KF7jE1hauhfuBb3O mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd382hrx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkWH5165606;
        Thu, 18 Nov 2021 17:50:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3ccccs49vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAo3hHl9tgNmZTt5HrZhjAjT2kKrhVJTiA0to4SemW7WisblOMWyPKup4V/zZFF9tCHPgieYPojcxVKSoWcuTOIHWBWg1Po+IubAZ436OvyRD6zfsyUkcbPv0+pg2uDb2cA3+WWtHB8Yktxrvu9M5MEx2mNWhggA27AicWaurBfvKcexZcnnEjFuAyBHe8szjyncQ2TtXeSGBxo0JjUU8fc9xbF7z9zcd9uWzPERyKoGgUssVoqLmJMs31CbMuSbLQuEzo+Nhqchk4siTUp9ceyE9P9Vyc7hBRP3zTb4h0FYtNQOwJazX1l6lfEeSvH976etHANj2pzow9QnHZmG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qOeGdx+I528mY3mQF2uIPBLRfHE/tvPcEFGcTU1fx8=;
 b=bi7TtoT2ENgHrbAfMxZJnuWTmhX6VW/PK0rcHLHfqxgzu6KprMb2yN9PYba0mJf3qdCg1hGLHW8r1jSKBJJ6TgKIYgTjfQmWTzVjAvVw06Tbbf9PYSnuvlSUpf7QPVW7MJbOuIrJKwEHZtEnHto4waHM5Xj3w40xeUidJAw9hiFyH44ZGwbWJLIlUpWzpichoU5dq8noF7XTFTKQ7HRSkiZ1SzvC1joGFO4mYWScTSf0FWJpbaFxb0jrtfiiCyl71R0Kbbbc3FZF5nZA8hBwdZYoSrPVTVF5J3MsKRVSp5j9NsRhVCFX4MefFFG17hnGHxQ185FomQ+UJ6rB7FWL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qOeGdx+I528mY3mQF2uIPBLRfHE/tvPcEFGcTU1fx8=;
 b=TkIjvU6CG9nCGLJt+MNNs9C1+PD4DQk5RdLJ4CaOAq2ryi+HqoN6DamCDHvnyZ6Kg6G7P1JmqYog8gRBGcCc20z1fyjVqKxnn34bFmK2Vg7DzRrzOJWry/7XHcpiMxpRxfez78QWFRI45WisilKP79Cs8LL3LLQMClvMzFaEtC8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5652.namprd10.prod.outlook.com (2603:10b6:303:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 18 Nov
 2021 17:50:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:23 +0000
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
Subject: [RFC v1 7/8] crash hp: Add x86 crash hotplug support for kexec_file_load
Date:   Thu, 18 Nov 2021 12:49:47 -0500
Message-Id: <20211118174948.37435-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7c849c-51bf-4c93-c7b0-08d9aabbe514
X-MS-TrafficTypeDiagnostic: CO6PR10MB5652:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5652B3AA3FBBF4CE14AE358C979B9@CO6PR10MB5652.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPEBfqSyIZJcCH11ZRsCx53wOXm0CNTFjzV0cfdUfYgy4kPA0tTsJaDTsnRHii7eZoWqh/SqCS+PsYlCW8sTv/rBdKoXn/2tTeveaqeDENSE7IemWwKKNKCu5eryfgIcTgxMmfql/UZE970/nTxrdvbeonWJ7gBrIrP+7/YbAUmgCp9BtCQXONyz7zF4icqx1+QKPIXogW/MZSUzn82p284lPwqUejZg+kttKO5CJds90i/tUPtNVm5C1+EnFoI5X8fHp0dKd6BIkK35g5yzu1IthrTJv4u/YrM41N2F6eeudzO1eop4ZLxg1Qza1bi0Zerc37d5yzopj3NvulWIwQgS+Jz4vbHlWmbSMJNrZ0M/mQadLsVJ9JZB2RASRycicjokOAFbh3MeBxF0dPLY7HM1sDibkf1qXmUe2YtMlI/c+DrsMgJf5PREgBaV93tO2FjJkeGhGKmdosd2VXo1Dw4/oFaNe+OLHHa3e0/MFFtQm5NTfGr5e8MmIMNofNjCLfK7TopBCbVxaUkaZjRHz0AjVBsLA73ukggupwArXAi9jIdd/6VRuI9VLUhBd2M3klrrUGIM2AZUx6a6iW6KpiF0Ymkjxgym0H3lBe6bKcIlO8fV4a3JM2HOiHPMpXFnlOhdWjHKybh2PDFrw59/dEIkWt44AIpublwjenmIfISVkLIdMMgD58NX88nXDKp0wiV03MDD5SK3xQcFfW7iGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6666004)(66556008)(186003)(8676002)(1076003)(83380400001)(6512007)(66946007)(6506007)(6486002)(36756003)(508600001)(4326008)(66476007)(8936002)(2906002)(107886003)(316002)(956004)(38100700002)(30864003)(86362001)(7416002)(52116002)(2616005)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmAgKZ5AKZK9yCanLWwK9fC+n3It857nh4aFn6OFTTX7yhCwnIiWT21nJd2V?=
 =?us-ascii?Q?Y6Kig125tYtXEXOZkyVKn9Ufctbi86Z3gCkSxEUqm74OGrUGCckmQ5duVuXF?=
 =?us-ascii?Q?n9qrwzLVpmTHhAdE7LxDfYO8RRGyjgvIXbrRx+PhDKso5MnK/UCTNJ+PSG3+?=
 =?us-ascii?Q?oSkYIH0ofdfqJ9o+pQnlYMT9JwLthxlY84s6dcAGWPRHpj5Kz33oBjmBf9Cr?=
 =?us-ascii?Q?Fvr077eUyMkK6wy+DEPvhZmW5CP3hjLwF8EBM7JA74ikmlE5jiFarzoGbJd8?=
 =?us-ascii?Q?bmMB76u+UxfP4e0cfpxau2tyrU8mRvd2HDdY+G8xiXTL0pXqW3QuhLQWtgEk?=
 =?us-ascii?Q?j9/DSZpqSNvGy7a9Y8QLi3umaHFgAtlf3b7ERyhnpRbX4FiDhs9ctGAL4Uad?=
 =?us-ascii?Q?S8So9Ok5iI3j0z5ZkyvW/pDuee0TpxEV6gqAkYplHCQ15Ce3pvxfB69JXaEs?=
 =?us-ascii?Q?Fdepz5rX4vHg/9VB1jo2iGGQhxxWPGkl+5kscqjbQoiI3GrfSgC+AGVBLdVb?=
 =?us-ascii?Q?jUvspiSagik7sUBKuGDY099bxuA5RmMtC9Fh3dpmzpZAwcwlgKpQ4g0l3t0n?=
 =?us-ascii?Q?DNcHK0DsIIfcAEWrFwIqSb3+K1UTgb4hzpUwhCLrVfxfLJNpWLNZQdMjpnr9?=
 =?us-ascii?Q?RO0HF7I6bMmkHljybgvoGDYjf9ZYhe2XExCVmc1jul9OWIDWu49FVVwVhHbP?=
 =?us-ascii?Q?JfJoAp8IJGYCeAWtFfV49B02EXPtHyBXsH9KHbVtskPuYFXxyKc/feJSncws?=
 =?us-ascii?Q?5SAGCNgiswcwP7qRuOxcre8sHRHfNLS/5+nOi3sQDKikdSANa5fGJFiR5Bw6?=
 =?us-ascii?Q?uyeNmK6m4ElPh4ykFZ75IDJOnr48kq8wzgWu/K8saW5X++XtpTDx20w8DgPC?=
 =?us-ascii?Q?12C9vmblztQiTo93uAIctCY+ldE6pDO+1GJgqoPQE9FtUNS5FwLflMndEIZH?=
 =?us-ascii?Q?Sje8aGbMHRksKSBTEJSRbaObCPJJEns6zm2v7A16pnHUKGnLvgj9k105N8yz?=
 =?us-ascii?Q?OgKpKlLi5NN3Eb91IwH/YYK+/oLN+GfH7yX5AEp8VvwaVfJvbkLM85s5GZc3?=
 =?us-ascii?Q?RQ7lr6FnQpsQ8B61Q8sdFKkbaWQNKbBt0cOH6d4ZwGUhOf55T1egmMft1+9S?=
 =?us-ascii?Q?pBLxRnuEFcF7inSWekFYkvvEpyndFYJc0dkUWtn3wejwjLJ54HrXiXyXovzJ?=
 =?us-ascii?Q?FkQj2Ui79pGtztEeW6ubUsnu5ZM19LsV7Jx4Oh7QuGHOvGMvIY7nciQu9Se9?=
 =?us-ascii?Q?Y4Fn+6bvtDjWzflapq6lhTHaFj6WOOCNjb7WRK6PoPQ1uIfqEyOvtG4eHuBl?=
 =?us-ascii?Q?7hVeJMkBg1ZUISjsDxP00Q7TKb6VECpZDxeEQMHY5vrb9WXP8gOeQQfI+h/O?=
 =?us-ascii?Q?Afo23a8/RmunnFFw1UH5aSdT+5mhAapMPoppQR7IRUBZZdvVNilMMsSHoFNQ?=
 =?us-ascii?Q?UbEXzMNB/RUv8csR+2Xwus4tKHyFAlKjC7hZC8pDMtaqlLDlIRWOvtcBpRfl?=
 =?us-ascii?Q?bu99LZEqvDfXcq0u1JjrQb6PYbfCrddLnHe2kg/ddLRJt+l/tnWtlw66lIV9?=
 =?us-ascii?Q?mcAjqO8uUjpdgyc6QE8DL2aTCHKbB8CCQ7meDLlo1jgJEiCuOKG13aREUNC1?=
 =?us-ascii?Q?e80QJ3jPQvOK0sCKPvdf62ppjmjSFUUxx+6S7OamMvVimfX4+eAmwdmPHCYi?=
 =?us-ascii?Q?LmWGpA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c849c-51bf-4c93-c7b0-08d9aabbe514
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:23.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILycLrMF9+0l9jZ9vqA6v5eZdlERAZaKh/hR+7nDiTJ4YzE0fcOAPa1RbrmYYXy9zwEGzTdmjxBXeZELLaQZX3hVkwqV5hvVlOQPe8NDYC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5652
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: A3Hn-ZLWACALRZdcZa89WajZhO7B4hDX
X-Proofpoint-GUID: A3Hn-ZLWACALRZdcZa89WajZhO7B4hDX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, the crash elfcorehdr which
describes the CPUs and memory in the system, must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory, and placed into
memory. Since purgatory also does an integrity check via hash
digests of the loaded segments, purgatory must also be updated
with the new digests.

Once the new elfcorehdr and purgatory contents are fully prepared
and no errors occur, they are installed over the top of the
existing segments. As a result, no changes to boot_params are
needed as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct.)

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item. The
purgatory segment was already properly sized at load time.

NOTE that this only supports kexec_file_load. Support for
kexec_load is not possible since the userland-supplied purgatory
segment is a binary blob that can not readily be decoded so as to
be updated with the new hash digests.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 255 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..d08e112cd345 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,9 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -265,7 +268,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -397,7 +401,16 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->arch.hp.elf_index = image->nr_segments;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +425,243 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+void arch_update_crash_elfcorehdr(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	/*
+	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
+	 * is passed to the crash kernel via the elfcorehdr= parameter)
+	 * must be updated with the new list of CPUs and memories. Due
+	 * to the change to the elfcorehdr, the loaded segment hash/digests
+	 * contained within purgatory must also be updated. Thus purgatory
+	 * also be updated. Both the elfcorehdr and purgatory are prepared
+	 * in new kernel buffers, and if all succeeds, then new elfcorehdr
+	 * and purgatory are written into the corresponding crash memory.
+	 *
+	 * Note this code currently only support the kexec_file_load syscall.
+	 * For kexec_load, all the segments are provided by userspace.
+	 * In particular, the ability to locate and then update the
+	 * purgatory blob with a proper register context and hash/digests
+	 * prevents support for kexec_load. The kexec_file_load, on the
+	 * other hand, is all contained within the kernel and all needed
+	 * pieces of information can be located.
+	 */
+	struct kexec_segment *ksegment;
+	struct kexec_entry64_regs regs64;
+	struct kexec_buf pbuf;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+	unsigned int n;
+	int ret;
+
+	/*
+	 * Invalidate the pointers left over from the initial load or
+	 * previous hotplug update operation.
+	 */
+	for (n = 0; n < image->nr_segments; ++n)
+		image->segment[n].kbuf = NULL;
+
+	/* Only support kexec_file_load */
+	if (!image->file_mode) {
+		pr_err("crash hp: support kexec_file_load only");
+		goto out;
+	}
+
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index and purg_index should never be zero or the
+	 * same index.
+	 */
+	if (image->arch.hp.elf_index == image->arch.hp.purg_index) {
+		pr_err("crash hp: unable to locate elfcorehdr or purgatory segments");
+		goto out;
+	}
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources. The elfcorehdr segment memsz must be
+	 * sufficiently large to accommodate increases due to hotplug
+	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	memsz = ksegment->memsz;
+	if (elfsz > memsz) {
+		pr_err("crash hp: not enough room to update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+	/* Setup for kexec_calculate_store_digests() (for hash/digest) */
+	ksegment->kbuf = elfbuf;
+	ksegment->bufsz = elfsz;
+
+	/*
+	 * To update purgatory, must initialize the purgatory ELF blob,
+	 * then record the crash kernel entry point register context, and
+	 * finally must recompute the hash/digests for the loaded segments.
+	 */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Initialize the purgatory ELF blob. Need to initialize the
+	 * kexec_buf in order to maneuver through kexec_load_purgatory()
+	 */
+	pbuf.image = image;
+	pbuf.buffer = NULL;
+	pbuf.buf_min = mem;
+	pbuf.buf_max = mem+memsz;
+	pbuf.top_down = true;
+	pbuf.mem = mem;
+	pbuf.memsz = memsz;
+	if (kexec_load_purgatory(image, &pbuf)) {
+		pr_err("crash hp: Initializing purgatory failed\n");
+		goto out;
+	}
+	/* Setup for kexec_calculate_store_digests() (to skip this segment) */
+	ksegment->kbuf = pbuf.buffer;
+	ksegment->bufsz = pbuf.bufsz;
+
+	/*
+	 * Rebuild and patch the purgatory ELF blob with updates
+	 * to the regs64 entry point context.
+	 */
+	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+		sizeof(regs64), 1);
+	if (ret) {
+		pr_err("crash hp: can not extract entry64_regs");
+		goto out;
+	}
+	regs64.rbx = image->arch.hp.rbx;
+	regs64.rsi = image->arch.hp.rsi;
+	regs64.rip = image->arch.hp.rip;
+	regs64.rsp = image->arch.hp.rsp;
+	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+		sizeof(regs64), 0);
+	if (ret) {
+		pr_err("crash hp: Could not set entry64_regs");
+		goto out;
+	}
+
+	/*
+	 * To compute the hash/digests, must establish valid kernel
+	 * pointers to all the image segments.  Both the elfcorehdr and
+	 * the purgatory segments already have valid pointers.
+	 */
+	for (n = 0; n < image->nr_segments; ++n) {
+		ksegment = &image->segment[n];
+		if (ksegment->kbuf == NULL) {
+			mem = ksegment->mem;
+			memsz = ksegment->memsz;
+			ksegment->kbuf = map_crash_pages(mem, memsz);
+			if (!ksegment->kbuf) {
+				pr_err("crash hp: unable to map segment %u: %lx for %lu bytes",
+					n, mem, memsz);
+				goto out;
+			}
+		}
+	}
+
+	/* Recompute the digests for the segments */
+	if (kexec_calculate_store_digests(image)) {
+		pr_err("crash hp: recompute digest failed");
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Temporarily invalidate the crash image while its new (and
+	 * accurate) segments are written to memory. A panic during
+	 * this operation will NOT generate a crash dump.
+	 */
+	xchg(&kexec_crash_image, NULL);
+
+	/* Copy new elfcorehdr into destination */
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/* Write the new elfcorehdr into memory */
+		memcpy((void *)ptr, elfbuf, elfsz);
+		/*
+		 * Zero the memory between bufsz and memsz to match run-time
+		 * purgatory hash calculations.
+		 */
+		memset((void *)(ptr+elfsz), 0, memsz-elfsz);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+	/* With purgatory fully updated, store into crash kernel memory */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	if (kimage_load_segment(image, ksegment)) {
+		pr_err("crash hp: reloading purgatory failed");
+		goto out;
+	}
+	pr_debug("crash hp: re-loaded purgatory at 0x%lx\n", ksegment->mem);
+
+//FIX??? somekind of cache flush perhaps?
+
+	/*
+	 * The crash image is now valid once again, panics will cause a
+	 * crash dump to occur.
+	 */
+	xchg(&kexec_crash_image, image);
+
+out:
+	/* Free/release buffers */
+	kimage_file_post_load_cleanup(image);
+	/* Free elfbuf */
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	vfree(ksegment->kbuf);
+	ksegment->kbuf = NULL; /* for loop below */
+	/*
+	 * Free purgatory buffer; this ksegment->kbuf is pi->purgatory_buf
+	 * and already freed in kimage_file_post_load_cleanup().
+	 */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	ksegment->kbuf = NULL; /* for loop below */
+	/* Free/release mappings */
+	for (n = 0; n < image->nr_segments; ++n) {
+		ksegment = &image->segment[n];
+		unmap_crash_pages((void **)&ksegment->kbuf);
+	}
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0


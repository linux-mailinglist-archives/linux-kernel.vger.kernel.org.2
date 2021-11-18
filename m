Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0E4561C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKRRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58670 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234208AbhKRRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHANPN019269;
        Thu, 18 Nov 2021 17:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wmnkJKuI/E6D5xhj92SZyI/NQMDaMdxokE0Ezoj3itc=;
 b=Z5tCW98FiBqJTR878mFQrJJWJ7DCcLzm+655XfSA+4YXIR0HnFxgIAZqquTn4thS3oqd
 as3W1j6qryJAIP6QCoAcfwprVdfc4v88zEBWD+0qqqZQLnu1wiFtZNOBMw/5SnHSaOOH
 sPxmXV1rVzys7Y06V6ade54Kjv9MCRJiJObwcmZMljl1qWARZ0Usp3PnHAi1d0UVxls9
 ce3cMH+OAQtEWMWvlU1iUudtkEUnH7f3MuGxBC7ZS3Shto917k8T1HNrqo9ZhltrlrnF
 JIhf6ChoDiCF47kB5XrdSYLJCd2pJvhVVq4R2R6xA+IhiGCSCvM5fYRDXtPEDz2LMa0t /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2w90q4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHklCr046683;
        Thu, 18 Nov 2021 17:50:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by aserp3020.oracle.com with ESMTP id 3ca568xvmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i53RYkOBTX97Yu0Hqr7XxeX8nGPmVaj2N2/2tnOIuz83am1J8vN01gGxDLGyhLx6iT0GqKg7bWXTJNE9vHcDwRf3Xbjidu6NUhle0e1S0WmZJvuHDYu3rYL48Fb72eh8F/D8qdZcO1tL9Ciyz3oxM8muXHOm711vjUUlpCsIjVY2bHydVfBxAtpw/zZ/uMtD2GKyou8btsDnyBk3u4BqHA2exATcEdBsatmxtuUGP/Uy1uUT3FrT48iJlmmdvoz+8hDw6mV5HFYRADnQuB/TxwgcHb9e9iOOWKfULRm+V8YBamS7QxxmhFO/1Loa8xwslorPdCpYamq4RgroHrDR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmnkJKuI/E6D5xhj92SZyI/NQMDaMdxokE0Ezoj3itc=;
 b=QT30+6+jsYM8nDb+xZJ0Dsz1nGmmQgLH7x0Qt4E62zyDi+Tky8R2Am0FHqDsqZ4YU3o5ZkvzAIjHpVwsEzJpTtPbiRRi5y7Tzu8XOT8wLy0TAB9UlFhNE56zGhPNJ4DF2p6B/S6a60/9KuM7m/dXGXDyrXvI6V1xGbjdXLE9tfx12BO++8CidaIqL+/Lyksu5FPP5VplrIFsIX9uZ8XYS5tJDBPmSnFMvYVVotC5yU1H3MDI7NikkQw0Eh4kmESIA6YNYl9f2rMKiTGhelwCEqX2aGFilfydyhwJIP+zmT2CLRUzzR/sw6AMhw2jmUEch7fCl6i28fvlgqlUtRa6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmnkJKuI/E6D5xhj92SZyI/NQMDaMdxokE0Ezoj3itc=;
 b=zUuKkTmnrfkkkRaJO3b4egb3R0nDBJj2XVizPE1tPyKZcW0/cSQT2i2bE27N67WHkXAN85yqD6rKm309IU4mJ8Hg9Lq15scOVrirjQPP95kRlbYfZh2do8h5xgtidmMds0ty3xYJWwK6O7TDYbBdwBl0kohMvf+hcn6Cm2lffqA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2045.namprd10.prod.outlook.com (2603:10b6:300:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:50:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:12 +0000
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
Subject: [RFC v1 3/8] crash hp: definitions and prototypes for crash hotplug support
Date:   Thu, 18 Nov 2021 12:49:43 -0500
Message-Id: <20211118174948.37435-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77acc07f-2b92-4d7f-6e0e-08d9aabbded6
X-MS-TrafficTypeDiagnostic: MWHPR10MB2045:
X-Microsoft-Antispam-PRVS: <MWHPR10MB2045ED82AB0DE5D1BB5CF2DB979B9@MWHPR10MB2045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch2FW1nP4ZupsI5yhmdQo9BvquYr1BXljKHCgwWF1+NVgwrklmqDSl+oCNXYYjJLnV5E+T1cSeDV9MSQvLpFoIlDIoUHnNgVWHWaRbyTA+uOaDJmLPF2cfNYEWxGK825SpaYKGHsCRqpqEtdeubBU5KSqp8VpU+2Xu1bG/hEaAfSsgV/wg+qNAww3g8VEX3aB7ig0/q4kiCPX2/Vk6qxjCuh26nBnDioshjjTOkXD8scx2o2Ko6q1Op4prk1/Zkrx3rWLHnP/ZUXuBrbWbpQHzr57l8w0BqqTa86rHwlLwHHOJQ1rARxSNfQMjw3KiYbWpszGied2QMrrbwfP4rYeuRFcX22PolIpv+QW81Rpsu7d5gZs+aA8MZPMeZjb66noDgTrSJJk0rS9eZrqanSaT2Mih16ZgQXvzMX5dMLJz7RGjlTjfPHMybPbfjeJ46iJ4sbtYjlH3yPqbhPNVnsCbauCVxSkjGR/6Xs6RCTmkEjjvbpsxgwNM+Z5lxiMfMR5utmzrElQsKrrR8ZJznTC9tIen5Go7c4g21JWS84t2bpqYTG49Ti2RVS23Pf7RSYyIvT6Y+dSYUnWNapOZgUKq3NIIb2olvcDK881vPuKJ9NkZCRQeza0qNKNO+Pqr2fGG+E/GS19wAq3Dy2+7k/IT9wtzpsiuEYXUgiTnAZVpwjsWUpSCOVAXH5jyVuG2ftFnvUtJDaS9kbkQ0ZEGvb1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(6506007)(5660300002)(186003)(956004)(36756003)(4326008)(38100700002)(52116002)(38350700002)(107886003)(6666004)(8676002)(86362001)(316002)(6512007)(66946007)(508600001)(66556008)(66476007)(6486002)(26005)(8936002)(7416002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLQQ6zXRPZC8UaRZgYHc8R3Bg8XFW/GOhXrr5WFVWJ1r46wVL3W8m9VSkG7C?=
 =?us-ascii?Q?Wa2FVYA7q8jOqJDTeq/DSKSbm4WAsOociV2TNlauA/yG8gdObQprLCEXzHDm?=
 =?us-ascii?Q?2qZuW4HmXQjjzcO6mk5KH58bwd8B2Du3AWyEWM7hFTPGG3caz8RKIIJxCh6v?=
 =?us-ascii?Q?3+lixhH521HbVOGh9FuUGQ9NrBTeSQta3Is4rztUQhSd3NwT4TMhknHjAd54?=
 =?us-ascii?Q?D47DWIDjBxH8rixgpPA0cS+8Km13Zaj9o6y3ewelDCV7K4PDj7P76ALKebmy?=
 =?us-ascii?Q?UyE/Qao3BxCb5v12urg8i1j4n3RHk/fas/A4ZXV2qTk+xAcaCfNP5ELdN+zA?=
 =?us-ascii?Q?wMSNx4n1bE7jAt4VxhQ9ZGV64OxspyO5woh5EYBH+VA091xmDml1GSUhtbIn?=
 =?us-ascii?Q?l7pGyuQ+HkcGZW/qJVcpExc1xkahbm2r5tChwGavV0uAKA4MT+YxwSLAi3va?=
 =?us-ascii?Q?DoAufhaGuhd3Vy/0+QvRbbSiK7PSr43rh2snq8i+RqJutWuX9zT6LWFAoMxq?=
 =?us-ascii?Q?ae+9ZvKVpXth0V+ef3NX5+Ue0qzD+IS8O/b+fpaUqmZBw6ADw+mww8oxDzYe?=
 =?us-ascii?Q?bMOgXZrR00w49FsdLfQ17/zV3MnK+8l+tO9nZOo4EdYYP76pJ7rlKWzAxfV/?=
 =?us-ascii?Q?TWFskAe9FgoTvY1NC4ZaxYJVLhG0700A3IVgf3OTLdTT0/q/qc7cBa9x0Ohr?=
 =?us-ascii?Q?4Sa6bEKzUAizMP7HeGwMXa2/mlZ3mMinelv9FS7wr1kukegZ8EJgS8xAhX4s?=
 =?us-ascii?Q?0ugoaT+Y2uezeKf4FI2hxIRPp/Iv9x10H5BnmbVZaNXrKwb3BB8GL9hrsmNw?=
 =?us-ascii?Q?tfCy8G0ut7wEPx2Vr4yFLZ+ap4NsLI8sEHLcG1mgx0aaVDltbxTHGOFUVYRA?=
 =?us-ascii?Q?9ek0T5Qc/MdTiZjV7D3RnVLp5acEnw7rzJ3+0U/I1lLJROBJhVK6DqfRc0d0?=
 =?us-ascii?Q?SrYJPF7f7Vo8HfPwvDYnBR2eoEmLXp6Q6EoXEzjPOqc5dJWl6JUBRCLuo8TB?=
 =?us-ascii?Q?HttTbrTCGQDaEp99F30eKLVBh5cAMo+aLCuXENWj3IElMNh+xlVTJn7QG55e?=
 =?us-ascii?Q?iqReM+8r1zzkNdbxbaAqJihU3XZbZHoEfgN9T4Ou4raQg+8haw4O+8wZZI/p?=
 =?us-ascii?Q?LFMMydEIfsRBmKhHa3iO8uyMR7z40zQ30YMdMjoetzpsTGz+bQb6DqEv395s?=
 =?us-ascii?Q?obdGdOLvxpefwRqd8quuXMbJj6XZo/BedyblBSSxagEvvaMWtQf5d9gBAqGg?=
 =?us-ascii?Q?v4UHPs7wdmrs95iIWdCk9pj5dveQYxh+ZW1AbMshm/mlvhTx2sDN/Dk/i0nD?=
 =?us-ascii?Q?/WO+xjrK/sCbJZxW09QT6RYEKNIs0ARkqsdnCU0K4CWzO+lESggYrob6k4j7?=
 =?us-ascii?Q?y6DbOpFt8aT10BaCE6oYadi9xMQ6UOLluB7p96XjXhPu3zK3n71dJMHOYv3A?=
 =?us-ascii?Q?fo8q3vFiQrx7OsF0YPs0yd6jamFT2Ys9Jc+AwSY316C6Q1NufCHWIgyouZ2x?=
 =?us-ascii?Q?x/CXRDBRNahEmIu8nQRnOYAEbnQlYea7c2IZJcB4ZHfQyqkO08mF334N2cSK?=
 =?us-ascii?Q?oEL9t+TDWQFymeEH9bGqQwsmFWbo4baYwJvE+PKjb9nN+uEDqH3BhWsmMBGE?=
 =?us-ascii?Q?25zZKxmTf+8/jtRk2dPJlf8buyywBArzrDOCsU5WtkUYC1fQn1sKaSfWDc+M?=
 =?us-ascii?Q?dBXrog=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77acc07f-2b92-4d7f-6e0e-08d9aabbded6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:12.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ7D6ydGduwgQ3o2R/FmFXYt7zgqCAFGuft0gu0YrCzKnZqQLYc4BstmU2No8JMoRRc9CHxz+QIVIyY0+aGrWGkikpTJUDxFgz5SDIo8Z1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-GUID: c3XwUus9pEqsmf_CAZhFXURzPQ37qKi2
X-Proofpoint-ORIG-GUID: c3XwUus9pEqsmf_CAZhFXURzPQ37qKi2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds two members to struct kimage to faciliate crash
hotplug support.

This change also defines crash hotplug events and associated
prototypes for use by the crash hotplug handlers.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..8bbf2ae7a040 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,8 +221,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+					struct crash_mem *mem, int kernel_map,
+					void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -299,6 +300,11 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hotplug_event;
+	int offlinecpu;
+#endif
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
@@ -315,6 +321,18 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_update_crash_elfcorehdr(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b);
+#define KEXEC_CRASH_HP_REMOVE_CPU   0
+#define KEXEC_CRASH_HP_ADD_CPU      1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
+#define KEXEC_CRASH_HP_ADD_MEMORY   3
+#endif /* CONFIG_CRASH_HOTPLUG */
+int kexec_calculate_store_digests(struct kimage *image);
+int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
+void kimage_file_post_load_cleanup(struct kimage *image);
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
-- 
2.27.0


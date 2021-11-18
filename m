Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2C4561C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhKRRx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:53:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbhKRRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:46 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHhWLP000708;
        Thu, 18 Nov 2021 17:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=GLwmuQX0t0oCyvZLY71nMC5sQAcr5iAf4s9G1PtXNaw=;
 b=gA9ch8ngiJQcgQmDllLvtZGWXNJfH6Xm7NWXiVT8TOW91CqtC5Ikf4/WV6zOFM43r5oP
 2Lq37JKpx4CZCmBw2A5aLwBSCrcGpc5lyGe0ra0Vu6ydk7cf2eMYGJsDLqhNyqkKCZPC
 gte9e7LTOA3/r7Ez+/NixKJmxt9Rv9cnNZzODKqnf5InpOPvaEPl5MpsN4nuWd89+PQA
 m+rKzkk7ElXIzNTOGrYL5qxVJrWZ9R7NlI0vw5XMgfCoh0+okooUxpTDewZBcmB3QLlN
 rM3EUdjwuJrJLSKFT3nsnO42jl7nk7vskpZzlyz6jtfH8cYvC8MrPI9tw9bJBf8wVIpZ Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205hh4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkJ1t102670;
        Thu, 18 Nov 2021 17:50:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3ca2g0vm7r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5NaEv7ZE0rjaVnxG5L1NWdXeC0itLrgFoNY+iY2s2kPuAtR5LfvHQsVlhpwYd+Gy/VlrlkXJr2mQ2r8ucl6y2n9voulkx/0aUOgRriCKBEyJx0KD3SsnPG9UjwDoLhppw8T2ZwyhtQb9ctrK4SU4g1b7agOUA2cDrb4R2MSDqpEuoJeS/OkH/EupxgbnYJb/Q0nqo3oXbUhKi5nlgBYGZoPRP6qzX72yrcXcLemYc4Vci6WcT6GWC1OOgmpSWBw6rQPIsohKDKx/XBHxn0khvsO3XuhN7ZiGnBJy5MFLFaG3jeEeIY3Q+Ugtutc7bw5q/6R54DBPgCzWEERi+SE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLwmuQX0t0oCyvZLY71nMC5sQAcr5iAf4s9G1PtXNaw=;
 b=FBZn+KXc/x36zmsevR0P0wyEGIQMpaDkeucYbCEN9jcOWGCEUfXQcBNgt/5cAvyhuK1BKZbx7QbyRo91pcfSQEE3U5cLLob2lPBEosRHjDjW6WKRCq3obMFQNtOBqdMKK60fZAvEFYodrx9j/FvvBWwA+hv7YDRIAfl9Lt0xewBv8L2IHgKe4cMiOO62rypOmI5yhOelM+kr5rl9/+xX63Xir95aRil+eMDwjiLX3rk/fyKS/N5e3aYRFV1uELTu1UedCnC8KJ+XEn1KLbUsAhZKHUNscybw45J15JkePxnqDR5GadToYxu+CRi98YVvkrJ3of+I6rcZECOogD5xlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLwmuQX0t0oCyvZLY71nMC5sQAcr5iAf4s9G1PtXNaw=;
 b=kQ0D1oT+/d16A0eFdHjS0z0JeRNmPErGFVJuArdT7psZlnardVprr4PijwQFABbKcM+2m0Go4HZfDq4YwDRsv0s8JPHAT2TTv766k0NQVbTGhktoHwVbqg6UQzfiLAOI8IIWaxCmlnqdkqMwy2Wpi+Z4l2IZcE6fRSCF7umprbE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 17:50:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:10 +0000
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
Subject: [RFC v1 2/8] crash hp: Introduce CRASH_HOTPLUG configuration options
Date:   Thu, 18 Nov 2021 12:49:42 -0500
Message-Id: <20211118174948.37435-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf6e3e0e-7b8c-4010-7092-08d9aabbdd57
X-MS-TrafficTypeDiagnostic: MWHPR10MB1389:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1389DB6E7D0E7ABEAF05B223979B9@MWHPR10MB1389.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBXkidzn4Y9qqkPpCSfzJj1WX0sPQfef93RJ03bPHECtGP9dn2KTdhJ7oThIknbhBe7vEFU1J0bCvead3MKcvE0LjWcKpyh2HtBsoEFEXjTRf5PlpNbE9wAQV4m2moQNFAP0/egB4pxCBh0biTn/htK5RPY4NzfbjUG5cn9DruFcPHpN7AKkgYqRIGbphbgKjLCCN5Ggvtv2xMqktRMRkjN01q1hRzXpFVc0wfaRG7764sDKvH3AZ0khyfCAjfwm28c8+7nem1WCRl2WtrZaQgBu79dtSORvX6LAVeruUOHpOA56SAAk2GFjCU1brZ0rqye/jyTj4m6zJ51lt6P65iLIfedt9137L9gojYFkIa1UBh6TfFrOhzYMByYoK976odCxaG1WuJOVtO+YCec4gjhXs8gVRPPomUeruczLcq5M6em95GcxOuYe1jXHLJTmPkhvE4eMezA/JtEDGYLcaFm82RqbfhGB9RhJU5Mi3uOnnl7GfuG+mz+K+vFEqJpksZiIFFOkpcWgCybUNdDJCP2BmXSNFz0HO0uIiHpuNGZSrNZpN2C0yTno56Ehcfffh2so8RaPjh+/E2dUzWx6s9k2pXVKGkbnE+w51yZqYFNk4hxEqaYsZOwzJIXKIrKhNdtIaqUqpT9CXROKu/SD29vnDVmVVZxTElEKinNSDs/m9B5Fm8t3qGv1XTuV+yVwzZUDoyqFqB0/ByMPId8uYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38350700002)(6512007)(8676002)(38100700002)(2616005)(8936002)(6486002)(52116002)(7416002)(36756003)(316002)(26005)(6666004)(4326008)(5660300002)(956004)(86362001)(508600001)(186003)(66476007)(1076003)(6506007)(66946007)(2906002)(107886003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+r02a2cdpp6+uoq1SheSXNaJ+cH2mmnQlH41ojr/AcfIZ8IB5t7h71byIGl?=
 =?us-ascii?Q?Ubc+sGfi/it+9pE1GNKfE9o903+2P4DZe5p3Fg/s+rNBQeIeuT8eE7IvPSUZ?=
 =?us-ascii?Q?1esAWtdQZ8klnCuWlz6c5mfvfLArw+tyxep76Q18Eu4wHGW21NhIFS+aFfYH?=
 =?us-ascii?Q?zp1kSFIKc6/gtbm3w/GxbRamOjFrbvfeVkKYpHYVcGt+EWsXS/DzaBmc1n0e?=
 =?us-ascii?Q?mcEKi/usOnCnImZg3lRDLjrdYrZhUe9dRKzRiR2bHOLsBSZ4kQxDUqxntCIQ?=
 =?us-ascii?Q?RIHg8TKu04Uxyp9nnlsLfmZcbDr0dI3EqbPActrN0LXA3zZvDLBjXzoaO8P0?=
 =?us-ascii?Q?eYKwy15R+O18xdqzsIemZZK+/mrsPWiiQ5zzCVDrSgY69S+tYd+c8jqlK/Ae?=
 =?us-ascii?Q?a1c3xo9Ns2gqZCJ0ktz5b3QLVQALGKj3Xq8LHYWakQuJctcCzk2vTYgNMjyH?=
 =?us-ascii?Q?xYd4YSjHwvOQ6a6LBR70u+vCLgF+hi1E6KMS8DaLIwGxHNcffm0AwVBS3mkT?=
 =?us-ascii?Q?+cVIoKtgAhMpX8SnFs6hfi2OZSH1HjnIxKQjw2pv+CWK+RiBP+kytYkzu7FO?=
 =?us-ascii?Q?aJftIZQy0cZ0yJTLyFPVDqTeb9ixEOWVwh10kFGxSQ4BcpGOY85mJLNy+8EY?=
 =?us-ascii?Q?7yvceKeFpI8tJbMGjlXjDeJqkEUD9KMGvuK7m1lYAIm9rEPO8aIdvhUNyMLh?=
 =?us-ascii?Q?13UmK1He/duSLRMTHkDSfNkYNOUYcii07fh2utOHCY8Ke46YmtJtkSqzzNJK?=
 =?us-ascii?Q?T3dKS0ED/ick3AF7bFG/5gJs3qw3wv02P7eoCkgDHLh6JIIn+C67BS01VHsb?=
 =?us-ascii?Q?drhuJhtB4+KpZ9HvJX7cOaT3rkO7kVKn3NPFdCHw4RXlR890Q7GwVxrb7Cr/?=
 =?us-ascii?Q?6GGfeWa6nWpzQfielvyhvt6My/wiW/AM6PsP6Zl07g/5VD9t7bhjhph1KTOg?=
 =?us-ascii?Q?H5+uF9eoUQTjKSn2nIaE30EmjPLEpOnYEVDUyP7TcTVKk7s3jFjeCpWHD7LF?=
 =?us-ascii?Q?2iq6ZxKEvHZ/tr613QX4sYT7DxkK00PyY6y06HAiSoEWs5O0OHY0ZqFFrG++?=
 =?us-ascii?Q?xJx/0y7hNLGiLVU3JzYhC78fTGSDp9Z98UMjfOJp+VliP63f4WPeGJziIZpr?=
 =?us-ascii?Q?ZCDKzcyMj597VCb5211+2aPLD3dAGfUNDalcEDaeCGwsV6t1uyZkLBRoeQr2?=
 =?us-ascii?Q?EWvNKvoF6FLRfrqIFYcXK1vLs3dUQYNyovWzj1p3YxY+paXqI7WCbj03mCMd?=
 =?us-ascii?Q?piIYFIZycSkRhavJEwYBNviy1sTpA8I9fub0QFlL9RH4vJ2ybKuoXFmG6F4g?=
 =?us-ascii?Q?E9KqYcfkDZu+jcb6ZVJd3T+bzXqrZAkbPyi5+EspgXnEk0X2VX3ge1b2Kddr?=
 =?us-ascii?Q?zAHJ0DI2JEEy9qbRJhVafH2B9dajMo0JCW5Judg5IRRAv6oFx1yvW1FYPoyb?=
 =?us-ascii?Q?ZPKHOnggd6BL3FRkwGxZf8f9EaxAllVUd3K9zg1sU1l1vH3AmOVB7wfOvGX+?=
 =?us-ascii?Q?GSx1vS/EN+dCdFvttlJCSc1UndE4Vi9Q1b3+p6RUS8twOjwK1VILIqq21QD5?=
 =?us-ascii?Q?62DLbXYpDKMxw0ih54AAuXtWPkfRQvxFANlLUHiseEk+NEtMbvpO/5/6TqNq?=
 =?us-ascii?Q?vypPy1nL9LEJ5mt303muDCaDWrXOeKC4X5OiHpoJgkye1Briifksw2LYCspi?=
 =?us-ascii?Q?vt1Hxw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e3e0e-7b8c-4010-7092-08d9aabbdd57
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:10.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz+p5kue/3T6Xo23tFMXOTYupWmDXvsumLpZcPxDh7avSBjgGYzSlZVlEyxo6XU7NTpPdvcxIL0lN4BHarjFkq22a4MLN8g7+MIFLcz0sJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1389
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: V3w9cCpEWrW60x4VFdi2TS1YhS-Lj9D9
X-Proofpoint-GUID: V3w9cCpEWrW60x4VFdi2TS1YhS-Lj9D9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bulk of the support for CPU and memory hotplug support for
crash is controlled by the CRASH_HOTPLUG configuration option,
introduced by this patch.

The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
also introduced with this patch.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..5feb829adb60 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2046,6 +2046,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate hotplugging a machine
+	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
+	  with 1024 1GiB memory DIMMs).
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0


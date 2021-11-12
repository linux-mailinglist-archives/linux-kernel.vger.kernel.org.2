Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0903144E88A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhKLOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:24:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24796 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235095AbhKLOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:24:15 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACClHFp007217;
        Fri, 12 Nov 2021 14:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HAhvbV20jTDeldZZLVb92J2TRfD8JK/m77mCQvbGbDA=;
 b=dskFXSXmAIY9D6e0Il/D7pz7WfoRFuxvhFrcMSK2DOnx8XlEATnEw0Y2n4UY4BIY9Xmf
 Xs4mV3/KJwXTpTOzG7jNAV2TxYrOYJ+tJIFO7DYRfYC6AcTfBMSbL4sV8AsW0FPUYO/O
 ss99zxJ/ar0s1moPYpe1JN5e979zbfgMRCP0rV6cFxGVOl5oV61Mp2zyUO2RRYVRv1Th
 FY2w/Cg3D8v/rs3od7WfT22ppDFwJNVapgwDG5kDhnP1fl9Rdd63tpRI7DTHYLbqyLf5
 78PW/khVT3UYFiGAFZnkIRofJIE+4hBA12o71p+f9Pxk4jKW9l/1le2gdCVe382kwUQy vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c9gvs2831-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 14:21:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ACEGCpa074531;
        Fri, 12 Nov 2021 14:21:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3c5frjfpcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 14:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY5MrZ4KqxfF0uLXDyRYTxc+5oYa4w4FygU/wJpK1DWLnGNid238TUUu/0zMVCMiWtjqKkKDOYiBIcYyrwgyLbn+ZBGs2xoWkWK928MlnF7d44bynQ8WcnmrmP8ugeN9Xzu2Q/5lwBzuxB45ShtBPsf2HGDZ/udO/iJH7l1v+L4s2gE/iMuWu4Qb2krhfOS4qi56gTk9GQfwIay/Ken3XBh8wcl5nCgVxjl9VqaCu/51CZOQqX/JLbty1kqAR9FOwmhME31yVfUKTg1rYCjsRk6wZkoNEBdKpEFheCSO0blaMYHNQekCee8IgqA8lZGapkWC1bREfVSqoh6oqfHlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAhvbV20jTDeldZZLVb92J2TRfD8JK/m77mCQvbGbDA=;
 b=lLwamNwRm+OdOiq+B7ltEm+csIt5O7LvXxszFiTGURingMXa/NSDTuaYflqCj46NKg1ehgOFr3fatLxmrAknBaHLiNqCWFU1VoYHm3GEIUp/ig3Sj8+CsN2U2Rg/uZAseokJqVFihUptACS6ShRnlcuhofC7XXOtYiyW1jZaXb4h+f1RhWlTqdUxMFfJjCVTc18fnt0h6OCiVveT5vhuHkdcfUJQXIn7KVu7YZQ2pDNgYbXIeoe+r+IYqPvM3S0gkzq7X5sTlJEKWNVz4TFGWGrNrJYYlIMlACLj7eN7vK/GW99IboJ8A0eXGfafXqvtRGllPiJAshSXmxzTR/f0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAhvbV20jTDeldZZLVb92J2TRfD8JK/m77mCQvbGbDA=;
 b=M+vRFH3U2RpdCncjQWE5VkwrJ/uK9mB39Ao0fWVMSd60n4f1TbVgvCdItglftcdAzrifiRfhij7ewrZnsxlDPAyQK327l/KRTCEOt78K4F5nMtrCy0QwDHWjPgPjcZ6s9uZhTAGqki4VC1/TXaaCdOOYRWCaRRsW+tiU0dy3L4Y=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 12 Nov
 2021 14:21:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Fri, 12 Nov 2021
 14:21:17 +0000
Date:   Fri, 12 Nov 2021 17:20:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yash Shah <yash.shah@sifive.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/soc/sifive/sifive_l2_cache.c:235 sifive_l2_init() warn:
 'l2_base' not released on lines: 215.
Message-ID: <202111120519.tyEPzv0r-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 14:21:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6de2562-4507-4789-21cb-08d9a5e7b089
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5555EA23D2E2581B5431F9F08E959@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz2+HB0aWrdw/hcNVAmMgk/x0BBx1S5RCzSDTajbHTlhmLWmKdCQK7GQGESNa9Q5ZIvxT6pj+FdGfzk8ATK1dUKtVryI0gjMtJ4bC3eopD2KPiquWUovns34JGhr/td4BfxHvVl39wDi/bMrOeIHEQutQTdO76vmWbyv5y2MhD6d4+fKpNbAvSLaIWcRbnmmSqFTO4p9wG53l4KI+gcCRi2vDJqpSu9S3hJM+cJ4EMPxQ5ceoay75ARWE2M/mtd3lbyan6ikIn1j4mQd4o8p/A48gToz3qEqcnl/EnOhjfdo4GRmDAFvZUcUt/P2L5dLc1d+RGByQTqsruzgjs7dcSo5R3MN3QFE24kProfn4jZUyqtRGtn3OTltX9CnlOYMW/5vX9v4pOiz2nQgHJyYQHUzM0WX5xlCGNsVLpbLp4JJsiG8YsBvdasD58kS6KPczLjd3EFx/aBhU0cykI3uZPFZULo/BlYuLefl+3VYPnpa4qoNvL+N6IfwrNtIk36B8QxuOKAENJBlt2jlTlE4jWFY/SIW31Phesvv78a24dfIXLWt2HMu4aK4nHyGLncWC4iwxSYhuOJ6QI0wuTYXnx3VPMaFiKUg7VXxC/WVzZLnt5xHeUNUcqkjkX29ZKeDzGH2lA9+7IJJizyUJN0l3NIR6celQUK+m7IPRYqPBclWpc0HuT4eTEingmb0Gr74RKuWt5r37ayCs1Dq2PtagTD4frT9t06cnrMqrwZ5aTka4x7YxlkJUERk/T3oXi+YeVK/fG1lfq1IZq1Srg55Ggij6xWHsDwFJFbDcSH7KV/QY6vMC9JW1TBs+8dCPrxB+MIpcRN0bHPyXyiRJDnp1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(66946007)(44832011)(316002)(36756003)(38350700002)(6916009)(8936002)(966005)(8676002)(956004)(9686003)(86362001)(6666004)(4001150100001)(6486002)(52116002)(83380400001)(38100700002)(6496006)(4326008)(186003)(5660300002)(1076003)(508600001)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuhMcBqxaALoWtBzupnOGvtFZWhYQs8Qw4aFRuLi8hP0J/XdNSSP3lIJNtK+?=
 =?us-ascii?Q?WyArvvC662R68jas0ObKW4ZPQJITVSQh3nX6MA8qlXjzQuJ78LQoQmzqHjyl?=
 =?us-ascii?Q?kQ8XHyFdnlcUGK1RYKCXAs0LB/jRcI6b0chyiVwH2vmL/u0Y/+1H0fguX3Sm?=
 =?us-ascii?Q?10xIi42lK7/Kmdj+osm8afLu4QZtxztvLooDqFt8i2I7zGwgVTSOde0fE/Vt?=
 =?us-ascii?Q?Kv979bk9ai42EnpxnUZUGrNPA/lMi4iHT/9GZVMXfI0GmTxjQVC6wvg9Jm/4?=
 =?us-ascii?Q?sGqRfjuXDTW/R0iCXm6F4yijdF6ASRQlRAzs4MImpCfolE3MqkE59xrjg0TI?=
 =?us-ascii?Q?E8EYt9YoxXnD1ittcVFHni3IEru5yPc4funPPcxiPMAWMnXFgdXJxFc2lrOd?=
 =?us-ascii?Q?4Il0borCIw2QkFaMUhdwgoqhAxI7yxGyd0HQ3tz6S8J/Yfa7kyMjWcOWzjIq?=
 =?us-ascii?Q?0JiD5obUXox2dQ0PFcPLUvOPiN/fub1kh6+R9Nt+qStiMgykZSPfalLFqdId?=
 =?us-ascii?Q?gTh1kb3tR4SIEpHZP3BsqjMqystlysyLhc5NDHFR42Kbovi3Vny+Qmi49Fyo?=
 =?us-ascii?Q?K/C5hJz1HWn/shWdcW/JAlmj12ffMWcVYLytqOPBJXZ9/4Ngvfyi7cxYd6cy?=
 =?us-ascii?Q?1Kp3stRCsJw/nrMy4I+xFIVmeTiCDw0zMr2E5JfcizLD3dglAddMItjk+Mm5?=
 =?us-ascii?Q?9GvtAa5QP73GTdfPGVKkLiJJqlYIKGeoUpXVL86hNKM4w8xEUL8PKeeP2KKw?=
 =?us-ascii?Q?XnhmtqtzH7/p68QVoAHsZKsityNnMOH3cL4gphNl6jeSOCbGfI7vBVcKUfbL?=
 =?us-ascii?Q?uUG/3LRI8wDZ19qaAsYCRHEfE4f9gGn6/3bORxpAPiNfJR9+uhCl2exqGn2U?=
 =?us-ascii?Q?la9MNDsZBst5AAvCu8LEoQWwf4n4LXLLPzbuO6EwdA5q817t0LYgoDyK+mDQ?=
 =?us-ascii?Q?jqkfO5KvBeSKDE/RIYStiFxcoWglVOYo8Psmrc4ANRvyISOB+8Ww7psthOt9?=
 =?us-ascii?Q?SYNpq7oiF2z10zUzDZ7l9g1PMhiRtPHheKtwhIoYdWhbsMc3wqle8sx9lnMM?=
 =?us-ascii?Q?nrs2KrQYSGmTmx2l5npMs4FZf0q2ChhAbvZs27nySumyV8B0FvCJn9NUX7Gb?=
 =?us-ascii?Q?/gUmbiUiEznr6REE+M+sft6smtk166dHEcN+NNmqO0u7pnfLMbUi5L12N45m?=
 =?us-ascii?Q?7nr8jxdXERinnLMu+fX69YWh6JwJhT8yoaag3k5lAKF6ow4u1vqJki4Mx0FW?=
 =?us-ascii?Q?b/VmFZP4bEnn+cu72onGGy5oOjFB8xPjnTNDzUBvnPvC6Ao4C/I1z250dzbs?=
 =?us-ascii?Q?8gPlWw6aFEPDqb9+No0kRXNNsooGRJ0Kb/trwInEOZSL0mwDRW001AXEYI5G?=
 =?us-ascii?Q?ybk8EQmYv8rH9nmWioT3QxIWW5/FkgEk56JZdSc3sX0Zj/UKuOotg0usbMH5?=
 =?us-ascii?Q?K82WUGKxli0aJaO/NpbrQkvS48WoxWaSvf5u0nmgcVuc7KYyahXtQnBMO2MZ?=
 =?us-ascii?Q?chov/wKxppz8o0mgXdmcO6zFCly3feRuaS3NOFD+3psxCSr+c7e75GKenEmv?=
 =?us-ascii?Q?ywHSvvF8kfqiIR0Hl8NSTDmnVBbs2iPWTQnaOujvV652lsKVOB5MNueCIkRx?=
 =?us-ascii?Q?xHWswcsjWvBuxNncsF3xoH3wMReXp3fvrLmXQXggpVQPMRtfZ4aJZNTV+ANG?=
 =?us-ascii?Q?xgJTq69KHHnIR1A3i/lXQ6Hiw7w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6de2562-4507-4789-21cb-08d9a5e7b089
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 14:21:16.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njAmquNuzW6EUkDJUdXKN+QxaXKnOqWmIbcVBQJbvgvrxIgLnSDZT0MAfCNSvh4AIHoVMUD4+NNQusS7ga6/WDq4co3d5H8HdYVRTIaegfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120082
X-Proofpoint-GUID: gtBy6ketZxT5k2Vuv_ChqZycspzfdqCE
X-Proofpoint-ORIG-GUID: gtBy6ketZxT5k2Vuv_ChqZycspzfdqCE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   debe436e77c72fcee804fb867f275e6d31aa999c
commit: 507308b8ccc90d37b07bfca8ffe130435d6b354f RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive FU740
config: riscv-randconfig-m031-20211103 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/soc/sifive/sifive_l2_cache.c:235 sifive_l2_init() warn: 'l2_base' not released on lines: 215.

vim +/l2_base +235 drivers/soc/sifive/sifive_l2_cache.c

bf6df5dd25b744 arch/riscv/mm/sifive_l2_cache.c      Paul Walmsley 2019-10-17  195  static int __init sifive_l2_init(void)
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  196  {
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  197  	struct device_node *np;
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  198  	struct resource res;
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  199  	int i, rc, intr_num;
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  200  
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  201  	np = of_find_matching_node(NULL, sifive_l2_ids);
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  202  	if (!np)
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  203  		return -ENODEV;
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  204  
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  205  	if (of_address_to_resource(np, 0, &res))
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  206  		return -ENODEV;
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  207  
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  208  	l2_base = ioremap(res.start, resource_size(&res));
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  209  	if (!l2_base)
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  210  		return -ENOMEM;
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  211  
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  212  	intr_num = of_property_count_u32_elems(np, "interrupts");
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  213  	if (!intr_num) {
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  214  		pr_err("L2CACHE: no interrupts property\n");
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  215  		return -ENODEV;

l2_base not unmapped.

507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  216  	}
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  217  
507308b8ccc90d drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  218  	for (i = 0; i < intr_num; i++) {
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  219  		g_irq[i] = irq_of_parse_and_map(np, i);
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  220  		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  221  		if (rc) {
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  222  			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  223  			return rc;

No clean up.

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  224  		}
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  225  	}
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  226  
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  227  	l2_config_read();
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  228  
4a3a37331248d8 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  229  	l2_cache_ops.get_priv_group = l2_get_priv_group;
4a3a37331248d8 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  230  	riscv_set_cacheinfo_ops(&l2_cache_ops);
4a3a37331248d8 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  231  
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  232  #ifdef CONFIG_DEBUG_FS
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  233  	setup_sifive_debug();
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  234  #endif
a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06 @235  	return 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


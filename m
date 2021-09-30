Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A741DA32
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351068AbhI3Mtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:49:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60928 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351047AbhI3Mtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:49:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCYSqm013260;
        Thu, 30 Sep 2021 12:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Qt2SaWL+wwsCEOhEd1JC3z1KlllzMQzhcow5qi1VaP4=;
 b=eJLD2h9BaxHI6O3D7ls6UlrIIgJCB8AvvkXBSRovFPvXXZaZlumfbv1NgCYCGK6Zkd1N
 S/kA9OLtUux+9VoYCLncjg6G2/jgdsvUK4nuHD4OCwg62+KejA6JCeku4JtM7zYRPuDP
 uwRUWnT21CE9ltGu/Qeh5Knkt1TUmX3t/unVRgQXjxE4StywCrNC2nXiFFIZNE4cQx/d
 o0gmpb6qnUCBkjJ01ccO6Dcjis6TEzJyY+1P9Lo2SefXzrxkfEmjrfKbEFzqzPLD4zJy
 4jkJFFoqrNWj4RCVQvXc0Ox/lamG46K744Opmxjzvlfv9a5IJcoO1NAc62u/D0xPewaY IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hvtnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:47:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCepBH030342;
        Thu, 30 Sep 2021 12:47:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3030.oracle.com with ESMTP id 3bc3bmh6jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA4TKYR9PpadMCxi+NTBHxUbvrW5ShQJvEyY2Rwrh0nXm/IPTLrAsiTPcgm/NJ5BZUa7ultjzRTgStkgSXsfgDG1ZlYpIVp04Hq1mJaM5+6XiyYBKj81LQUV//G3nUYfHCvkz4+YuIDYgbErxAFpK32giRGJWQEcEGV51KurDLDYbmr907C+sv3KvA/hnTa/swGW9+yxg2IpKWm9U6SRuh6huhj8RbjZfs6eoZJV9vLhcYOdnkooWQfYHPOQ8jhDqz8nwqFJIxlqd/q4WimFk4PZz8/Zq0+Qeglnzw+pRLzDuw7Ma95b6VDHdSwfqFxjiccR1iQRzWH6aYpJG+9bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qt2SaWL+wwsCEOhEd1JC3z1KlllzMQzhcow5qi1VaP4=;
 b=RWG0bkCcaLmqkT1c1SWjQ5dYHjdk4+dmtdvTgWzo93GhY0smzNJoR+YddlGX+3SrwYangIlIU9w+qMQ26hC25u1FPzDuL3w9KArbyebJPoHJEOYK0zHEEmyu7R7GrKhDrViWqWAT9RKLdhytT6Uo/4hKQBJgyOm3hE8cS4p3Gn9cOyECzj7eBuVz2NVK1c0oqO+5GdWrYG496oa+DqlwL7FYyUWJeYT6VQGlfqZBDfVP58ip8Iq6JndH5n09DtbNJUOUJWmtwC/LpmAoAz7531G6muBu1Xgs02t1dExamCrb4OQnCdO6z0Y1Tu1hOIczvjHPjxheyKdLg78SnX+p8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt2SaWL+wwsCEOhEd1JC3z1KlllzMQzhcow5qi1VaP4=;
 b=EMVOaQevcmFqImdgC4veH2fNEfpXNk7ti/6ljZfqPLJ+P6WaexWE+chhIVqFVgX4MmS4/ixMOyvVUjn1zpzORFXjDrsPJDIR2w9QuiV+n3CrwkYFfaU8/VemrLR/GGpQ8GtV+Y+rPKa3JGftb3JS2x/GZxQdVVSJXAtNe+PoUW0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1488.namprd10.prod.outlook.com
 (2603:10b6:300:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 12:47:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 12:47:49 +0000
Date:   Thu, 30 Sep 2021 15:47:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yash Shah <yash.shah@sifive.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [kbuild] drivers/soc/sifive/sifive_l2_cache.c:235 sifive_l2_init()
 warn: 'l2_base' not released on lines: 215.
Message-ID: <202109302046.uPMqjGop-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: XU5ONRFAJFX26O5VFJHCGPOJQ2V7PIIG
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.159.27) by JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 12:47:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 401174a7-1e26-4a3d-e136-08d9841082ba
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1488A52F14EFBF5CC327A9688EAA9@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjc36022Bn8gxB5TxqeWYH3ozpIfyJh2k4wifzMNNc9B9dOy3NIhdWNdv8VQrype49y17Izy4BJgK1Zgy9DvpLAgvvjsy8UM9rph3nBsfv4x2+mRzoz3DmoEg6jRnR8BADVL/lJ+IwjI2V4JBHb741zChNuQx/Skn+NdEdgySp9l0M/fyOgPqJ1NA0QS14yf2v+/MyuvHJFtsGarSfJ6UQ3HzKS3ynE7oDYzotGKo++ql8DH8MjsXe3CeVyoUABIs9L3BoeJBhPsr3Jb4GXbtd5ss5b0y2Hddi1bsVeOY1hVhtUhfHQMzD21JvwEVGZ4g/J2dbfdiXEIw3ufQzanQILDUUY6gHtYP/aU7FzRXY0oYtNdAQIKidIxeADkUnTEX7AUyZLpTkVf9reYc8AfU+foWu24MyqjlY3rFNxcAqQF9wqLbRF8BmzfWiDhDtdkr7FS8e5nv987y3tSImuB4kNub33Y3uDq09uxGcX5/Ps5EYguJIW7eMAhTktdSXQ5S26x2NKLhmMdWJz2/EZQYLkofWt9Uq8UczZE0SsV4K5HEwnWkRbnqQBzFaqU8rU1ptjysbYwnQVFZEVa2uB11k0Fomjr/QbeWnPtEYxtS7Kfq85MRWnUVjRY5MyXwc+An9F6pPzTaxyvVTAY8R+jiBEC3iM4H/m5mAgUQbiIIg8BVWUMtY7qEt/3rqGpvJvpMXlGSIH1VJ5UAmyxrSL7NaeA/LHQa33HA59RWoeyVUVl7iUUos2xDHXkczpmmidY+gfV/6x/+y+BMCyeLxv/geUkVh3cMt/rovocphNgg1SyiMvE2zbmd83oybspjva6PhXg9v+ZpcMqsB4YLB8Gko1Sia2dqxvaESy4rkcCBY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(966005)(1076003)(38350700002)(8936002)(52116002)(8676002)(6916009)(6486002)(6496006)(4001150100001)(6666004)(508600001)(5001810100001)(316002)(83380400001)(38100700002)(36756003)(26005)(86362001)(66946007)(2906002)(9686003)(66476007)(4326008)(66556008)(186003)(44832011)(956004)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6YzRocZRQIqXgZAQBMdAS0nuZhFR14c4FITpB9gq0435v90ZPqTOybBg8Nu?=
 =?us-ascii?Q?OrfBMqD1n3l78Eci223/RTwSDU4D8vlw/zXyqzv/wa13BD4akyRBs+tXHjCc?=
 =?us-ascii?Q?A89d5rXSuun5Baw3Ks/HnkPbmuLP5gE7aEJTqystzR3/uKrfn1QDKMtyrS+4?=
 =?us-ascii?Q?BzTbOoBnumbrEALqOhTMiRw87PIr6tw+5MohAk8PVH+VPiXBzPQLgCpcOBdE?=
 =?us-ascii?Q?2uj8JEdT3dKBlKd0ZKNni4q/f+pd9J1oCMg79lKJ+S9jZ2mbgOrpeS9RUe9U?=
 =?us-ascii?Q?qtMXOCGgXAilRZ86U/fZvBP88ESqo3CD2Yon4WgSoHT6xMFhuPZVxGIexKmt?=
 =?us-ascii?Q?g/DzsYfUKVlhAOePdiVF02Pj0jvEXTpL0MnWJhJex0VXigCVrY7HP1koHXiD?=
 =?us-ascii?Q?mgVM55P+0A7qedIWRh1kKrAHtbD1l6FlRampuRzeanoWFMqJrZACS0ywWiut?=
 =?us-ascii?Q?Yy0Tu65yYV610fmCcxRS6YddCnLGCfWdWVlEQx75Ej/5hUL0VUiDgGyTxiTo?=
 =?us-ascii?Q?ImPO89GbNUJZNWZXwlrF5w7Pzvh6i/BMW1mw46v+qJRZ+lMuFyEzVPTtFKXt?=
 =?us-ascii?Q?2clCJ2oTJ0S+f7z1pJ/njMqGZnhKyCkkAP8v7aiC8BUV/SbaY4wgywKzk/xC?=
 =?us-ascii?Q?2GLfK94TDOIstS9V6DUypNB7Bil9hZ4DeJqie18TmGgP3ckN9z75UXSXpL/6?=
 =?us-ascii?Q?maPO2oYyyootw0jziB9HII0ifo1Cww8mwxuiblE0gUVvIHDNYiW+FMtbU2Vr?=
 =?us-ascii?Q?AEemzK6Y3xaErBN10sDpQ3oOq+pZj04/s5jLAT/5zFxEkiIzFB50RXg6oarO?=
 =?us-ascii?Q?U+jK1c3akvldn4Tf/n4poO0i/qlB//q5vT8n++fu+DYT9dGRSvwZXv+EHJKQ?=
 =?us-ascii?Q?1GzwOHTalStA9IagPHfzfx8hXbZOjHRviDCb0UDpAzZllkiVPbwB9vqcSq8S?=
 =?us-ascii?Q?m9m61CEcPeEoNwrm29TITiVW6ZkgJNTod4s37pz/LBdTVhwYJLBWtQzY0lhu?=
 =?us-ascii?Q?wK4CnsYi/rm+K1BF6GjyVRG/vtfgXAxnsNY6MTcqptgEggYL2uWfYvc8TOFK?=
 =?us-ascii?Q?ccAvSCtirQlK2TlP8d1s2ofz09stshARl8bCk8jDlokXSHopYhyXIZ/TMIJn?=
 =?us-ascii?Q?PXCCK4GiZLDj35Z6MONUt6YqwnD4maLD40ne42QDyMy1ZUj8IUPVynih90Fq?=
 =?us-ascii?Q?i54ZSgceYeXahRFXunaj05GXF4b0lee7LxfWUukUql2PoQt7L4Cg21BK8kvV?=
 =?us-ascii?Q?3OckyzRPtG2786QCIamB6nOfqUTj0bmvch8i2VavV7ZBDXEl3nU5BXdApFOE?=
 =?us-ascii?Q?rKKwWzrLCXx1XiDDZLJwCZPU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401174a7-1e26-4a3d-e136-08d9841082ba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:47:49.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow0H35elVnEyIepMSSdzlYmul8W6fahTxNOgx8eBt3EZbfwGBuaHo9ydt0y5clFmWvgoUBoTnMn20X7D9YS2jtf9fTo4/PKwMfBEhJkfzZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300080
X-Proofpoint-GUID: JH-W1DDUkh7cUOrNW6Z6L3y5iau51omf
X-Proofpoint-ORIG-GUID: JH-W1DDUkh7cUOrNW6Z6L3y5iau51omf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   02d5e016800d082058b3d3b7c3ede136cdc6ddcb
commit: 507308b8ccc90d37b07bfca8ffe130435d6b354f RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive FU740
config: riscv-randconfig-m031-20210930 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/soc/sifive/sifive_l2_cache.c:235 sifive_l2_init() warn: 'l2_base' not released on lines: 215.

vim +/l2_base +235 drivers/soc/sifive/sifive_l2_cache.c

bf6df5dd25b7440 arch/riscv/mm/sifive_l2_cache.c      Paul Walmsley 2019-10-17  195  static int __init sifive_l2_init(void)
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  196  {
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  197  	struct device_node *np;
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  198  	struct resource res;
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  199  	int i, rc, intr_num;
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  200  
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  201  	np = of_find_matching_node(NULL, sifive_l2_ids);
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  202  	if (!np)
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  203  		return -ENODEV;
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  204  
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  205  	if (of_address_to_resource(np, 0, &res))
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  206  		return -ENODEV;
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  207  
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  208  	l2_base = ioremap(res.start, resource_size(&res));
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  209  	if (!l2_base)
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  210  		return -ENOMEM;
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  211  
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  212  	intr_num = of_property_count_u32_elems(np, "interrupts");
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  213  	if (!intr_num) {
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  214  		pr_err("L2CACHE: no interrupts property\n");
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  215  		return -ENODEV;

No clean up here.  iounmap().

	rc = -ENODEV;
	goto unmap;

507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  216  	}
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  217  
507308b8ccc90d3 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-12-10  218  	for (i = 0; i < intr_num; i++) {
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  219  		g_irq[i] = irq_of_parse_and_map(np, i);
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  220  		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  221  		if (rc) {
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  222  			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  223  			return rc;

Or here.  Release the previous IRQs and iounmap().  Yes, this probably
won't boot but we may as well do it correctly because it's less hassle
than debating endlessly whenever someone runs a static checker on the
code.

	goto release_irqs;

	...

	return 0;

release_irqs:
	while (--i >= 0)
		release_irq();
unmap:
	iounmap();
	return rc;

a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  224  		}
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  225  	}
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  226  
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  227  	l2_config_read();
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  228  
4a3a37331248d85 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  229  	l2_cache_ops.get_priv_group = l2_get_priv_group;
4a3a37331248d85 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  230  	riscv_set_cacheinfo_ops(&l2_cache_ops);
4a3a37331248d85 drivers/soc/sifive/sifive_l2_cache.c Yash Shah     2020-02-20  231  
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  232  #ifdef CONFIG_DEBUG_FS
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  233  	setup_sifive_debug();
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06  234  #endif
a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah     2019-05-06 @235  	return 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org


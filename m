Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA040ABC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhINKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:34:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48696 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231863AbhINKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:34:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cq56024454;
        Tue, 14 Sep 2021 10:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+SrC3ta/CIAxZKRquxY2q9b9RT3lOWvUmDWXKCJk8Gg=;
 b=EC/XWLcaRfp2MFHjQs1SWPRv8hcBj2CvrbYGZNcBJTRw1iyvLCnWNe6pAJdK2ZiAYu1n
 qf/TZWhQJu4R/o2y8LhK5aHrLt5oCoAxitRZTN3G7usXawalihMGCq1eXNbMKrisMq4X
 ge5V0kuifZevr3KOUZdvAlUIbxY9wRv96q5l18XVHOwXP89mzEUCzyG/5IJD5vBijj6f
 3qO87ZpGSWOI+iC2OIAO5gpsiZZTQKqyeQaxQCVlm/tuZ6n6gEPbF2t2FAafjAbAZL/D
 NyGhziCzkLAo43HtEj+7mU0fpgDGcCI7dIu8VeizHLWxcfY4nE9FeBu7lDrIHX7ahdlO Bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+SrC3ta/CIAxZKRquxY2q9b9RT3lOWvUmDWXKCJk8Gg=;
 b=Yd+JnwMGKCFBIPrzPB1jj4soQPCR9QI9A/gIfNOu9HYxq1K9QYeiMObV5/kbA3+sFsWj
 hjVOhJ5w+ue3ck3AyMkCP8Qe0PpO/xjrSnCX89v8YaojR/rYA5gKZ5tSyzgjaGnQQnlP
 PxqoNwO0O0AuEJSIdtpKiS6SB8sSPhTrMYcU7A2XJBRu4ZbuXMgHdvUICDI02u+LIjXX
 Kt3g2n/oRUmrVn5PBwu3sU2oSjxU1Iat4t50MgtF+ecMYQWucEsJprvAA8FtMQ8DLFVG
 KnipmCitmc5nSAbhh4faopf5fR66AFhagu5zZe6l2B5+IimLFh4Kl2A/WOEOo7TS8IwK Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg8q15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:32:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EAVUxv071424;
        Tue, 14 Sep 2021 10:32:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3020.oracle.com with ESMTP id 3b167rv9bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOa+76GV3QberyWRvYXf3slJs8z4TC0YBGFzuPB5FxhJiaIlvGQZs/V6DWIjUWuuc+bnW2wRZjGJFs4wEg7+I9uJj4CKFujEL8tDwx9JdVNFDjjgvX7UvNWjw7Yf4hh1AwREfriUGAJIPa1HzZqD8MPop1A+VNyLWO8WDBLXxm9glhmqJlzRh/XGPWC5s4fkGiLOb++KFU3GGFnfB2J8dablNxifLRwyqlMRjI/GNhutTornpmANHPpeFfSMLcGqWVEKxb3+czK6mVNianBNCMVotghgOzHZJL3mQgUUOU5XiTlSh+Y7LeUH5/EWyAnilcLYCU9FeBZ7wMug7kad2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+SrC3ta/CIAxZKRquxY2q9b9RT3lOWvUmDWXKCJk8Gg=;
 b=Wg90PCvpMaqbqWJYKBg8XkOYinUvORkbej6/AzVNBEQGVXZ38shnpnQ+n6QEBlsj3BPNq5Jiu1daVxRIxUbir8IqkusTBFAo7nq2G5oz/V8lxvjMBMKMlBbrc30j2Y2suVgRDKbM9Id76j7H8UB9nSa1Zm7TNtYvFQnX8eTwRI5KtIxa9EEngLj1485pA/uLUpjLRG/9HTvBlzkhfoWIPU0t/hDOsyeIv4iiKZQVxdotcL10Nc8B/KMNgjPGOQ51XMZ/DLKkFtWAAQPJg7rdE8XVEOBz2EBEUHiyYN7khLGkTFddSKOA+DYVNFpC0rTyttFICxF15Kx+ERUhfoq7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SrC3ta/CIAxZKRquxY2q9b9RT3lOWvUmDWXKCJk8Gg=;
 b=uTSVX9nNY7UwCAkY5aJIysXSWVefXUENok65Wwzl2YALE69nKZdvKhiq7yFicxKRKxhOzpGx2rbjEx3eMjOiRzTBmT1RF7MaVvCArBv3OVtxAB9VRmfkBI45DF5CLUnQzIaRuPsIOa3HIMkIeputsRdTPDlyr540VHR1ANUp4wI=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 MWHPR10MB1886.namprd10.prod.outlook.com (10.175.53.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Tue, 14 Sep 2021 10:32:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 10:32:45 +0000
Date:   Tue, 14 Sep 2021 13:32:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Huang Rui <ray.huang@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rui:amd-pstate-dev-v1 5/19] drivers/cpufreq/amd-pstate.c:243
 amd_pstate_adjust_perf() error: uninitialized symbol 'amd_des_perf'.
Message-ID: <202109121824.CEpjepfT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Tue, 14 Sep 2021 10:32:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fefd063-02f1-4f52-972f-08d9776afd60
X-MS-TrafficTypeDiagnostic: MWHPR10MB1886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB188613AD7F76F505FC9187FB8EDA9@MWHPR10MB1886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xboWMboahKMizK8cLaL6UyWlca4LfMoECeuaDW5E9B5sNg6vD/r1Ugl0xdtOjVOaMthd4ls4x4r3AHMcRffDwdjMppPX1AROQGkzc4K1R4RYMJogJAeNUn3wgbGUBYxkJb/udRv5FfGbe6p/h2z3ZBxIL1pemacFQ/aGt/l6LB/lG71DboT3Pf3QM3JnunCKQo+WOG+Hcd0Aa7vnzswhiDgSVFnlJ7uEH1HQY6BiMuBPSFMDCRW/rg5klNwkWAJRuKSMp9xHoGLV2TuOpWKDbzZEKN9B8B0APlHsVAXK0/iCFGVGxYifFt031rt7n+Z3kuxNVeNJ79+D3JiS0IBsSlEVSS+qFBXnfgbmEXArfk2Abo9Hkf90TzlQDEn/9Z2Vq9p4cawipkaQKozUc68HteBvCOH1IbtLV+4wMMBTdgn73fzhzJnpMVA1NPZur2jpNMAw8bDZ6ACHg+k0pu0hC94eoynIn6IA69Cvzr61Y9mKD2T0xCCQDfBpU7ftJ1Clf/nfccLMhB+sa+Y34A0s7luen+fYbYrvQcAEwqQoG4Ea4FpSJJX6MzjO2ZaHVoOMqpKUNXg6L1pjifyvswPfdu1pg3LoB0CRvmQtW/8mpiBHPpra49eazjGcE0It8kASIYuMtgFi97WgtJC+ftHfE4n52YshidwtXGgdueAG7gt/SodcskgX9y9auIlRX2W4FTeIvCmZSqq7Fo3ur1EoMIJkwMjBjY+PiFSQH0lY+rUzeJE9w8tRgowry3KYXxNc2AwTuTqWj8uZlLKJB5yeAeayfbm5fQXuEdaBwt2ztm9giKJKelxGc+aAqPJnbrV7O3htvwt9Y57W07DGbw8bkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6496006)(1076003)(956004)(66556008)(316002)(66946007)(6916009)(2906002)(9686003)(86362001)(38100700002)(26005)(52116002)(83380400001)(36756003)(966005)(508600001)(8676002)(6666004)(44832011)(186003)(4326008)(5660300002)(8936002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSfnKENfBGHH+0twn2PifWGRwZAczOo/xr5xSvdpg1/XFwdIGvD+BtXIvnf4?=
 =?us-ascii?Q?UODQR3MTZcOtnTqW67CRlxcXkocCfHVsCzzCUcAoJKCM7abt7aE3deD3kTwL?=
 =?us-ascii?Q?hZhgDHfRmlntjOxzMxb2z/d5P2eAxm2jCMUBGR79Mead7YE3CuMgIqQARd/i?=
 =?us-ascii?Q?DlXPaBWrEOj6ONzyKvUhAfIVIliO8+EN1ycZQtWxl6DBwTIpDgOjBwfpTKQx?=
 =?us-ascii?Q?+8EjUo/Y92ks7LmF/FeyH6FB4oPxQ7mPZ+99dffp3jfjtBi1MtLAB0hgWe5H?=
 =?us-ascii?Q?bfSD988MPZslWkKBkZ1STEn9040AUjiCmRY9LL9CZxrXC+qbE1D98YkMCR16?=
 =?us-ascii?Q?60q64MXY27F7ntFAq3MH0UitfvAoL0olC2MvkWlerh2mSQPHrQ0Vfq3dWLnr?=
 =?us-ascii?Q?3jaHTNdFTJqAs49JOHWWNBw01H+teqfr8KxRQrZwfUf3/8XmP87zxPQDuOZm?=
 =?us-ascii?Q?o+MdDjuIDDl6IFQjDahR04Kue6wekWpN6yqC9GuSYErBCtErX4N0qTdiiPA1?=
 =?us-ascii?Q?zxSuEu8jxpYEkg0pz/94a1E6u+cwpiAZcAg/A6JmJMN/iIKk0T9MhyrZ1SBw?=
 =?us-ascii?Q?3gmZziR7M4UIU4Wq1kp7ftxiE5cMn79IYik4F5DOSBs+vgzNj9e1qm2iSQSw?=
 =?us-ascii?Q?SDa95SLjY370AJ+gKjXlDXHhonk8WuDNTX0yTidTT+/9mJd6u7O0zSp9zFra?=
 =?us-ascii?Q?Uoy/LfyifoQXA82FayTV0SLRWv1CP8hn9gwQ5XXiz/b7t0W+WXRIrBbWtFXv?=
 =?us-ascii?Q?IV8C96HI4P68ripNldnkFfcusSTkMwsZngiUSWQFA2rGc3rxQQmSpMRhcQ/4?=
 =?us-ascii?Q?+PeiNOuNqqixyReJoj2lehuP1Tqd9lnldtUU9fU118frIKZN931zYGL1IqVk?=
 =?us-ascii?Q?sbglToDFDhUZ9FKqsqcLWGNuwF1IyNgJqhyjERfwMKYUWpKK+AdW2hgqrV3z?=
 =?us-ascii?Q?M9YmG9VYyeNKyO4+3eaPcK3c/Bu0rTTmnNap0c2M0fZ8M/nlzI1qjEj1DlWQ?=
 =?us-ascii?Q?BexG7Bmjk+0SFCf/jtldg4fVg7RLay+81qi1XqWj9oTced6km/WpnamvNP2d?=
 =?us-ascii?Q?I59WDV/QxT6brNkFwvD80j3DU3fzgQkn0GYmCG1GIcWz0e8DxK9WyVngC6Hg?=
 =?us-ascii?Q?Me8KOlD2UeDf0yImYczB3fBKxEvxL63U5plRJdW5hKisAqD4NYUsUczQsneL?=
 =?us-ascii?Q?cdDch848djdkdtl/T/SfeZ5epsl/hYTJQXbOWUpRTg0rLzpoI6NfduZuZJGv?=
 =?us-ascii?Q?Zc4qrg+9BC/Gn1b4Ty59QogeJdO5qswwO1K12gmxjEahzD/h+wBfBeh3YvWk?=
 =?us-ascii?Q?7KIV7LTQYFBuqNzJb0qhlSRI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fefd063-02f1-4f52-972f-08d9776afd60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 10:32:45.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZG4uu186DuGn3zKTF97IjgX1gu8yeWPWKbK+nE4s+moqJi722OMS3ISoqNkc2/q8Mi3zlrnVxZImf4RGEbCdqvePtraemX33BvYPdY25ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1886
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140064
X-Proofpoint-GUID: 6V5HuUex19rhUUT1fxfIG7yFL1GDhatr
X-Proofpoint-ORIG-GUID: 6V5HuUex19rhUUT1fxfIG7yFL1GDhatr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git amd-pstate-dev-v1
head:   abfcbc164c1aa0c63d5e256854bad977a9645586
commit: 54beca4738acc38c08710cfcb1c3312755000cf6 [5/19] cpufreq: amd: add fast switch function for amd-pstate module
config: i386-randconfig-m021-20210912 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/cpufreq/amd-pstate.c:243 amd_pstate_adjust_perf() error: uninitialized symbol 'amd_des_perf'.
drivers/cpufreq/amd-pstate.c:270 amd_pstate_fast_switch() warn: should 'amd_des_perf << 10' be a 64 bit type?

Old smatch warnings:
drivers/cpufreq/amd-pstate.c:301 amd_get_max_freq() warn: should 'max_perf << 10' be a 64 bit type?
drivers/cpufreq/amd-pstate.c:342 amd_get_lowest_nonlinear_freq() warn: should 'lowest_nonlinear_perf << 10' be a 64 bit type?

vim +/amd_des_perf +243 drivers/cpufreq/amd-pstate.c

54beca4738acc3 Huang Rui 2021-08-13  215  static void amd_pstate_adjust_perf(unsigned int cpu,
54beca4738acc3 Huang Rui 2021-08-13  216  				   unsigned long min_perf,
54beca4738acc3 Huang Rui 2021-08-13  217  				   unsigned long target_perf,
54beca4738acc3 Huang Rui 2021-08-13  218  				   unsigned long capacity)
54beca4738acc3 Huang Rui 2021-08-13  219  {
54beca4738acc3 Huang Rui 2021-08-13  220  	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
54beca4738acc3 Huang Rui 2021-08-13  221  		      amd_cap_perf, lowest_nonlinear_perf;
54beca4738acc3 Huang Rui 2021-08-13  222  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
54beca4738acc3 Huang Rui 2021-08-13  223  	struct amd_cpudata *cpudata = policy->driver_data;
54beca4738acc3 Huang Rui 2021-08-13  224  
54beca4738acc3 Huang Rui 2021-08-13  225  	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
54beca4738acc3 Huang Rui 2021-08-13  226  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
54beca4738acc3 Huang Rui 2021-08-13  227  
54beca4738acc3 Huang Rui 2021-08-13  228  	if (target_perf < capacity)
54beca4738acc3 Huang Rui 2021-08-13  229  		amd_des_perf = DIV_ROUND_UP(amd_cap_perf * target_perf,
54beca4738acc3 Huang Rui 2021-08-13  230  					    capacity);

Not initialized on else path.

54beca4738acc3 Huang Rui 2021-08-13  231  
54beca4738acc3 Huang Rui 2021-08-13  232  	amd_min_perf = READ_ONCE(cpudata->highest_perf);
54beca4738acc3 Huang Rui 2021-08-13  233  	if (min_perf < capacity)
54beca4738acc3 Huang Rui 2021-08-13  234  		amd_min_perf = DIV_ROUND_UP(amd_cap_perf * min_perf, capacity);
54beca4738acc3 Huang Rui 2021-08-13  235  
54beca4738acc3 Huang Rui 2021-08-13  236  	if (amd_min_perf < lowest_nonlinear_perf)
54beca4738acc3 Huang Rui 2021-08-13  237  		amd_min_perf = lowest_nonlinear_perf;
54beca4738acc3 Huang Rui 2021-08-13  238  
54beca4738acc3 Huang Rui 2021-08-13  239  	amd_max_perf = amd_cap_perf;
54beca4738acc3 Huang Rui 2021-08-13  240  	if (amd_max_perf < amd_min_perf)
54beca4738acc3 Huang Rui 2021-08-13  241  		amd_max_perf = amd_min_perf;
54beca4738acc3 Huang Rui 2021-08-13  242  
54beca4738acc3 Huang Rui 2021-08-13 @243  	amd_des_perf = clamp_t(unsigned long, amd_des_perf,
                                                                                      ^^^^^^^^^^^^
Uninitialized.

54beca4738acc3 Huang Rui 2021-08-13  244  			       amd_min_perf, amd_max_perf);
54beca4738acc3 Huang Rui 2021-08-13  245  
54beca4738acc3 Huang Rui 2021-08-13  246  	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
54beca4738acc3 Huang Rui 2021-08-13  247  			  amd_max_perf, true);
54beca4738acc3 Huang Rui 2021-08-13  248  }
54beca4738acc3 Huang Rui 2021-08-13  249  
54beca4738acc3 Huang Rui 2021-08-13  250  static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
54beca4738acc3 Huang Rui 2021-08-13  251  					   unsigned int target_freq)
54beca4738acc3 Huang Rui 2021-08-13  252  {
54beca4738acc3 Huang Rui 2021-08-13  253  	u64 ratio;
54beca4738acc3 Huang Rui 2021-08-13  254  	struct amd_cpudata *cpudata = policy->driver_data;
54beca4738acc3 Huang Rui 2021-08-13  255  	unsigned long amd_max_perf, amd_min_perf, amd_des_perf, nominal_perf;
54beca4738acc3 Huang Rui 2021-08-13  256  
54beca4738acc3 Huang Rui 2021-08-13  257  	if (!cpudata->max_freq)
54beca4738acc3 Huang Rui 2021-08-13  258  		return -ENODEV;
54beca4738acc3 Huang Rui 2021-08-13  259  
54beca4738acc3 Huang Rui 2021-08-13  260  	amd_max_perf = READ_ONCE(cpudata->highest_perf);
54beca4738acc3 Huang Rui 2021-08-13  261  	amd_min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
54beca4738acc3 Huang Rui 2021-08-13  262  
54beca4738acc3 Huang Rui 2021-08-13  263  	amd_des_perf = DIV_ROUND_UP(target_freq * amd_max_perf,
54beca4738acc3 Huang Rui 2021-08-13  264  				    cpudata->max_freq);
54beca4738acc3 Huang Rui 2021-08-13  265  
54beca4738acc3 Huang Rui 2021-08-13  266  	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
54beca4738acc3 Huang Rui 2021-08-13  267  			  amd_max_perf, true);
54beca4738acc3 Huang Rui 2021-08-13  268  
54beca4738acc3 Huang Rui 2021-08-13  269  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
54beca4738acc3 Huang Rui 2021-08-13 @270  	ratio = div_u64(amd_des_perf << SCHED_CAPACITY_SHIFT, nominal_perf);

Should amd_des_perf be a u64?  Does that matter on 32 bit systems?

54beca4738acc3 Huang Rui 2021-08-13  271  
54beca4738acc3 Huang Rui 2021-08-13  272  	return cpudata->nominal_freq * ratio >> SCHED_CAPACITY_SHIFT;
54beca4738acc3 Huang Rui 2021-08-13  273  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


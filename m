Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A453F5D08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHXLXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:23:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27262 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235618AbhHXLXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:23:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OAWoJB030409;
        Tue, 24 Aug 2021 11:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZkDxee2mjTv3+ll1HSEz2/xpIMZ+vVSE/S38NLxpDts=;
 b=dOsxSqR9WK0S2lL7NQsoKyDrIi+vjH+Z/nVCvO4XpGa4XBVeh1Whv6qJaH8PDGP/RPdD
 HPVqHShWBfpmwkNhuUoCkWO+nAyYfmkQoQIl/kVH1TF064WjVNSH+ztJY6AMH7IQcusP
 UmlSyAkEP3R98QmrcHDzLW7sHGx+G86FpNSQQg39oWxMAxCwPD9wliog1T6EL1SLafid
 8uQfOqW/C5M6YO9/hj2FUtLHtNBpYYpNPTKwumoRIUaNkeSwan2J3p12Bny/e8XUY1jZ
 Pw9EI+I6AVanimc1AxhKEsATlv5lTFSxU0JgvrI+9QCcB7nakdBwxopfl4yv5Jfkt3jC 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ZkDxee2mjTv3+ll1HSEz2/xpIMZ+vVSE/S38NLxpDts=;
 b=eGCUJ3ncoXDZp5qLeeh4gurJRQkB/Whafaz2KmEZNrexd5yJqzvbCIg53RDw0S0jan49
 3TAIJvIx7hHDdk5PRLXJGFQj0PzgxsCA3gAjg0jvxCqRSRoJGj6LJoVfhYY9YHYUIDoV
 9MoFDi6BKGxgvWoYnVZvgtRY21fkV450Fz1c56PCScbJitS+Y6yRV9pzIhlNPkBt2CiY
 7JFVwYreLOQ/NHTFDHtS/qs6g31zQkwlrsOIzWc2ImB7ZOLy7IyYGwMQ9ua3vQ/rCJgm
 RRM+f1U9lCnUEqYIcdLyOTT1bX8eM297ZM60zrYEqK4VBRbbA5rLcDcqbMj71jZ2B2rP UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amv678jj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:22:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OBFVio023029;
        Tue, 24 Aug 2021 11:22:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3ajpkx41gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naG+1Y9kH5qbUWIzwMPp8QtBfZg1ZxnL5O2vCBuos0B3jqMNMsta9YfekV0vT/BYEOMiZ4UeHVpslaaxdI+uBTaCvrWyGEzBtebL97tAXejP97HGlj603+il4xezXeWwVLSDh4Fp4j9JvoBm5yK9gHQX/ON9mQUVhkkRuWssHNMZHxQ2VxBiuT7jdkJJRC9fmQGY/eXW4oyoz/fLB5z5X93EFOEuwYH5owV9GPcrGxaLcGb9aiw3fZYQGvz+ZEWBKS6b2ydHfh9FJV3NUq/GBKieIR0X6iIWXxoBab+o33KOofD0FAY1gJF2F79KPvTeUYLsuecUzJWBzUwaYT+R5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkDxee2mjTv3+ll1HSEz2/xpIMZ+vVSE/S38NLxpDts=;
 b=DFxmvmg4zqu6bPVVvPURdNaGVqDwC9E+F9PAXBqU/XUm2PaBF4HSAGHEoeq2bQXgoGTeKLPkHxOG5nPx3zuhOBS3Sw8+HQ9EfVwNj262PmGxbHe7RC1Q7+a5NzSnqdHEkRBkh9xsugzapuduxxFPhcUM6RrSyHlYcjQpFtKtQyWn+MwKVdeDUtt1w8cPxtWGshl1E0cKX8+rhgXJFLyzsi4SXolYzWQLi8lBMG/n4CFicMdUvjIdbfnoMo1c5KR/5ypGXZTGaETTHHczzG8lomIuZqNd5G70JqJyBGZGFI+B9GZ8Sn10wnmDKJT51GRBIi9PEczpLRWZbOpl4nq1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkDxee2mjTv3+ll1HSEz2/xpIMZ+vVSE/S38NLxpDts=;
 b=Xn573Vx8q36l3i0M58oZBkqA5C+6lteFo4BqDiT1nUikLUEvAi60BeVgCyDq4RTjumbO8prrX7luSfacTEueWGLpX57tuXq62jNaf3PhKrhhU+yD4wdpWIrFq1dYwJMLl0CAQtMaEl+puUjSOlXwEmeiE52ZOet6TpisYRwDnKs=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5410.namprd10.prod.outlook.com
 (2603:10b6:303:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 11:22:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 11:22:23 +0000
Date:   Tue, 24 Aug 2021 14:22:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Inki Dae <inki.dae@samsung.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] drivers/gpu/drm/exynos/exynos_drm_g2d.c:907
 g2d_runqueue_worker() warn: inconsistent returns '&g2d->runqueue_mutex'.
Message-ID: <202108241809.A2EmbR3X-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: CYORPQHZOOZYKBQDOKSIUJJ27EFNN6F5
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 11:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39fe3b5a-435e-4679-a184-08d966f171e8
X-MS-TrafficTypeDiagnostic: CO6PR10MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB541076836D2183ABE122B36A8EC59@CO6PR10MB5410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/hAz2i0ygN/BkpbOXBMkevjfTi1qcOu17Kn0MMdiJrUf/AbyT28ocF4GYe4heABPvigseFS4bU9huoiwtr1e4z2zQuV7uDF7RUipeRcdWgYu7DgMoQ4hKFAjQ8P50C+hBOIWWm3ACxaxXTmg77t+y9arKYlpWAMpZuQ2sBVxXu6qus/t0DVt8fUZOhHH/Zdj4Yn1cO00qJjBhfpfTgU3lZ8w1UgkLDGLg9pjwQZm74iu/qY2HxCCRJ3PGFSf0/WftsF3NxgH01OxepjwtgkhJFhz8F6HBm2pSsfoLyRfHIIPdc81q7S9Pv3RDqEz0L7LhtYQF8hl5eU/Wp4nJURRmKmUcUkAyMYR3L1WVYCCvaMt6tqo2o8wSQuLJkA7is594vCL4IrgahgGgChPzElA/8gB0YPngnHi6RnHZ05j5t+StEnMabqphhBtsWQ7z0L0FLdHzGltmHFVi7O1+sVLyK0ytIxI7OzcHEXdjry7ogLhKTP+OkuGrbbK9lepI5BBWUE/IjuS3ssCnHoBX4FSQaNuIFs2K2NgeWN8rOYiOfF+WgsAvZ8h5fxEs5/B2REWiyl0fUzpU57Bzm4TUdnd0YoAfBZriDvehJxJW7BM1sWc/POdR/v0eqzUq3p9uq4gt3n1D5ICr1KZ9jpS6xqe8Kgpu7lAVJRbRYgepsCXww4eFV+PkRTwCmKSCuIrPP6KJNqxTZuuZSSPEls7JoeAAvmw9extjU0ka6PfKD/e24VJbyOouQ21/cwGDnAk1W8xr6HNoCGM3xCUkGhgdRdH01KFdPJSfzw4Ocgk19GD79L7VIhovv0PMqljiis3K9sIagVkEtX/a4c5dMR86WOtzwT+IG2l/+WwemTu/j6l/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(186003)(38100700002)(38350700002)(956004)(83380400001)(8936002)(2906002)(8676002)(36756003)(26005)(6916009)(86362001)(1076003)(5660300002)(6496006)(6666004)(4326008)(478600001)(6486002)(66476007)(9686003)(966005)(316002)(52116002)(66556008)(66946007)(44832011)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1X4Srw994Otm4ov0p3wvUwih/XxSLpNkalZBr0dCfgD+odwtMHOxrifZjnYj?=
 =?us-ascii?Q?A1vrSZeyPxssocecQ2x2V+jiaTQx6wDXTTG1p4WLAa+H7U072z6KDNPRSXIa?=
 =?us-ascii?Q?3n9ky55i832Vr6gAIq+gf0Y1OaI4n/KhOAVUV2IE2pOKDtQtGamQxUlyPYpS?=
 =?us-ascii?Q?srRJBYZPuHIR0ABA3gV28hZVj3EHcvs+INjBiSZlOJW2djlS8oNF+W/Jv2Yf?=
 =?us-ascii?Q?b5VMXgtXeoD7w6QHhNEreJVIWNj0VEHNCAdFTjf2H3x7RbPLb1lBUgT+kISh?=
 =?us-ascii?Q?ZNf2OrRFlZ9AAGHOBtJhnkBiATfsvGZ8OrBKYehnaXz5RKoJEeaZWyvSnriD?=
 =?us-ascii?Q?Kbs62TlXNqeGUssQiwQweApSpj2yN76x/7lZS5ziILpnSO7QG4JYNN1hWaUc?=
 =?us-ascii?Q?3Ty/RtCSzmpj10xmchHRNJvpSjBDGBm0AZheLhl49kw+0pHNFVzW/rPrVYgw?=
 =?us-ascii?Q?J+SLJDE9dvJLTfqZYK69BnySzjOgZCy7tUwhRQPFU80I3D3qHKhlYuD3/zuf?=
 =?us-ascii?Q?679yaq8/dnr75dUBv1p5cny4rZajEv41T3mjpJz0gp+OlisbKuqcU51mTBex?=
 =?us-ascii?Q?TVTMFyq0gow5+xf05Ow9pUfkfOfsHowckThvo7ae5OCKunOcGcb23jb203MF?=
 =?us-ascii?Q?5CEIfl4hGb/ZzSmVeRnz2EijWafLfK/8OUIR4DyaX03ypXYwO2JPOG/PBrIF?=
 =?us-ascii?Q?lqNyRrQt8xrRISclsOScs0LvlVwEd81TosFxQ+hGCriGVq/Mlz0u5/Nd+C9t?=
 =?us-ascii?Q?RsOycVj1UDiFrdU2Pz3SLJQ9wwP8jJ99t/Ar2t3yyhX2czhGAbApwqZymaYe?=
 =?us-ascii?Q?1W3/RuDaZPGhLh4vaFuxLwSeQQJlCEU/J7RDQ2tBeH11ePevXP03CdS9Rtc8?=
 =?us-ascii?Q?MCab6ur4bS2XL579FdsmlUxy7mKVbEalt6GGns2eSuCF+7q9haqNucBqHbSx?=
 =?us-ascii?Q?foLRCcByBoBZOA3cTTatOg6+IY4UN3O83axyy5LQbDL/bB6Zmvby6Pp5j/MH?=
 =?us-ascii?Q?y1+ULkZuwldn0N0MURLOVhoGjTgvN6mBpsK8I9B/zSuvy8J4sDSmm310TbUx?=
 =?us-ascii?Q?YADCCQtpYL0nlgy/kj6CuUgjXLHj1D1yKGRCuvik9La9OY3jNj8L9mhCqhzQ?=
 =?us-ascii?Q?1wspgAY0ns2JnCuUoBfUNo3uC1RYFNpIksDeUxGNfeU7JAJ/WlakbuWCt4Ny?=
 =?us-ascii?Q?aCFtgj2H6Wl7A3V/9SNKSB3paH30COghHWLubxwl//aLhGtJjTdkWwUcDksU?=
 =?us-ascii?Q?avOIVh3xfK15hDtTN8KHh7/cCoSWf9l+yw+wnYo/6q3UoSlHUgvYfg3ikg1A?=
 =?us-ascii?Q?bAX9oK4ZQ+M7pOISn2bATv7O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fe3b5a-435e-4679-a184-08d966f171e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:22:23.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbkxX1YZ+oNnTjRFSyDbVA6BqdKpv5XeYqiHqp7CajCAAeseaEfxcpwIUQsJzv2HvNPP8LBkyfM4gJU8lqHxrMUOtg8z2crYyNxdGktwXSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240076
X-Proofpoint-ORIG-GUID: NDNpog8RUAmYxj_WxSrzIf1-1WV5xHKF
X-Proofpoint-GUID: NDNpog8RUAmYxj_WxSrzIf1-1WV5xHKF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   d5ae8d7f85b7f6f6e60f1af8ff4be52b0926fde1
commit: 445d3bed75de4082c7c7794030ac9a5b8bfde886 drm/exynos: use pm_runtime_resume_and_get()
config: openrisc-randconfig-m031-20210824 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/exynos/exynos_drm_g2d.c:907 g2d_runqueue_worker() warn: inconsistent returns '&g2d->runqueue_mutex'.

Old smatch warnings:
drivers/gpu/drm/exynos/exynos_drm_g2d.c:1237 exynos_g2d_set_cmdlist_ioctl() error: copy_from_user() 'cmdlist->data[cmdlist->last]' too small (2040 vs 4080)
(Presumably this warning is generated from a 32 bit config.  The
 cmdlist->data[] is a unsigned long, but the code in
 exynos_g2d_set_cmdlist_ioctl() assumes it's 64 bit. )

vim +907 drivers/gpu/drm/exynos/exynos_drm_g2d.c

d7f1642c90ab5eb Joonyoung Shim 2012-05-17  864  static void g2d_runqueue_worker(struct work_struct *work)
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  865  {
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  866  	struct g2d_data *g2d = container_of(work, struct g2d_data,
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  867  					    runqueue_work);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  868  	struct g2d_runqueue_node *runqueue_node;
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  869  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  870  	/*
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  871  	 * The engine is busy and the completion of the current node is going
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  872  	 * to poke the runqueue worker, so nothing to do here.
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  873  	 */
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  874  	if (test_bit(G2D_BIT_ENGINE_BUSY, &g2d->flags))
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  875  		return;
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  876  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  877  	mutex_lock(&g2d->runqueue_mutex);
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  878  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  879  	runqueue_node = g2d->runqueue_node;
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  880  	g2d->runqueue_node = NULL;
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  881  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  882  	if (runqueue_node) {
7c3fc2b5ccd6694 Tobias Jakobi  2016-09-27  883  		pm_runtime_mark_last_busy(g2d->dev);
7c3fc2b5ccd6694 Tobias Jakobi  2016-09-27  884  		pm_runtime_put_autosuspend(g2d->dev);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  885  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  886  		complete(&runqueue_node->complete);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  887  		if (runqueue_node->async)
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  888  			g2d_free_runqueue_node(g2d, runqueue_node);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  889  	}
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  890  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  891  	if (!test_bit(G2D_BIT_SUSPEND_RUNQUEUE, &g2d->flags)) {
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  892  		g2d->runqueue_node = g2d_get_runqueue_node(g2d);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  893  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  894  		if (g2d->runqueue_node) {
445d3bed75de408 Inki Dae       2021-05-25  895  			int ret;
445d3bed75de408 Inki Dae       2021-05-25  896  
445d3bed75de408 Inki Dae       2021-05-25  897  			ret = pm_runtime_resume_and_get(g2d->dev);
445d3bed75de408 Inki Dae       2021-05-25  898  			if (ret < 0) {
445d3bed75de408 Inki Dae       2021-05-25  899  				dev_err(g2d->dev, "failed to enable G2D device.\n");
445d3bed75de408 Inki Dae       2021-05-25  900  				return;

mutex_unlock(&g2d->runqueue_mutex);

445d3bed75de408 Inki Dae       2021-05-25  901  			}
445d3bed75de408 Inki Dae       2021-05-25  902  
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  903  			g2d_dma_start(g2d, g2d->runqueue_node);
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  904  		}
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  905  	}
22d6704dd4bf2c8 Tobias Jakobi  2016-09-27  906  
d7f1642c90ab5eb Joonyoung Shim 2012-05-17 @907  	mutex_unlock(&g2d->runqueue_mutex);
d7f1642c90ab5eb Joonyoung Shim 2012-05-17  908  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFE44D33D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhKKIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:35:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18086 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:35:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB7GxLd008237;
        Thu, 11 Nov 2021 08:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kXiFK2JsDgVorngDfeZnAbuCcLTcB+YnskuGIum9ltA=;
 b=Urhrkktz84B+9cibQqfOHm2GEL6fBNrsPFiJ0ZGH4/eqhgQ+ne63zpmbcZMWttjOubyo
 CI4odA17YE+wGZ2Zlw9yMqd+FtdD+v2MZnxJNbwqhQNacPQuHgwbo4If8bEijsesREio
 DcSeF66rWsTceFwIszdMKjmWFKmmlAgplVKBfm30FnUw4OA4wZ83MoI8cEOxJVouULYB
 d6WH5hMeKNcrlB1HvIbW+OjgOm+em5rR+bKeSikWHQieiV+5IVps0fJNQYR0Vi/1TiLp
 QF6YpmL4ltZfl1K0DHdFN2vb55mlE1im3gBNUGi7X67IKEmiqDro6mf33JuqMhmduAhY 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c880s0g3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 08:33:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AB8UkeD109455;
        Thu, 11 Nov 2021 08:32:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3c63fvxaay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 08:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EESG6t88CFcCzESlzLw73zDDEloazs8a7U06Zb6j59tjFPOrfiNIVu9O97DdAqOI6olej5sfU2/DaVZiKz2XcuPk42R74Bho86OEVT/zaSgJzwA7DpVPKNVbkaiyqNlhaBAoMy8PJS5QyNAPwWLpvuYVd/8aUebhmH2HdPPZmanhprCyjsU9GU1aH+R3A+DRoePBup9ErpyNppTrlqe26LD1e2VjnpqeOTsyQIcYsCPFvJqDGpauamOVkHrxk9o4/BQBrrdpSI6gxQO/YhsSyXkIYIDFks/AE0JN1axR8k4+5eIzZJt+qGYLquo4U9R+U7WkIBli84yCHDh8aG81UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXiFK2JsDgVorngDfeZnAbuCcLTcB+YnskuGIum9ltA=;
 b=HQRkkk4g7SEgnvqbaELLKRsE3u/6ZMg7Bdltx9qxpziEkrBpoOZuUCRKRXXoeZ9vLg33AmXJoIuai02Vh2ObJF1xNpwJZpwQYCjnqofGhh/vKUSpxOs1gxgb3tzP0cGb6WLjMaXQxyvAM/gy6jtoFi6wPQUSxWn9QJBXKNkDDRJ8gpEjBWfD3Rwt45MPMDjZb6XzqJUwZ1uVcxiwqw3VbgPqXkcnjdfwNhuMCIqBOoH/wLfZrJV5Dk3eZUT64QszlIRtib7fCq0LENYliCEwmbYUxjn3WyQ8bghqTy2WyIkYzhV6eAg9ZUIm7D8SbwpXXyPsRb+hV0SeuDBoQdzVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXiFK2JsDgVorngDfeZnAbuCcLTcB+YnskuGIum9ltA=;
 b=hW4qzryn0JEdr4KDdXtpRMgPBh2QlZMAIhfs4w57nz/rre9Tq9AQSC0jRrGYo/Tf4dUrhFeF5YHtumdSjc9yoNqoonuhHBPNiiceQL1WNygQXWYXpEzDCWHogJGRTatOtRTlV+YXGGY1fJ6xogN3CjpLtODEagoSupr6a3HFK7E=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 08:32:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 08:32:57 +0000
Date:   Thu, 11 Nov 2021 11:32:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jakub Kicinski <kuba@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/core/dev.c:6917 napi_disable() error: uninitialized symbol 'new'.
Message-ID: <202111110259.SiMy91ja-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Thu, 11 Nov 2021 08:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78141d6d-c268-4cce-b17a-08d9a4eddce8
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5412988D9B33DB48FC292FCF8E949@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkjZrigjIE/kuqW/RBx8ezKV0iBF6XVN0ZcZfxYVlNqHcYvbhmI8idO1e31bBD2oGjhv/vVgIPZWGQKRkacfWbInSc+nS7efvTt9dMtcYS1b7tHxDtBnX0jM2iRKBmOV26rAlmLNBlqRUSJP38HwLiHMJDZEHlhATN3UjLm9OmxWgld/ePm0lfJitRTetsdMwxnDVPvzYF73P/qcN/M4KYAoP9jqKML1GegiTMfnS/dSDRXpptYLPuE3t5TYV4lB+zIEfn2HjhFzCZ5AjtHNYnhFTh4BGn3i1oDir4jYrCupP4mEw2GA/HhS+a9Q8HHEgMmtN39XVbSm5QDoMfVMMOpa79eQFznzBC+URe6S00cbSmhb6myQHY1FmRSgZVT51G77DUBYEOVDy5kUC5aykLXQZdjFzABt0Len3FgKobdALG6PdQ2OaLMTERI34BdfL3TkZAHLUMwW+LnBPN0yuna0yaGjCFo0RFLOgyweQgtJWvn3lCqXNLUWilITSeADgP9MxGvJKUF2khGpeRye6WclbcmLN86DEvx5NlXuKcEtCKVgUU3kVrZ57lncGwpy0MHjzzaP8faKUEFtOHrX0gMpmMd38yXzlTnWbj5X5XMCIoKx6QmJJK0c0UJZVRdnWaBxlKGqaqpiasRYhaPTwVOhX70CiKRYK1dniaISXMZZdpncsiTNfRPy/lxVAYUBaO7tmGOIrQ8Kohf0E6NOdbCJqRY8j4Z03YR94RaE5rzQgmGC47o4aWh9sEvQCJPOEvkVM2ZwsFvJje4RcPoExA+TFqY2j6q3J5Moex+v8mk1UuDcfjxhRPM1Bk+dEqC7buKqFEcTukAlGR3TVgpWzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(5660300002)(186003)(26005)(6486002)(6916009)(8936002)(83380400001)(66946007)(316002)(66556008)(66476007)(36756003)(6666004)(52116002)(8676002)(6496006)(1076003)(4326008)(508600001)(44832011)(38350700002)(38100700002)(2906002)(9686003)(966005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IcifohCRW6mAJuHE3rtZzvvtet6YYvGbpAGbbrXGlVh1aMdaHA3t1Y93VH8K?=
 =?us-ascii?Q?dhfeFpgxsENiL5gJ+GurkIKzjFWdxVZYTlf043cnz1SDBneRIoJNoj+urR8e?=
 =?us-ascii?Q?empLmA7JoOvnAwFMq/2IUqnR9c0ahKc7mO0Lr1Us9lxwn/LHr9hPNTZH3+DA?=
 =?us-ascii?Q?ygsrI7hFATcj7gSYTHkHozkeGPS8n8UKtkYn/bIagrMq3hJbvQhIqOQIce4e?=
 =?us-ascii?Q?BLnb4rzFH3D9b0fZnK8+Z4T9Xt2r7IVMoI7gHwYvBWxEcEyTQZRTaf6VGZ0f?=
 =?us-ascii?Q?chrTkA6IMCSQ4FpcZe7CpGtMpXgAqDsAaCvU1vvlXTyYoQqtsmw1dDfZcNq4?=
 =?us-ascii?Q?z0Vr99JcpnlbczEYYmQ9IOhis8OAOBvSsMc4zDlvETmNj17yFZJ4jWECbYL0?=
 =?us-ascii?Q?NIvMGUKsUDr2a7yx5RARXyuM8tOyPtHR8XyCKiid548yG6z5jgfMn//sHYud?=
 =?us-ascii?Q?7M/tgvg3wsaMmOmiuclbFTUV1HpTdmCItjmJ+ruhIFj/gzYNQVCOIwSGdTYf?=
 =?us-ascii?Q?uLCRqr6pFKb2DhflvdgWoma5Qi65Gu24zVF0Zhlv1DpKaIRRI6BzWc01tWmT?=
 =?us-ascii?Q?3hFyZyQzkSmbDzj8LEPTc4vqoV65jWw94uP0LKOk/IEzs88TiNI9YzRq5+ft?=
 =?us-ascii?Q?+0TxNydc4Q0V/zBQ+kCUBT7ZwLrtZiXA3x8zG3hvOXs+vWQ9A9AAajC2pfUO?=
 =?us-ascii?Q?Uggppm1WPaKxQSDngrKY6DyfuHS6FhszW0bbkCemvvxnKT5IDv0xx/1dK4+u?=
 =?us-ascii?Q?XqsXsUXL9N/j00m5ccJDnfHWonTRPBhQqqD18ozhraVE459ZLVX7zdah77Sc?=
 =?us-ascii?Q?5DhaQhstIIXw5Lcv7YSwiRHAwncSP0LpY3dy0CHqTMv0IAcy5W+xqAKiLnnp?=
 =?us-ascii?Q?EAuDCZUPxsP3z2jMJW+5VmDi4i5Itc67CcNnbAzd5XcV4tmFTDlZ5w6HDPHr?=
 =?us-ascii?Q?nMu2h6vly/pSlUmCoo7rdiGuRjhn1tCopPNzf0vOAMz8LNlfs08oba6VA9ca?=
 =?us-ascii?Q?Ldajv7fHIOsn3VEtGOT9k2Bv9y02F/1QMWCbTxfddWQU1uWDIeJxvmBbR8jO?=
 =?us-ascii?Q?bBICa/x1fO5LxMEDjq6HDcpKDI4fRLq4DlDcV2Ot0IaImGyMMlhUOkofUJn3?=
 =?us-ascii?Q?Oh323a9A4ajeDwlW+Jke8sK3A2Ki/HFRsJVfcngi5DlJkN8TpZrIOsRoDsug?=
 =?us-ascii?Q?ut82ZClXD3iIJ4fmTaX7vInnxP2FkDmXH2E89SKFV/AisAacliQVAyWXhyBJ?=
 =?us-ascii?Q?HHoUcxtt571Bx6m0fYUdWTcLBnXn9SOO8vNa/TUsa/zG1H2xeOLxV12fAZjq?=
 =?us-ascii?Q?wC0yEGt5Xto7uT/b/baIDmaCkBIOfclZ0EkBW02rn/Jw9AA1Y20KoUhhEgAR?=
 =?us-ascii?Q?+wxW8pkKeGykkMKMlgBoXSBySqETp5WBWH7SZgP5pKck3s4oLCUgw5/YW3Z8?=
 =?us-ascii?Q?VJJXmuvi5n/j3uTEViAwue/d3STgeaYIYr80GhgFcehN1bn+yoc8pRKNgZtq?=
 =?us-ascii?Q?c/7QYqFNMR4n2kqw5IgOhrOWCBnilkPMTCTATiNo2KqJrL8nBEX/MMAYU9Qj?=
 =?us-ascii?Q?yVHIF5vT+b+7BHKYTBPh+syvrjczHnx7RRpPGlBjTIlKQ0amS3YIKhJOxb8+?=
 =?us-ascii?Q?QEboiF1MSyNhIlXLwPEQ4G2OKwVHhFNSoINkCQzQ7aMb5XTHd1WGv/DsGK4J?=
 =?us-ascii?Q?uBYb4cG9rBreC7Shyp+0vlh5AHw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78141d6d-c268-4cce-b17a-08d9a4eddce8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 08:32:57.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyHuAq06gHbFvr2uVR1W5bg9+HAHkW8t3wc5yJ6jVKuCEX1bfjO/9rd222+jU+GhfVOWd+z1aUS+ygtX9pmMUzLE3dmZxOPzFOz5rt9uqXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110050
X-Proofpoint-GUID: jrXvcxPH5ZfiDJIn-2dvV05mW6OWIemj
X-Proofpoint-ORIG-GUID: jrXvcxPH5ZfiDJIn-2dvV05mW6OWIemj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub, could you change the netdev patchwork bot to include the Link:
tag so I can look up the thread for this with b4?  The LKP robot sets
the In-Reply-To header when it pulls the patch from a thread.  In this
case, it's pulling it from a git tree but it could be modified to use
the Link tag as well if it doesn't already.

I don't know how we would handle patches with multiple Link: tags,
though.  I guess it's supposed to be in chronological order so the last
lore.kernel.org tag is the correct one?

regards,
dan carpenter

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb690f5238d71f543f4ce874aa59237cf53a877c
commit: 719c571970109b0d0af24745d31b202affc9365f net: make napi_disable() symmetric with enable
config: i386-randconfig-m021-20210928 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/core/dev.c:6917 napi_disable() error: uninitialized symbol 'new'.

vim +/new +6917 net/core/dev.c

3b47d30396bae4 Eric Dumazet   2014-11-06  6901  void napi_disable(struct napi_struct *n)
3b47d30396bae4 Eric Dumazet   2014-11-06  6902  {
719c571970109b Jakub Kicinski 2021-09-24  6903  	unsigned long val, new;
719c571970109b Jakub Kicinski 2021-09-24  6904  
3b47d30396bae4 Eric Dumazet   2014-11-06  6905  	might_sleep();
3b47d30396bae4 Eric Dumazet   2014-11-06  6906  	set_bit(NAPI_STATE_DISABLE, &n->state);
3b47d30396bae4 Eric Dumazet   2014-11-06  6907  
719c571970109b Jakub Kicinski 2021-09-24  6908  	do {
719c571970109b Jakub Kicinski 2021-09-24  6909  		val = READ_ONCE(n->state);
719c571970109b Jakub Kicinski 2021-09-24  6910  		if (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
719c571970109b Jakub Kicinski 2021-09-24  6911  			usleep_range(20, 200);
719c571970109b Jakub Kicinski 2021-09-24  6912  			continue;

Can we hit this continue on the first iteration through the loop?

719c571970109b Jakub Kicinski 2021-09-24  6913  		}
719c571970109b Jakub Kicinski 2021-09-24  6914  
719c571970109b Jakub Kicinski 2021-09-24  6915  		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
719c571970109b Jakub Kicinski 2021-09-24  6916  		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
719c571970109b Jakub Kicinski 2021-09-24 @6917  	} while (cmpxchg(&n->state, val, new) != val);
                                                                                         ^^^
Warning.

3b47d30396bae4 Eric Dumazet   2014-11-06  6918  
3b47d30396bae4 Eric Dumazet   2014-11-06  6919  	hrtimer_cancel(&n->timer);
3b47d30396bae4 Eric Dumazet   2014-11-06  6920  
3b47d30396bae4 Eric Dumazet   2014-11-06  6921  	clear_bit(NAPI_STATE_DISABLE, &n->state);
3b47d30396bae4 Eric Dumazet   2014-11-06  6922  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


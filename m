Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2645D521
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353360AbhKYHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25396 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352620AbhKYHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:51 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6Ekn7011267;
        Thu, 25 Nov 2021 07:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hfgdCk8FcfhLExq4eeVT2WLy75N3rKlprxVxOgJmDD4=;
 b=ZRLyZc9NpPWZJf2y5TYP+XPGByvdCU5BoISjj7Im1twiAnJ7cC/FlJ9XZ9Sp0Tr45DS6
 o+iLyVoHHjcsFd+8gjDtR5s+sPSa27Si8hNpuBrM7VGQ/wJvI6nKCAppQbLfq0+EVxqJ
 9r760oTb5oDxKuHKza45pOivq5q9BuInMksmxxVREow6Rpfo7M+Aj4+9ocLGeAaWIm49
 UlJiDpSNVH9oBJ/9PTWGk8RTl02lERtfxSikJ0DrksTHXTBt2MdI27XDRI5EwmvFCFft
 vdaJBFRai/5cL1bvUmy46/0VjBta/NzUxn8fcYcIcUP0mznqaKhr71cg+VHwq8eMLiVU tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chpeevmk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:05:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6pQ71075874;
        Thu, 25 Nov 2021 07:05:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3ceru87u35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbGMwR+rREwQ0/Oumfl1BdidNQV4H6Bp9kqh0vWajFRUTaUmnu/rzWRRF+U7hUVrDhyGfnxb+hIWOrZLG5Jk4cdlNidDaBviLZVDoQ3/xdNQ/YCtTNeGBUX2dhVHvjzgE1X+fI5rSqggqR6+B3d9wqKpeCPQ/G8yQZ8TgVNg4SmI/iQPi1Fhx9/UNUQVdFsEWA3LsVqsAzutVywZ0Gx3ScBDiV3D3xj6bq84Kuj2BfaqUI1KzoAxO23dpco42CsevWnAbkh1X60sdrjkd2Ey3Uuh6hpp0iRKh0J83+nLQeamDsIhKkC28iWohb2brWaxO2/IERGUPUddrXqwxdKkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfgdCk8FcfhLExq4eeVT2WLy75N3rKlprxVxOgJmDD4=;
 b=NzIWU1rLiNVzGpN7tP5BRMydhGnYBcZpqwglUFT9of2AZYfgJN9/8pbFTSffqgfAVGCS7anssyY402WvOZVKUTbCSCax53t2EYxI6WSxqO5wfPR0vtKE0ufDr5Hvzc/1DHdjexIREIdNepdaBHfDFEU0C3jeKewYOQraGgV8JNdhyqTCwu3zytML1WtKikHtsZe+QsSbngvGKomOFllAHBExS2LUG06kfVn33iG2ddv2qw/GdI0IonlDl6hL8rMoiksqOWVMrG/R3ck3XzTasHiRqEQ3DrMMEbpja1OKKYub1GCgIGOS5PJK7zBfr01gTApZkyeqpdb3sya8uwcfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfgdCk8FcfhLExq4eeVT2WLy75N3rKlprxVxOgJmDD4=;
 b=buTU9ePQq0q6wThnEbbRG7Cbpxz70wEjWxXAjns5mtAxlc+GHkSfdhVk0Ibk/IY+yeFXERgPZlXrY70M0+fv39j4h/KjT1QIBx3HOAe+bfQfspa4MA2EvQiqURMrj825sDNc/HgsxoeT4wENAitm12kDojhrOrW8z6LlwZFiQx8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5667.namprd10.prod.outlook.com
 (2603:10b6:303:19c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 07:05:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 07:05:32 +0000
Date:   Thu, 25 Nov 2021 10:05:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use kfree_skb()
 here instead of kfree(skb)
Message-ID: <202111250652.KJ5iJFpx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Thu, 25 Nov 2021 07:05:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b8c9f4-de1e-408d-48f3-08d9afe1f8d9
X-MS-TrafficTypeDiagnostic: MW5PR10MB5667:
X-Microsoft-Antispam-PRVS: <MW5PR10MB566719A7C5BC114C62DD4A7D8E629@MW5PR10MB5667.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttK/LHVhd+hLmzFc7ee4k6aBPcDxn3Cr5IfRgPsM7vw5NK1q7BR3cGMaoeiLwPHCyxpqNiC5uAgTxsdZ62zu4/n39GwKxCxzOonU8CoAOs/ghjJ8OkC5kaKhP4lCnXyP/HgUvqpg+9RJLOYUpwmVROm4SSl8eV9CZAdZERBQ7CSFbBe0eoaOix/rOnU+Kxu2nHdiaGhcpkzpjVfZlYbFj3oXflGpVGEUqTrEEbTsKQTEUb/aAX8Quzdz4R14lqez0BovwUM94jP70oE8hYLy82HcwnbYAs9A/X6jtV89nd7dDTsDoFn1WkQEaaAQpen+fBArsYDPwFnuTn6aBLorGIwAxz7DVjydC210NggaSEof1W38IxL8uT7i6RHeSobYNya7FjLGlc+hq0BY2z2uhTkn+Rcvs3DLaOYrvF2AkLKf1RKMm2ScTpjvT/36hJLlecSlxETj8BtwN13fUvTNvWTd4+d5kDRwV/r+hFvjt0nFLLE5tlqPJylTtHgbNNotWBENKUMMLROjwMylvnW6ykrqKwG4zC8AzRObbaBOsHtTSISExINjFxVHwetU0xJEW73p+X3BFYXxK+5my0uIp9KrIhKBmo68h5S7qYFMP4gygStU6EFv1owN6/sWvXeTS6vaYAS5+JoO1pFDOyJhdSqJOlGoH68R3OWBVBgCQICD27mZz7dQqoZZzcwM6ta6nwHdvOEk72C6pz2UblQt9l2qsU5o+WELpb7nYhITEB3P6SkMKGU9MHKulClJjtexX0rlupcZfrITxCpDPDF6XDp37X1mv5rVlMZRcVvKrcK9ZZ176KKbldm2akhGYIBedNhfPV95KMDhxq7w3JD3/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(956004)(66476007)(2906002)(508600001)(86362001)(6916009)(4326008)(6666004)(6496006)(8676002)(26005)(316002)(6486002)(66556008)(36756003)(83380400001)(9686003)(52116002)(44832011)(966005)(5660300002)(186003)(38350700002)(66946007)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbvQFqffN7gJFtvbsCr9WFfNE0bw0EMvVpLJWN0VIncY2SmlJ0iBDJP6sXcn?=
 =?us-ascii?Q?TTHnlrNGfq7JUH11cecGab9b1EWFhVJsos2CYEGOFFkAvcN8cmgf1uI3z4oT?=
 =?us-ascii?Q?WjoIc9HTv3lrxs0AVcSm3VTHGxs+UPS7G83hKzkVhiKCou4aOQ5NeltX9hri?=
 =?us-ascii?Q?2HJR5VpDL/6I+OVNza1AIrLLV8h/y+Hm0d1a10WPcNyinNEBD3sp1s67eWPg?=
 =?us-ascii?Q?xj7OsMyhCZ4pY5hNn0Nstal4C9ZniguFlqDt2j4WiMGOAuuvPd2w+k4ASzu5?=
 =?us-ascii?Q?VTrhKoLUgetvHALubILF4igtFWNphnjUeBQFBidH6+r5mhULeRdV9nWvowEE?=
 =?us-ascii?Q?W5VpDaSfkPcHi7w1dbZq6/3w4nPOAY6dWPsJdfxZB5iycQy+fA7yZwYMV23L?=
 =?us-ascii?Q?vC9BPH+L4AZe3QI/rvW5Jd3iDhLtgPi6BYQuQ2QTJsRag5cMXzjvftqwL/1k?=
 =?us-ascii?Q?HOLfHmX0Ks15fi++J+LGCP3OeygW+ruhzmyKjp6GRSGTLj/O41w/ck+qW5/l?=
 =?us-ascii?Q?5NgInL2OozGKry3t7glEQfG2fd137ls22f4vx9DHX7z0VNaCK7S4fLuQWl+b?=
 =?us-ascii?Q?IyNvBiDWuCmmLYDGqdyays0fu/Y/DvwQ+KVpje1JdGqpZY0n9z7k02oftrUo?=
 =?us-ascii?Q?VFQaK12GPdo/ZcoadkFCrVU3/uotHiYzmBuePLUbASx3W9fCEXmL/dcFayDd?=
 =?us-ascii?Q?zaMfS2G30wC0xglIiMVy2n+XWhxp00TgJMjXoxG+8onqESKd/ZffDqUSFVyu?=
 =?us-ascii?Q?mWHv6AZPTApFPznh9p6F1EljY5aVMFOM57urv6UEFVVvkTvUSMz2diC9OqDB?=
 =?us-ascii?Q?ruFVJLcsXZaaVS/mnjxAyIoW6tF+R5JyoTfwmptqdzyDYHpMZeGoKc0T9fp4?=
 =?us-ascii?Q?tg91K/wzoc+heasByj4JWSd7f8Ugo0UT4hsb5RfxMQrzVdALi3eT3G+qVq8o?=
 =?us-ascii?Q?3Z2N1wx4wZjgsFti1Iq6/lLZOAIJEyiWoehX5fLMssMRthU5x1aJ7AWdH62+?=
 =?us-ascii?Q?AoXyK8D9l+wTzgQYH02rng0I7p5acVucbOZXTD0qUKRCAKf0R679lylU3dBk?=
 =?us-ascii?Q?GK821GTPNZr/KGxGHswwXXKAz7VcvCEVfgxbbKb7docyxfINS0ryPzj6LMld?=
 =?us-ascii?Q?RwExe0+UV53SO1NXpU1sdGoLryE7+K0/PPnetJuIg/KLYfyQzzsidc5Mpsft?=
 =?us-ascii?Q?0kTs0EjtbSQ2/VmTI7sJ/al5rcHeYZhi4CUroEVYWUX6lEzDG4zO+AQqC8Bv?=
 =?us-ascii?Q?CROyD7wJ1UgYSVUJbOt5MAgORY11Z0IDzvTKw5Lp8Vj03jKY9Qmw+xWEmxGz?=
 =?us-ascii?Q?K8H/XJa0949ol+8Hg+S6GoE+NiyueYcAxuWMu+1AbbjrRrsZWLpdSAQyjxcv?=
 =?us-ascii?Q?2AqQlBEE7swuB3ZPxYMwx7p9Shve7AQw2giuo24XP3yM5IPovcV39Hsbol2i?=
 =?us-ascii?Q?HlUjdWVBS0AbCVLsvkxi9U1jOoaZtkbkI3yC114SZcaIZri645eBBm31m3hO?=
 =?us-ascii?Q?LBTjii8NQPj4l18mlPFtfMqdDWv9tCnYvciu3lBbeqnhf3RK34jLQrXbiuvg?=
 =?us-ascii?Q?lGyWzxmI0AdGj0E6sGdV9VYm62K0+6FxtTv1PfvQcrV1U74F28urUR4SfaA5?=
 =?us-ascii?Q?4iwGniN7TZSawxPdpEJrpzGy2znylmfKtH+mhbLYRVqQsn1pUg+XP9C90uHF?=
 =?us-ascii?Q?ruJ3PZuZtCz3H9hUjftKuw9WSIM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b8c9f4-de1e-408d-48f3-08d9afe1f8d9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:05:32.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCV5apR4ZF752wMy3kGMPNHNuE511Ug+IKiGzdn9TU1h558P0EAU6GVmIXZGOH874mDA8xYd5Fvc4G9+/14FIxMo5eETUD5h2tD706+rKqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250038
X-Proofpoint-GUID: 9IWjfgI3Rb1zPgA4TRXSsj95Gz5M9Awz
X-Proofpoint-ORIG-GUID: 9IWjfgI3Rb1zPgA4TRXSsj95Gz5M9Awz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: ded21b72299529cc143a4213ea0ec4b0c620b8eb mctp: Add test utils
config: x86_64-randconfig-m001-20211122 (https://download.01.org/0day-ci/archive/20211125/202111250652.KJ5iJFpx-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use kfree_skb() here instead of kfree(skb)

vim +15 net/mctp/test/utils.c

ded21b72299529c Jeremy Kerr 2021-10-03  12  static netdev_tx_t mctp_test_dev_tx(struct sk_buff *skb,
ded21b72299529c Jeremy Kerr 2021-10-03  13  				    struct net_device *ndev)
ded21b72299529c Jeremy Kerr 2021-10-03  14  {
ded21b72299529c Jeremy Kerr 2021-10-03 @15  	kfree(skb);

This should be kfree_skb(skb);

ded21b72299529c Jeremy Kerr 2021-10-03  16  	return NETDEV_TX_OK;
ded21b72299529c Jeremy Kerr 2021-10-03  17  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


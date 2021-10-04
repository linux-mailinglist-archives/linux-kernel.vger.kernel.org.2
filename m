Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9A4206F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJDIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:03:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36384 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhJDIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:03:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1947Tip9018657;
        Mon, 4 Oct 2021 08:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Vg3VR62zw6VIq7fwQClnVIX0X62wep2O6jN0h8gyBn0=;
 b=mINwZov2oUdu/v4TMzUTaqe7Hu+hNJCiiqBzKdgxZ+1KYQll5pT9Xte4V+e+z2bh69Kg
 TljSeiy4OHK4aAiQzjftt/f7rbkoHeBusHekIdD7fE+0tAp8ubla9VM6GUBhh4Zt2Yj+
 tOMY7q8E3mqPkGV2xbHMkdyC7DleL0kmWeeBuF+eI5J/uO7GjpZvz96dxL8G2dO2yQab
 VVN4LdaapvOrQhpCYY7DBtYG0rFbIklIbg+G+N+VmAARztspCZJ2KoQJDJZ2QXHs8R4C
 LpuOoFXxskJWHjnU51Afiq7pdXIvr5CxKVNdTLU6ilKgfvyjWTKCFs1w8VnUlBq6GBo5 UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bf9m02hyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 08:01:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1947xrB9015142;
        Mon, 4 Oct 2021 08:01:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 3bev7rau97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 08:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly4kjeDJ0U2zZh09WsUQWnOuurdRdhOjypfW1baKFj+0cLV1lKXBbquD9ElmIpaApyDy2jLG3U/+Xls52ZLqFrxci0z+8RrA/Jzejc2KHIvI4VbtpyQZvpHkXZRQ04s8Pn24AErzqGtsyTFzidbEL76SyV8iKXmnfVq5CZAqoCJ8IFfgviqErboEyHoUy6/fywaDNkUVwDF6oMOtuppH4a2eUTB3r0TYSHycv4i5OVEj+6RKS/xwrT0o6nfiXU8HPvHfBMs2P4nsuIUfd/U0UsDHvJVh9YtrcnKOqSUx9wBmcfUE5p6Xlg9E38Ae3NQEX5lK5zsEuoeE62+3RdUSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg3VR62zw6VIq7fwQClnVIX0X62wep2O6jN0h8gyBn0=;
 b=Qe3lG8OhVytf1S2ohrpC4ctKdCeuG9sM+bMXPAstCLjHEG+te2cur+s/djLN2H04znKuS+vGu75JnscHaWbHuhhH6jYDSlbDqBkm2d/kldCUilgFugLW+BxHF4c6QqPrd+LJrfhxcu3hxPE3OdwUFCpZTudptkOgBqVzGthDowcJkpTMzOyBVXx4ICmuUpfmER8Go1aeR4okXv7ykAbn+O1N2fqUpMlgk9LspO0Jb8VDYKc7WGwyd0ktgn58NhXkKBCgCOQC9Gndvn+UpY4N6OPNmzRHrcGlv0EkGIKC3kKcOK42o4L6Bale2b8zYa+KJqduRThmxPjJbZOUNR2DTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg3VR62zw6VIq7fwQClnVIX0X62wep2O6jN0h8gyBn0=;
 b=puJLtnkopZ+q9z0ns+QBAbNxx3aqkWGf1v2smQ0YF7XIOF97PJTSAwvsRG6MR/J7h/EiisRdq5KkaR33l0WUwVnu4JWTIEDOq/GtSRcHerNTp5tfwxFuKXNzkaqUky8lEoS9LHFJ7nX8GbyigK/7DtYJVGMva7IESgaRFQ/8eX8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1358.namprd10.prod.outlook.com
 (2603:10b6:300:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 08:01:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 08:01:38 +0000
Date:   Mon, 4 Oct 2021 11:01:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Palmer <daniel@0x0f.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 41/62]
 drivers/pinctrl/mstar/pinctrl-mstar.c:88 mstar_pinctrl_parse_groups() error:
 uninitialized symbol 'ret'.
Message-ID: <202110021827.APd0FQbV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Mon, 4 Oct 2021 08:01:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4424f3e-7808-4a36-499b-08d9870d3167
X-MS-TrafficTypeDiagnostic: MWHPR10MB1358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB135819EEA8D95D6186AF17908EAE9@MWHPR10MB1358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHK9jK5+Vy58BcFjTxuElT6ngVXPt6H6Vyj4OrTwIjHHKWCQFP3Yi16sg1owEnAkvIBkI4sNuOPNi/tsUI0onvywuiPssYR8MOkl+n+rzQw2pjSA9BfsAQh4/czXZbnDgwCq2qq1XXSTfCZjhEd9V+Wq8y+senMq1LN2v3iCURi7P7quAR/rJQsVcFFeIfH1YX5WGDjHyew9adkbbe4Wjz/ADoWUrJ7je4S71TxBlrKBobs4A13KCwEWw+UH+WvHqxeF2G4YiJLsuE4qEB3StVAS6Ut5DrhVDy1VhSz4/JabzWL/8aFI2jrSXrGieYJIeXmtGQoO2D56P2JMlUHvtNDLlBMLK9JNj+Yl0jLrFh1qngxVVlRnTHnyiDEQ+YGvkO3SO5grjiPP2fecRM6n/4Ps4tLFfcuVA3otYvCyIV05KjpOnA7x4wuiyqM0OfLXnr3GrPqDCXdEOQa2DXYRcUVarxp3dib6+YayJT+m7mrV9s6XN5Ov82QNEI9+1Xs/rmpVoGyc5aYZ5JZb2fDlJsMiD4ToznpK05+ItZJ0q37kCpjby9gnAcfKHvjxynHAb8Hk4zgPI/SYRAMgwF6VvW6UxikT0hjPWFMSY8GGyBcxRDvuz5TFs1ZxhasNLueyU0WlhE7mwrpNtFkGxdgBi0KzfUWWv0ERFIL/7nRJHX3p5wzBfdsQnS+yvT3o9BzDaM7u39+nKVYsM1qucnqyKZ0zll5iHs6XYiHlUl1zfAoutYLbPAMYhAGmRxA5Q3x49/Mi5JHslQo6LzCcGrxBUW5KM5Bm2xKEAHvJmqXNeiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(966005)(6666004)(1076003)(508600001)(5660300002)(36756003)(52116002)(83380400001)(26005)(6486002)(66946007)(66556008)(956004)(4326008)(6916009)(6496006)(186003)(9686003)(38350700002)(8676002)(38100700002)(44832011)(2906002)(66476007)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5R6rA1WnAxMn7K3eYlaEmvbvUsmGYEDe5fpOubz3v+FiSAJ3SrNqI/xZAGb?=
 =?us-ascii?Q?N+ksMB2lHdWY2zqvzwZjM3UjQ8OpXAVdOWxH9E5tfwbm6ohzK2FCQoTaNvi8?=
 =?us-ascii?Q?9//C+BR+jJw38Uc/U5QNP+ykyCPdxBEQBOvnwe1cbZucjgodiRqF8fFYF4oM?=
 =?us-ascii?Q?kGkllPClKDht9rkM7hClfYawXwuOuNfszMGHQCq6gNQX85JmHuz2JenS8BxR?=
 =?us-ascii?Q?jKRr0I1TUgWEJd4XTuRwsHBu3YW1Oqa4zFQ8+Sij6i9J/3WKYyZ7bWcj4DRc?=
 =?us-ascii?Q?a/4UMHDCxk67V4vnq6gOkj37g6TI6dYV+GaYRNtcSHTw1y8YIqIVeT5VtTVs?=
 =?us-ascii?Q?bxgJQjGmSA1tkP0Qti1yNvCaXLmyJol5mGC/ohjyhk65J25MG8dG3APJy3h4?=
 =?us-ascii?Q?vxt61UtglgDKIYtqpJEcjc3J2bhT8pRos259/ubGrynyhgymjLJyBZ8leeBM?=
 =?us-ascii?Q?XyJFDF0S7jHsM2hs10BI5nxaLlTsHRHybaRW6+Wqj3axKfvXzY9WSNW0xKfm?=
 =?us-ascii?Q?pPjarojQc/qbVv0bvWRMbrL5qCsRECZDGIeiiyaH4c+pZ6xexIjU+RmU3K7q?=
 =?us-ascii?Q?A0GLLwY00e10lAC+zr3mcGTekYrtrVlifXxG3OQkqBsgf3GYJ3U5Igz7qV1X?=
 =?us-ascii?Q?Qh7aLUtgI1B4NCnwjgAgUzbyR7FZ8PWBOy0U2yJhHpGsFpov5fYi6dW3C/YM?=
 =?us-ascii?Q?b6RpQYbeKyiPpLg3fB+Z5TNfNB9CQBZoYlx6VDqsPZWByVnjrVtCK+EIESTy?=
 =?us-ascii?Q?Uqd3GkII61N0CDtMOYLOBMkKxWW02h0m6uUi+TmurZAtX84bi+aQzXf8HqVK?=
 =?us-ascii?Q?m9LDOh+BWFhrDu2bBbtNMVMyJM9V5RMEJSyXcyw3Zq3WL1UT7ccSObprWTVW?=
 =?us-ascii?Q?5dc8tbHpzEiwFxeCMwIi+T6W2YUM6/tIToq8C1JVqiGbRO/1G6PxqDPDIRwq?=
 =?us-ascii?Q?3zaH1gPTYyw8rcmfswYJ2K7XREMJfLDMA1Wau5Qid4V1+dpPGoUBJvDuNLjF?=
 =?us-ascii?Q?pxJQOa7FJW+CAv4HfZYx2Av2WkoVEO5ksIDtD2evBZ4jbcp5LzJGkO7wYxDb?=
 =?us-ascii?Q?co1AcFi/bdPPOHAJJE5fDTBq+VOonlihiFhPAoP0RYooBErbszkVau+9A4mH?=
 =?us-ascii?Q?7+rWk1Kv6BG8R8cWm1Mm3vCz06yOg01t62kKwsJe0j1mrS27ArLt5skQH06A?=
 =?us-ascii?Q?UCp4uOV6bQ5ry0h9mXYJaL36QyHj0zTaRBimS6TAe9NjT1JD/lLg9/+rf1Wc?=
 =?us-ascii?Q?dckxog9Y8iy0RXyOKQuerTXfhulS7bA4Qu+oXzuVmdrbfkZev87MWos37W2z?=
 =?us-ascii?Q?TrdgQJ27hrwQx2zkW5xNjs3Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4424f3e-7808-4a36-499b-08d9870d3167
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 08:01:38.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjCY+gtmBN1SriEnF04xEOaLQpY17LI+8BtDMj1VLssjvqaKNiDNXCffA/MCzfTNTeCZDgzlQqDvCiPQcRtphkl7ezG04R2ptuoKB1inbMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040056
X-Proofpoint-ORIG-GUID: wW9VhxeKov1PA7Msw_Ae0fXRThX-8J99
X-Proofpoint-GUID: wW9VhxeKov1PA7Msw_Ae0fXRThX-8J99
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   1b2db4b2c68fdb4acc386166e82a28dfbc808705
commit: c4c8b6c55a5a3880c67510369fd6c3bebe11d1f3 [41/62] pinctrl: mstar: msc313 pinctrl driver
config: mips-randconfig-m031-20211002 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pinctrl/mstar/pinctrl-mstar.c:88 mstar_pinctrl_parse_groups() error: uninitialized symbol 'ret'.
drivers/pinctrl/mstar/pinctrl-mstar.c:112 mstar_pinctrl_parse_functions() error: uninitialized symbol 'ret'.

vim +/ret +88 drivers/pinctrl/mstar/pinctrl-mstar.c

e2eeeecce8807b0 Daniel Palmer 2021-09-18   77  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   78  int mstar_pinctrl_parse_groups(struct msc313_pinctrl *pinctrl)
e2eeeecce8807b0 Daniel Palmer 2021-09-18   79  {
e2eeeecce8807b0 Daniel Palmer 2021-09-18   80  	int i, ret;
e2eeeecce8807b0 Daniel Palmer 2021-09-18   81  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   82  	for (i = 0; i < pinctrl->info->ngroups; i++) {

The kbuild bot does not use cross function analysis so it doesn't
know that "pinctrl->info->ngroups".  Even if it used cross function
analysis it probably wouldn't be smart enough.

e2eeeecce8807b0 Daniel Palmer 2021-09-18   83  		const struct msc313_pinctrl_group *grp = &pinctrl->info->groups[i];
e2eeeecce8807b0 Daniel Palmer 2021-09-18   84  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   85  		ret = pinctrl_generic_add_group(pinctrl->pctl, grp->name,
e2eeeecce8807b0 Daniel Palmer 2021-09-18   86  				(int *) grp->pins, grp->numpins, NULL);
e2eeeecce8807b0 Daniel Palmer 2021-09-18   87  	}
e2eeeecce8807b0 Daniel Palmer 2021-09-18  @88  	return ret;

This just returns the last return, so if something fails in the middle
it will return success.

e2eeeecce8807b0 Daniel Palmer 2021-09-18   89  }
e2eeeecce8807b0 Daniel Palmer 2021-09-18   90  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   91  int mstar_pinctrl_parse_functions(struct msc313_pinctrl *pinctrl)
e2eeeecce8807b0 Daniel Palmer 2021-09-18   92  {
e2eeeecce8807b0 Daniel Palmer 2021-09-18   93  	int i, ret;
e2eeeecce8807b0 Daniel Palmer 2021-09-18   94  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   95  	for (i = 0; i < pinctrl->info->nfunctions; i++) {
e2eeeecce8807b0 Daniel Palmer 2021-09-18   96  		const struct msc313_pinctrl_function *func =  &pinctrl->info->functions[i];
e2eeeecce8807b0 Daniel Palmer 2021-09-18   97  
e2eeeecce8807b0 Daniel Palmer 2021-09-18   98  		// clear any existing value for the function
e2eeeecce8807b0 Daniel Palmer 2021-09-18   99  		if (func->reg >= 0) {
e2eeeecce8807b0 Daniel Palmer 2021-09-18  100  			regmap_update_bits(pinctrl->regmap, func->reg,
e2eeeecce8807b0 Daniel Palmer 2021-09-18  101  					func->mask, 0);
e2eeeecce8807b0 Daniel Palmer 2021-09-18  102  		}
e2eeeecce8807b0 Daniel Palmer 2021-09-18  103  
e2eeeecce8807b0 Daniel Palmer 2021-09-18  104  		ret = pinmux_generic_add_function(pinctrl->pctl, func->name,
e2eeeecce8807b0 Daniel Palmer 2021-09-18  105  				(const char **) func->groups, func->numgroups, (void *) func);
e2eeeecce8807b0 Daniel Palmer 2021-09-18  106  		if (ret < 0) {
e2eeeecce8807b0 Daniel Palmer 2021-09-18  107  			dev_err(pinctrl->dev, "failed to add function: %d", ret);
e2eeeecce8807b0 Daniel Palmer 2021-09-18  108  			goto out;
e2eeeecce8807b0 Daniel Palmer 2021-09-18  109  		}
e2eeeecce8807b0 Daniel Palmer 2021-09-18  110  	}
e2eeeecce8807b0 Daniel Palmer 2021-09-18  111  out:
e2eeeecce8807b0 Daniel Palmer 2021-09-18 @112  	return ret;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


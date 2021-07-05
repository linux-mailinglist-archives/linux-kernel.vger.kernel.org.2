Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202553BBA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhGEJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:59:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhGEJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:59:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1659q4xk021043;
        Mon, 5 Jul 2021 09:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=u9aQec9HZfC4iT+QDuQvGVTSsRfVorcGiJ5oC6RpAcE=;
 b=jOMUP45G/AboVHkR5aXt4pB56oWyyHHlCROIie45NOkmoaiHqFACgnviMRWmRxl+bpHE
 4MbqPt8U4YmmugRBdazcujLp/lBGBGALeH3SMZKqB6YRrM0QuNqZzq1I3KFp7AL+SVKY
 lTX/1xbYiqyeKeU1mRRsgobAVsYvKPQJhDF/+jtNiuh/se9hkt9CRjLX0qR+0JxsSJwj
 9ytktvDYNIxh4w6JAi5AcTkuMTP+EEikG/ZOOoOyHeIsHSvv5eb2j87YuEyfAFg8odEc
 mCQobB2mX7QBNKgnJEFfccaKzNWy6H8Msw9zkIHzAeNm1HtD3BU6x+fPrCrx9OrV82Ll eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeacjadd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:56:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1659o1on133148;
        Mon, 5 Jul 2021 09:56:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 39jd0y6bmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfrOUnE1p4bQc1vkCC+yKQSHb2cAW/CU0WPWnwIIJoLCLwOOL8q1XamEl/vHyF1a+53GgP6eQc4y9um9Td0BBS6Gi83hFu40YEn2zFK2QtetGQg2QUKQJ4t7RDPfddIpwAV6aLF/dWibwbDIBWlwPZfJrOKt7IhCnGsVmCgBmuKuredY3rz4ufPqYRZB6v6vwakLrqz4lReY/du23oxQpiNiQhpIaan+YnpR5HeJKCOi3Mrs5m5Z0Ooa88obkZxZP6AI/H3DZceW9NZGK5rrNWjrB4cJ+QRu5qu3ugSHr53R/dOVVt18yJkmq1EhSh+d2TqNQMWCFFEUGgJZWAjYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9aQec9HZfC4iT+QDuQvGVTSsRfVorcGiJ5oC6RpAcE=;
 b=E6Q5TnSiB8kVrZiUF/ugHlxc6fjUZf8tBV4+G63i1pPtyM1PXBxpPLXs4Sg+U5+6TaX4CUymhpUKuxSiYEGwZaGTpvM4sdsVqUgNeX6grsGZKPf9KRCKfbJR9wg4pnk5mUiO8NY+xmKo8N8nZ5d+b45f7cy84qOo3H6Ej9eylFiwuPf2RmsamGltoRmd6IZbi+5aGapFPJgKyUGlb2jctkSddlndiNRe7/2AkTCks+agaqRaJnaKcZXJOs8QyGeCKduEENUldMoHBN7zV3bo+uObNJLb3rbjF4LFlsMp4MsMiUls/eXlEZn/v8mu+V9ksD0ARR+WOmhHx0nmoQ/MtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9aQec9HZfC4iT+QDuQvGVTSsRfVorcGiJ5oC6RpAcE=;
 b=ZyjJSM1jJX4SBbLnHZYt7dcD4vl9VnZjoIR3CiYkZy/ZvkakjE6tRo6pAOmPHi6toHdFkE+mFTN0RpEwcbHQAFHYl6POcmRth4am1xJ4e5jD4G8AUaaEtpb7w26CDE1idjogS7iEPqS2LAXXttmJtelM3fmK3nsiwzq1N8sXjiw=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2093.namprd10.prod.outlook.com
 (2603:10b6:301:36::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 09:56:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 09:56:32 +0000
Date:   Mon, 5 Jul 2021 12:56:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ojaswin Mujoo <ojaswin98@gmail.com>,
        nsaenz@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] staging: vchiq: Move vchiq char driver to its own
 file
Message-ID: <202107051622.6i1l1vdL-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7178086322f774772d95141764ed99d0698139.1625401927.git.ojaswin98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Mon, 5 Jul 2021 09:56:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4277633e-3c85-4617-6117-08d93f9b2ae3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2093AB8F4B582C2457FC5B0E8E1C9@MWHPR1001MB2093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uURlQsvLcS7GDqEi/6/R7+WTLqI9cqgLRDSDU0/KIyu+hdV0b/9NqAHLaRgCbEWgX5H/enlSfaqB1EUX8whEpTcFgEVbyIgsfCfD7A3HgR/QCnahyTe7r8Byj4BsdRpkd7X212Za1gFO+fc9rNeSWfGTTcJ++hCmbbkOItp1mUKcpQmEJ4W5yVcrSTA0BTqoBtqWPNU0dLqQ9Na4wcm47whkujRt3peoJZMGqCP+t3fNF3WwIshWd65GuSXceFJSD2lGfi+IY9c2QIysyvXHvP/1C35QTJ7Y16Lp3J1iwvx9mOQS7yXT9G17OHiik396NCTIaXmag0oMUh/N5iqbNO0LR8RTOacRlDwGpoCWFNExrALzTxq0LMqgGNeCR//MTlY2w17S1GTB3eehYfs9NDRZbnRNkCLyqDE4EmAUDUIyLF4X0WcAv7raBa3bq6ADY4VPZqqollGE8PLFOQnHmq3pxrxpy3Q/X4fcM989RuaTEdlTR1Ni5DUtgjNL2TwW0+2KUcU1DQ/V8I8aWf1ASadgJvm7qkcx6Fm1apcosIlZ3DcWW8cyPsKnTelvRXyFs5b6inC5W+kXKETwSCc8+pyNDI7ySeeoaTDEjgXHy92bjYiCBzkaByX7Mu2h+K6lV+lKN6kcRw/OjttrUPLI+SGAcmtlHVhJnTaJFgKfXuBPvsBdyG1FcGJWjzXkk9iq3/jkBAmwrIQ2MsxcnhSTcvOfeRJyM8KW4pmOY91uYfhIa/5x4JbUbENvpqRCyJSWSTQFzbBQTXwscogf6LlXL/JxotK0HtbUela7yNNql+N5YpPva9hUNvN0RXA6FFym
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(2906002)(83380400001)(8676002)(1076003)(966005)(8936002)(9686003)(16526019)(36756003)(186003)(5660300002)(44832011)(6486002)(26005)(38350700002)(956004)(52116002)(86362001)(6666004)(66556008)(66476007)(4326008)(478600001)(66946007)(316002)(7416002)(38100700002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVN8ZwrybZ0IOnCJLyE26ZoOQuRECQPfXfllpPRjWO/2xxX9zTJYR9hf8Nfv?=
 =?us-ascii?Q?0FJEd6rB9Mnwt2VYcz6Ytz8PhKeOBnPHiYfqD8KeNHSA3TWUE3TVr+S7BbNm?=
 =?us-ascii?Q?aggrinZHbO7shB2mguuQKGZkVxNA5XuyLlHOW+GYg+k9EgFFGzUJxhoLef/K?=
 =?us-ascii?Q?e4Wl36TCtvZglQkA1UaapdZ8sgQ5tz2reCLgqdgdHbWBom/oTz/Radj6lfRl?=
 =?us-ascii?Q?TK2Q3Z9Sj8TZcPZn4XyAuaT+7RbkUUPwN2Q6AXa8WqFVdVO/jCPbviLKY5Kr?=
 =?us-ascii?Q?J7GlnGvVbaMQq/WpzHFMkKM/HyfyY/C4JOAGXsp797hk7z7++QT8wD/DyfX8?=
 =?us-ascii?Q?wBPscoYwycbz6EF9TXXqRotXQccYK/c3PdZCDo/tz8fH9hzbGX4P1EXIx+nT?=
 =?us-ascii?Q?tzdgP7C9EZuvCiRnDBFRIlfCO4It0dMdDWcBUU63vlAlGbtJl2URCmh+p66H?=
 =?us-ascii?Q?OkrzWMGeTc5Q5+tlmkHDXOSRhG/TXJMtXHAO5gt/gUk97kahwTHu/QHeINs/?=
 =?us-ascii?Q?8l7/VHs/wFOYcdhY2FI33uMy7KDHwi4OGHG9nWflBJ3rDZCivk890aRsxBHf?=
 =?us-ascii?Q?GtlTEegluJHhVutKjbyKgXxFdlwS4ZOstm/fVvRaRdelSE2B9MTKRkf1pqtP?=
 =?us-ascii?Q?yQSeWeY0bitjUpfIM+EwVJitaiNlf3ToKHfRaju9GX3/1Zlpn+gul+YNk9Zc?=
 =?us-ascii?Q?pt94YckKqGs+yP66UXh2InLLBvT8/UWey/AQe6gfROKbNorE8xVybgX4CrJV?=
 =?us-ascii?Q?9cMgDilkLBEkSuoYt6NG1fkcaC1X2/hB6NP7KbhX7W+EQAI8yKMjJaSucY7c?=
 =?us-ascii?Q?ydR/1NDVqv8q4TN2jWPcQb/mWFqHdvZC1TA0FpnHpSRS9XvOSwPd2eIENjq/?=
 =?us-ascii?Q?8S9N65tcstj8Tdzczd3y2AS3roUGgfuaNmm9Q4VVfyLAyswYhBM6NpxkOUUO?=
 =?us-ascii?Q?vWkn9AwHQsoraHH1zJiui2Jcu34ZWX8OaHBZuSqhP24rAXgQzHo+Lr8U59A6?=
 =?us-ascii?Q?DYBDbFvqOfKoHHI2TPHDAN6xD6drhNXbr+TFqh4AUCy/VODIB0CtGdOi18TN?=
 =?us-ascii?Q?4JV9p9jNalHbWYzs8+g9db16lQ8ZCZpZdJaa59NGXi7Abzcud3qCOIFNuu8W?=
 =?us-ascii?Q?gmPmEMPYrmpEJIYfuV+MubfDchjn9sSbmRi6TQazV4ZFtWoJRt6bBBTyQ2VR?=
 =?us-ascii?Q?AWSQfMMeax19833gf6y/VFjpmjdbW2eqQ4fgr95DlIiwFAgN5WpOSzFIGATk?=
 =?us-ascii?Q?P8TNwyfc3Bbvy6vUOCF7UXTm/2RnWg2tAQcHRMMQwu98fOwaQOi0idkO/JgS?=
 =?us-ascii?Q?1BWs5/Z4ipJBPy2ZAx5kQXl5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4277633e-3c85-4617-6117-08d93f9b2ae3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 09:56:32.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZJag31rYbDHGCi38tMvuCgPXAuJ11+9MYGzXHrPSQSGnj49wNai9M1kdWzEgc3/TbVfpN2hn4dgn/xeOv3CBp1UQ5GDkbQQkodU6kVCOOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050052
X-Proofpoint-GUID: WHrKQ3P6ADHH-MnXQW-2GYHSAZPVsTLA
X-Proofpoint-ORIG-GUID: WHrKQ3P6ADHH-MnXQW-2GYHSAZPVsTLA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ojaswin,

url:    https://github.com/0day-ci/linux/commits/Ojaswin-Mujoo/vchiq-Patch-to-separate-platform-and-cdev-code/20210705-000124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 77ad1f0e99bd00af024e650b862cfda3137af660
config: i386-randconfig-m021-20210705 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c:1235 vchiq_release() warn: argument 3 to %lx specifier is cast from pointer

vim +1235 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c

62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1227  static int vchiq_release(struct inode *inode, struct file *file)
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1228  {
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1229  	struct vchiq_instance *instance = file->private_data;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1230  	struct vchiq_state *state = vchiq_get_state();
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1231  	struct vchiq_service *service;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1232  	int ret = 0;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1233  	int i;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1234  
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04 @1235  	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1236  		       (unsigned long)instance);

This should eventually be converted to %p so it doesn't defeat KASLR.
(Not that we really care on raspberry pi, I think?)

62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1237  
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1238  	if (!state) {
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1239  		ret = -EPERM;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1240  		goto out;
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1241  	}
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1242  
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1243  	/* Ensure videocore is awake to allow termination. */
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1244  	vchiq_use_internal(instance->state, NULL, USE_TYPE_VCHIQ);
62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1245  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


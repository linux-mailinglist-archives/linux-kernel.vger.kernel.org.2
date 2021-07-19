Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72FE3CCE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhGSHVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:21:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9148 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234441AbhGSHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:21:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J7CFgF024364;
        Mon, 19 Jul 2021 07:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1Jh9AzeLPOpnnlE0WsBq/8ngHB8w8OQLrlCe6TNkgQU=;
 b=F7TF+QeKQEAWY5o7xTpnh/XVsJdmg7crgK2dJU46mCJlnyd2dX8epGeMU7KzhsaaP4lp
 kmrWuC+1O99PjciYNsl3RaMEMKnJT8R+PowWtSBhqPyzVumir2wVZsr3DMUhqk47jFor
 s6J0kYnZo3IWROOoZxinlQnvlsox+HqSRWQYHzBLwhh9ETAGDDVAtRS5uX/MdKFghM3U
 zPCXuOHap/26It/Ok0QlV4AkWCGLHKGZfg16Xbdph9iroUIw1+is/ycwtlwJi0t8lXxi
 9e/bErx75ldPcuMrxA1bw4N8v6Wp0pXqSsPusktygoAS32Ab8wPZ1mjO5AvinXS+Owcs pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=1Jh9AzeLPOpnnlE0WsBq/8ngHB8w8OQLrlCe6TNkgQU=;
 b=RjVTVxL5zdIXh04a1Zc38vMdpVe2JmnkN1r8JgkNp19SDl8KKoIXv2qwyOpkSb0zyck8
 WhDFgjuWGDt5TXXPC8wz4+F+9T6pXVIv+NsqBJYKQDuuuCRS5MifncCbcgC8hlpgrzZv
 1egYFXGQec9xVTvm7RJynD+wXOvxh2SXF6XcDDlibk5nxv4CefFhJs7+gg2rkM5FAtBg
 fuwKKP4UkpWUhyQCeoFGhW81q5WROzzZH5f0rGTFzX9zHfhNjAZq2RLMoytxyRzfzg7/
 olTpJPf0ZjXvSX7FJVYCNINzX5QmECuDIjJjGRYSEADufUAq4rWCVNBUO/hXxxYtiUFg Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vpkwrrgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 07:18:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J7B2Lv057373;
        Mon, 19 Jul 2021 07:18:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 39uq147555-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 07:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4E7dyuZ5emzB4kL6aUhsp/raLGkAyXUX7hsv9ld426Fua39Ac2tkBCvF1cf3icmvsjs4lhGkOIrEfDiGsJl7Iluy5PxaVVvXYR2lhzGMgI49MSWQ1PqD9a6Y7vTyV00zneujJZK2HSraazZpoeIe4EKvSMsiMcHdBeBCAdHk3+4L9krsm0+CS9RFuEu1UQuym9g4VWtTYJH2B0r5SZpeUnNEpmLh7cxHWSFy0iSi49bJ0F//ypHibHaU4Gd04ETFxKuvWpzpHrIgCEJcWXwnO4ZspAEayOE54mJAYiXrpaOgWR2g1yNs48Yvfo1gRnXufURRH7O2v/TnUWixmNHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jh9AzeLPOpnnlE0WsBq/8ngHB8w8OQLrlCe6TNkgQU=;
 b=PR6GyLyT6Hm0E6hwqGszrV90jcdjzdvqceOSA6MVlP4QHFIvsvVZygbCJMNICSR8TkCBGmXTyUH4c6WWqm8yPZ2ZSspIoMzfQSq9SAn1NPjoOqpY8M/vHWYy/gPl6jWDx+oj58brC6yvxcnjVEgTZUDCQyjO23tfDj1cRTW17+VKb2oOxtE4lFe6eh4/4pK8LDcYu/tdJiwIB5v3nMfdNOW8zDQs95QzI75N6s1BrS2dG2ZKptQgSRLyTSISAOUDg1RrFG2ZIhL0X9zDzBIP82IwNwzHQ4/AAR5RhOIlo2JQ8yuz+YGmSFah8w/5EFnkpuetWuTvz9aix3odpe7IOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jh9AzeLPOpnnlE0WsBq/8ngHB8w8OQLrlCe6TNkgQU=;
 b=PSZcass7J+DBYWOmDVpbIh7ahkAwQUTYFbA/95ut62z+zEAC4TkQFkJfTqVGu2R5IAlWPF2liZkIggQL74Hru6jCxXZLVUPWdZVWnVbGGRks2a2EAG4iS6JNpm4aYOA9r9/2OdJD+K3nIaIHEQnTBvZ6LwMcNNrtdKlO3weSmaI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2208.namprd10.prod.outlook.com
 (2603:10b6:301:2c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 07:18:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 07:18:17 +0000
Date:   Mon, 19 Jul 2021 10:17:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-stable-rc:linux-4.4.y 1449/1774]
 drivers/input/joydev.c:485:16: warning: comparison of integer expressions of
 different signedness: 'int' and 'long unsigned int'
Message-ID: <20210719071758.GP1931@kadam>
References: <202107191112.AwqoFW63-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107191112.AwqoFW63-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:18:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25edb180-7195-4c51-4e76-08d94a8560d0
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB220865D3C4801F4F62EEB54C8EE19@MWHPR1001MB2208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbBOqKwgXC5+Sk1ND2KbF3Y8pTYJeMAfhSez8YSBLDfzGK4dlTqR3XQWDwBmA8IhOmNl9vo6m6iS5SqAth93t8VjWzb9+NQ3bLyf4s36L+xbOmNpdE3PQ1LOxPs7/aHPg/mMCyEtfwcizrL+Ot/KurKzorHcrgcY2oCQ7aZ2XZsG+3fz4b0h8xdXE3ZqYCx1TUC5yneBErGrlvOf5gCI5VFX16tePVGP0iEE4iZ2WCOPuc4mNjdyjWIL1a8mdQu9LCAslxdCyM06SY/rPdiqFn9ieDcHoADPN1vJZxQnHmkhjF83Zd18ewSknxSVexr/x0XUK2YbQWPBJvJDkrAFwvwPYMGSjyxHE50mQ9gZEX4qqDvIJl4d1cv9Wh2z+/XuEVKy/CdWygHGTkOxdwbPo3E7YCTnvWbRWujVuAWsV3UwNx5pfoegbkiJvm2rAY8yKR39d3kM03p7IQs2zx6vurwrWtVS6heoEXmKOxaTc2Nvox1leTj8crvK9EK1ldSqdceeWak3sRO9rByZrjvPQ33G6M0OIupvn6LSoOH62leFzn74wMa16+UySvY+pVDLwOjUm2krA8LRRUDA9s94w14JEemHijHCDpKQ/s3hQ4xn3y7U1M868jhT/El2PmOo+ihC+XlUOYtaskSg1kCp7yN6oiDjEyBgvIe7QK3PXjeaomCKyTx593ogOFoDRVIRpuDQt7+ukAU7GI8Hm5PZOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(8936002)(38350700002)(2906002)(5660300002)(83380400001)(6916009)(186003)(1076003)(6496006)(8676002)(66556008)(86362001)(508600001)(33656002)(26005)(44832011)(956004)(52116002)(38100700002)(33716001)(316002)(54906003)(6666004)(66946007)(66476007)(9686003)(4326008)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WhxP+10G5jLk4cEtrFSPrXH6tMJVrmJTkaoRo6PsRD5qix87XYgKTDmynl32?=
 =?us-ascii?Q?GuGrJ7zcPSMuVUBF70sNwi8aZKzCzWlHWDbo1m2e3zP6X/Awhac7A3ZSJybV?=
 =?us-ascii?Q?LtVbT2QsTZ6v74Zgca9HXPFje20njMqkk/WuQc630HEUOFcs1PZH3xvBW5Of?=
 =?us-ascii?Q?e8DyFLaR9AZBJF/lX0dXh5TCfzTHsgs/TgAfIHMPSh6K0JsDafMB+aVyAMk9?=
 =?us-ascii?Q?hUA4vnaiLuNzY8zt5v/bb7T/ujqW8WztZ9/7wd300IsNCLi4INtZ3gCX42KB?=
 =?us-ascii?Q?yybI2Ya35p2T7BX0PtkmAX3MqAVxPY/rtAv6eSZOsuiUoQwT4cmamJI54hSU?=
 =?us-ascii?Q?JpSqaIlW8VESGavv9Sv30g7/ExJxcIrcBH366V0npFZR64tRcX8rYC8TSMEE?=
 =?us-ascii?Q?Ij78MuNf5pha2657/N+E0CqT8TvSNEvJF7mf2McVO02+0K2GCoWI5UcauHck?=
 =?us-ascii?Q?hTtev30daEARYgJp29hdGEoF2yVeUCMZrtCI1Pey+aQ+dXdc6Qi0remiR8q4?=
 =?us-ascii?Q?MLLcopM0ppA/8aJCN/nf/1IJTrI5VU2es6OxQwgnhH2WqRG+zjbF8uGe58D7?=
 =?us-ascii?Q?y/L5y+pE+5iETYV3ddtb3uj7RiARtFAqBHQynhEIyHUyyXNWlo9WJA5YZxkR?=
 =?us-ascii?Q?jRRJFJz24gtWkdUpo7dFYHhOUciIkqQ3K204JeLTWFevaJoXRObithSnQeCk?=
 =?us-ascii?Q?Ozz5g9oeWzUsuwvT1tQ1apDH3sLNi0LDULydtfrO9+0J+Vec7vXxg8a8X+Go?=
 =?us-ascii?Q?jldYRffF1qC25c4f3flPu5QA42ZEqwZh+uv7aa2lA7SoFIB1sS4otm21Kchm?=
 =?us-ascii?Q?J38RwReHDxe5Nse32WSPYSgaDhSG730XJ+qd/GVP+65LGv8gSY7D2BbMhzTQ?=
 =?us-ascii?Q?uIwBpaEB7XRbZ5zCt/241FSIYQd1wWhERf/U4NA/mqbXrzHlN+BXbKsxG1tq?=
 =?us-ascii?Q?osNM45ymkhRAhIPcT56ZRFEZxGTkDRayVsBYhxU3oVNMTwQo1tmDGjZWA9sZ?=
 =?us-ascii?Q?XT4iJDf0a43XkbdfQXpRqOBt833J8Jn5oR7tlxN587vqrDQZBqAI9e/a4rxa?=
 =?us-ascii?Q?jp8k02P0e+mJW2ovGt/14axqjW9Ae/2mf/wAXmus2m2hUjvF/DtjyfLtA3DT?=
 =?us-ascii?Q?4+7b1IidaBONary5fjUhygkG+DWv5Dp1tsr1NMW5M+Pb7wN7AkggnquRXkH+?=
 =?us-ascii?Q?dlwWOMMgFGBGGxDRHd+VLX2z7hVYKTbgPADvSHJEQrlG6YdGId4eNjh7TaTe?=
 =?us-ascii?Q?xPlAelPWHI29nr7idmNvUFNjkCuJumWuua4YQjojwg5WUJBycPKvb8tLlTbU?=
 =?us-ascii?Q?FpsWMrf5LVuMMfanFj2z3VsN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25edb180-7195-4c51-4e76-08d94a8560d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:18:16.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgVlrgM4BZj4F7ks9p+vlnTHA8fSpoEQMR8ttdVDhE7KmzOKBPEt08QsYu4BcJ/AfgVqfDBJLNtXsQKQAdZkOtnDc0CmrzCa8GwMg1DPh4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=854 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190041
X-Proofpoint-ORIG-GUID: xfqa3BphquIV064WwVYN-p63-H2GuwGG
X-Proofpoint-GUID: xfqa3BphquIV064WwVYN-p63-H2GuwGG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:39:16AM +0800, kernel test robot wrote:
>    drivers/input/joydev.c: In function 'joydev_handle_JSIOCSAXMAP':
>    drivers/input/joydev.c:451:16: warning: comparison of integer expressions of different signedness: 'int' and 'size_t' {aka 'long unsigned int'} [-Wsign-compare]
>      451 |  for (i = 0; i < len && i < joydev->nabs; i++) {

We should figure out a way to turn this warning off in the compiler.

It's a stupid warning.  It never fixes any bugs.  It sometimes
introduces bugs.

In the kernel if you are in drivers/ and you have a loop which iterates
over 2 million times that's probably a bug.  But GCC is very very
stupid and not designed to be a static analysis tool.  It does not know
which loops can iterate more than 2 million times.  Even when it knows
that the loop only loops up to 5 or 10 times it still warns that maybe
it will loop over 2 million times.  INSULTS AND DISPARAGEMENT!

Seriously, please disable this warning unless you can point to one
single bug that it has fixed.

regards,
dan carpenter


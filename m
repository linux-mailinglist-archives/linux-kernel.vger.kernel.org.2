Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B73EB361
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbhHMJi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:38:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2390 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231309AbhHMJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:38:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D9ar0W018781;
        Fri, 13 Aug 2021 09:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=muFTPW+ZWd+Mvjbzsf21KyALNNNsW66ygb9y4tWbjA4=;
 b=zOlhBuNm+byaFy9D/0I3pM1qd5U86Me+HK2Gkqsxy+9o4dFrzTXTjxaxEi2jig8zPSix
 GYdMz/ZTZm0GOS70MIPSTV0H6VITZ2m0cWomwD6GCEzEsz48qsUfCqbUH4ym8VOe/Zpx
 DHM97di0u7P9rjqwf/gTaV/kexIWy+ofHFULl4rXLQxuwb0T08Tymu0v0uvOwbOyAwGR
 oAybvjWGVctmzfrExa29VYXSvlvS/V0H+Qt2/SeNht26GH84023Hw3CI4iYH8e4yJALQ
 Uh5zOIfpvdX7B7PN0ZI2a07vftFpHbHSsUr5QbjOz8zKoFEPpLJplhzzOeP3AtlTWzHb DQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=muFTPW+ZWd+Mvjbzsf21KyALNNNsW66ygb9y4tWbjA4=;
 b=bncC/we4kmKu4TDCaNkscBHEJjNNubrSiCNFyf2sz88rKxBD7WOOXXhWksRIFR1AT+LR
 BosLCkBPbJwZAvwDwQrlM2loe1CBFppPkA2AsIjmKbo0gWIkl3q5y3pbMrgjjJvDClz1
 hSSCdWd979DVnwIk9Yc6gpOfGx1EZLAlFIiEdil5y7wZGwT5uoTD2stnD+lEawGHdODb
 9/93nsK4DLaf79OSSmQQ80IdGFXIQ3A6WOme2lcaZgej79hLnVdzcPo5boWY7HL8WBW6
 sOCIMFb6UvWk0FEhEgQXadCPKXWPVL7bDQEApE/BZbz4yOM3fY8BzkGRQOvHK+o5UAl0 RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p2yv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 09:38:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D9aXsw192887;
        Fri, 13 Aug 2021 09:38:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3accrdqwgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 09:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDSnvmH2o3aI46yl2Z+euC9hkuEJmQpip1C4XBBR+cH1StnZ6XKKdV4hewVFZoNHMZAH35QnT/lM3RfyMssgQGX95iP9HLhMdM4mn69SfeFR5z4JnlqSPvWIZVzkNlclgs1mWzteqsUgzrM7ZADaM+YCqB+DyZTn3lQQXE1FEqT0Ctsd5pLz4x8Bjnr9V/PFaITaJMcnzXEYiYO/wT6ugANGcJtY9ANNy1ruITytJikpTUuF3eaktRVZw2YpoWjflon8fPYCoz1pmElRvzgmZbGJbcMAVYDtM3ZOCWEszmzJFrQPMjXbJrD1HUFQV8bEQ210HK6UbvX5iCSixo1wHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muFTPW+ZWd+Mvjbzsf21KyALNNNsW66ygb9y4tWbjA4=;
 b=mJnqk5CbX2EkaZP4YfFhYSTOxrFNQR0xv3KyORk73GQs4qa9wItT/8mJ9xmgUtDNCf2P+HUeuO9WLTcHUrm/fZJzEtGlRuZrq9qQjpfz+sd1qTuF45xcLAAbp042judMuhII3MrOVq1nK/Pn+08odkdMj44VLT5to+NyQZu4illOAYgA2abgZnC05S5Nxe5bsLQjC5id5p5KtGtqxLxseLGSdAoqBo5dn7YnJhbdthxcRQO7DrmXLPl76rSEmFJHaHWhecOe9zC510ZNL6m+oMaQVzkBUL7FTZHOSwzAYAdSBQVJzkGQDjrdrVLsym9EWmHJFCskOq4t5vIbYQVVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muFTPW+ZWd+Mvjbzsf21KyALNNNsW66ygb9y4tWbjA4=;
 b=hupPVmm2vqin4/HsvpKw9HPKqHjGVOgwjHv253IVGEHw0Bo2r8tSa7eQzbS52ncDDcX8kDRCcqPZJUHNtxwpqHDnDfwp1Phh75uEPgN+nrwKBQ6W0thEC0hAugjK3okVzYjeb9u+8BCm8fBBW4WZ3dVqfbo6pxHa24/VjG5KdY4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1422.namprd10.prod.outlook.com
 (2603:10b6:300:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 09:38:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 09:38:14 +0000
Date:   Fri, 13 Aug 2021 12:37:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Haren Myneni <haren@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: arch/powerpc/platforms/book3s/vas-api.c:100 coproc_ioc_tx_win_open()
 error: we previously assumed 'cp_inst->coproc->vops' could be null (see line
 100)
Message-ID: <202108130245.yreVnhXi-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 09:38:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfaa50d0-f3ea-4fc3-10f1-08d95e3e129f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1422545B3B3CD2ACA94220698EFA9@MWHPR10MB1422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:76;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEHIVfmvL6RJa5d+kqFmrkIH/9JYc9PaVyHFFaNqVrbnXe0Gsv+S8YbU2HshnNaoegMJIWYhlw/hdRuASMx/d8azlbftX12IK+6506MQMi2tFRrpBIZNZhR0yn+Rd7cnQLUGWCqn7Eokk2a7SOmw7jgrXJPIyYdBWcMW1GnL2OFHzXbcgiLgDQqx0c5s7YMEcqPsUA+fNg+1Cr4vQ4FX+HGMICYkk0+zSuyjWanBdiBmm3RzeGkY24twM8P+Rd2e170eoPMFGt7nlL7CIn84263TI87h48MJtKiUICznFYATbQaSfvOw2V/dDp48HkOWobznjJZFbRlYARKG9I2Ff/aX0EuK7YTuEbIap9qYByhvVomXmGDEn7KdpYwgVVDs4uQjK13OBul3QSju1AXfNDbNN8p5IKLSo0WtklG5ujMQ+YWEUaUVbPvlF6CUqfskVbqSglwiZd5OX380mNYqGYGcM/5MTpJTnLJwvrl9vwSKNmxcJ2XFUJp6o8VWVY52vWhx67kdm9WHwhZXBm4ryZFITNqXJk+LUbRWMxTiiiH1VH1P/KQP/7fGgyxQRMGqm/44emP9U19/A7deDh98xj72GpvrS3SmxMm1PCvQij+2JxEqoXYeVikRDs5t6cmrQmTKUgn+Ok4Mp6i4+JcjJg76f7YvAHoe874gnyAx8WJxnyns2y8Gjp6OatmpzqVNNn91ZPxmW9XhsU2nif7dJ5kMzNYrCGgBKc072eXhD12G1Qu3cGJQ0O+cg0+TEUv62zoRwYoMkdpF34x9TtTimkm3/1RFYe+fXUwon2xxm4sXQMrPpA4YsC0QiVLBrCIccy2pCf3t+Kpn7QpTtsnbbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(8936002)(6666004)(86362001)(5660300002)(36756003)(6916009)(966005)(956004)(38350700002)(316002)(2906002)(478600001)(83380400001)(38100700002)(66476007)(66556008)(4326008)(186003)(9686003)(6486002)(44832011)(8676002)(54906003)(6496006)(1076003)(26005)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2mkCM7XW6QzOODBl9ELYJSf/x1nKJ8r5BToprPsDX4yO5gMnPGzbklCOWW+?=
 =?us-ascii?Q?FYW65+l4BBgPoMsotU2EvlbH26o/sP4IBzOzJ5J1w4qwMgAGirvSxTGPAhXc?=
 =?us-ascii?Q?2yvoHzW4tPC4q1uj2z/pG4dnJnrD9TwGg6kAYunL0ac0vEKK8JkXsUK2T+8w?=
 =?us-ascii?Q?IN/y3zDN+MhxcEgRa1t45/TGotwVBi/qbqk/9yoOYugKaLBuHqLt/hCktZmC?=
 =?us-ascii?Q?Nr5/l9XpVMEk/BncrKp7euYsN0cEdT6FHY/ltc/fkPe1uzSqH5O80fOJ42q7?=
 =?us-ascii?Q?vOvvDR3xLJ/wEwfyz5MG/9Frv6wIc93ILcQA+JhynQsW/n76isDM3W9FyHqj?=
 =?us-ascii?Q?UPLkYkXJJLLYrrLOQfteJ1FXbOxyfb8hm0Lwk6+boVewidKIznVx08/7jQb8?=
 =?us-ascii?Q?VgAdac/bOqUiCXtniBpITuooVpAnpooIZGwN1GqiE6rRqaKzdLvBy9HC3nJV?=
 =?us-ascii?Q?jNSIkAMga6XQaKN7RQ3u7bQPnwZZEsXjb6HyiAr49Z7py/ToK2W8Kp6Y/YA5?=
 =?us-ascii?Q?QIMxCCr4/mXvIOt+q4dAFzOjel8eK3WjVJavPcEp9Nk4D/GBRuF3NMcvXiwr?=
 =?us-ascii?Q?IF0Dc2XNzO1Av0ZfygWR5ILhnUKqb0NxqRqDIr39/pha8TJbq6mCKY87d81k?=
 =?us-ascii?Q?cikfusSixOqmYxBGOTz5JV2Ua1fcfOrrDrFAd3jZf/oFUCLtHvRu/uw+ItZR?=
 =?us-ascii?Q?6u78w2YG/pfCIFWwwtXJo6bUAznccLVaNIRT1g54OJtHeKQQmPWERfXGvvIs?=
 =?us-ascii?Q?7e8DutcAZERBGZN/xO8SmuRzPxhRP02x0BlyXH2q1bWY2YmZLju8khh1ICFh?=
 =?us-ascii?Q?jdetQxsDrg+oHhgEhF/apE61pCGbGNGtyTReS0UOqUBowny06yC9b47vaPwL?=
 =?us-ascii?Q?dILEAV5LA9X4CIAr0WwPIrsC/G8AhQCjHQSh2cra1YF30h6YRNnSRMQ4lmOj?=
 =?us-ascii?Q?d2rYCQY3WCOkIcfF6EAgYikNZ+BY9jevEo1rFsxczyPc5SojhiOvU6SGKAX/?=
 =?us-ascii?Q?qunqQ47LNNoOyuL0aiY3kpN2GGPBuzpzLCHYUsjvtMJZSWejcj4CHH/ve0dG?=
 =?us-ascii?Q?3G8Lg0gmb5CyPG2f8AoCzJcbPoVFMmHIsMr5Ok/ejuht937n2EykGEB75Sly?=
 =?us-ascii?Q?4ZZbh8Pn8X+vKocyCrL8NcjLSStUSpJ8lY8rEJOyA0X5rCzukOeTweYXcgTu?=
 =?us-ascii?Q?YTyvLcbd5cudqfgnLhVImHMOz1yaFIOv6813n7OWH+8cCs8sNp2SMBe3smNx?=
 =?us-ascii?Q?ObB7faIGQcXmuf8ByNqmxV7g5Eh24cB78DBokbMcSqtdbK9usKMk8FIfxmDQ?=
 =?us-ascii?Q?ILG+8bwyTu3uMT2vrI8RX7DW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaa50d0-f3ea-4fc3-10f1-08d95e3e129f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 09:38:14.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwRz+aubgk3bpMdAx/ZBc0f8XagjVWaARr71cXeCqBW+ryG5791DC+mCCif0Lkvno5JUkvvDA8B/2AkE8N1xyg2zporSGKLXNY1/Z4gvh4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1422
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130057
X-Proofpoint-GUID: cPOk7huyx_2qJJu3L8WvSGH9rH-w0pUV
X-Proofpoint-ORIG-GUID: cPOk7huyx_2qJJu3L8WvSGH9rH-w0pUV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1746f4db513563bb22e0ba0c419d0c90912dfae1
commit: 1a0d0d5ed5e3cd9e3fc1ad4459f1db2f3618fce0 powerpc/vas: Add platform specific user window operations
config: powerpc64-randconfig-m031-20210812 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/powerpc/platforms/book3s/vas-api.c:100 coproc_ioc_tx_win_open() error: we previously assumed 'cp_inst->coproc->vops' could be null (see line 100)
arch/powerpc/platforms/book3s/vas-api.c:170 coproc_mmap() error: we previously assumed 'cp_inst->coproc->vops' could be null (see line 170)

vim +100 arch/powerpc/platforms/book3s/vas-api.c

dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   73  static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   74  {
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   75  	void __user *uptr = (void __user *)arg;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   76  	struct vas_tx_win_open_attr uattr;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   77  	struct coproc_instance *cp_inst;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   78  	struct vas_window *txwin;
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17   79  	int rc;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   80  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   81  	cp_inst = fp->private_data;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   82  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   83  	/*
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   84  	 * One window for file descriptor
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   85  	 */
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   86  	if (cp_inst->txwin)
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   87  		return -EEXIST;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   88  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   89  	rc = copy_from_user(&uattr, uptr, sizeof(uattr));
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   90  	if (rc) {
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   91  		pr_err("%s(): copy_from_user() returns %d\n", __func__, rc);
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   92  		return -EFAULT;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   93  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   94  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   95  	if (uattr.version != 1) {
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17   96  		pr_err("Invalid window open API version\n");
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   97  		return -EINVAL;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   98  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17   99  
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17 @100  	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->open_win) {
                                                                                                                   ^^
This was intended to be ||.

1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  101  		pr_err("VAS API is not registered\n");
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  102  		return -EACCES;
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  103  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  104  
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  105  	txwin = cp_inst->coproc->vops->open_win(uattr.vas_id, uattr.flags,
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  106  						cp_inst->coproc->cop_type);
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  107  	if (IS_ERR(txwin)) {
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  108  		pr_err("%s() VAS window open failed, %ld\n", __func__,
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  109  				PTR_ERR(txwin));
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  110  		return PTR_ERR(txwin);
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  111  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  112  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  113  	cp_inst->txwin = txwin;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  114  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  115  	return 0;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  116  }

[ snip ]

dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  147  static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  148  {
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  149  	struct coproc_instance *cp_inst = fp->private_data;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  150  	struct vas_window *txwin;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  151  	unsigned long pfn;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  152  	u64 paste_addr;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  153  	pgprot_t prot;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  154  	int rc;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  155  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  156  	txwin = cp_inst->txwin;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  157  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  158  	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  159  		pr_debug("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  160  				(vma->vm_end - vma->vm_start), PAGE_SIZE);
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  161  		return -EINVAL;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  162  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  163  
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  164  	/* Ensure instance has an open send window */
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  165  	if (!txwin) {
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  166  		pr_err("%s(): No send window open?\n", __func__);
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  167  		return -EINVAL;
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  168  	}
dda44eb29c2357 arch/powerpc/platforms/powernv/vas-api.c Haren Myneni 2020-04-17  169  
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17 @170  	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->paste_addr) {
                                                                                                                   ^^
Same.

1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  171  		pr_err("%s(): VAS API is not registered\n", __func__);
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  172  		return -EACCES;
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  173  	}
1a0d0d5ed5e3cd arch/powerpc/platforms/book3s/vas-api.c  Haren Myneni 2021-06-17  174  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


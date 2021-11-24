Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588C545C829
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbhKXPCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:02:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50910 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243404AbhKXPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:02:38 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOESHAK000716;
        Wed, 24 Nov 2021 14:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=uzeVqjpwsxOknYJwwGG2h5OOjFgBDm6ptcXJGOn/ueg=;
 b=ustRkpbJ1ZBcvDMVn5wsCvgxco6SPdhEmhOkiiiapbiJ+z1u2gGEtZId5mCaXrJYOI2V
 a8D5m173RJySJ4y4LTyM4zJCrew0aK5r+BTPzxxfc5YEzBbIaqdPnj2e4nqmKzVUOj7Q
 I+nOz8FIny3gmTdnrHLsteW3O8zZl6KSshOwG/ML9UPjM7dq659eX/soEMt/vO+gfhRv
 n2otfOelq5CunQr5pnRZpcFWlpU0eESgHgSbgzmGDGZ+sU5f/Aqxaz2HXbxAJ92rnqts
 lbVlXco3AF+woWUI7CwfL+cbpc3Zh+/PqdqpOZWmQfNHNg3ivqOXntTNCDqQXYitEiZv Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chkfk9g72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:54:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOEpHmi164096;
        Wed, 24 Nov 2021 14:54:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3ceru74w7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1IqDZc0bkPV9KjvcFiwc9Q+0PE6Tn/XYk6OrpESA0/a396Sp8IX3cDrUbd4zzyMywc5TxHKSedTCnwjCstDtT2L3h4x6jEOco4PnbekJl4IzlVg8DtgBvFxCAWlrRG5F3NP7sTs+dPu/5Xv0vxdzClsfcfokNftrr1AYAoUAgNFeGVIjQp/y8a+8JbFAPKniWG+Y6IinYrqwfo7jJLuzVjoUIk3oDkvNU/Bh/5E+BLsgdIh8bWlUelc5vD/U2rXH58dMJskX32ZrXi906NlfrwkuW7wY7Xkoi1QYNqyAuvkYZcwuQEXr3oE/NTAgAZ8Jh+9c0XRZGp0gCgfcGU1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzeVqjpwsxOknYJwwGG2h5OOjFgBDm6ptcXJGOn/ueg=;
 b=Hw33uApFyBHe/0Q0TauvNiWQVsnNEKB5dd9yd8axgTpma3IR2GkkhICYub2ZXTkc6VBZrz7jzvnhcI9ISvSYw2gKuUqm7uHgBKm93NFb0lQF4dl3bcUGZLnnikSqbxn0uu05G8MAGxV24sE5/Ka9OgkWW3FUyWtkmgNYTnt+uSbwA+Er23nKzJKphnnW5BRcCYR/U6h4NsNe3Uo5um7VXGUoYcHW3q6Xq3HdQV/xl1haEuZW4xAoia4GO19F1xDqBCXnUx58CI0iadZwEZcRP1vBc0W1h+1UjJMIar4l5BFr5lE+OexGscVBrdSndQl9HBWhZzv3fGfUMm4c+1g0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzeVqjpwsxOknYJwwGG2h5OOjFgBDm6ptcXJGOn/ueg=;
 b=SKqCHhoJj/7ioAVShNBCNotJi7gKvWLHdAPW+gpMP/mxxldbb8x1rLcgEE9145IOGwviQyA8M1TZeUy1yKOuPf9+tGOUdrAfH49y5n0kJxue102+S8EOnbpxRXT4iVXST56cN2S5zfQZntdpIjEg9KRgN8DAdkHJLhjxy1rrOG4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4707.namprd10.prod.outlook.com
 (2603:10b6:303:92::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Wed, 24 Nov
 2021 14:54:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 14:54:16 +0000
Date:   Wed, 24 Nov 2021 17:54:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary R Hook <gary.hook@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Message-ID: <20211124145404.GE13656@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:45::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend Transport; Wed, 24 Nov 2021 14:54:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30c8b09c-b43d-4793-abbe-08d9af5a4926
X-MS-TrafficTypeDiagnostic: CO1PR10MB4707:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4707203D3C348DF86133C0C98E619@CO1PR10MB4707.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d3zTa/IB1dIWVTLX3Hbu6l43ag0Cj9fLEWz8XpFwgS0glY7c1t9TGnT4WjGuhF7i6hufu6hqrVmV8Nh6tk587DlPqycehTAVCE2SmXAcqqS3d0S18xv7Pk3VbFP5sLwVOzA/aFl1yPjvl1ZW1VWk2ag/0aMTcCm0Hv3nGO1DUyd/Olk1IzekC2XZyA9PhXlVtMJUaCLhSw0Y/mQZ+A0aI4LeSB3OaM2Nv00qeS3Oba4NsqqidoYSWvDhIIsZZxAeVcP2dVsesn+pyE0hYxSxG5baa7tgfKI8GmocyauHEfcm0uKkqhWgjRsDUa8NSSGUkD//6hvt1934tb9eClFvLv65Qp1p2fAffvYjycXkbxwKOM0+FSk/lLXKtS4lk2oD1n7ZI5+roPifuXz6vd0J3fMuka7y7+e8dQ7YhOZYdMvwTzUXENGTRKdYp3OCEz/9sXAa6Qu6YqTTItbvUfoPl/jn2jbyjvkA5gNNo0+SmBDGa53gmGmPVy3yjnNKKemhFnHgUkRH62lv6//9Te8sDfQvcebnV7UIVwn6ONkb6Se6c3L4+5hblHXd7WSono5RTJoq+ehoqKzrinCFpoSNB/mz8Ytjkq66WAjbBvA2m4tQ0/gaAJujLhCxcX+14h4WVTY9vLh7bQ9sRTM2tH+nTLbuAF9cGteiR0OtRmrlt3Ool2KKlfzoIeAj2o40d93LgpTtOLtCfjx3SGCjxUe1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(38350700002)(86362001)(26005)(38100700002)(83380400001)(186003)(110136005)(33716001)(52116002)(5660300002)(956004)(54906003)(44832011)(4744005)(2906002)(1076003)(8676002)(9576002)(6666004)(9686003)(66946007)(8936002)(66476007)(316002)(6496006)(66556008)(55016003)(4326008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIdBl2LRsN72neC+5Erly5lpCnFk3pUbnA2IekQM/LmAzjkRhF+s0NRFlLVQ?=
 =?us-ascii?Q?xDE60C9jrR4rlP4mtC5Wjt/o2LIY0gxyzEsmijXKZyBukxOw6NeoK18pDDKW?=
 =?us-ascii?Q?qwblEAXX9p7CpQsuQXw9/zXDwc6QQwPRsi9zxabdjvXGKdl/1ehlk1oBOt53?=
 =?us-ascii?Q?NbpI6rWzgKzD+ohVDOCtk3iRzSd7ntfFqOFderKrX7O1nzJCI19L+mEkhD2M?=
 =?us-ascii?Q?iaLbNK+hJ996+03LGR9sb24YfEUWklfQkNbq3idAIW1391M2Mw5ToMMCMsjx?=
 =?us-ascii?Q?I57m2Zv4cMsm5QjBVms1Uo6NUaI4vx9SHeFNfrYvdNrinmIDblmGZ+H242Kd?=
 =?us-ascii?Q?29M5ZhH1l58VuQKz4+Z9fq7YR33LuMdBfx1cfGU60rxOqcg049+ta02HGciQ?=
 =?us-ascii?Q?eR0t+US0FWlN5YCVHZJ9SuIV5DH/lB49Vt+K38ZGRsJDqP4Oo4hnE3NENMzp?=
 =?us-ascii?Q?RMaSJX1bdES30Fun/7Pq7nCorTQ3CT30WPROyYwcwxCPPXZWUK0JsCPrmblf?=
 =?us-ascii?Q?hm4e0LJHu7eJZgbOYCLAJ71uEFCf/IfFtQnSdHcG16k5BDby/ZbTpwUni6ak?=
 =?us-ascii?Q?SIsDPGG71DduTvI4dQqtfCq2op2cqUIfqVK9Ymszt6a9bG7LRgdNxUOAMYJU?=
 =?us-ascii?Q?ZSWLBULyzI8pQWPeK0KqgmO7x8/k+7hBXGtS8WMrfH/nEIMXUSANF/zDiUOC?=
 =?us-ascii?Q?66iZoDqVtueKCKVYuy79Dz5B4UUg3MAOeIF2BuJr8vJOzJxwMfyDdDyMd12/?=
 =?us-ascii?Q?n7LvzCFQDttiLihegOAkq52p76D1TT8pYVTPfm3Ro9BDXAlt8GYku0Z7sw0F?=
 =?us-ascii?Q?sqWaDNKtX4gKK6HQLcWiBJUfx+5aAOu+73rCL4HTs6wH3EKKXgAxqA4XqStm?=
 =?us-ascii?Q?qwYAxj1AcvFUFAg7g+24Yc3a1DAjK4Ce7JTBMLanjfGAGZqO8Imzz8JcAy2a?=
 =?us-ascii?Q?2f76qSTO2vtH0u9Egkg8ytbhd3juDhooqueQHt+0E/s+IIeRbshpSbP8JBWY?=
 =?us-ascii?Q?iI3NS6s0b5Wa+47pl+xd8YGNpCBprvETeTib1JG9soKZiO3XgmVOVhWsijVO?=
 =?us-ascii?Q?hyfCwF67QyN8bqm3zvnh1hErqeUiYyMq3OwBP6ih9go01ANVX1ACtHCykMPi?=
 =?us-ascii?Q?e/O9Ct2Vw2aCY2AuPx9PcD7l/gm4MGgtBsYQoQ6wHE2V83H23Sb/ZdP5KUyD?=
 =?us-ascii?Q?FiMjVy2rVwstHTR8AX8cSmcVK9gpaVHjlSGzO3Hh0vyW4LYYPa8ETvUv3cQ7?=
 =?us-ascii?Q?vJ4K6PiCj+dlsUbctjO9nLo2zQXkFA35Rq4/1AN/IGkXJni4EM6LhfSE94k7?=
 =?us-ascii?Q?2oSsxy+4UAUiAGGyteV2DZxv8rMMX/P0rhtdLB0zI+4D/sy+hHutG7sEoWvt?=
 =?us-ascii?Q?KrjtCaKiUKSb8n1iXJaffm3i7Wkb1P/kunNvW1lvDJ6olpcCbeK5jPmlSqrt?=
 =?us-ascii?Q?ig7JercA7DFi+GxVMPqV8hMb8JmLvJpI7FIKREpfHGeACEbjlrPwlhQV0gD7?=
 =?us-ascii?Q?tsgaCjSdWRN7HW8qivAdoCTzMKjMJWFUXXYRCgk0nf/XbUG9IVYXGksxr4pf?=
 =?us-ascii?Q?/I0bQFA/zwkjPp1/R0XM29KD8ysBQmx3Q8cz39zz8bcGzRoiPuWE4LGJtyw4?=
 =?us-ascii?Q?/dZ3ZxD0MahtcpdMvF2yw8+6Sf6ZU2fffB9J1vQhv8Jfx6K/txLDDdDe+xCN?=
 =?us-ascii?Q?rdafH+EMIQPBcwS4qnf73jy0lTM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8b09c-b43d-4793-abbe-08d9af5a4926
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 14:54:16.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpfvjf2Oe5xFvyvhpLi2qpsyqTaAuOvQksBF2TjQl4xOcqEVtK0QBIxKXFctg8Yj3aSde8LPjuH7Bn3qRJ2cPwmr62kKjFPJ0asXcLcsbyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240083
X-Proofpoint-GUID: uXlz_-P4v2vZIAEtbnKSuDrnAlOWfWQ7
X-Proofpoint-ORIG-GUID: uXlz_-P4v2vZIAEtbnKSuDrnAlOWfWQ7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __get_free_pages() function does not return error pointers it returns
NULL so fix this condition to avoid a NULL dereference.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tee/amdtee/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index da6b88e80dc0..297dc62bca29 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -203,9 +203,8 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 
 	*ta_size = roundup(fw->size, PAGE_SIZE);
 	*ta = (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
-	if (IS_ERR(*ta)) {
-		pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
-		       (u64)*ta);
+	if (!*ta) {
+		pr_err("%s: get_free_pages failed\n", __func__);
 		rc = -ENOMEM;
 		goto rel_fw;
 	}
-- 
2.20.1


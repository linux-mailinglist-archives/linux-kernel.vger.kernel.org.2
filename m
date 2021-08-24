Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7F3F5968
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhHXHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:52:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35176 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhHXHwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:52:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O7LrjV028126;
        Tue, 24 Aug 2021 07:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=l/VhNxu8IQl8PPUrDbEAv7kyNBjLZrE+YdWmk9wG5mM=;
 b=Px8RKnf7fgci3nSAW1opfXwKKOPzpo+mQuQH0U2Di/PjFjP9pb+rnMFfu6FCL27KQKwY
 uF4mwYAQYYpBKbSmrDV7pzmBEdd5fqkhHQKYdCbd6WByRW1OPajOlIA4SIM+PRy9eW+V
 DT7TwvYjFnwvITmKVYeTiQVKdUXIP/nCMKjdNAQqEW/yPPS/NxUOPnR3hOEngeq1MNM6
 LSMXQJLDtMsjnyNBZGKtcM81aZbTwYVoqViUDR5NGquro3URF8EXSKFzc8TaPvxinnu7
 DtolBAB0CH8JX1uMguf9obGYYT6QtN4fKAhwXOS0RZaXXiUIpDpJplzqUB/4Y/+s3LlZ rA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=l/VhNxu8IQl8PPUrDbEAv7kyNBjLZrE+YdWmk9wG5mM=;
 b=CQ27EWRjbhDJWQPVVOKmI3toT6VUsVUvkhLsPL9k657d6u8IBAxH+atVuZWbTt95cYWr
 GuHx3w9fZ3wfRpX9nOrdpoZwDim8aLZ7IKGZn2we8b4deD7gJwPUhugFSgszOIVEJnIc
 oqUKbc1A+zOUttnHqQN48wuf119WasK+5a+USQn5KC1esivykZRTjOOEHPk+XLdZKX7h
 m4okAqoNjSQjgPSBIzM8r52MzWHac8Tc4qR4i1ur2S0n0GlZxckamJp77hvAO/b4QQ8v
 0Cw7xWxb4hATHW6NkzZ35jtCHXpvWNlNbJilmXGntRODlDwOkUlrvmLGZrsVnPkI0VxH /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwfm3m0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:51:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O7pK3W038917;
        Tue, 24 Aug 2021 07:51:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 3ajqhe5e9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIqItBn4jh12Wi7mr0lTT4UhnxJahRy0v1d7IPrbCStLB5X4Ic+D1d1Fl91r+ypBDfLYo/qz7ol8jE9MD/g8p0QR6cZjok1eSp0zmZUu/BAwgjEjhFQ0xwbYlDyuXVXU+WaiPXHzaXMznF8XuNKMOtqVVIDzsCR30bVCtUc/4PFhaM9r6vHd97KJOKpJrP1QGqsckfVO09xfVdoKUK9m9vYIaD9Bcb0XJq12gU//8VZ2bhbwVsLWnJJb81dbT/vZ4tO7XuBw0JkB+D0BI9ZUF1gvEtGcY2VRzsgxjPAVA0JVuMIrmMC2m9+P3EYzpmGrh0qYe+dR2g/RsZYEHSklLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/VhNxu8IQl8PPUrDbEAv7kyNBjLZrE+YdWmk9wG5mM=;
 b=XZ5WT8+Dq5O/Ty6eIOqeScJjcO0teV+r4lzcV7ahfs1lBoIzvFlkxs0dyURmZJNlOOFqcokFN0jH6hvCJhzybJeXfOveCR/9gFsCXFWDxHoRxbwzip0Drxtr/GaLX3QUz45DH69EN7LGC69chxxBw97mQlzBp2hD/2nPU/mPO/8l4Ex09XfeH4FHAXSsLjSfD4S0yTHKSnVFjVJEqXaM7uken4vfh+EieWwH52vgI/IuyHtzsaTbMnAHiuo2JQHIKUtSsviY3JHqE+oarjYEB5StsNYdpE0Uq+7wJgmNfZR8LVK8+dM9J4qYdWyo0yMawNwuN8OIzOY9MKNohkZLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/VhNxu8IQl8PPUrDbEAv7kyNBjLZrE+YdWmk9wG5mM=;
 b=S9LWJBaZJC00qHXT+XarVFc2gMe19hMUdSLp3/VmfUONsbRohDfyfRiWEBYmctXbKG6TER6BeEO+CDNZ+BYrnM8ju27WoWd0UdRBWV2faxE7KcBNu3r7uHUgLip2ACFk4u0YI9gk+izvXkqUYy1W1WUxxv0vKyMLWavljTQYjBQ=
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1821.namprd10.prod.outlook.com
 (2603:10b6:300:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 07:51:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 07:51:14 +0000
Date:   Tue, 24 Aug 2021 10:51:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3] fs/ntfs3: Fix error handling in indx_insert_into_root()
Message-ID: <20210824075103.GC13096@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824074932.GA13096@kili>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 07:51:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a484b56-4758-4b0b-70d1-08d966d3f2a5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18211DEB8D9BEADD2F2352B48EC59@MWHPR10MB1821.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrTog+O/vdh/Zt6dnRkTLrrKiV/IEe2JzhA34QlpPQOI8b/hUqHB7E3Kj4R2MfdwTggwugU6bWmuU0Sif7Y0X+LTW6YlseaNtNVy8pHSa1keRFqkTm0zUO1P7lWIYM/q4uxqsurIRk3gJjag9mVWd4emZOOii7XHif2hc6hiZ6TUd3kh2ynKvgEZdgeDG4Nghl74x1s16NtJYRUPuqzYUhOX6VGuIlgn7eE0hxSd13Wv6CvV+iTL4jXOl3cMwbMSM7ZK7n72krgTPorq1wr+5vIN00OBnvfs187W3Fh+jtJLQS9+2sD9fSDWgQM4wAt9FxLQUnkY9LfR/NoXxssB0MuhpEXfipzNZGsFIPO9NPJRbC/AqrSHvKjqbtpOHNxiNyip94rnVrBkzR/39ik+Uv3aH8Q16k2kJNy8sMAxK53ADuYa5xZ7D/lEBYkzZpPrSoTACmtilyUqKKx0uxHsIlJrnF/32Aj1NNCTkfy/jXnYh3ShJ4/IZWFDNhywXGW51LLg8oBBx1w+wJHw6WNz5UabKr2SuqHnfTrJx5RhuvdoAE1jDMjfBtHi+bMs2ds5IQApJmSLofHrgX9LVYhdpZA3Xn6rKD9mXSbLXnXOUstdsb3S3zVsdvKQJyiE3r/y+xRiyvA0aZsEmVVt/Hgp85+S4EdaXc9X3yPSvMfSGMkWbgxMK7nxALxecjWdgFibQmn0+Y7ojAcpOrrY5DYwcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(1076003)(9686003)(956004)(86362001)(6916009)(55016002)(5660300002)(44832011)(9576002)(6666004)(83380400001)(478600001)(33656002)(186003)(26005)(8676002)(8936002)(6496006)(66476007)(66946007)(38100700002)(66556008)(4326008)(38350700002)(316002)(2906002)(33716001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6M4GmLTnE6o2jAZRCK6Cw1pNHQUO1/UDfXKfFnQ2sjdaU179vY2nvw+9TFYW?=
 =?us-ascii?Q?kTgZBBbpGskxTwmYzZFsIx0h8gz3/+nW7qOzWwdMeGOZI9knCVLUmqAs0kH+?=
 =?us-ascii?Q?oEg1S5dJQT+F3IoYLnmxoxBP8m99KgXzIH/9+FuLXASt1JtYkUwecuQpfO+u?=
 =?us-ascii?Q?QjBLK1SeCztG8VXCYbBP5hp2WhkkLuw5PWFnn+iqaZWOsncrl7tsGE4aH8fw?=
 =?us-ascii?Q?rj/+pcl/OKYutymjEgrpP1UuRcSMEkfOsrgFqZg8dDWuuIt9CCVvJOhUAHur?=
 =?us-ascii?Q?6SQhGK7M+Fgpm7K6/+AQlLSgX30NplrPMHLMd3sG6EXO7+18MNb0lFOPSKcp?=
 =?us-ascii?Q?kPhiio3iJRMvt1iLqIV8YZuf8kebQVHa1NN9EAw4rN/ZtAmU0enasPRK0R0l?=
 =?us-ascii?Q?m6YVy4mt3Q1MoquFBmBeSW6SBuBWalxLfaWEBP6CDJO3NrP5I0gVgvtoGnyA?=
 =?us-ascii?Q?J+31AALV634CDhqO1tusZAJEmzNxcRc4IVajhLZJJmbO57rrDydxqaH1MFxm?=
 =?us-ascii?Q?kTtp/nnhwZuou3vJysl6TxsbMdIHaF6DkYKiIu0DxU0ZxBGgjSPMLqHRqOEN?=
 =?us-ascii?Q?MmlEBBf4V9NUoHuMcZGMQ45OoR7DsUnTwvXpobIQjpb2gGW7qioUFfpcPCOS?=
 =?us-ascii?Q?MCaXnYTA9YO4VjmT9fDHUi91AoaRPTQOFm0PpNaRkPzS+Y64cosdRSqsu6Vr?=
 =?us-ascii?Q?MCp5WfwCI9MOCFjBW7OKiffR87Q3pXXxcp59CoTS6T1Bad0Vlda7KUVKHPGO?=
 =?us-ascii?Q?0td91CQP7FoEtanazrrtVLS7KsVN0WK+c+QSiUzLAK28Mmtd0iNTIcqfnVLv?=
 =?us-ascii?Q?ywJtH8AqdPUUlitInVJNoVlfdovyRn8KWwlX35nsp1N3LjVNvbPcOj/OZTQR?=
 =?us-ascii?Q?Gj0JLfAi7GZZ33YiWh3AAvORh+mukP8spgHCIGvadoX/efGLfsYJsBHyKxoP?=
 =?us-ascii?Q?eBJRkyZI8j239tWPJXPQqrTW9y20Q7MIun9P579scob7Qbmc95Qn0Yf/Sgd2?=
 =?us-ascii?Q?MCUgO7vC6jPmNqNBBUy2MMKlIR1aeG7tOxqahw1y93VAYTQsJSfEolcUSra1?=
 =?us-ascii?Q?XYVvGlGCDBNB6oKO5VFC9MEkBwmgKk7MHQ9aRkCUMs8DqJKgaWD9EUSLbCUx?=
 =?us-ascii?Q?ULqRp3rZrxRkyfJic/OWTd4FIyztP7w+YRciLh0wc+Fj5RegGdhzm9GceKgM?=
 =?us-ascii?Q?gqR/QoDRBdlhVk2WyKDGAE5mJPriclEcxi89NE9jP94ppD/f2jI917z7f8En?=
 =?us-ascii?Q?nTrs+gPxqgDl5tr/Pz/5vAiq7eHGdaoZQLVUc+0Tweo66ljGscufeIrgIz6N?=
 =?us-ascii?Q?ydUB1mQZzkrKKC+/su/CPabU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a484b56-4758-4b0b-70d1-08d966d3f2a5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 07:51:14.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U39OwASdAg6WYnmOQWzelslUB7ifnIDCPdEn9kpfrC+Rx11MJwQteWgfM8pBNmF5uibyrBDzxKqOpbsQ/obSUeBu6q6yLgCQy5DPIUanUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1821
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240053
X-Proofpoint-ORIG-GUID: 8zBrQ5UIjzOfsJP3tSy1S95sUI1sYzTJ
X-Proofpoint-GUID: 8zBrQ5UIjzOfsJP3tSy1S95sUI1sYzTJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three bugs in this code:
1) If indx_get_root() fails, then return -EINVAL instead of success.
2) On the "/* make root external */" -EOPNOTSUPP; error path it should
   free "re" but it has a memory leak.
3) If indx_new() fails then it will lead to an error pointer dereference
   when we call put_indx_node().

I've re-written the error handling to be more clear.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ntfs3/index.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 489e0fffbc75..4f2d24010386 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1554,12 +1554,12 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	u32 root_size, new_root_size;
 	struct ntfs_sb_info *sbi;
 	int ds_root;
-	struct INDEX_ROOT *root, *a_root = NULL;
+	struct INDEX_ROOT *root, *a_root;
 
 	/* Get the record this root placed in */
 	root = indx_get_root(indx, ni, &attr, &mi);
 	if (!root)
-		goto out;
+		return -EINVAL;
 
 	/*
 	 * Try easy case:
@@ -1591,10 +1591,8 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	/* Make a copy of root attribute to restore if error */
 	a_root = ntfs_memdup(attr, asize);
-	if (!a_root) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!a_root)
+		return -ENOMEM;
 
 	/* copy all the non-end entries from the index root to the new buffer.*/
 	to_move = 0;
@@ -1604,7 +1602,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	for (e = e0;; e = hdr_next_de(hdr, e)) {
 		if (!e) {
 			err = -EINVAL;
-			goto out;
+			goto out_free_root;
 		}
 
 		if (de_is_last(e))
@@ -1612,14 +1610,13 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 		to_move += le16_to_cpu(e->size);
 	}
 
-	n = NULL;
 	if (!to_move) {
 		re = NULL;
 	} else {
 		re = ntfs_memdup(e0, to_move);
 		if (!re) {
 			err = -ENOMEM;
-			goto out;
+			goto out_free_root;
 		}
 	}
 
@@ -1636,7 +1633,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (ds_root > 0 && used + ds_root > sbi->max_bytes_per_attr) {
 		/* make root external */
 		err = -EOPNOTSUPP;
-		goto out;
+		goto out_free_re;
 	}
 
 	if (ds_root)
@@ -1666,7 +1663,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 		/* bug? */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		err = -EINVAL;
-		goto out1;
+		goto out_free_re;
 	}
 
 	if (err) {
@@ -1677,7 +1674,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 			/* bug? */
 			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		}
-		goto out1;
+		goto out_free_re;
 	}
 
 	e = (struct NTFS_DE *)(root + 1);
@@ -1688,7 +1685,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	n = indx_new(indx, ni, new_vbn, sub_vbn);
 	if (IS_ERR(n)) {
 		err = PTR_ERR(n);
-		goto out1;
+		goto out_free_re;
 	}
 
 	hdr = &n->index->ihdr;
@@ -1715,7 +1712,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 		put_indx_node(n);
 		fnd_clear(fnd);
 		err = indx_insert_entry(indx, ni, new_de, ctx, fnd);
-		goto out;
+		goto out_free_root;
 	}
 
 	/*
@@ -1725,7 +1722,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	e = hdr_insert_de(indx, hdr, new_de, NULL, ctx);
 	if (!e) {
 		err = -EINVAL;
-		goto out1;
+		goto out_put_n;
 	}
 	fnd_push(fnd, n, e);
 
@@ -1734,12 +1731,11 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	n = NULL;
 
-out1:
+out_put_n:
+	put_indx_node(n);
+out_free_re:
 	ntfs_free(re);
-	if (n)
-		put_indx_node(n);
-
-out:
+out_free_root:
 	ntfs_free(a_root);
 	return err;
 }
-- 
2.20.1


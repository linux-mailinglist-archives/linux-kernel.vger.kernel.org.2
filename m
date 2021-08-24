Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAD3F5D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhHXLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:50:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235566AbhHXLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:50:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OAKkTP030422;
        Tue, 24 Aug 2021 11:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1L0yX1R+KkKLYfIpu0kMbas6O2hnWehqqmORGj9SxlE=;
 b=jY6nxru8ZoDrNyQyRxuMG5cD+izr2ePTNOqv59nncXi7OKJvfAtuMq4I5vxYUVzx9mIU
 bO65CvtZY9ivIKYSsLd2ky7lrt17bb7tAcfWNYe9dn/2+XIJ06kmk4g6eGPkBpHvPRCO
 vbJwtUQuXK3TDJ4Hgf2KFrHxgRDrkqYOYcPQ0RmOofprxuJuIDjdtonhH1vsWTHOVGt2
 +yT6A708/PEiZe1tXmZIloLtSiocgid+Fs0dXIQB5spypnREG1xpfbEQlNjpdIveGTm7
 qkyvLKH1F2L2bDyI8xfrXD3ACfok/sUxePH8GP2aUikkYPpWF41ffO0lgRWS8YbIJ1de WA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=1L0yX1R+KkKLYfIpu0kMbas6O2hnWehqqmORGj9SxlE=;
 b=QSPYO+QB8F9Y96VTG6J5ZPfUL3xLIvxhWuypihB/UKXb4a2DwS4/2GvwEKCFkrbnWyRg
 eydIBVGHuHdFYT7vV8uOYa/UhK3CQBAJdcdON+EohXzNSiV789/SPWQ6L/i1zTwwk1am
 Nkas5zOf+/1wSBrSGbhWBntCaAgkVtKwzGWseKpdTX91ZQ4T9dEs28lqXM1BVM7FilDm
 SL7eiGPhfKAhUZsmn50zKLH2CmS91AOjNAKrzkQxgUvfrOZVYiTTZqjo+b7ASprYOkWG
 sqNgnTTtfL83zYImXBEWttDuR+O2gYhQzwt64yLule/2U2xyqrXesjj1/WZAY2hFj59F uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amv678mf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:49:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OBjLod192285;
        Tue, 24 Aug 2021 11:49:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3030.oracle.com with ESMTP id 3ajqhefnaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEnQ/lfynSFkR9992fJRzYnD0k+BF0lEHRo8ENZnuHsaVIiZg3e//Gw2z0AVSw0GTio8a6Qr2IcUlGfDyg2yLgnDa6diiHvy3M+oQRDbjmf8x5hQKoTGD/7b/OopHIp8FysdateMu6Kr7uDUjEe7tiYrthHp36UvDCjYYH9+2TLGNCtvFVGFrbD4PqnqlctkuWjFaVtMcrLDnKA8OvJESXLPfiR46Ag8ln2WocEjMKp+5WodmYbJcNwQuCBbCYTRDvzy5mBeD5d3yHXjSHKRHo3fSs929tWxIgEOkkN5hrmQytM9YER20iOoFpzptyC/hFVMv78t3iBvxBXm4rDung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L0yX1R+KkKLYfIpu0kMbas6O2hnWehqqmORGj9SxlE=;
 b=ekrPDMOOvm3L/9tr69DWe6L0p1E5REOk/FkudzrlgZSPMm2D6FT8ey2RGbkM9lVTaN48vzXFxDZvP5TlrXN/nf/PbAxiAzPSeS5Cmk/aj8BuzLHQkIRTAWrFYHfjTFA7D6hUdwlAmKMiNufFJCUuYnyvlJREbHOcQ1MxTFSe5piK3M31FaVkJ0quUQYotZrOHT1g/HaULYrlBDz6NVpcIlveL1ntsO6m3aqdLmgqleADVYK5PoMes0jxCMwe5VY7PRQKfhp/N02ymI2jgC8WfBYOFtvu6pQY19O+fVfWxDfr8ackxQNN9+guQc9OixrGTeLsB7sG5sJb0Kcro48KOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L0yX1R+KkKLYfIpu0kMbas6O2hnWehqqmORGj9SxlE=;
 b=eHGYIt0vUSuMP19zhWrPKnZps0t58FgE3qSehyb7Fgecvmw74lFVLj4DaPj3VEagjS9VW6TjB0Se4vKaZg1f5wL4IeClVXpInXLc1dW2HBxl5GvQuvEXjC+ieRXYpvvyMcsdZQGT0eEDwsaaODfoaiRNaDl96RaDkLZi4m30fiU=
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 11:49:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 11:49:09 +0000
Date:   Tue, 24 Aug 2021 14:48:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix an error code in ntfs_get_acl_ex()
Message-ID: <20210824114858.GH31143@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 11:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a012bf-89dd-4a55-694c-08d966f52f0b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB459560756F01653B0366F5378EC59@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAF+v07pyDuefIUywZjAMRfLi2cGFMptF7qx41UU1spNeZNAuG3HCdBmN8l09uZj/2w3r8s1Om2Y1U+LnzBVB01bMduSNqxtUHpmHi4jTSwjpGg0Oc6XyZ8D5z72IoMNU1A/VKOgJytL8WZnDDf0nucw+m/L5UxIzbuXhAWayD9gVmiQjaoUu6Ky4+cR2lVeWDejRPuUT5AluySZ6ax6ZKvA4w45ymJuRWGcL4Kr8+eJ3QOL06ucowWs3MiPezCb9Iftx1kmEkKb+D7T5bKfaZ7t5Uyi5/GCwd1t2F6up25jf3ZxIBRFPq+XOyEd1Eh42cHf39uxloNKsNDC0I1j+GtnQde7zVD+FtQXIc0KzkvZfsGr89JkzdA6Zp5C3WjuuGX/fL5yjeAzJ7gzZO6W0Nksf6Ha8RSGF6bqEZbOKJtTxY8wtxYjFq34GX6qUcriDc6o79nM2IYzPW/gu2XH5KFBMvDhzGkUmIe/6u35QbwDJP4sH0wvllOg7/clQgSQz97kg/YeBVdPkbaXURKTm0y5YLGwM9HMGKoLX0da4EDG4w9witAnXAEMvHLGgbC0SIzOgVlh7k9Zm1rfJclHwQvA7g+6Ui3H5G7I67ovwC/UtoaTHEUITLZayQs25SXJb+sUA/PejbLEy0RuNG8ndBmw3BwmlUK4jDRTR1NLKSyNXofi4YxfdDjhRswhQXFfSFBtLcri7wZ4kuQCZ8IKNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(38100700002)(38350700002)(6666004)(1076003)(86362001)(9686003)(66946007)(4326008)(2906002)(6496006)(66476007)(33656002)(316002)(55016002)(52116002)(26005)(478600001)(186003)(5660300002)(6916009)(8676002)(33716001)(956004)(66556008)(83380400001)(44832011)(9576002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2S84Ub24d/Z8F8TpGCndlbKb9bXtIr2gpdJbpFn2wEZQfJgJJI/sKEaJ1skU?=
 =?us-ascii?Q?RGn6MrbMPuIHvm+A+j9ADp1EhwgZJBvgqnCdau/GNRJXQR2kr3WYsuYcW8Ag?=
 =?us-ascii?Q?RQvdYfL3UDclpQTuiwf5GWfh6m7lQYB8oAfIH4/mDFoWiDFo26vgryqyUzbg?=
 =?us-ascii?Q?AyA1X3VUhYhWjXHcm3Th+sTSUWhw4i+7jDNZrDQi8VfLleNn3+xG80KEcBbV?=
 =?us-ascii?Q?qixw3eLUqq/2xMdGX1EMZP6dqXPa0iUFs9GRObtXlULPs9jcqZFwU6zEsiKC?=
 =?us-ascii?Q?130RswK6/dqmqS9QtEJ79upSnRzK3QqRp6nX5UYfPo4zQCjeGPko2EYbT8uT?=
 =?us-ascii?Q?X0a2ULU127Ir1gg3iuTrpkErcdkEVFs1uMkEOSI+ri6DfBRMSktlVcB4G7gB?=
 =?us-ascii?Q?fuxh6zxbZlhOkIRD8hppLeEXInJllbjdK7U1PfVQrz+xiYcoxiyhitpyOMBt?=
 =?us-ascii?Q?3ZpFP8jkhkTDynThLp1oyjUWfuURK3lMkP5YWu9A6wVtRuQu2MPm8BZpwBsh?=
 =?us-ascii?Q?/bQWnta+UAuYSEpgQo6Jp4Muqcn5cKwsLmIP/chj/qta2C4Yu5Rc4d1SrR0C?=
 =?us-ascii?Q?KnFPfBlDvzLJmxi8QnaQl/caacPovhhB0x+cIpvkxUy0jt8Jmh5EmzdcBPA5?=
 =?us-ascii?Q?QDC3Pgmu+ozHGFMuLBknoh62s0x36Kk9yzm7Gq8/L8QlGJac/vp5v85h4NYT?=
 =?us-ascii?Q?2X/XHPbl/KpOsF3/RsGDyRH5Duz3RuJG+WuBZw02YR2ApbmuwgSovljunRXn?=
 =?us-ascii?Q?eICfoL4FFZNMwPzXf01jitupBn+xBqtbGLoc4OoZAUoXXlEA1g/biib7uM2b?=
 =?us-ascii?Q?pNnH3ahs+HhcJ9x42xbg9KaEFNRx1G7XFgd81xh8vm6ntXBsE63D3U6rGhLM?=
 =?us-ascii?Q?MH02jvbznElJlayzlw6xdqGoS4WSq1a2GRzLxh8OmlU9Q8EiS/xROV1R93NV?=
 =?us-ascii?Q?W9FyhA2k3S6686UiNT86glpy6x9SL719TFIkCmtFjwqmYo97K8dpP2mDcREh?=
 =?us-ascii?Q?RitSoyCzUKBrstW1YAEbVauN/muj4akXa1ivnFVYi2ItOZ0si7LAoQYHJHpb?=
 =?us-ascii?Q?GIhXmad43PhEJs5SdDNFHNAKpwLNZJulKUtRQM5Z8q1CL+Rd+jMWNxGb3QuA?=
 =?us-ascii?Q?NnPfFpvf1ce5srqPRKFsB9BIx6Fv37szDewDCebcP4wtqfOml8/N4lE+aqnO?=
 =?us-ascii?Q?+ZLBoH6MDW3b7w7TgcmeRvM/S+/pD4tPLm+8C/JdZdS5zAqwagIeFeD56ffE?=
 =?us-ascii?Q?hEhoYCBV4p9VOObEc2b1/FxBLlONy09L+j7ht04gKoWTYddgmcTUnvxrXhiZ?=
 =?us-ascii?Q?6QMOLJaKXezVwrFaQ0XGCBlE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a012bf-89dd-4a55-694c-08d966f52f0b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:49:09.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU7/2lQgVoze+y/o/MmxE9b40hNKxm1GXccXuvHNtrvlf5pQ7I8EXYY4LNWJ+BBq7qcjY97wobehCApdPoL8f4ahwm9Mkh8slGEgDfkztw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240079
X-Proofpoint-ORIG-GUID: fESl5YGN12tV0eyGEQ1QPncp4M508hhT
X-Proofpoint-GUID: fESl5YGN12tV0eyGEQ1QPncp4M508hhT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ntfs_get_ea() function returns negative error codes or on success
it returns the length.  In the original code a zero length return was
treated as -ENODATA and results in a NULL return.  But it should be
treated as an invalid length and result in an PTR_ERR(-EINVAL) return.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I'm not super familiar with this code.  Please review this one
extra carefully.  I think it's theoretical because hopefully
ntfs_get_ea() doesn't ever return invalid lengths.

 fs/ntfs3/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 9239c388050e..e8ed38d0c4c9 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -521,7 +521,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 		ni_unlock(ni);
 
 	/* Translate extended attribute to acl */
-	if (err > 0) {
+	if (err >= 0) {
 		acl = posix_acl_from_xattr(mnt_userns, buf, err);
 		if (!IS_ERR(acl))
 			set_cached_acl(inode, type, acl);
-- 
2.20.1


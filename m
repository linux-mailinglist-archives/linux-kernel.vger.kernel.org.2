Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC43F7C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhHYTTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:19:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60070 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235172AbhHYTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:19:13 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17PIOAbb006325;
        Wed, 25 Aug 2021 19:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gnSzySOU7HpWgImpWmrnnrgL+J/j82jP3f19i0zkOTA=;
 b=B8j+cdx0TGrJaY/+tAsaL0CdvnFNMP1eBKBdfCTx+Xs2qEmXK1yW4RIQyYZUj5C4ZauZ
 0OVIMuG6UcG5cMrlJZdzjMWJUo5BLglf8JxIsLbdtx2d6f1hiPvmxrEge/9kpjHyhf2v
 suMiqc5YrN6yuyzspf8LaS4NfsYI8DztEMfwjERN0x8IYstiXt38c758WvCosDPbnAuy
 5JgVeERRBgMUD8Z4OQFud5RPRb6qgXUfo+nAbcHPefvpihwYA18vf/qTMQLsPZofNEbp
 RkwoUi4d1vCnuRJItTccXLi7y1M/alNGNcBdUN7BQ5H52mouzeCETWzvq3ks4T0I5t6C 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=gnSzySOU7HpWgImpWmrnnrgL+J/j82jP3f19i0zkOTA=;
 b=SV6WlEEgygQzl2obY6h/0bgoTDA8GP0IngEyzy7Ta3Z+jXJx+ZRBNyiQJkaW09IXK7O+
 ehB0Ft8zaiQjb9ER90mzD/mr+JfA47h3k0ZydIHBFd7z7lAZGHKZQ7uiOdBCaaqeX8Fx
 nWjolMQsKS3o/h2GTyutyemDIiAXn8pE7tArzT5cU7hOJJil8eHGT6P+bom5Eo7BBOut
 7vHqrtQ2HgQ3n/9tG9yJ7uyVl6K5H0PFky9marbJmebu5ezIETbtqIT+to7QgN/lrn52
 i96/rBAkxnAfY5Ko9HkmeY9MANUO/ZPIyogeEf2vbNnHjiM2W5TjDCu3EBzkTz8YGe3G hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwmvcetd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 19:18:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PJFJ4M180194;
        Wed, 25 Aug 2021 19:18:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3ajsa7w23f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 19:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRxe1RqOiGrNVCTuLKkUwK7+BMmYeiN0RacNfEK2upDRU3YAfghpbxNV60ye7wKQ5Gp7aYNhMcCeduPP9LMHap0EPgbQNNpIMaPACqyy71R/VpxNqlHTq8vk7zN8buUss7IqsH2LDp2G//RVrUeDYDAEcFiy7rfKQpjxJR9h0jhQ3G3FzPSBWnNJbZbl1cKVXSfFxC+ykEuenZGStcSpCiOOeIAFOypm3vGCKpwe0KUBLxuRrLmJtizEvLNZtiNh1wxevZj4NFIlhIoGGBB/ota1aEpaHRqPst6L6qy3afadXsIQYO5IFxy0Lx7RraCT/Y1kFFJQRrXoq88T+xIE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnSzySOU7HpWgImpWmrnnrgL+J/j82jP3f19i0zkOTA=;
 b=g3xjRHlyJr9tjX3xna0kqsCOOqFv8W9BuPS+XvxS3UKvZzzQn56/sHqdlY60UyIPLm/QZqRKsA37CdRqv2+ZapgHUqQzfTI1+1qCoh5Usd1AEJd9KbgIAWKCyM7qOfKjrmDy/OlnKE34Ud3LNhEJM1t2ydl7zJvU66nZ0NlkfFbs0vVSUyexIMXbPBeavMoaMWWsliZW13Jpec7TpRMCE9G+T8LGrBGFuOSYL7MI9dqUPP/IdyIF1v0PzONrjWlxEAQQ7nDXlNlZnjzY2ykJcVZJRf8bNGE0PK5I4e/lKYqIL5f5NIKccOrO72XxuCeXwui7oLF08H31cFftnE9lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnSzySOU7HpWgImpWmrnnrgL+J/j82jP3f19i0zkOTA=;
 b=nBjMuloUmYvTg206SQuvMFuZcYj4y2IYIKVWcfEnNkKku3IN5GNQLRl6NUk/NSOle6uo2WTxpNgOeN2fTH2x6ScszyVeE3u1ufQJrrbdTxgbrcaGFtZOcalAD4vQb9/k/pWaD53277N9pI9v9b91f2UB9FvgfhgUumTtCb0WrF8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2205.namprd10.prod.outlook.com
 (2603:10b6:301:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 19:18:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Wed, 25 Aug 2021
 19:18:19 +0000
Date:   Wed, 25 Aug 2021 22:17:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Remove unnecessary condition checking from
 ntfs_file_read_iter
Message-ID: <20210825191757.GW7722@kadam>
References: <20210825182522.1367594-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825182522.1367594-1-kari.argillander@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 19:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdeb3a57-0b8d-48ad-d703-08d967fd18fa
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2205340558427A9E82D81CE18EC69@MWHPR1001MB2205.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI65U3Uy0SJf+EzLHGiKfGUGGTKQ8NfaOlpcOiz/LF2OX2FvrjZnS+da7x6cgYIKuAJG7C83OKy9imK8H1IP+VFSolkBgLPKcBMoeBxmn3vsqHORR/ciBI8dx7NYXoNWpBBl1AMjF1mxyNQp1LjZ4vcmN3WBd4myddk/ldJB2Qper/5/dvS+xJTIkbUk6vEeCN+fk6Ko98Ub+XlOFh2P/GqbqToCS5asMBiJXno+ZB2l3xr6mwvTSy43g3wmuoHt/REo0/DN/MbMKYwQG7nGlJTv69dvl0VEg806DCq/We0mn3nPsTLm0SigN6gUZslBu/MWYrNtPnY9391FMsbivp2w6KYw/SOriAgb/J7cqzWo9cycGCw5B3iL7TrC4ruUtNiDEL1vurLdayqJGKCHob41HxZ/4BO7IW0TxIWed+tez+f/TccddbBix8d7SUcY3WAJT2ROiNIWUf/wu2hftT0o3Ajrhmvegbn2U+CBBJxFVjadgSD28o4tU+KyFYBtULJo4ua2zZiVxOP42mm4gKX9P7UI5+HNxBvco6fYeihifgP9fkQV/oJmWO/qKkNF9RQAkYdxUWqHY8TBaR35dure7+NOZSk8u9XL2knFbtY469SKeg4LPMtLt8A5ALAze9J2qUpqQDpTeoS7OObYveNyGngP6jMbcvOma1B1mU8dgjUJbRaMkDiYxVH60jyM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6496006)(33656002)(956004)(5660300002)(44832011)(86362001)(33716001)(6666004)(52116002)(186003)(508600001)(2906002)(55016002)(9686003)(1076003)(4744005)(9576002)(66476007)(66556008)(66946007)(38100700002)(38350700002)(6916009)(316002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzIAKx+pxm9uaVIK0ugM9NodamDDercEF4rxIclAoUzG1ierO5YCuHb3d4tv?=
 =?us-ascii?Q?W3h/n0WMrLGAeu0bGrJBwQaTAhyQQETwgjwHOAdHS7Y1JGRcBRWnIeHQY2NO?=
 =?us-ascii?Q?zhTrJplFydov4xaHJbcATmUwYjZdgC0+XF3oGYoR0Mivnb1FmOiOnCoHeksr?=
 =?us-ascii?Q?uPmj8Z/JGeg3Z9g4Ilp3vHQCREeupQWUCpnqNwhomy41mJJGqd9S70tPw0uO?=
 =?us-ascii?Q?s2XcFQhGTviIXi+J8/D33BDdUR4MWu6oC6pSyMcORlhmxkP7duBbrKfuNBrA?=
 =?us-ascii?Q?+ct7RDwrNQHCQxRXntlquMiw8VGBbEB1bkdZ0HYTkiUjYsgjzYDrLq4FB5mP?=
 =?us-ascii?Q?uX7UQqcAvqGOPSURewCaAuxAhuxMrAV0w+Y7l7vgqUNZwdicdvw51syL9yH/?=
 =?us-ascii?Q?JZL87/HUGBgJuRMggFqFnOub2s1LVzS0+T8cN/B0cl3ASs8ZI42luyOko33H?=
 =?us-ascii?Q?r2n/CD7H9rU67+vx392Rr1POGQsUlEwx6Af+ZtzfsC0/ZM2OEqaLeIuG5yU9?=
 =?us-ascii?Q?ForrrrAdsO/O2AJv2zzce1faF9FoZ0z/0wDmAkkLkoJZKoXnpI9yDUTB6QgI?=
 =?us-ascii?Q?LKj5lIsSGs7uNZ/n6jUg/5pIv8bFZbLdHOBlksd+7PFFalIscZXNKifyT/CK?=
 =?us-ascii?Q?xes76Qf3wBPE5WOv1DksMFzt0cNkrcpfOF1/Qf9vbgXOV0g3vBE/nvZhPzyo?=
 =?us-ascii?Q?RvmLO2cRc9r47FheKHPNP0q4Z2aoxSXAUAbHSgJ1EgCq3Nw/rbPjGh9z202+?=
 =?us-ascii?Q?5T3sl8w6a0hitXTYcz5Rffig9JVEjhNtzFfUH1QqTtV1LHgEGyJNHwTYBdIx?=
 =?us-ascii?Q?Nf1a0LZhuSAfYnPGyFA5/Cgzy2OUxcTpNChp5KH/8UUSl3xeOghMZWDg95kb?=
 =?us-ascii?Q?nyg4DtIX1C03eNg7yLNXBhHkAWRBSzk1wgOACrnznXJLNLxWKZ/qiqDvPpEc?=
 =?us-ascii?Q?8hkHlU5mLh+ZyMJxIzyaOQo53x9ITfDB7yzBSpqljv1u37Gv83aD3vwRl4Jn?=
 =?us-ascii?Q?JrGqvbdr+eBR3JDlV5d59cCm3GZ/Hs/3EkpjOPeY3pIfrzM8RSlc6WNGTj9J?=
 =?us-ascii?Q?av1N0eT8lQnQ+BjimudY5WD1B/hqrFH51Hqpdchq9sgiR/5YyAo4wghTBqqS?=
 =?us-ascii?Q?s4QPtzVPEXbPyRh5rPM+aR+JDjkynPbUGqSZ6KFHhlmEDaKyX0sFtxF0eljx?=
 =?us-ascii?Q?GRXmZouX+2OeZF8mMrUXLygYxzUtskywUNGP25JFpNhDJ2yi4r+GKY4VyMeb?=
 =?us-ascii?Q?iRdLnXvrX+8mkeIFb3DNHJ4g9OL+eZ/dmtM44EJBlb7qjZ0EYkwrjrOHxenJ?=
 =?us-ascii?Q?bBbrbIAlFB45iI1VWXiGyYOD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeb3a57-0b8d-48ad-d703-08d967fd18fa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 19:18:19.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58lgwcjOdVt4HQ9FvaEd5ftkvYRsQ3yOgn8i97SQ7XJMojKNAtug2egVD4RdUdYqJO9EqMr6WX3EQNY4cdYjNAvDxmGs7rlK7CAiAzuY8z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2205
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250114
X-Proofpoint-GUID: 1p6zHmH4v_Uv2v61AhGkoe73nJ1n0zjc
X-Proofpoint-ORIG-GUID: 1p6zHmH4v_Uv2v61AhGkoe73nJ1n0zjc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 09:25:22PM +0300, Kari Argillander wrote:
> This check will be also performed in generic_file_read_iter() so we do
> not want to check this two times in a row.
> 
> This was founded with Smatch
> 	fs/ntfs3/file.c:803 ntfs_file_read_iter()
> 	warn: unused return: count = iov_iter_count()
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> I cc Dan also because I am happy that I finally managed to install
> Smack and straight away I found something with it. Thank you for
> this great tool.

Thanks!

You got a bit lucky, because you're using the --two-passes and the truth
is I haven't looked at that in years so I'm worried it's probably not
great.  You probably be better off not using the --two-passes option.  :/
I should remove it.

regards,
dan carpenter


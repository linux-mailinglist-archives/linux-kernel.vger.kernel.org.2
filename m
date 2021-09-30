Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C241DA05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350980AbhI3MmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:42:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17466 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350978AbhI3Mly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:41:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCYMwm006682;
        Thu, 30 Sep 2021 12:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kIMNd/NtTHgFqbT/50TKb2BaXXtwdzKW7OVaA+GLHYE=;
 b=M8X+RCkmoLRrrL1trY6/LEFdVuS8GSSgeLpHcsYiH3GPfFLu7ih9C/3oLZLpdGAySSKK
 peLGf3kDnsU+Ecg71mxULiZNyOaK/nDARGCb/nhz8jv4IAZPArOQata69swHfW9RPfIt
 nmTT1tuy1KO4XxTQHIOGHfz19ezxJiF2p5diu9DzPTn1E5Jym5FS9WCqxiO8dDrL8smR
 MDcgrwb0VFI0rskhNDcGNuQfCUzRRrObTbGW2c03gaFmu9WhFrM1Y20trChcaUeDe/VC
 FSNYa6GO4SMbcFVXgNxalLEc6x8voPikeLHiB1QJkU4eXtbwf1nZDHnSVL32XBM+iMMA VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfm28gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:39:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCdmHX121978;
        Thu, 30 Sep 2021 12:39:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3bceu6yp0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAKuu7N4/oWdA2sZufgPWWV6g82Nj7cMM4h5VtL8rJ2d++cAe/Yim3hBQPX6vl8Sgj1DCt+9YFHKaAhuF5+PdgrSutSokCphZv9k/EZjt/24emdYzT8qBRiBy1+sbXNkK2pq2Tj8xhjUfe+qygpNYhHXFp20Y3vet6uSvk2MnA3pFPIJyt7YLo58TjgHWFZc9VFN25Ayto/qgZmscACZQt3OoZg9GjoYeU2PHN5IK2tsufBfpkNrwSzRiDB4Wd7E9LI2Hdso/TACKQNoOBH75eU2Ge5lwU4ZNMe8awOYCsolYjEIsRnED2rHAgSRPCoWzTlHuAyiubESpCyhq8hlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kIMNd/NtTHgFqbT/50TKb2BaXXtwdzKW7OVaA+GLHYE=;
 b=BnoK+zVbjVsmyXsWo3nbC0U7dEKUdGhfHcPKU8JovUzibmD3jjzivEPpiHpSm0z3oDuZB2alXcQFYTXabJvMa6adEB5521taBdHgEsrpH6e5IzyvlCa/s8XQabo9j/ESg9sQK4S0FQ79Z+A3Ik1gxsLN4GPGRniYu6yesrhXScBgyHmyREF76ysNlmRNXGRu/usvMTQpu65SsYXyk4ohYtS8a8ujYl68oyyDKpraWVwYwSM7zyg2DbJJcVIH2rPuRNpxkcaLbbRyR2IfqUS8Yr1o1mZrRFqqxz6Pc4XNgnQOJksub10kfT8vp8gA6bZeN6Muxzynxb/fvB6cLupl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIMNd/NtTHgFqbT/50TKb2BaXXtwdzKW7OVaA+GLHYE=;
 b=aOxSvvHCKFLqeZf87fR0nCyQlN1z8Q4Q07ZKlveDfV9oyljyJ47jvUwn3WOhC+SdM6RvIZa2DibpS4GmemmSiJhJjAcCZJupOgq0IIuwlsY7Bnoh99eIbHFts6XbW0I6k1fUj+5SXgqdl20vlqs/5How6oGbdUizIU8zZxwpsN8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 12:39:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 12:39:57 +0000
Date:   Thu, 30 Sep 2021 15:39:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove
 rtl8188e_silentreset_for_specific_platform()
Message-ID: <20210930123937.GO2048@kadam>
References: <20210930085542.10222-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930085542.10222-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.159.27) by JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 12:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14cbb016-cf9f-4184-2a79-08d9840f68d8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45133F84E8585FF5C52B03558EAA9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/h2e4zTJsjp0ysJbw7O6e85pluArFhpK3m+3gBT0hByY34scyTNTBcXqCplNNnbnzJsTQ/PUFt3K+bzaMyIn8jbsuLjy6QZkw3jOapmjnbQHZS1MYs2+q32hohBUVOqf5C3tJr9vBiKkoOZA1wSjoclGdaeHDgxhqhEZlniA47kOGx5nqnCtX1HRaw6ihiufHP2BlDOrwxaK4hGTTr3NQVhD9Gj9SuunW7OspSoGuGnWFlbBQe5jg8MsKk4t97wjMWTCzRQM14N2rnWooP3NXUz5wKhj6tx/2YQJeDJSHpazxFcvyc5wWnuJkmwJ//WtDJfKDerZmPaU+1AidZ12/B0h/J403r4hf3a9CEkAovfJDb1303kPBCDPfcUSMdds2TqnbeNIjhDvMdMao4f2skJ6BrboIG6dgcjQaaw409/r1KNDt0tFvmeBsY58pyl5ArOSCAKWVw0qPsyO9G6hsCWa0QCog4iwW7j0mfXb16ijKI97TDJj4SmGyb57Gb2faZwhueqixFO1iCX+Yf3dCZJM6ak8ob6OZATYh1tGRJr6zBc/s5mYaoLNAUBI3pBV26MBTdCmc6xsFZYUTK4mqDeH3qRej8oHlCT35dho9oBGWt+CN2K8R6fqZ8soXZAP9FVVdNwEh/Jm1n1mrDnVahFNIRxH4iKgUFPpZkaBvgyD4x12osuo4HJvJYbNHyE9CO6PKv3DaeqZz7Wx++MfdYPfdkT9/vbEwLUM+K9cXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(5001810100001)(316002)(33716001)(44832011)(2906002)(6916009)(508600001)(4326008)(9686003)(6666004)(9576002)(5660300002)(6496006)(86362001)(26005)(33656002)(38100700002)(38350700002)(1076003)(8936002)(186003)(4744005)(66476007)(66556008)(52116002)(83380400001)(66946007)(8676002)(956004)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JwdVp2YCsc5hMDDJCkLhXHlz6mjwuz/Tz59S28IcuLYRy08r6pQF8B4h7vgh?=
 =?us-ascii?Q?3UlZx0QW9fDkV/HwiDjjQutnY0hFlqSmRZtvuKIN3BovhmsbgButvE68W6dj?=
 =?us-ascii?Q?O/QRR3nA2N7fWjuJb1MPWMHzJcksnjn5vyPnV0hN39EOWDUCeQKnLOxYhg7M?=
 =?us-ascii?Q?yxg20UbWBiUx6exRv8gbZHGIE5HRMpC84hWg6p8Hju4En50ehgmLmnry3Tr0?=
 =?us-ascii?Q?PUc7zWcTHkc9Qmjt4w60PTVkc0IlruTQenV70nJ4D9nlpBlNQKX9fTuYfloH?=
 =?us-ascii?Q?sdXIfykIhxfjIcUPt/yIrL5OID+efYA95g2H2DmQw4wCly7OWtE9M614Ydcm?=
 =?us-ascii?Q?gpgtaNoWuEnpLUOXUeeXBirszivA1HBmNT92Vb1OvAoD0mE63XRRYxzBzpMP?=
 =?us-ascii?Q?RrEFvAVLnrstzOjhdkhsmFv1M4NS5wsOlYZtqFtW6ZZl/8d2oDQUbwmgtnfs?=
 =?us-ascii?Q?aTgLDVbx1jOhuwsdUxOYQiWvI7J8YO5/tb2UNyzwffL/LCe7ZXobUkj4a4s3?=
 =?us-ascii?Q?9uWtk4/vTstGgWhROWbMv+RYfMyY+g/tJhABLfrO7l/eDKs64J4QPrygdE1h?=
 =?us-ascii?Q?ZeM95Aa2mF2ScDMPSiZeUM0DZePcUoyC120aRu3Pg38ItNIv18X9rNx9mggC?=
 =?us-ascii?Q?cCOvl6hF+wFa7WiXvrnFuFji1RYmd0s95lFwLphbWuCHkIy+wsmmDUozoZCG?=
 =?us-ascii?Q?2raZWuQKeYSyx0QBtUGTfniyRHl/Ba6Yl5WjjrqIwCQ0yap+XGO+PBVt5X6v?=
 =?us-ascii?Q?aUM3BiUdxleirAn+duX1iNCbjcZ0RTtwfVECgNdRqxliEsjqo2udmz1GFZiQ?=
 =?us-ascii?Q?D0h3y51vHHboGw2QHSaGhbq8dauo2oVTIDxmpqKYjsZ0/QG0dTpsRq1E2LwB?=
 =?us-ascii?Q?LAZ9CWBTPvm9eVKS5I9jf41kNd37oLTIZYRnAejKWb8GPh2WrMYQFcSbcpmQ?=
 =?us-ascii?Q?KGUBbQXq7ZxK6I5vCcaZDU8n8CajWDZPnZ1cZppcXnyyHFBiS4Q3v+YDB2KO?=
 =?us-ascii?Q?rJdSG1YZ7hGEHJUtz+M3rjHn48orOTc/yybEUvwOjhrlDny7ZG3vFeUrvNWE?=
 =?us-ascii?Q?+IWllAhrl13FFJSFJUxPqN2rZ//HtZgJEcWXArO77H+SL0EluU+5n1EQLzoG?=
 =?us-ascii?Q?Cxpmamq56Qsk8DxtM8O6/Xxu6jmcgHvZICaNwmSRkvNpj+YexlhlxheVg028?=
 =?us-ascii?Q?h7f7l+xomixfqyRrknskrjz3E0mf80Zyt3Sdy7YfWZs2x91JKMfQdWWTtXtA?=
 =?us-ascii?Q?P/3vvXTXLbrBtaFC18bY9JQb4Bn5CNzzQsxy1AeGZHwkFJmneOD+iVWh7tEB?=
 =?us-ascii?Q?SKI2axgO6+MysA1O5GB5sNRF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cbb016-cf9f-4184-2a79-08d9840f68d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:39:57.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQhlQzyfK9sPcb6iAkbJ/+EzSnx8ozz9Tmm+qNYEVz8klOs8LHUxPyrRfLpyoj6k2NPhxZAWUKyUsj48UWFqOanHYT0xSXRFky7Px7tW9dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300080
X-Proofpoint-ORIG-GUID: CAqd1lQvux6NHm_okpI1aTynnSfLz5jV
X-Proofpoint-GUID: CAqd1lQvux6NHm_okpI1aTynnSfLz5jV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:55:42AM +0200, Michael Straube wrote:
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index dd47098ed1e5..852f8e0bbf64 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -4005,7 +4005,6 @@ static int rtw_dbg_port(struct net_device *dev,
>  		case 0x0f:
>  			if (extra_arg == 0) {
>  				DBG_88E("###### silent reset test.......#####\n");
> -				rtl8188e_silentreset_for_specific_platform(padapter);
>  			}

This introduces a new checkpatch warning about unnessary curly braces.
Just delete the whole if statement.

regards,
dan carpenter



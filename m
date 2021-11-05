Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE54463A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhKEMzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:55:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhKEMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:55:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CIHVv009152;
        Fri, 5 Nov 2021 12:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ALA7A0/9xtIwGZJvAsLxHWfXsFtXQTwJAXPrZUJnbAY=;
 b=sIUm+yLkSzv9DryHYvRkwFRXNLRis9KPGQuqf9P7ufwCM2CNZzIInPm98VdoC/j52VLR
 XboLaP7STuVjSXl/Sys2JmuVzsOjbqyYmj12YeI1Wpsookd0nHU7KXa4s/bNQuQewjYV
 kBoiC0/24Vg1YOA/7tf+SgLawJY6gdFVjOrs3oA/bkB3E6Ib2Nqz79uImyqs1nCaV2L9
 IxRtwi98Hxg4jtNXwC0ZDIsCMac2OrTQZcAL2ErMF1TDngf4wI5nwazehrvl/Uc8CoO1
 Dbe8iV85EX+6b/vIea/oNFuYU7+8llcldEOsmYgwAE+Pw1b36Lxhh+OSiETZg0gqXBBl hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7htcum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 12:52:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CpAkV043996;
        Fri, 5 Nov 2021 12:52:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3c4t5cxb1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 12:52:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le7uSPNxhRQ+edkTKsIotpTTYHHh0A5Fhl1CIrqfNjKIpyfnNf+HmkTv/jnd4O7msUrDMaw5lTg8pPMcwmbgqcFSlOCxxW1oOHIL8RTvfIIw3B08RJtW1deTdzLXtur9iNlVC91Nt1zDx9NZG/RyCbseJzRi/v44lWQJuQ7M1EQ0NCl5ElpBBzaw9c3w6TiUQJyt7o741cmrD/vmFb5fnPoxRUN3XlZkW6gioG/Ka9ILPdL53yroV4FB/+7115CHgXsuEInX/qg1DVhM9Qx4TRJOLz7vU6KPQQ2d+ugGyBXsFiVbQKdvuxdH9A/WvqYtvfokbIJpa14df0MkCa6bUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALA7A0/9xtIwGZJvAsLxHWfXsFtXQTwJAXPrZUJnbAY=;
 b=DcIsitxP5r8wU32N3MEIjY2w0Wv42DCU6nB3rLvxEOxaSUCsL6uCSDpTq602xkl35E0/3qYxo2O4/MsPKHcffRp+NX0CctVuseOBJHRQluTk8EXXRNupzRkJva+exzRiQjgEBv/Qgian5R5WrUBixtNjnbFQEA8hKHx60CdC3pGDDPQkcVDYP6abG0h/xuO55mfMVDIokm/SS/N70ZJW8PQhqFdxJ6pVLVkvvQ7gCu1xk2l8HU96w3THGnDguzA6ZYDIMOIpV8RMBrRPb+9AWDkwMU7OdP34ywPPUR/ZQVtGy/LlT4R0o5C31EZKsp9Mo74ncfo2yZviq8RWjrh4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALA7A0/9xtIwGZJvAsLxHWfXsFtXQTwJAXPrZUJnbAY=;
 b=ZpSRSKL975gapumCTfEfc1qP7YvkTkH8vKTIv3DfhCnw24ZSYWBA+3Ep9vyn9MNzF2nvGGfgfVKvEhFCm33o621wXkfvxXkaWkww8b5QMJ4slb5nKad3c/pYClvmanMYQ603Q0Lz0fqUITQ8WhmCYH7LCkcvri2pCCSgQkH4TO8=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1824.namprd10.prod.outlook.com
 (2603:10b6:300:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 12:52:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 12:52:13 +0000
Date:   Fri, 5 Nov 2021 15:51:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] staging: vt6655: Introduce `idx` temporary
 variable
Message-ID: <20211105125144.GA2001@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <34bd0e8f42597edf006a950d420345befc4e0bc2.1635773680.git.karolinadrobnik@gmail.com>
 <20211104120906.GZ2794@kadam>
 <2dd81d1a081562dc38bf9d8c6c73b432c5c5f496.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd81d1a081562dc38bf9d8c6c73b432c5c5f496.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 12:52:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ea7535-37cc-4f4b-0bac-08d9a05b1691
X-MS-TrafficTypeDiagnostic: MWHPR10MB1824:
X-Microsoft-Antispam-PRVS: <MWHPR10MB18245FDFA8A29A21C258CF9D8E8E9@MWHPR10MB1824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuBjQ5On+R3VisfxNyvr1v1j5qaZqd2ugj4P9AZIKwLYLVnyXPHIyAC+nQOcq4wUJIeLxiR2oSbOcRMnz4qTyZLUDraH34sb7sLzh5l3AYe+vcGh013sU+Y1tK/23CqwpSV1ufVtq6FWR+LI3aoFF6KrYLS43xVou58PbOE7oLzlClzQapq3zcVvxEh8jB36Xy3sISL9vvj1svN73dGNv4xWMektR/frhf6lzaE/sGp4Vy9kpnj7RwxpUJ3P3VolP94rnkhd8cpnKcoqm/AIGLcXp8F20xNI3rvzqjihoQhtbgMJbmZsqa1xNKxsdATUA2Ghk7wgSVxouLRhCd0olodX4wzStJZ25nXaLn5OFCzI7Syfc8rRWnLl42P1Kc2alDnL8XzPupEuoRQx+SpCZJmZwA/pcW0rawj+Ky+GjFl+ltpQ/5lVGpoaj5qPC0GsVCJ4SIje/YnFDf+UiNNohKfvhxqSbpeItv8AVw1x9U5UW1TfMYKEziMjjHOTFUjP+ThlZIsCJwCelxkGjWy333BzXBQbS/XFYIcEi9IEDiGwE4krAiYROs/gMrujWKglgiODk4jakvz6AJIDqxO3Rr5aQSXhruC25Z4mQKGqtev4G8JbIrYfS5IXFyXu3rjn034rSQM8scMqKD5SsGDzZsQHCJEUbmu3b0hSCNj6OYuFr/a1eDYHThwAjWxa/LSp26iUOV7PH4OIidoo8a5aMTh5HBVOwTh7PciKoRPFSXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(26005)(9686003)(186003)(55016002)(508600001)(33656002)(1076003)(38350700002)(38100700002)(44832011)(6916009)(956004)(4744005)(33716001)(6666004)(316002)(52116002)(6496006)(4326008)(5660300002)(9576002)(2906002)(8936002)(66476007)(66556008)(86362001)(66946007)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DFKUkNdys/J9Sv5ajrAC97q3KQQuC0xxH9+YeOY7g9tK40qtOLIPm1zul1jG?=
 =?us-ascii?Q?dWDtCHt8aBsBYHGHEdrfsuSml7V2h3ixNIwRlBNNbT+ax4+tyPKN6yShzcKQ?=
 =?us-ascii?Q?rRjkayToxVSat4kW40sw6syW+MKmV/vZCt0/yGYIjL4xRl5h4j6UMPHy4acf?=
 =?us-ascii?Q?shHy2tknrh+geJ3lnOEImStVm3hMvs9GFN9VdIfpMsiCdIQXSEqaBq5aMQ5Z?=
 =?us-ascii?Q?etPyV4yYkyHjrAiCw+y6gw0guo6vKHV3hINh05w1UTe3U9B51KH9hNfc7hFl?=
 =?us-ascii?Q?2cbKu2GfwkNrxv3OgX8NRpkYgVZpZmwENEoAgkvbLBbzyGXXq4r7thtnv2Bf?=
 =?us-ascii?Q?s//jrEa5xaTnzwj+OqlXMU5Js8XPt2LwLS8mENlBHRdHvc4ZYuu3uOdFJQ9i?=
 =?us-ascii?Q?AU3/aWUxUXcDOXXEiYTQR/oE/ccsRKy9RuRXVKUq5+V1viiwW0rmDz9GqWQa?=
 =?us-ascii?Q?91frpnrVgMb07rlpXQCmPwHPFizzs762+ttFWbR6Fjr62/i+EQweDZezt73W?=
 =?us-ascii?Q?hxxTMd66/IIJnfapks9L8+zBpYOJkwM6uSBTJcgDiWq3uNtV1eL2iFcSZxYI?=
 =?us-ascii?Q?nZcsdZW2bZhCJRgtAT1wpblaF6usB9b+oJjyZAFjjn4NY/l/JmwepD/ICAJ8?=
 =?us-ascii?Q?M5AYkSdbdkemWOCaTvKi6uejGeEU3K2Nk8p8x+Zc6RImYtPGQLERnJ3Etp4x?=
 =?us-ascii?Q?XYvx3uCB1PXx39BhzB103dxyUSkHBALJ5nAqmrX4rmtAW8d2e6LiPTr9M+OB?=
 =?us-ascii?Q?xxCivKtClgTGuIINhKkmfbBdv72ltCjooqv3gGeDECcLBCMEjd2P9oGk+Ox0?=
 =?us-ascii?Q?9a0UXESpXK55W3fx3zaFAuqEhlddRAveP6v3xv/TPRyC6Inzi7m+Ea2/n9vL?=
 =?us-ascii?Q?pYllwQDq6tj9L3jUTi2Edmqm6DlcCYPufXN07V+S/2wLtgN22wctP8MNZFyf?=
 =?us-ascii?Q?AEN4R8Xeqc1b3l4T6ToBvT5sO7ntICQFWUmNPcXxHcrEUJ1Cc4Lzpp7Goqa0?=
 =?us-ascii?Q?xBbI03B1q6JjJQSqgpW52fcHufPbqTZWaZebCoqS5dK4ZpOwka2NGmskZX3p?=
 =?us-ascii?Q?PXX78NONigLjqIcNAmc4caRu+lw2jNHYRyxzAcl6FZQnLWUQtUO+8wKVS7ks?=
 =?us-ascii?Q?AogTT7lQX4WFCcvT2xpw/UGpL2matbj8iWmKtI+jmSOX5WWEvdkARoupZn2k?=
 =?us-ascii?Q?BorPRdeEkXbcoHNgboE2fuQ/9KHWMDIWvlq5dcbUDYi3GKh1mKl0I0Z8cPGk?=
 =?us-ascii?Q?pdepzXEl39hKWnrVgadLu1hS9dPcHFnKwlytnsqoR4kF64OtiIW0KhgIFfmC?=
 =?us-ascii?Q?FtzJslSioLiUznEWlq579ZGXPaeWrJIezeISZ6l7zR4owhF/OILkfzxbpD7T?=
 =?us-ascii?Q?3iKckGeeqh+M32q0qva3b8vGMyJDnge+xr+vDJCboWUfa3y46786qKUfNNN4?=
 =?us-ascii?Q?oAUYtPeZSM/0bFROlQ6yeMdYatcnizZEXOsaSM8yk/kyROUv5qansFJA66Z5?=
 =?us-ascii?Q?L6mQFksNyxRBoTgk2QCjYTEL+x3z/SyQovzPBiI58rRcQ/Zrq19Xcf/HQ7QC?=
 =?us-ascii?Q?vpU6663xdW+a0QePqndlHooZR1FKgDp5AT9iUXXYgJK0unMEDp8fLBWjOdrf?=
 =?us-ascii?Q?gPKK/ui7+ZnYR9+OUdLXAIklUL+flF0eOIM8jzk/xEGfpAnjFP2XWwq84ra6?=
 =?us-ascii?Q?aJKuniGuxxgdtDy6ZeZwQsHq7rs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ea7535-37cc-4f4b-0bac-08d9a05b1691
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 12:52:13.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7spBijo93cSVwHwvmeEupjojP6KOt6FlSJCbejh8cUmaq7XdcGPgZm17GpkCUUSZq3OYAN+NHCgVt1EnAk51Xhe6LS4szok8aEpQRcgwXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050075
X-Proofpoint-GUID: x2z_an8bP-sccqLUxITwyOosyRA2mx8q
X-Proofpoint-ORIG-GUID: x2z_an8bP-sccqLUxITwyOosyRA2mx8q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 07:33:36AM -0700, Joe Perches wrote:
> On Thu, 2021-11-04 at 15:09 +0300, Dan Carpenter wrote:
> > On Mon, Nov 01, 2021 at 02:31:59PM +0000, Karolina Drobnik wrote:
> > > Add a local variable to store `MISCFIFO_SYNDATA_IDX` offset.
> > > This change helps in shortening the lines in `rf.c` that
> > > are deemed too long by checkpatch.pl.
> > > 
> > 
> > I started reviewing the v1 patch but I should have been reviewing this
> > patchset.  Please don't do this.  Leave the constant as a constant so
> > we don't have to look it up.
> 
> It's just an intermediate step to use idx++.
> Personally, I'd combine patches to add and use idx++ directly.

Yep.  I saw that when I reviewed the later patches.  This patch should
be combined with those as you say.

regards,
dan carpenter


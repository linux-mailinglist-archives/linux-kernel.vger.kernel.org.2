Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80FB3FB503
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhH3MA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:00:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236661AbhH3MAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:00:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBNbKb021066;
        Mon, 30 Aug 2021 11:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=pdMiV8MFadfa2MWStRjkf3U671qDPmHOVk48DD58l0Q=;
 b=GLZYfPbBkbtpXo2vNNURcL20BsYZKs9cVgtoXmvjHlfibOvvdjuWuQzTbA1ZA8A2pdeo
 MlmtOSgTlO3+vzm0SIWzi+ZI0y5BDus5HWUKVBobyaFJ5uVOUrblnUblRrid06Q8v6AA
 G4aq0UzdwT/uTFLEb4jslP6O5ebZiLVuYzWlCaOVcCkbzdNw29awdEf/sqNxzE/kqqLp
 TrjQfG/GWB2iKRQZcwa3mmi/VIM9ASf2875uF1rbMWol3tXGY4iQL2n/bHNA1dbAcUuK
 A6R4TpHweiaQvrNBYKJiW5dO+8043ZDVikzSt9GrppBVxFIXrE87JUMjWwWYpI8i2eVP 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=pdMiV8MFadfa2MWStRjkf3U671qDPmHOVk48DD58l0Q=;
 b=IkafNBvCeMmVxZGvtdr0zC6qnGHaeyiiusFjqRtFIMwQM+sQOk/zGkWuPeTSIhLTSVXZ
 cyhCZ1IG6ZpWuyBTEOsC6OWJnJu1ijw1BFSf4tnqeaHf07NbG/0/GMo2I2kVWoDYNMSA
 VoamKG9tS5JB9TAY8CGF74MrHFG3Tf9vD1xA6KJNq3fzisBkl9/Z8f9G97+BmsWrpS5T
 aG56QJEpEbNAL+xdA8UXzq2DbG+M4NU9LiWgNE8Z7d+fBdGmVXRWNl1/Tohv2NsG1G+a
 IBRGYZs1MMoswbLCLMfl5PA9JDX1sWae1+B3xpYW8DzMoHZg6gvgVbRcKyx1cLlLYFU6 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxwhb69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:59:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UBngUS069274;
        Mon, 30 Aug 2021 11:59:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48] (may be forged))
        by aserp3030.oracle.com with ESMTP id 3aqb6bttea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWfVWZWIGKV1Th44cUgc8/x5+H9gAeQl/nK4HyVNqjY9K3+G2B1M2OPD/PM4S8+t6QFJG8VYBln4/RGgVhqJ3ZMg4lBQi8DdloM+qTgYPapLoPJtEi4+DKrVx3yab6Dr6kCNznnIFn57DpbfGbcqseHHMzIwU7uK+O+nrDF4rT1KGjE0kTGFMBJNxJubVABcLS89HDulIb1aljIsFzsqIEvhgZT3S9f4GEi+N08ly3kCZdH386Wf94Q2H2ugkQn+C/QYldwrefVLE54KA1nL56TL7Kk3CUGBA1pSJIGwbdU8zPSt8Y86e+4R+XfbeMSPPWKwkTuRzjeI7L24nX7tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdMiV8MFadfa2MWStRjkf3U671qDPmHOVk48DD58l0Q=;
 b=T/PDPb3LrhXDUhUJqXucCeewM8F/dwJSIyJckc76dGU3lgr7OxOO4NW3C2dwHFgv+TrHIMfESHoojqiqPzx/ILIq97Ye0hk02I1h0sgXn9x94Ve4GlBXIgctmoxb1H52yZHVaR71qjno9jdrJZS9JBAtcMLnXiZSpELuc8SIi1dJy6Gy2VwVFGt7RIMQ/vplSOJ5Dui6EwN01V6IHk+hlF0QDQmkX6qAvA6dkK9TmsFkeHjbnlpw/N3j1Iq8+zFuNHjHsobz2hW4SGknIvJlzG6BiXc3V/xwq9AgzMtqorTGb0YC0TbeaSmZOwReYpAEtyKhz3gFegd40hjBA2vk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdMiV8MFadfa2MWStRjkf3U671qDPmHOVk48DD58l0Q=;
 b=NM0aAkBAh0om9+swmhOxLSHGGwskPyHYfDlPWjGbFN2DQ+zWp13tSQ9bvNOkX3U9lg4/g5XKRoU3Oagx2K8jWePE/z/dqAzQFldU+uTeZM+kr7wVPP3mDbzw0VXK2Nku8O1FSKvAuALfHBN8eWORyBZK+qtnpiA5duck8jn0S7k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1421.namprd10.prod.outlook.com
 (2603:10b6:300:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 11:59:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 11:59:48 +0000
Date:   Mon, 30 Aug 2021 14:59:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Julia.Lawall@inria.fr, gregory.clement@bootlin.com,
        lee.jones@linaro.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Fix a memory leak in error
 handling paths
Message-ID: <20210830115931.GH12231@kadam>
References: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
 <163021483704.2676726.2051426762011017819@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163021483704.2676726.2051426762011017819@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 11:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3bc207-ffaa-457b-a53d-08d96badaa3f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14210931835AC80622C6F1F98ECB9@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfeI0odbMeVwTufZJegYucSz7qDmBicdRe2HrqLFRsC+i8JZYzQmW8GDV5dzKfyj1lmIwBook2ss21hf/y5hDFPFAen9oi/Q2HFX6Krrsf4cro/smxGGXN5eUc+3AcPurnKZu/7vIJQ8kHcEe0DdOfONdl0Q0Uau7b04TGbEpRYl4OCNPOm7stb1yR+G9Afnd29WRDh0f15k28Zj9nvx/fr4OKS9KZpexSX6cvEk+AiiUkoEt2wdSDnREG4mWHLXy77kSIiDf7vw2c51X7PtfrwA51/GK/56EmD6liIYDnOA3H0JQO9Z0Cy7mdztX80WMs6yUYnloQDf6hcE7jij4LzQ0jh+ulU1FnYb2dlGmXI5pPHPv1u6U4sGEJUw5Aw4NxJNhXuKdTK0Ikv1TY2jLa3mILyrOWNlnKQ8tGsEVy2EoDp/w4pJhoI8nM397EQ5pS9JlzmhNTpilzNM00EYV5dTwyBTPOWUFS/yZCOdFt2c4ubfwpoN//Vzei2rc2iVxeLmDRmI8U6Ar4pTwgl1+hwB7qWMTdPFu/a4GARlcAUzWyglD3zWSNa4ZslXH7tbejMoLwY+OACNGXkSuSUBanAMjtF4J2AN0Vd57h4YzmFfTU13b4uO1J3FpbUl4W/ODa8buVyllyLPnz6NLi1nEU/VIk8+qGnmKf4vRlLNaHZLSiM8HRfC0sF3OS2QDqG8GHAs8kAoV+B4/qPjxcbc/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(55016002)(86362001)(9686003)(5660300002)(83380400001)(478600001)(38350700002)(38100700002)(66476007)(66556008)(33656002)(66946007)(186003)(6916009)(316002)(26005)(33716001)(6496006)(6666004)(1076003)(4326008)(52116002)(44832011)(2906002)(9576002)(956004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvOfgVHmVGwR04zj5jvdL+GeTf0KGB9A9Omio0/w8z5BsF1po6hYOhdRM1sy?=
 =?us-ascii?Q?O/jbMi4PWECp83liENSty+sC4Bk4Xvf0z0yYOGjwLqXeE3wabtbwHcYr1n91?=
 =?us-ascii?Q?K3yucOHjCRPDBO97Y+Bs8wk1j2mbBOv3vMC/QXn6Mf9g/oeQ70ABjNFQLAtC?=
 =?us-ascii?Q?TKBAexAffV4aE7qU/SrM8g6u9JW/yGUKSiKRsLrBcfL6qHPiPT08ct4SrEja?=
 =?us-ascii?Q?WOcC6s/X3uAz4YjVpC4x0t5Cg2jPh+B7a1pQk1tkadwG3xIyY/33+uvMAWrt?=
 =?us-ascii?Q?MZ5iBOlA4NelWL0UblevrB39Xlyt98pPi9SfZdCMHXFFajv1V9kabwZTI4n3?=
 =?us-ascii?Q?nlzoDICQhQsNKUXl3OpbO96W3XaBNmQvrZzjvYLHmcQooW3y9ki80h4uGvC8?=
 =?us-ascii?Q?O+kjD2UJhN1pbYqx3/btOACfqtc7RUeTJL8SJKiNKYAzFkiLyaNMRB+UKJ8E?=
 =?us-ascii?Q?2fqb1g+iQpGAkSP3vBfYeAGLYc23w5OPfSxvgz1atx+ea3GZzbtbEmesyApJ?=
 =?us-ascii?Q?M6OFjzPtPfjTVhaL1QD7IsP+UOD6uhVjHh5S/oEXbqLoZQIT9baMg0rpOqge?=
 =?us-ascii?Q?TZ2RqKKj5KMMNXGfKJVtblR0GN8oHB/gZYqDC7ItBq1Dz22yDjHGr2IuCyqC?=
 =?us-ascii?Q?hGU/lPKJeCwK0yyLU17jBHgEGxMzXmBlrUNhxUaSj69QifuW2J6TgoR7LdvW?=
 =?us-ascii?Q?sVo93MPk4WZeyD3jRlx0+A6xruVIiiqb0KrWdGcYR0pFNgFk2jpxwb210xyz?=
 =?us-ascii?Q?3Q42eBdzqGuYbE3Yqx+5eSYq+3MjlVILLWBjARTNmfasWNY7dvcLlgESxfTc?=
 =?us-ascii?Q?5PhRSitExNTOixHxb0RSXAZmvBDxerpbm50ahw/b5d2pNewLLipBRlk7lPev?=
 =?us-ascii?Q?REoc3mTHg97+IRC8jG7Z0Uuf/aMoi7WnMz29JiTRO5Y7RoMBv8fzkFiTJDwg?=
 =?us-ascii?Q?6YogG1mbVodHnMAzePQHYQZzyjqfDOArRyizjhR/QiZyMj6JvGrtNNOeRjYq?=
 =?us-ascii?Q?Slpkc3X5dLLMsXUPU+ekKmM91VXyAxmJEgQVEvxMC56/AFXUp7XXvM34H15I?=
 =?us-ascii?Q?MQjXUxJtyFed0MxIrTxeY8MHMFqwhqfofhZGV8TVDPsW3CtgP47KqpFpgVM6?=
 =?us-ascii?Q?qdYiukB27I08uSNxsKwR5kghEdkZJTXfdPJTjmuLU8JM4iYznlhnPQDprRbc?=
 =?us-ascii?Q?DO0M3G1uPh8xY7KuRiOBVwOXjKL0UaOV5pttYOq89qF51sKAUkK3TFFg40ua?=
 =?us-ascii?Q?NmcGSfAxItS0v2HRSc4T5IAteasjLGmanSlNZEeBF0sJULRxtTH2urR8A1AR?=
 =?us-ascii?Q?RsP5StSB8zSuBbQNpyGVJk+W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3bc207-ffaa-457b-a53d-08d96badaa3f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 11:59:48.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKt9PxtyhwmPmhYQFkVRJletqkKgMJcj4EpLSKceis9HjgNZEo+IDklA8PEeG3EsE1KGeP+x/bVEJWTfdGOfgnEiL209Ceflb/zgWQ2sSyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300086
X-Proofpoint-ORIG-GUID: fkrM6zGGDDw-qAGjcUYzJCGqmFjfqY_0
X-Proofpoint-GUID: fkrM6zGGDDw-qAGjcUYzJCGqmFjfqY_0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 10:27:17PM -0700, Stephen Boyd wrote:
> Quoting Christophe JAILLET (2021-04-23 00:02:26)
> > If we exit the for_each_of_cpu_node loop early, the reference on the
> > current node must be decremented, otherwise there is a leak.
> > 
> > Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
> > In order to compile-test the changes, I also had to change the 'bool' in Kconfig
> > by 'bool "blah"'. Without this change, it was not possible to set
> > CONFIG_ARMADA_AP_CPU_CLK required by Makefile.
> > 
> > I don't know if I did something wrong, if it is an issue only on my environment
> > or if something got broken at some time in the build chain but it looks
> > spurious.
> > 
> > If I'm right and that these drivers never compile and no-one noticed it,
> > maybe removing them is better than fixing some unlikely issues and style.
> > If these drivers should stay, Kconfig may need some love from someone.
> 
> Nobody has said anything on this patch. So I'm not really sure what's
> going on. Probably we never take the error path, or the whole system
> fails to boot?

You probably take this one.

   106                  /* If cpu2 or cpu3 is enabled */
   107                  if (cpu & APN806_CLUSTER_NUM_MASK) {
   108                          nclusters = 2;
   109  +                       of_node_put(dn);
   110                          break;
   111                  }

But, yeah, probably on one carse of "dn" can't be freed in real life.

Still probably worth fixing though just for correctness.  Otherwise it
makes static analysis less effective if people deliberately leave bugs
in the code.

regards,
dan carpenter

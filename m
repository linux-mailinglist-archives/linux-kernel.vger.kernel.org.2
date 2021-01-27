Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB305498
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhA0H0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:26:15 -0500
Received: from mail-eopbgr700082.outbound.protection.outlook.com ([40.107.70.82]:49761
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233656AbhA0HW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:22:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8po1azR39T94IRmzyupJ0e6EtsHaPBIU7wVdFRvshCt9TbKDEFRLSj1Aid61k06OKh/LRP59t3FNoUs6OldeImdHGnzfV21nnEv+FEULe8B4Vz8NYIXT5gJrGkthk9NuVsHSiByOdOkbT9F5sMAoGEdHzKBsQ9pQVJEMjhT3BoqNg/dyZlwc248sUZKCaizSvYOeP+MTuXnHCCCcn93MIxM48/66M0vCIfw4fXA4r/68oDrQ7z0WMQDPDIWOvY2zU27TC0EgFh34fGC4u2XM2P4pwVEfKs7God+zmpYXi9NWcq3wEqzt3azmhu/lXPD1LUpaFJERAmxUO/fPoLB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE1F1mY4NE6TZLqgwxzJ7gw1Qi+XWQE9kwI68bqBy1M=;
 b=d5qfAXEBtf3P1GSKevzhDkkHI7AJEUW9yeIZ0Lz4StWGigH0yvvNKVMd0YdSD3BmHXqBCzslEU9JxpPm7VWPlu9jAvqtKaMsC68b5uG7PkMNxkYX9Fxjj+KqHGxq9de8y9YD9oK28tfYWSNL3gsp7NGBzeObK8s5qBcYQ9yHczYKCi4XwPA7vRs3//yC/nEos+NsRm5oDd/8Vg0CopPYXv8KwQHSS47msq+C2hJdxKUnAIjFmbp0QYf3B6qL+JjAI+tMAxsxRqgLWyRjPHORAjlY2IL0oTnCaSW/uxUJnS02ddTEBpU3kNevWwKj1uKPAPoXrP920GZYuQsE1qVqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE1F1mY4NE6TZLqgwxzJ7gw1Qi+XWQE9kwI68bqBy1M=;
 b=IpZknU0F4FhkR8hkLgteYMpFbxFdTBFQG0eaZ7/WUjh3Z3PIoKrvMC4ikwQkd1KAsF8ZE75i0SLrPsUdjUO/xpBLQV4r0bXFrpi1G6k7k2DbpccdWkKM+wLyV2YIUHxHkBIDq2xIa4TCbNpmYFl6EywOUvP4FhoN4e5S+QrkgB8=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2922.namprd11.prod.outlook.com (2603:10b6:5:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 07:21:43 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%5]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 07:21:43 +0000
Date:   Wed, 27 Jan 2021 02:21:40 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from
 EINVAL tests.
Message-ID: <20210127072139.GD23530@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-2-paul.gortmaker@windriver.com>
 <YBCD+czt+6IjAymI@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCD+czt+6IjAymI@smile.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 07:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320ed46b-792b-4cca-d48f-08d8c29432b7
X-MS-TrafficTypeDiagnostic: DM6PR11MB2922:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2922C9E8670F3DA99494348283BB9@DM6PR11MB2922.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6aVLKpuFMKQTuv7XXkzjLlwJTZR3sj9Ipapal6Sc/mHfGW3nuRqNW5bK9QoxriBMXMGjrLWxKnMV5cWZue9LZ6pEnIprb/0yOtc1nY7FwAzuIcZZHFz7y79z02E8T1zjx1avuoyWb7m899gvCdS9bWV/yj1Oz+HVGuWw1QrnrNFr1sTd9mywDt9Y4kijgY/WZ2YCL2svemG+KGzPYkXo8VI8F3wyuV5zldbyCuHEDq2iMwfhoZnX8BTTuULsZIF46j7uZjQ2AVzIzSGnKCyNm5YIfEZTf1WWsqFpKXzIRTflU2BrxdVyLUoXZd9h/FYPMlEdHaGAODd95S+Lt3ktnZWlgI5mYoW8SR0pjk3fUZtx/gEDtaH7N7ExOLkzl5DUQwwdTli171eu7graTgk37+RKAaLZ7DMgahW9hpAnzNk3/L6H6X7+fpjVsYndU47Ol1L3Jh5GWmhYKLjEhvv45FFfXH7FQ1PFdsVINg/xhWJOd2UwNFVEyr1C1a7/P3BLr3zA7AuSANHph4SigH3Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(366004)(8676002)(7696005)(2906002)(4326008)(66946007)(316002)(33656002)(16526019)(26005)(44832011)(8936002)(52116002)(478600001)(55016002)(956004)(2616005)(1076003)(7416002)(5660300002)(6916009)(8886007)(186003)(36756003)(86362001)(83380400001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WMGqlwt5pYekTv7uwXzQ8Ti/cyvCXu/jj47V/y5uZJ7Zt0InqJiyZBKAm2oS?=
 =?us-ascii?Q?52SZYtC1oiyCEfunWdjqIdNoT8alK3nucifpoB4yT5PB9jkQOvidnXOQEuOj?=
 =?us-ascii?Q?7vaBCiWnQX4w+enoEKBS32An+JfEOO+16EQCkhUuIIM8ip6YAFuc72lymSvh?=
 =?us-ascii?Q?SPNZhpO5KPEEtlCm+iPj/gscsUWuf6OkEvVPr+lH+vrcp68UlqP6MLNqu6d0?=
 =?us-ascii?Q?BbO90aOyjekSUjwNiuNyGaYSgdBEDhzMumWWPQuimQg1BvEtZ6ClnajA26bK?=
 =?us-ascii?Q?sjSTQ2+wfom9D9pnG6Yy8O6737sL+Mkj+6tZdbtq4G8blSiSOBUzQO1CdMvo?=
 =?us-ascii?Q?IrHDKT7YrvIr2hUzlXByVIm1UcSLeL5dJJJziBEhtLwKL66G0e0q12m2E0yR?=
 =?us-ascii?Q?Pfl2PBQ7feYomy6zLQMlbtr53ZTHo1zPThA3y1moI2N2vbaf2ZxkuUZzfCjk?=
 =?us-ascii?Q?EyzWMf3lQxlUNwp4xDbDQeEqgp7y5xj2PAkJ4ref4MGIpU3IefqurlZneyO/?=
 =?us-ascii?Q?x5lSFNVveOderLDDFON42VeEaUdoh4FjaI414GdxHao63HuSSif4jUaNTgzb?=
 =?us-ascii?Q?7kGS6yznss9jNqVa9sG3oVSqfOq+v4BBXQfOKtcO0JpxhytlJJSsXqurlweM?=
 =?us-ascii?Q?/x3pIskunWYvud1HPA/k8a7aoKK7QTT+b+ADzUJa9xDF8ZBPgbn+crLvkN0S?=
 =?us-ascii?Q?2e0Wayz/EBK08LraxaLR8SALUfrmjM3ZekoYSOM/QQzhYIz0ouZtGmKjfOH6?=
 =?us-ascii?Q?eBhamrLYz1oizntB4fezWwyUpMY9gZ747xdpEGynQPyQqFwCv40M8aZsuq6l?=
 =?us-ascii?Q?pZCl9vJk99x008WfVisSOW3sy503My051zo6sW3+ypdHXp6AAGrtWycyMAb/?=
 =?us-ascii?Q?xwBuXb374403iI/UyRuTMFLI/WaxWwtflB03j40vfKo03rHoTxPYMEq0m/mj?=
 =?us-ascii?Q?s1teEB3v/fENycCfhfm1l1oyhY2Ipj8QdA6smfqA3ueo6ThCflsIoIk8zpbN?=
 =?us-ascii?Q?IuJgz5HxOKJWmu2SR3Xx4kPktzYTeBHNsq8UBnBhhkgBHo28MK3ES7TAtmMG?=
 =?us-ascii?Q?m8RfhoLa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ed46b-792b-4cca-d48f-08d8c29432b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 07:21:43.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR8TPzNajVbHhQocKI0/TlJlupUDEepqWzx7vVbRtSB06d2p+TFoYfbVvKztR+VcIvXmjg9mEX3MCMtXJFTVaZU4UycDWuEFmCF9rBET0Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.] On 26/01/2021 (Tue 23:04) Andy Shevchenko wrote:

> On Tue, Jan 26, 2021 at 12:11:34PM -0500, Paul Gortmaker wrote:
> > This block of tests was meant to find/flag incorrect use of the ":"
> > and "/" separators (syntax errors) and invalid (zero) group len.
> > 
> > However they were specified with an 8 bit width and 32 bit operations,
> > so they really contained two errors (EINVAL and ERANGE).
> > 
> > Promote them to 32 bit so it is clear what they are meant to target,
> > and then add tests specific for ERANGE (no syntax errors, just doing
> > 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).
> > 
> > Note that the remaining "10-1" on 8 is left as-is, since that captures
> > the fact that we check for (r->start > r->end) ---> EINVAL before we
> > check for (r->end >= nbits) ---> ERANGE.  If the code is ever re-ordered
> > then this test will pick up the mismatched errno value.
> 
> I didn't get the last statement. You meant code in the bitmap library itself,
> and not in the test cases? Please, clarify this somehow.

It probably wasn't worth a mention at all, as that test in question was
left unchanged;  but yes - it was a reference to the ordering of the
sanity checks in the bitmap code itself and not the test order.   I'll
simply delete the confusing "10-1" paragraph/comment. 

> I don't really much care, since it's not a tricky commit, but it might be split
> to two or three separated ones. Anyway, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since you mentioned it, I assume you would prefer it.  So I will make
the 8 --> 32 change in one commit, and add the two new ERANGE tests in
another subsequent commit.

Thanks,
Paul.
--

> 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  lib/test_bitmap.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> > index 4425a1dd4ef1..3d2cd3b1de84 100644
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -337,13 +337,15 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
> >  
> >  	{-EINVAL, "-1",	NULL, 8, 0},
> >  	{-EINVAL, "-0",	NULL, 8, 0},
> > -	{-EINVAL, "10-1", NULL, 8, 0},
> > -	{-EINVAL, "0-31:", NULL, 8, 0},
> > -	{-EINVAL, "0-31:0", NULL, 8, 0},
> > -	{-EINVAL, "0-31:0/", NULL, 8, 0},
> > -	{-EINVAL, "0-31:0/0", NULL, 8, 0},
> > -	{-EINVAL, "0-31:1/0", NULL, 8, 0},
> > -	{-EINVAL, "0-31:10/1", NULL, 8, 0},
> > +	{-EINVAL, "10-1", NULL, 8, 0},	/* (start > end) ; also ERANGE */
> > +	{-ERANGE, "8-8", NULL, 8, 0},
> > +	{-ERANGE, "0-31", NULL, 8, 0},
> > +	{-EINVAL, "0-31:", NULL, 32, 0},
> > +	{-EINVAL, "0-31:0", NULL, 32, 0},
> > +	{-EINVAL, "0-31:0/", NULL, 32, 0},
> > +	{-EINVAL, "0-31:0/0", NULL, 32, 0},
> > +	{-EINVAL, "0-31:1/0", NULL, 32, 0},
> > +	{-EINVAL, "0-31:10/1", NULL, 32, 0},
> >  	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
> >  
> >  	{-EINVAL, "a-31", NULL, 8, 0},
> > -- 
> > 2.17.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

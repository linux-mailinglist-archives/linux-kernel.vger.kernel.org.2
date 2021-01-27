Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEA305557
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhA0IOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:14:17 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:56385
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234305AbhA0IDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:03:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1BWLo43C4uS8OkfbnKl8X8oz7bsr54Lt4FiQXLszbCcY16VwwIznOzKuCyvNJf/S5l/osF9RI/HPOCQ76BZz3LRacMGN/URsXLW6aS2Mf2sOyMW7FHuyS1OOAr1xDqau5tyEDoO0UXdc9j+IBdaKaYGFVWIa0hgllRM379d0Q7JcYVSHSG0xR01V37dSd8K7hbxBlVOHx5efvbg66dQyS4z9OmUUHXXAQ/aXX+UUiM35Gd0TMp/62gL57KtSD0KVfI106pd3d4ruvWX1flGFX5l88P6J1Y+QJW5+b89ZCvkf2gcDbvCsYMYCfNGhZAoolMCo7k9XDhBP0kc+yc1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGRjJJWWrdi+v5F/0uneQ0NlPo2fIMZ5xE287ZbeOgM=;
 b=gQxijPyJ+tweNM5qN3EFA+M//hTLTTH3ckelq8kW3iJ6hGM5lJ4rLZinXCEM1XbSvOeBcE+RpJkZakJWcGsYq4whZW4pmCj2+vALXFInrDyvgQOsxnbB79zc44lLk/iJBCR0pdwb5jFI24aLNkt1kBklPVbfWrobUcDfYX4RwxQv3fRJHRpuTOc318YqU/4ugJ5jo/4mR82EL6wPqb0Dqrip+7AOi1JAqPTwKGK50tP1alKf9soWKoDhOt+imDWGe9jCj9SBgl4iK6C9+RMCgkadGx4ZBus4ACbOo701FwCqsZmmXyDFr8gPBpAT1ArYfVjV9h5jbSEUeA92AsatXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGRjJJWWrdi+v5F/0uneQ0NlPo2fIMZ5xE287ZbeOgM=;
 b=T8Pfg+/w1PeVx0XFPsiIsQrUdTOxm3z7YTss6B9YUPjG5RXEkKwAZDc8E4aw6cTOSq1dswXVQhtzKnmwfQSrXu8+9N9RnXhmb8H6k6b52SFz1AQN/V6cOf3mEtRgSy1LpMsA/xJt0nady0HZ7PkUX18CwD9oVV9PNPXMaszJo4M=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1451.namprd11.prod.outlook.com (2603:10b6:4:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 27 Jan
 2021 08:02:10 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%5]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 08:02:09 +0000
Date:   Wed, 27 Jan 2021 03:02:06 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
Message-ID: <20210127080206.GE23530@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-4-paul.gortmaker@windriver.com>
 <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 08:02:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40de8919-d819-47b2-3a7e-08d8c299d8eb
X-MS-TrafficTypeDiagnostic: DM5PR11MB1451:
X-Microsoft-Antispam-PRVS: <DM5PR11MB145145FF783034BEA8F9074E83BB9@DM5PR11MB1451.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVy4wNJvsxWObuTzIdUxYwSmWyXyil6Iv7GAm5uegUHFazD4kZNtfoyg5ZruCUMdDBquCLJodHUxn8OfjvX1G88K+s1HvnrT9tA7Rbfy+yX9rry7wu7uOfNZbLrqaVJ6cMXL2KdKLgU3EcxJ1Rvv9Div/3gEqq5V9o+8B6+WHoKJNPjwf9Fk+P42ALfEAKA0cS68tnRgG062ItCCpWx31KnojW1yYrf5RpdZOsASJOapYN/LRHbIJEOdlSVrLHbJWkBmrgxtbbmkMe63523BmUIEAhYc2UHVfQD7WkxsYYo3ZhuhkhUqMTjQdw2UxOZ5b8XATZVWfuosasx6ogO41d5Al9TxNS550rdxBU7akiE9tWpEf+sKJ3Lo3TZRBFoFBT6sUqCJtOaifj21lcuC/hn0X8sBh+bElOvAhbK3c5gPrKSrNaczFW3i5a718Pz8q45jB2lkzVwfwCBeInTGvE9RLmp2nuENiWbhIHZI314ujJX9TJZF/GfyVo1+EixfqqFEa2kB5bRvDbAobP9/2Ri4ccgOnIkf9K8jyn7Gg9eLbNSt/QAzKNXBhz5SQU4IgeBE7chij+jUboVvReCVhzmd6vbjPWSJCtT+SaJCvCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39850400004)(346002)(136003)(1076003)(26005)(316002)(66476007)(66556008)(956004)(2616005)(66946007)(5660300002)(7416002)(44832011)(52116002)(7696005)(83380400001)(36756003)(16526019)(186003)(6666004)(6916009)(8886007)(55016002)(966005)(8936002)(478600001)(86362001)(2906002)(33656002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SPDDjnBLGRw3JkR3gbU92Vyhb6bp1o123afapI8ItqxN1marFPlv4aC5M608?=
 =?us-ascii?Q?ZCReDhevPX894ZafDDme+EWbYvo1TKsqPRPlFbGw6tbBQCmBxeojv7TbmiOw?=
 =?us-ascii?Q?8VDaVmSdGWcTtvNmx5fHRir+OBbLHI+5Qs6h43lJmeSBaSrxfEKlF4XXnkI4?=
 =?us-ascii?Q?IA2MoqEOX5370AlqsRtorDXHypRCCoHgCnrI6ImO0dnvcIIArpQA7q7wyA6d?=
 =?us-ascii?Q?SkFfo3kG3nuOSPPv7BZmlCW5I3r9ODk5vXKY+eRXGTkeH4Xzw9vAFj2mlT+z?=
 =?us-ascii?Q?X1hFEKHx4vRrqBPKsedzp0xcm3/+gsgpzf5V4OGu+VYK5JQ3oVKVKoKCl50Z?=
 =?us-ascii?Q?xMtHWlv+Shz6K3L8r3UVmLCBqb4gnvBlB5eo/T9OVICDYjaPdT4PXeXHoi9p?=
 =?us-ascii?Q?5qY65q2V5WsKY2YBUYdxZJYynLHkPwXWnzPYiMOmRxcAkei3KouhgJvkZq/K?=
 =?us-ascii?Q?JA5y/f0TKH8uDX1DmJ9JFNv1NdQBTCgLwBr5GuvIh0+xXmhuMzasSOBn7XB+?=
 =?us-ascii?Q?FkzYlawyA/Aw+Tp0aeNCbDImfUmonXnJ4SlpEHSThfA+o9/Wi5egNI8JQt36?=
 =?us-ascii?Q?6Goe4H6mTwSINY212m3CWF7h70+VLNY310WtVFmV91ICd/01JVapr1ClBQgP?=
 =?us-ascii?Q?g89MnhJG8fU0Fxf2+UuwzcNInUARegm4AQuj79bZwgJABBxPF+LITFg3XSlE?=
 =?us-ascii?Q?TJNwIvGUWSiYgwet68B1jPy6/IYO6y9/VV4eG7ro5MiwjYCrHBJ0gSeOQ3CI?=
 =?us-ascii?Q?z8a8k8nDFzkuMzF52Z+Jl8xM1/0Jnxx9P3/1bmzU9bqsFrrU9QCH0k7tPSxD?=
 =?us-ascii?Q?GgrsgkTKmFHLzf4tbesn2/dGimKjK16vfbcWwrEHWwk5TBm5wCVfxcBmvIt0?=
 =?us-ascii?Q?sbaO/CqevmE1tzjsY2Ny5u3dAo14bB2p/D1lX+X0fCBfks73YQr4mYZMNM0U?=
 =?us-ascii?Q?8UwWAjC7Iyesj9q7+4fwo/cKLL2ug0VwRPOTp00g8+YZlaz2ilVmtUCSFKJ/?=
 =?us-ascii?Q?0/6Tk+iNV7tsRQOVBVWfh4qDVWtb2NTDVryjqlb8FaRI6D+eALCUKwDUx6Uu?=
 =?us-ascii?Q?vHVKMMtB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40de8919-d819-47b2-3a7e-08d8c299d8eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 08:02:09.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL2f33WdztP2c6so5Df87pNZBqXvy196/YvQ5XXhCnSq3cG/4iDZNg7gRl7m89mR2M749nZQOk7CLy330OCDPpfWoDME5iMEFdF8tnC+RJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct] On 26/01/2021 (Tue 23:16) Andy Shevchenko wrote:

> On Tue, Jan 26, 2021 at 12:11:36PM -0500, Paul Gortmaker wrote:
> > This will reduce parameter passing and enable using nbits as part
> > of future dynamic region parameter parsing.
> 
> One nit below, nevertheless
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  lib/bitmap.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 75006c4036e9..162e2850c622 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
> >  
> >  /*
> >   * Region 9-38:4/10 describes the following bitmap structure:
> > - * 0	   9  12    18			38
> > - * .........****......****......****......
> > - *	    ^  ^     ^			 ^
> > - *      start  off   group_len	       end
> > + * 0	   9  12    18			38	     N
> > + * .........****......****......****..................
> > + *	    ^  ^     ^			 ^	     ^
> > + *      start  off   group_len	       end	 nbits
> >   */
> >  struct region {
> >  	unsigned int start;
> >  	unsigned int off;
> >  	unsigned int group_len;
> >  	unsigned int end;
> > +	unsigned int nbits;
> >  };
> >  
> > -static int bitmap_set_region(const struct region *r,
> > -				unsigned long *bitmap, int nbits)
> > +static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
> >  {
> >  	unsigned int start;
> >  
> > -	if (r->end >= nbits)
> > +	if (r->end >= r->nbits)
> >  		return -ERANGE;
> >  
> >  	for (start = r->start; start <= r->end; start += r->group_len)
> > @@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> >  	struct region r;
> >  	long ret;
> >  
> > -	bitmap_zero(maskp, nmaskbits);
> > +	r.nbits = nmaskbits;
> 
> > +	bitmap_zero(maskp, r.nbits);
> 
> This sounds not right from style perspective.
> You have completely uninitialized r on stack, then you assign only one value
> for immediate use here and...

So, this change was added because Yury suggested that I "..store
nmaskbits in the struct region, and avoid passing nmaskbits as a
parameter."

To which I originally noted "I considered that and went with the param
so as to not open the door to someone possibly using an uninitialized
struct value later."

https://lore.kernel.org/lkml/20210122044357.GS16838@windriver.com/

Looking back, I had a similar thought as to yours, it seems...

I am also thinking more and more that nbits doesn't belong in the
region anyway - yes, a region gets validated against a specific nbits
eventually, but it doesn't need an nbits field to be a complete
specification.  The region "0-3" is a complete specification for "the
1st four cores" and is as valid on a 4 core machine as it is on a 64 core
machine -- a validation we do when we deploy the region on that machine.

I will set this change aside and get the nbits value to getnum() another
way, and leave the region struct as it was -- without a nbits field.

This will also resolve having the macro handling of region that you were
not really liking.

Paul.
--

> >  	while (buf) {
> >  		buf = bitmap_find_region(buf);
> > @@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> >  		if (ret)
> >  			return ret;
> >  
> > -		ret = bitmap_set_region(&r, maskp, nmaskbits);
> > +		ret = bitmap_set_region(&r, maskp);
> 
> ...hiding this fact here. Which I would expect that &r may be rewritten here.
> 
> I would leave these unchanged and simple assign the value in
> bitmap_set_region().
> 
> >  		if (ret)
> >  			return ret;
> >  	}
> > -- 
> > 2.17.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

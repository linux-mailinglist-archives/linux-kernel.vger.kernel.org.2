Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1119032091D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBUIIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:08:04 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:58976
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhBUIH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:07:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fny744yqaQorqMS2ZcQ08+ZL5uwNUMvoy+Jd3jcmk8rGzCnYtZ9p/TsD1Y9HOmVYuEWma+eRo7qfY8h3zGvYyZ5k/NRJfbf8lCcBGks3W3OWTy2ubChE2XDfeSwplJanHuZHMLHpy4DiZcov9XcQrKo2HpoXy44OA8tMIDzXDLfqF+hwAxqjSSR8hNiHSVshPBNbwp2mwMI75EtWtUQrGsutIbxyAeV2RFvDpCXAk+ajGW/zFEDCtBT3iBSBeWwwCxoD3LqKhjb8QhuYSp0+yp8/E5NGYP7Qd6T2gJTWjgjK0ayIp1qeVdzTTrCg0QN86vm6uP1lqb7I/yX+yAgKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0X9IbrY7oartuXDx0L9w4RVKCOn7G2wyMuHYrEcmWQ=;
 b=i2cnxqeMjBTX1bLgn2IUyaH7w1HBWeG7GkDBEiSxCyK0TRAxi+H6l8qgEQCknkw36++dhW3p0doI2gNVJLWjVe9OMBYT3FIu6r64MCZn6pWg1pIDfrrB/WhyWEPHobfq2E/iKamGIsqLqXD8fRF3u9gYb5/PN+RrskJ0E6DVZc0Q3168ZPsl3PzbtitHk1nz0h8sX+CsvEn4GHp5anb2Ozh6h47vuBYp1kTnl1bP67NcC2YmHC2uiHWDong/lu4wOQVJncsmVKUyBJ9YH5Q8YJb9JZOuOccp68YBbuikmKbrDKzMe1Ywl4esJLuCgKo0FyiyUfxrD8OuAwhJzJJlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0X9IbrY7oartuXDx0L9w4RVKCOn7G2wyMuHYrEcmWQ=;
 b=ejm8elxwRkt57MNDej3JKGGCDLPdbVRx2tcVjT//dJSmWuvImIe+HfoIQ8ARUCtVhueqiKE1PP4HTgidQazDSB0aFLkSMXgd9z5Xl98CjkABKksoanrizT4AAJ2NzG8z9uDK2wZQLVXreQ6lfRGSarOYkTELi2ImCTncnDJyMjc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sun, 21 Feb
 2021 08:07:12 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:07:12 +0000
Date:   Sun, 21 Feb 2021 03:07:08 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <20210221080708.GC6298@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-7-paul.gortmaker@windriver.com>
 <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
 <20210210155825.GA28155@windriver.com>
 <YCQOmkfEH0lLJY8l@smile.fi.intel.com>
 <20210212012417.GB167389@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212012417.GB167389@yury-ThinkPad>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend Transport; Sun, 21 Feb 2021 08:07:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd999a9e-90ec-41a3-f2d7-08d8d63fb197
X-MS-TrafficTypeDiagnostic: DM6PR11MB4532:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4532676F8709FE407FC6A9FC83829@DM6PR11MB4532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ILOyeto5E2FQIrybGstjZLmtHTH07m0y7Oaw8TdMhJN5jYAQnnD8CT3lua6YSxu9j9HKh57RbPH6nOJo7Xxmj/eo7cmc58+ZoizLi7KGhyZYUe1tTsQrS+nTWIE4B4jiZ/ye0MBJ47XLYSJn6T+NY+zgKy+JVBepBMrjYYK8wDG8NyTZmar+qnkg0+82DlxahQxT+dscp5QZHKpK8ep8kqcappPLPM0XvBclr3oawgGuPC1T0mcQ8nn2KIhCEi+pGVJ0VK9dbrlxSCivATG1t8Lxucza3x4nRJLl33WkpilOOmSQiFnypEXMXvGBMELUK00xSwiCJPyOv6fCrYYW0eEs7JthETmBd/eX/LTbUFmR08Q4yCw/J4Hu/AKCHbK0qjwS7XTlXf7LCQT3+bEUsP/wZQ10udbmy8tQm9ZXYON3nESAaeK4L6fPZMgBpu3SEaHCd+JHyyDMD17ipshpnK9A+1UdMEDU3fB2gcM5OrmMYS4WyN5FQ1BRRP6YYywgnnT+J3H7r3SFFw+L0ewcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39830400003)(26005)(66556008)(478600001)(2906002)(2616005)(54906003)(956004)(8676002)(16526019)(6916009)(4326008)(53546011)(8936002)(6666004)(7416002)(8886007)(186003)(1076003)(83380400001)(66946007)(52116002)(86362001)(7696005)(55016002)(36756003)(33656002)(44832011)(66476007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c+3BbjCvvsYEfQp0lRXcGigFFYj+gVMcXhaqr2T4EEebCW0B94JL03qXQYaw?=
 =?us-ascii?Q?Ho3OLHJMC921YnFpKznj6jaqr3LNsh8BymNGCJK1Q8tP63sTf+/3jYwU8Mva?=
 =?us-ascii?Q?jfde0ZOrgTr1uTEMmQa/YHkYqeb75crMam0/I2RCYMabcz55+kwWmd+Wr+Q0?=
 =?us-ascii?Q?h1/DQ4FEJCpzn3lwA5hSUFRQxDOq4sFRDt95A/PwSHieWqktu6UXwmFBo8p5?=
 =?us-ascii?Q?5KmhCsg1sXwYnZRQS2duQoRDPNtu9eVD8UXvBjQVCCOle+86KUHuCZOnYZ7t?=
 =?us-ascii?Q?viN+fuaGDgrYnLo3UfmwDX+CMIBMn2e7jPNscj8WD8FeoWHMbeIi2uyVqk/u?=
 =?us-ascii?Q?LPieJ6IPocxOdiKzeiLabay7HzDz4RBPG9pUahfdBRwgT2Jpz5UHy8UcVDmB?=
 =?us-ascii?Q?OYBE1iyMg7/1QkMxtcpnncRyldgGwveH1gxIdUsKGlCP8Q3Yd1o/lvXV8Pf0?=
 =?us-ascii?Q?SdXf9GZQFo5uJ1mz+EQmADsbWqHMDE7Mx0Xmv/t+Zocyg+wIhK8XLKG6CzjG?=
 =?us-ascii?Q?1YLZlzIbGtdgx28Sxot6UnsA11HJTjNhBegkfA4bX6m93gQ0z3+NwW6RURVi?=
 =?us-ascii?Q?3oD40kksclZkrIuRT3dhLPkJtdJDWfCg266RSWFANe44CPGlAX/lcvKRFa+o?=
 =?us-ascii?Q?sijjI2xMrZ0U+8MD+Gewttt2denvhzP4z5nRsZjesXVPoT3ZpC5pkebT8vaA?=
 =?us-ascii?Q?w/hU4cT2IF8rk6aJr5FUWrkVFGCaXAx9Nu04nzNBPVQ05AfZxFQSVD5i0AWK?=
 =?us-ascii?Q?PBeoE4D88Hhvnx/2u89SdTBSPukfBYH1IEo5QMbMbJTUreAgfMxSBpJCuswL?=
 =?us-ascii?Q?p24qKR8QJ3v6AGK4zeTL5QuNpTCX+hXyICjRqO4NCzK080CZTZCBSevJbTnS?=
 =?us-ascii?Q?N6ePrH4cvLnFWBdSQ2XH1wmQOHl9kjujCMnAXb1X4WqrhLQ9ezxrsA+DmaRa?=
 =?us-ascii?Q?dv/YoCW2dCTnFQi9shXYD6VOebOFrHzrjJYkFN2TKjCR0WbBrFFujQ8anksl?=
 =?us-ascii?Q?tN0HX58OBtzKLv9T41YGpmbeGp085G5Tjgvj61SveQq73Ky0LV1ZpB0meMqv?=
 =?us-ascii?Q?vc4O8vm8rR0h/Jss0thwUupKKPnMi0bLzWCBz1xK4nW9LJlnp1HupPB5OsGi?=
 =?us-ascii?Q?5Yf9xIvKFSEg7iC0qvBCvbsOw9vGUgRX5T8tNc4/s5kSwq3pOIXJh29YwKK+?=
 =?us-ascii?Q?1DXW9v9hq5THcbWLFsNaCwY7DEk840HxTY8pQ7bRiDiGE3xpBmhr5xCgpyaB?=
 =?us-ascii?Q?tR+VI3uvw81RE/j0P52ei0jKhc2jlg8HePOb3mOwz6iTSiwDaqec83RqGzUn?=
 =?us-ascii?Q?rHYi75sVjyh35jHNbt29VEEv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd999a9e-90ec-41a3-f2d7-08d8d63fb197
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:07:12.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE2or7yiRqRU6duHOCWgmXRNwy5M3CYDsx8J0Ccj4eFN2GZwedoRmE7upqdFp23fNC9961d+WDRlTqyzP0RMgZfEJWlgd4PReiu/tgmsKKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 11/02/2021 (Thu 17:24) Yury Norov wrote:

> On Wed, Feb 10, 2021 at 06:49:30PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 10, 2021 at 10:58:25AM -0500, Paul Gortmaker wrote:
> > > [Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 09/02/2021 (Tue 15:16) Yury Norov wrote:
> > > 
> > > > On Tue, Feb 9, 2021 at 3:01 PM Paul Gortmaker
> > > > <paul.gortmaker@windriver.com> wrote:
> > > 
> > > [...]
> > > 
> > > > > -static const char *bitmap_getnum(const char *str, unsigned int *num)
> > > > > +static const char *bitmap_getnum(const char *str, unsigned int *num,
> > > > > +                                unsigned int lastbit)
> > > > 
> > > > The idea of struct bitmap_region is avoid passing the lastbit to the functions.
> > > > But here you do pass. Can you please be consistent? Or if I misunderstand
> > > > the idea of struct bitmap_region, can you please clarify it?
> > > > 
> > > > Also, I don't think that in this specific case it's worth it to create
> > > > a hierarchy of
> > > > structures. Just adding lastbits to struct region will be simpler and more
> > > > transparent.
> > > 
> > > I'm getting mixed messages from different people as to what is wanted here.
> > > 
> > > Here is what the code looks like now; only relevant lines shown:
> > > 
> > >  -------------------------------
> > > int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> > > {
> > > 
> > >         struct region r;
> > > 
> > >         bitmap_parse_region(buf, &r);       <-----------
> > >         bitmap_check_region(&r);
> > >         bitmap_set_region(&r, maskp, nmaskbits);
> > > }
> > > 
> > > static const char *bitmap_parse_region(const char *str, struct region *r)
> > > {
> > >         bitmap_getnum(str, &r->start);
> > >         bitmap_getnum(str + 1, &r->end);
> > >         bitmap_getnum(str + 1, &r->off);
> > >         bitmap_getnum(str + 1, &r->group_len);
> > > }
> > > 
> > > static const char *bitmap_getnum(const char *str, unsigned int *num)
> > > {
> > > 	/* PG: We need nmaskbits here for N processing. */
> > > }
> > >  -------------------------------
> > > 
> > > 
> > > Note the final function - the one where you asked to locate the N
> > > processing into -- does not take a region.  So even if we bundle nbits
> > > into the region struct, it doesn't get the data to where we need it.

Yury - you asked why there was an arg passed -- "lastbit"  -- and from
your reply, I don't think you fully read my answer - or at least missed
the three key sentences above as to why "lastbit" was passed.

> > > 
> > > Choices:
> > > 
> > > 1) pass in nbits just like bitmap_set_region() does currently.
> > > 
> > > 2) add nbits to region and pass full region instead of start/end/off.
> > > 
> > > 2a) add nbits to region and pass full region and also start/end/off.
> > > 
> > > 3) use *num as a bi-directional data path and initialize with nbits.
> > > 
> > > 
> > > Yury doesn't want us add any function args -- i.e. not to do #1.
> > > 
> > > Andy didn't like #2 because it "hides" that we are writing to r.
> > > 
> > > I ruled out sending 2a -- bitmap_getnum(str, r, &r->end)  because
> > > it adds an arg, AND seems rather redundant to pass r and r->field.
> > > 
> > > The #3 is the smallest change - but seems like we are trying to be
> > > too clever just to save a line of code or a couple bytes. (see below)
> > > 
> > > Yury - in your reply to patch 5, you indicate you wrote the region
> > > code and want me to go back to putting nbits into region directly.
> > > 
> > > Can you guys please clarify who is maintainer and hence exactly how
> > > you want this relatively minor detail handled?  I'll gladly do it
> > > in whatever way the maintainer wants just to get this finally done.
> > 
> > Funny that there is no maintainer of the code.
> > That said, I consider #1 or #3 is good enough. Rationale for
> > - #1: it doesn't touch purity of getnum(), I think it's good enough not to know
> >   region details
> > - #3 (as you posted below): I like how it looks like (one nit below, though)
> > 
> > But let's put this way, I think Yury had done a lot in the area, let's listen
> > more to him than to me.
> 
> I think that the simplest approach is the best. For me, the simplest
> thing is to add a field to existing structure, like this:
> 
>         struct region {
>                 unsigned int start;
>                 unsigned int off; 
>                 unsigned int group_len;
>                 unsigned int end; 
>                 unsigned int nbits; 
>         };

This is what was in v3 of this series, and I have put it back to this.

But as stated above, it doesn't get nbits to where it is needed, so
there still needs to be this one change you explicitly asked about:

 -static const char *bitmap_getnum(const char *str, unsigned int *num)
 +static const char *bitmap_getnum(const char *str, unsigned int *num,
 +                                 unsigned int lastbit)

There is no region here, so there is no access to nbits via region.
Hence the extra arg. So that is what v5 of the series will do - just
like v4 did.

Paul.
--

> 
> Of course we can do like:
>  
>         struct region {
>                 struct boundaries;
>                 struct periodic_part;
>         };
> 
>         struct bitmap_region {
>                 struct region;
>                 unsigned int nbits; 
>         };
> 
> But it would be nothing better than simple flat structure.
> 
> > > I'd rather not keep going in circles and guessing and annoying everyone
> > > else on the Cc: list by filling their inbox any more than I already have.
> > > 
> > > That would help a lot in getting this finished.
> > 
> > Agree!
> > 
> > > Example #3 -- not sent..
> > > 
> > > +#define DECLARE_REGION(rname, initval) \
> > > +struct region rname = {                \
> > > +       .start = initval,               \
> > > +       .off = initval,                 \
> > > +       .group_len = initval,           \
> > > +       .end = initval,                 \
> > > +}
> > > 
> > > [...]
> > > 
> > > -       struct region r;
> > > +       DECLARE_REGION(r, nmaskbits - 1);       /* "N-N:N/N" */
> >
> > I would initialize with nmaskbits to be sure the value is invalid, but it will
> > add some code, below, so up to you, guys.
> 
> We don't need to initialize r because it's purely internal and helpers
> don't expect that r is initialized, so it's waste of cycles.
>  
> > > +/*
> > > + * Seeing 'N' tells us to leave the value of "num" unchanged (which will
> > > + * be the max value for the width of the bitmap, set via DECLARE_REGION).
> > > + */
> > >  static const char *bitmap_getnum(const char *str, unsigned int *num)
> > >  {
> > >         unsigned long long n;
> > >         unsigned int len;
> > >  
> > > +       if (str[0] == 'N')      /* nothing to do, just advance str */
> > > +               return str + 1;
> 
> Is my understanding correct that this is an attempt to avoid adding
> the nbits to struct region? It would probably work, but I'd prefer
> to extend the structure. For me it's more readable and maintainable
> approach.
> 
> Yury

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FA3055FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhA0Ila (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:41:30 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:20865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231718AbhA0IjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:39:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTkcVBDwBxrFEP7fNJ5R3Ej7I+6ffNcQ8+TwGADOqNhU53J4ou6SpXsCXo4YbcwOE/hFzsLrjXxEjryjNLcrGOxVRxBe8MsrVrk3dTnBUjOzhODre6mLZc/YYUCWheZtwQlMB81X7LxOzXLGhMl9K4y2xMn5fPP14tD3UBF8AOwV8JfoXmzXeHeLfZ+R4k6bB5psh3810l3uDMkGBnIavk/9LskM88xaz0mnsaziGORAnyDN0nSBCZ6Wq3HwiNgcVnQEkJWbpFLMM7UU7zq5RK5AVjh+b4bHoBFXDPhpefsPHfBInCLxy4CZ9jc4ZDxatunVMZ3+cB8/VRiC26xHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgJv3a6orf1kPSMKxAaBJDxtv6fvtkY0M3Rai+SV7ho=;
 b=g/X/V6GuffHwNp5EYEoeIC4wc3s6Y98mYOVsmnTD28grcyAVepK91SxGDwfRfqWJoN//N8MF0XZg639yl3lRcPRXDsKg3+dW8BZiFRAcqa4QzloUtozclg/KJB2sjCi3YXNu8LjOs9ia4CHs1SRX1naN8eLq0Yk0s+/iVdiNcIb0cvj+99RZd19BEImbTaZPxcSvF14Xa7dW6ITxsYeVCiDftKD8N8y4whxjiraSiK2B1vvpDYawDcs4RtceVQHjSz7BCAX+O3ttVlurKGDifcyhFJu5C1OMpwcyiWrjF+21uyvfPvxNQpy0OuRZyTfnapY06CwoQL332GsXmgvm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgJv3a6orf1kPSMKxAaBJDxtv6fvtkY0M3Rai+SV7ho=;
 b=Dqcp27ZHVNEOCqvhko3MFUt8XAkrvbF8mcxkNY3ht+d6hNrjcGRLkvxvMkm4Hjmvpps/8AUXqbApWu9QVt8C5E60JMZyikQQg4ieE9i4tXcH2fSjHzIv3eOuBpl57vosex4fD+yW9OVFC+WZa4EBCBI+/Pskc2QnIivgUrJGYaM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1898.namprd11.prod.outlook.com (2603:10b6:3:114::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 08:38:13 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%5]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 08:38:13 +0000
Date:   Wed, 27 Jan 2021 03:38:10 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 5/8] lib: bitmap_getnum: separate arg into region and
 field
Message-ID: <20210127083809.GG23530@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-6-paul.gortmaker@windriver.com>
 <YBCIXzUkgjcCTprv@smile.fi.intel.com>
 <CAAH8bW9pQ_==uF3_Zo6K-ijqHXDVcW_-9gx0fvFWXe=fEvsg9A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW9pQ_==uF3_Zo6K-ijqHXDVcW_-9gx0fvFWXe=fEvsg9A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::31) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 08:38:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca05dbf2-a167-470c-f6ac-08d8c29ee269
X-MS-TrafficTypeDiagnostic: DM5PR11MB1898:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1898F995A90EC90BF76123CF83BB9@DM5PR11MB1898.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cG1BFVGGaIdUq5qmYOtf1SWix9knTD+IOo6r5ve35YxqL/4lqpgutKhYcxhuK1ecHJVPq+FNn9fVgznTAZo6jTZW7yIf6gkYXnM0TmhPz7dRYONkeE/B3JO5/MbTUl2XdbpvBsmKlHKI+VTWYYrjpnjETyIl7IhriIGSbFojx3h/OzR1pw/hm8tVZGy9NFYK6jN4gXhh1vkYe/0/EPo/Ylun3b5v8g/ArhQTgTtYPl7ZCiuhjDwWFKfJcaMJc7BE+NDGyHtB/+u3x9QufbZrzv1s2xK3HfoaN0BXUfez8i1jZ1Pvi639QTuQPwW/YtjiGshNJ5UR9qdn8uSilAJUHEoIQYcp4vFTo9HgrQOiVK882G14oEhq9zmJkWf1F+7FkzfFbqBrW0WdvaCEpRFajg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(478600001)(26005)(33656002)(52116002)(36756003)(7696005)(186003)(4326008)(7416002)(8936002)(53546011)(6916009)(55016002)(8886007)(66556008)(316002)(2906002)(8676002)(66476007)(83380400001)(54906003)(956004)(1076003)(86362001)(44832011)(2616005)(66946007)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gTk9SsmPY4tz1g/849AMO6lpeyQa6zJ5YR/8WmCNzxetTOv2iyZ135E8PfDg?=
 =?us-ascii?Q?qMiMyL6/y0lmm8fO0klkl3I7ZOs31XWdiPegSfhq2oVpB0WvtaiucpQNB1rB?=
 =?us-ascii?Q?w3/m8uXmlZb2xao/hLjloTPCuzdCa5UrYsDE9W636wWuhYUZhLATaRrn0OJO?=
 =?us-ascii?Q?khWUJ1q7GuG2uY5R9Qh+tuPi/5gd8dxuSU3Tf2TfWaGcdtSGCpeke39Js+of?=
 =?us-ascii?Q?OSuEWdTjWMx0hsgI944o8l/brncptCtrk0ZZnbtVHPj2BGLMzqFpUEKJyipy?=
 =?us-ascii?Q?LsYf1zfS3022mAFtJZmx9IMeK0f4fuH2yinYHI6pj7+PKjkRGXbiDtFuoVyD?=
 =?us-ascii?Q?9YSVAoaYj5iAdNyfqxSV7ftjZ1ADTG+LpASZWhZdlyj86BmFMM9vv7aZUBNc?=
 =?us-ascii?Q?oqTGwJ8QNolh7FO90K3V6tlHrkNREDLZdu3TGzhnWE/sNKeoJR5qDohPeh69?=
 =?us-ascii?Q?aoKQV0U8ww0pe+qMqhMufBEvWWEFNH3Hze1gm/KRabp2JgmxomnH+kDELrDo?=
 =?us-ascii?Q?o1FXa3CvyCl8GQH5L++FoaTAustx3E5gVIpIJl9pTJ4i6Ekdwc3PkS8IcMk9?=
 =?us-ascii?Q?Dva1h1TLlXTnfSHWBylTYoLHirndqPAbBPMkpFl2T9uHGZU/LQSD70Kn6GB4?=
 =?us-ascii?Q?k03g9YaymiIcXyfcS+oVLo/sA403ndKX1nGWkOSjA+fs3VMEujgUlCqxd32i?=
 =?us-ascii?Q?BKNNX2ZXcSNmQ3KOqTT+16AwMAQlx8lRw1fFjHfZLSf4W4aMtTUt0N9iMA2T?=
 =?us-ascii?Q?KzovkcgNJFZBLzD8JFxnql4vOXxRO8UUkw6kmzFrOP25HgPKlmmVsoIxW+W4?=
 =?us-ascii?Q?YJdo0/VOJzYclrf3qKd0YDcMtZX2fH1vUsOLlFsjCTnGvL4VzxnVJwzKbgKs?=
 =?us-ascii?Q?QAs4tYPzoJeBH2n657Shpo2n3OQCR7BzwODznD6FxHFJjNTALeshtF1G2uwz?=
 =?us-ascii?Q?Q8UrKenCdPp8EMylexYka37sLzTgYUNLY2pHftD1tre1B+6NgVoQBVL1/q3N?=
 =?us-ascii?Q?7n6oQOZGDjcU7v9qvnNPrihVT11314e5+rutQMA6Pkn0N5+Bcv8o/tPHRgbP?=
 =?us-ascii?Q?jlFv7zAU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca05dbf2-a167-470c-f6ac-08d8c29ee269
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 08:38:13.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqeiNFRbWoevzKdp9brKnulDX/NefQZJlUiyw0f8sUVGQlXB8OJIKOUfvX+rU0DkvhTJInQhmecjD0x3jBGVg+KN8cYCvEe7+5Ralbacxcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1898
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 5/8] lib: bitmap_getnum: separate arg into region and field] On 26/01/2021 (Tue 18:58) Yury Norov wrote:

> On Tue, Jan 26, 2021 at 1:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Jan 26, 2021 at 12:11:38PM -0500, Paul Gortmaker wrote:
> > > The bitmap_getnum is only used on a region's start/end/off/group_len
> > > field.  Trivially decouple the region from the field so that the region
> > > pointer is available for a pending change.
> >
> > Honestly, I don't like this macro trick. It's bad in couple of ways:
> >  - it hides what actually is done with the fields of r structure
> >    (after you get that they are fields!)
> >  - it breaks possibility to compile time (type) checks
> >
> > I will listen what others say, but I'm in favour not to proceed like this.
> 
> Agree. Would be better to drop the patch. Paul, what kind of pending
> change do you mean here? All the following patches are not related to
> parsing machinery.

It was directly related, because...

> 
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > ---
> > >  lib/bitmap.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > > index 833f152a2c43..f65be2f148fd 100644
> > > --- a/lib/bitmap.c
> > > +++ b/lib/bitmap.c
> > > @@ -533,6 +533,7 @@ static const char *bitmap_getnum(const char *str, unsigned int *num)
> > >       *num = n;
> > >       return str + len;
> > >  }
> > > +#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))

...this one line above opened the door to then do [in 6/8]:

   -#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))
   +#define bitmap_getrnum(s, r, pos) __bitmap_getnum(s, r->nbits, &(r->pos))

which gets nbits down into bitmap_getnum so we can handle N in there as
the placement you'd specifically requested for treating N as just a number.

In any case, I've decided against putting nbits into the region struct
and have got the nbits value down into getnum() another way for v4,
without using this commit or similar macros.

Paul.
--

> > >
> > >  static inline bool end_of_str(char c)
> > >  {
> > > @@ -571,7 +572,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
> > >
> > >  static const char *bitmap_parse_region(const char *str, struct region *r)
> > >  {
> > > -     str = bitmap_getnum(str, &r->start);
> > > +     str = bitmap_getrnum(str, r, start);
> > >       if (IS_ERR(str))
> > >               return str;
> > >
> > > @@ -581,7 +582,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > >       if (*str != '-')
> > >               return ERR_PTR(-EINVAL);
> > >
> > > -     str = bitmap_getnum(str + 1, &r->end);
> > > +     str = bitmap_getrnum(str + 1, r, end);
> > >       if (IS_ERR(str))
> > >               return str;
> > >
> > > @@ -591,14 +592,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > >       if (*str != ':')
> > >               return ERR_PTR(-EINVAL);
> > >
> > > -     str = bitmap_getnum(str + 1, &r->off);
> > > +     str = bitmap_getrnum(str + 1, r, off);
> > >       if (IS_ERR(str))
> > >               return str;
> > >
> > >       if (*str != '/')
> > >               return ERR_PTR(-EINVAL);
> > >
> > > -     return bitmap_getnum(str + 1, &r->group_len);
> > > +     return bitmap_getrnum(str + 1, r, group_len);
> > >
> > >  no_end:
> > >       r->end = r->start;
> > > --
> > > 2.17.1
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >

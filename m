Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1432091C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhBUID2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:03:28 -0500
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:22215
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229680AbhBUIDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2YpLVmk1N1mZ/2ZXaTa5til9o1dHkYKaRgWNuyKWHsfL2EIdapCDEyw77n30K66l5AnJiMzhWyRkLdUSWqW+IL3J1apwPCua1UiPsVtdRQDmyPNCh5/9BZwVTsvCXzz0ib3bCFdl4rl7sBNZhewGa5N1zh9qoORBmgXL8xlNriBlcY1bgXw6RrriGdciBZwXJeoSxZN4vxDANvZtdWPEpkAFFH8pVePycSpqHpkClM9WbwitXe4DJSl/iAPCbKT7t+mIkOIfHQeqh6OMoeR03qZG7SgoO/m1daUSgyV9+cEytirH6Yl8/Cev1Kz2Op2wHYtEllMCQUb4fBbgyIp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O7jdh90KwBk22i0urFHmFxfYjfxwnXWZ6NeuFyYnRM=;
 b=Mi+/TSkWwELTwIT0YyT9Hhp10shetGKYuOZi0G/0aNm1rCTeerIzBKgF+pSbEzRqfY/WKnlU54vs4b/AF9zuI5SRZeXpT6ARnbw2ktrHsILe5en2+uTCPcH112YXOA26oRkXMVUMqhinI2+Ucm3DV0Xkmj2MU3JfcacrsYdooA0MRQWgbryOry/zURCk+YfGfFuX9Xq/8Z8kT3/NwsUR1shcEVwW1anv1hrn7MSS2pO1vgjksY11JAF4pvkuoZ56JHmu4z5/HHYQY/L+QGe3TdkRH72uKR/vGEbZKLre1TZDtkPkklnolTN4Uiu7u0CNdyiLNOX08gchAXE3lyrrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O7jdh90KwBk22i0urFHmFxfYjfxwnXWZ6NeuFyYnRM=;
 b=Bj0nwVueN37CUkm/dHcirikxPgv69mJOE6xulN76+7xQ9s5osOINOK2RaYAIz6rtZT+xo8+YI12bOlc9Ok1Nl1Y6B9GxLWlaFU22C3Rr+DSl7VSl87WsbDA7jB+zfTNgEhAzmnQGY77sPG2nqDaDcIb/Yb1jomKqIJ2w5zvssJo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB2044.namprd11.prod.outlook.com (2603:10b6:3:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sun, 21 Feb
 2021 08:02:40 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:02:40 +0000
Date:   Sun, 21 Feb 2021 03:02:36 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210221080236.GB6298@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
 <20210210175751.GH2743@paulmck-ThinkPad-P72>
 <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30 via Frontend Transport; Sun, 21 Feb 2021 08:02:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f7d413-c406-4bb1-9de8-08d8d63f0f61
X-MS-TrafficTypeDiagnostic: DM5PR11MB2044:
X-Microsoft-Antispam-PRVS: <DM5PR11MB20448616C3E02E38B4600FD883829@DM5PR11MB2044.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyxMerxvy/kvtecn5TRHvfEXB3eNPjekXs47b/eKGlyI434dDpYiV55SfsR4/vWVP54VbcpAvUUe4dkczvCCnND2qUuCVtkJHwrnzOT445fsMh+fuFvVaNRwvErgI7j2W0bbvOAU14Xpf10ik57J8/z8+Mt80YfRKe+0NNkJzb6WMbxNYtdy3Ca81cVKwgCXy5BDVHhFWI8SzQxAKa1Nr1v4FI0WQ94iVkmx5pSq3vHvpFXOk7oPIof8Qlw6gmcsD2WwN6e8PRlvUJbDPS8/ONVGdWoej1qd9IeQD+RgMZZPjCiEyCd17QOtvnJUinQkedVh4iMsUy0rabnPx3GfS/nSSJvs38J0UeFa4qvFWE2ju3yk7Ug0Dl+YcpJiHbjLF+HEf84XAZ63NlJR/vKqJ40I7NlywTPWiACMT1iXIt4YVlw1uIyJf93Sxa/tUTo1sMOKq4YdCEv4fKAcZGHOOsPqx7kkSPrTfJsQEL+PMzU7vi7VkrlzJObDzMsGkx41UQVE/22uppR7ZAyNaYCaAH4HKP9GnCVBO98Fs4A4GUMg3ZQEfsJrY7F7hcyLZhvGsLY93yBoaU3LBKqBoIJoDwjxW+r35B6pNp/r8N/BgMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39830400003)(366004)(376002)(346002)(52116002)(7696005)(36756003)(956004)(8936002)(2906002)(2616005)(86362001)(55016002)(186003)(16526019)(83380400001)(26005)(6916009)(966005)(53546011)(478600001)(7416002)(66476007)(5660300002)(8676002)(4326008)(44832011)(66556008)(6666004)(33656002)(1076003)(66946007)(54906003)(8886007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OxHjHLTr3GPzYHDk//LZ4UOdg2zCi23Y4GlPYyuFrNWULzZHJNRty3tYe0fe?=
 =?us-ascii?Q?EAYhHEozMvPhGLnhZxdTAcwIDC3+H8iKiDz8QuUOUUHqAPMH2hUbcXJB+raR?=
 =?us-ascii?Q?nOtmsOI1/jez7BAufyktGEYem5yE/Boti6C8lpiuI1FTpTuIsUzYVc6yyiwp?=
 =?us-ascii?Q?SmNeNMg7JF8TuxTfRK5uln59kvp+F8Suq3dBwfrEYRWrC4A5rvXA41xe/sap?=
 =?us-ascii?Q?QlzdEBoXYOoHqGoBtDqg4aY+Gh9XXKmg7f5T/5UhdustPNj0JRj51drl9lB8?=
 =?us-ascii?Q?8P5sTB1P9wibWIpnNC0jlQQxlzq2Akh91WmAiwf+yPVHSzxzDVJFOiaBOKws?=
 =?us-ascii?Q?nJ/a3/EOPnMDTjJDofQFq3wi/15eq3WE5PJF7VkBHQ8Eh8yGzQdhxqSHXiaG?=
 =?us-ascii?Q?RvpyQNDNS0Gq5wS4qKXoJMZlqX1y4bmFIq1VkgxxOyqIGzGaXYHtjnbHz9Wj?=
 =?us-ascii?Q?zqtuEZ2UZ5Me6MNAhzL1i0IC0gWv4BvvBkyUKErzsIB5T6UVK24Xbw/qfuN+?=
 =?us-ascii?Q?3W15m/Ac6MiTAlp7a4WpJaGvI+9y/qoj2e/Rxpls3MnmRHniPUlEHB92v2nG?=
 =?us-ascii?Q?WUZIpCrtrkFvsW2Bc/p2djhtHeQGRIkIdSVkPArsNPC9/F7hIDDNpretvMnL?=
 =?us-ascii?Q?seakt0VAA2J1qhJJBq10YmXWgjCnbrwwoB+9ZOgYhd4hqMcwHdNxGEDkEM1p?=
 =?us-ascii?Q?1Ifz1/tJLiKxK1y0xoXHY/F6Kjl4e+AiC0iJGbohAQ4lBA7YPtw2+MLVJPUY?=
 =?us-ascii?Q?uK+Fg31/51cCABma05ytyBsRvxiiDOuwr4AUrXw3FVTKoanox+rbZxUmLvn9?=
 =?us-ascii?Q?3DpYfRLNfZVBZHkAbSlLSuvjTgSqO9Pvvg6yvB9E6GeYvZ6eSa+KLnhbWKrJ?=
 =?us-ascii?Q?1CKXTYAxCD8ipQiqG9iVo5xdcVh01m7eZb5bldFKBAHwRgyH4QOt9H9pazjZ?=
 =?us-ascii?Q?qbJ9WcA8SQ+T2XnM8zqmPWifvohyDq0Gxy9ftQ53VIOBklD5XfF100pImJ1p?=
 =?us-ascii?Q?VLzeF9VR6DXKUKgeEUtW+3gkhv0Q/fQ6TzYfCtoMmN2CEnbV7gIkJmoVXGRY?=
 =?us-ascii?Q?d1+dxL29qxwGdqD/ZfMzffaLhytikOpyZhu8uNQncum/EHImIuuE92qVVjqV?=
 =?us-ascii?Q?EFG+JBGY8C553xILYBhzYokv8+7fcfvUQZMJKNp5L1hugdc9+cv6uFzZBqR8?=
 =?us-ascii?Q?a4ePeHA5LF0voOXrgYPDar6qGBSujiJWj1WA/GDHvX6kgYMS+X2mNxgP4jFI?=
 =?us-ascii?Q?8OsbpjxsoWZl4oaWAyoR4Z93ucsX/4b8FvNHClyPq2x5I4YP1EhT58YoyUfu?=
 =?us-ascii?Q?8uI/J9k2BPJIj0XhvubB2cep?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f7d413-c406-4bb1-9de8-08d8d63f0f61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:02:40.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuvyNM63Gr3z8Z7TkBPWe5s/s9cUkQoGsnTtbK+6Dn6jiFAhacAf91TiS01qX8O4Ve6neaZNnLrhcfRQ5VBDH9wntB0rrLzgZ1d6h9Qq1lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N" abbreviation] On 10/02/2021 (Wed 15:50) Yury Norov wrote:

> On Wed, Feb 10, 2021 at 9:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > > > The basic objective here was to add support for "nohz_full=8-N" and/or
> > > > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > > > to the last core, evaluated at boot for anything using a CPU list.
> > >
> > > I thought we kinda agreed that N is confusing and L is better.
> > > N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> > > sounds better as *last available CPU number*.
> >
> > The advantage of "N" is that people will automatically recognize it as
> > "last thing" or number of things" because "N" has long been used in
> > both senses.  In contrast, someone seeing "0-L" for the first time is
> > likely to go "What???".
> >
> > Besides, why would someone interpret "N" as "number of CPUs" when doing
> > that almost always gets you an invalid CPU number?
> >
> >                                                         Thanx, Paul
> 
> I have no strong opinion about a letter, but I like Andy's idea to make it
> case-insensitive.

It is trivial to add later if someone can prove a genuine need for it,
but it is impossible to remove later if we add it now for no reason.

> 
> There is another comment from the previous iteration not addressed so far.

Actually, no - it was addressed in detail already:

https://lore.kernel.org/lkml/20210127091238.GH23530@windriver.com/

> This idea of the N notation is to make the bitmap list interface more robust
> when we share the configs between different machines. What we have now
> is definitely a good thing, but not completely portable except for cases
> 'N', '0-N' and 'N-N'.
> 
> For example, if one user adds rcu_nocbs= '4-N', and it works perfectly fine for
> him, another user with s NR_CPUS == 2 will fail to boot with such a config.

Firstly there is no "fail to boot" from "rcu_nocbs=<invalid>" -- that
just doesn't happen.   In any case, as you can see, I added in v4 the
documentation (as you requested) for this case - in several places.

And I explained in the thread above why any attempt to do some kind of
mapping policy was doomed to just add confusion and end up doing the
wrong thing.  And the discussion ended with that.

So I'm not clear why it was brought up again here as if I just ignored
your "broken config" concerns and never addressed them.

In any case as others have indicated, it serves no immediate purpose to
over-think this and start adding corner case reactions to use cases that
simply don't exist and probably never will.

Thanks,
Paul.
--

> 
> This is not a problem of course in case of absolute values because nobody
> guaranteed robustness. But this N feature would be barely useful in practice,
> except for 'N', '0-N' and 'N-N' as I mentioned before, because there's always
> a chance to end up with a broken config.
> 
> We can improve on robustness a lot if we take care about this case.For me,
> the more reliable interface would look like this:
> 1. chunks without N work as before.
> 2. if 'a-N' is passed where a>=N, we drop chunk and print warning message
> 3. if 'a-N' is passed where a>=N together with a control key, we set last bit
> and print warning.
> 
> For example, on 2-core CPU:
> "4-2" --> error
> "4-4" --> error
> "4-N" --> drop and warn
> "X, 4-N" --> set last bit and warn
> 
> Any comments?

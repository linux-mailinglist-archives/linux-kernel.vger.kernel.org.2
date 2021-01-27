Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1363630569B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhA0JPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:15:46 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:36321
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233532AbhA0JNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:13:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNNMn8Py/ym0FBjhC4IN3SHAZ0I2C/1frVugQPnviE6+0YlK1nqA0y0BtUfscqdam4LBLHwt0vtd2mQtt00kIZ4FTuab65RfqjfQthAWE9MYNEBZCLghcJE742J22uJ8qysPVyeOM14bltHgk/e225i2fhM8FzMwa0+VqzgWSIfjIsY0JbGFquJQjj/URgqQlYDPYgd36t7NLoSK0ilqORJkewRKpY1L0laNb5soBUncj+X3vCluRctrjDwRA/yKwnIt/OyFfLU30Ze60JJ0QQmXtH1qawcKds+E8x2sCZWLJzxjvswf6RwFtW+KpZWwkCrlqvqrFMLnmZ8rCBKazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CNSFQ7Av24ZOf+xqpGVTVnpU9e6E+rkwDRiIi8X7pA=;
 b=Ga6VmeNY8G9UE/rVHYb5zC93huWOOvSKureEoo7lhlTb4LodApaAfUSFci0tgTVMJ8sfPCdy1HChKhntni+4uIVDazZz8tF7crpunjsaHDdgsorWQPU/k3fZrIddQpByJsvlLEI4djfC7zzNlQ1uM0cems2FgaPhObiWY9O+KDKYD7qbHe9nGcD7r7rM8rKRwPWBp9/vpanr9LH5bN9RSlPpWtkLUipBCBE5nVmB8tN7TCpChFKfddgTsa5RBi5Cmmn5IPQCb8QEKmITrWtBwW0ZNbsE/ovL7e5w2DSKt3RlVPqJCHbdjZxZCRNmbfnumeosK1HbEEZ4p/fN7J0xwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CNSFQ7Av24ZOf+xqpGVTVnpU9e6E+rkwDRiIi8X7pA=;
 b=mpFmClhkFVariiXjd2mHUigA8OqJmN5TQ1MIpTvZF0yUQY2wDX0B6f55eQVViazGXpe72TxJNKyKMfBMMVz9vobq3ruUDt74aW1/4w3xGTrxGt7dNF2bP+oLBKfei/iagAohD0cpiFMMf7iXFuxP8UyUbFQxwwp/94OXQ0jxQ/w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB0012.namprd11.prod.outlook.com (2603:10b6:4:68::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Wed, 27 Jan
 2021 09:12:41 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%5]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 09:12:41 +0000
Date:   Wed, 27 Jan 2021 04:12:38 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210127091238.GH23530@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <CAAH8bW-6GQkx67=iiwozKwG=4b4rJ8sqNB3UrMeS5eregNvkzA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-6GQkx67=iiwozKwG=4b4rJ8sqNB3UrMeS5eregNvkzA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 09:12:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b332f54-9d2e-4822-389f-08d8c2a3b32b
X-MS-TrafficTypeDiagnostic: DM5PR11MB0012:
X-Microsoft-Antispam-PRVS: <DM5PR11MB0012B9B3E6C9635CD628544683BB9@DM5PR11MB0012.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6IodU5IZWYoCOz0Ca+x7RqTJyI+Mgdwovrqw5VwLRuKUxZv3m83/qME/YtbBVxJerjYfTnesMbmxPhcTLNSNBv1lclYLLXiCKXL61TAfrlP6/Ios2iklD2DxhR6VFARDOiEJ3autikcE4y0MU38aQC4znDhgvj+ebmXNoKOD8sVYpEVRVyyCd5MpbJlbFJ1yA0k4Z8UHBFGy1itC9xIYC/mTg36mjYVCLxceJXSjMaYbi0Kp9/fm+QLEYtV7H63C6K/jB+RZVCP44KhKS2rvRKIDvjkN0K/FK4JX9wl9o7IOu1cdBMCxGe+iEplQcM0XzbnB/eE98ixIcjSm9kINZEFgEi1PzMeycEar95rjmT16RPn9Lpm5E0IATu7JC4urIOQPoubZEkpm2ZPmJ1xjZjt0RYkimJ1RBHyxy2uTVPNctk6NSa2DRJVXdXUR+uRI7Ii7rnrP6xw92jqo7s61A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39850400004)(346002)(86362001)(186003)(36756003)(6916009)(2616005)(16526019)(53546011)(83380400001)(956004)(26005)(44832011)(8676002)(66556008)(2906002)(1076003)(478600001)(52116002)(54906003)(316002)(4326008)(8936002)(33656002)(966005)(66476007)(5660300002)(66946007)(55016002)(8886007)(7696005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?blQZRrVKwrJLpDQ0t7tDdnkJ8XuQMWc/jb0CtRSUfSxfbrqa1AutwG94xk66?=
 =?us-ascii?Q?bJ6Z3H4YYoRd2f6j8r4ZlUzrxvK8NoMpYeXGYmNR42MLX+3WIFI+eRaOaQPD?=
 =?us-ascii?Q?bED2iLCCD/vpIf5bpsdJO8/1GayhK3jNzzrEjjl3myrrDzud76iEaVTv+7OS?=
 =?us-ascii?Q?RvcfkQFwHIHCLtIx6KAOaA0lWjct2C5Fhogh7qS+cvyEL8t1sDIbPjINJlzI?=
 =?us-ascii?Q?IHQTe3WWIJrZhTU8GP1cdbyv4+3EDgdYTyG7+YQ3UQ8eP4uF4LzNNBeq2vyv?=
 =?us-ascii?Q?+UF4L27t3TnTMCKypnSqECWeuDHTftTkavkwpDUtohP6crADb3uTeQnyU0fa?=
 =?us-ascii?Q?vq5EsM6qyYJF3q49c4EdkNW7i7kZ1bXKNrA3z2xhhrLucTwaYggmvU1WdmUl?=
 =?us-ascii?Q?8ZWiW0sdItNIq4h39xl8mUCU1GezoCEYAowTTsX/6rH08n5u9s+/Nz9lFKT7?=
 =?us-ascii?Q?aKZQ0y/J11Jh39/mTL20D9nyuKabz7ScyErevpES+CqXQmhkOdsWyBsx7uLT?=
 =?us-ascii?Q?1tIvnBxv48zQLqpKueTCwmCjDsQ8lQY8lfUNtcqObVa0k4Y2wQdCByiMhCLu?=
 =?us-ascii?Q?Xemiq2A3X+w0lwhst06VO2KG9Ptm1OsE3n/Vi6xceho0a9IlLmuFGXwcSujs?=
 =?us-ascii?Q?/c2sD9ahymyt/1cAL2RTFFQYPd3IEvawNP9dmMhn87bM505txe11zpQX8QaW?=
 =?us-ascii?Q?KY3UQvSSTsJcyrqV+FGxgOKb9JGRFC0RAv906v8sSmCzHj7mMcVLYK0maeF3?=
 =?us-ascii?Q?maipsG2SQakdXexLQ8d5qJd74qNTOsvTJzYE+dab+0jLhR4tMrhmGF526Yfz?=
 =?us-ascii?Q?KKL+1VLL1ugFqjjwuISWHaH5dm2JW8yxvrQjQgU/vErlilPR5stqAyXiiJzy?=
 =?us-ascii?Q?Afh5nrNONTvmMEjRAH++hyDC6DJtDE6UwOeOHzmNyA8yv6iVf+h0Qkb4UuKc?=
 =?us-ascii?Q?xmq1vyiHeaRM679xve0Wdi5rzdWCo4d2Q2mbRwIWTB27DhIF+Sb1CdVMS3xY?=
 =?us-ascii?Q?IRI356CWoc02bgIHnemdVB10N9bEHqmirryv3TJsRKZwLgh5DVDYm1yw36Tn?=
 =?us-ascii?Q?fmAGrWro?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b332f54-9d2e-4822-389f-08d8c2a3b32b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 09:12:41.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlBnsWOmorcOwIu3Qigi7mTyuJF1MQFuXjvq9gsCvyxVtAQE+US8JAfXB2TuHbYA6AqOd2W+SE9Wt6SE8t2z46b3K/8EOjrGorBycQNiy2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH v3 0/8] support for bitmap (and hence CPU) list "N" abbreviation] On 26/01/2021 (Tue 14:27) Yury Norov wrote:

> On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.
> >
> > Note that "N" is a dynamic quantity, and can change scope if the bitmap
> > is changed in size.  So at the risk of stating the obvious, don't use it
> > for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.
> 
> I think it's worth moving this sentence to the Documentation. Another

Dynamic nature comment added to Documentation

> caveat with
> N is that users' config may surprisingly become invalid, like if user
> says 32-N, and
> on some machine with a smaller bitmap this config fails to boot.

Updated example to indicate that "16-N" becomes invalid if moved from 32
core system to quad core.  I'm not currently able to think of an example
where boot will fail -- vs. a subsystem getting -EINVAL from bitmap code
and printing a subsystem error instead.

> It doesn't mean of course that I'm against 'N'. I think it's very
> useful especially in
> such common cases like "N", "0-N", "1-N".
> 
> Would it make sense to treat the mask "32-N" when N < 32 as N-N,
> and bark something in dmesg?

I don't think so.  For the same reasons you used to convince me -- that N
should be treated as just another number and not have special rules.

If I boot now, with "important_cpu="32-3" on a quad core then I get what
I get for being stupid.   We don't special case that and subsitute in a
"3-3" (which would then be "3") -- and nor should we!

Sticking to the CPU example, we have no idea what the caller's use case
is -- we don't know if NUMA stuff might be present and whether having
the single CPU #3 in that set is better or worse than EINVAL and no CPUs
in the set.   Expand that to bitmaps in general and we have no idea what
the "right" reaction to garbage input is.

The context of the caller could be simply test_bitmap.c itself -- which
would be expecting the EINVAL, and not some kind of "hot patching" of
the region in order to make it valid.

The only sane option is for the bitmap code to return EINVAL and let the
calling subsystem (with the appropriate context/info) make the decision
as to what to do next.  Which is what the series does now.

Paul.
--

> 
> > Paul.
> > ---
> >
> > [v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/
> >
> > [v2: push code down from cpu subsys to core bitmap code as per
> >  Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
> >  https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/
> >
> > [v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
> >  just being allowed at end of range like "0-N".  Add new self-tests.  Drop
> >  "all" and "none" aliases as redundant and not worth the extra complication. ]
> >
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > ---
> >
> > Paul Gortmaker (8):
> >   lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
> >   lib: test_bitmap: add more start-end:offset/len tests
> >   lib: bitmap: fold nbits into region struct
> >   lib: bitmap: move ERANGE check from set_region to check_region
> >   lib: bitmap_getnum: separate arg into region and field
> >   lib: bitmap: support "N" as an alias for size of bitmap
> >   lib: test_bitmap: add tests for "N" alias
> >   rcu: deprecate "all" option to rcu_nocbs=
> >
> >  .../admin-guide/kernel-parameters.rst         |  2 +
> >  .../admin-guide/kernel-parameters.txt         |  4 +-
> >  kernel/rcu/tree_plugin.h                      |  6 +--
> >  lib/bitmap.c                                  | 46 ++++++++++--------
> >  lib/test_bitmap.c                             | 48 ++++++++++++++++---
> >  5 files changed, 72 insertions(+), 34 deletions(-)
> >
> > --
> > 2.17.1
> >

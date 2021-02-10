Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC8316A96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhBJP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:59:26 -0500
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:47840
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232022AbhBJP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:59:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUrrEmRd5sUidBNPaXZbDNbabGLEsKkJF47/lTrRS6buf2j9/0+0cO1hYN681tqBvLMj0VkCvkphdY1dSl6DWO8yxIJrbm+WFPF02+KdK8UqEBCRlhjOXKVd71H6swNz+lcFCuaSo2r6DoPoUnEw6jf0bqz08UukYuQjA05+k0f86oC8D404Q4Ri9aIoJuyXlXKfbUEqxjQ2Zi0stbISF+P4z3VhudsbQxOU17z2+UmmvoYEoKdwr2nlXWPqSU+ArXN6WEr2EVqGVIYnCbsPgbRhO3aZuwgZXEVUnwJZTMEaVtC/syWJLJm4HouB4wrvyTWqHppNSjDou/KcNmJJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U737ElsizDcdAU1CbZOBTNpw0GeVapqpLxIHAymc9hU=;
 b=TGl7kl+YsMiJG1p01Dr+pyXIEZ7MhKbHlWq8/UxJXxUe21PiJoEtgT8YDdpOJ7fXUhdPVf2JqgVrRXhOOgweetQciBezGtcrXH8V8QBVkclheDi3ccPVeXmZr4XGKmae97NwBnbSfW+qaWcytSIMWtyMebPGu5g4YV7wUa8lV96DFv7ouFVCdg0i/Y9UbJ6vXt3Gv/JuYmQFRw6juZzFcV16Jsu68lCOJ6oV4WbS8iZ4AmN2MfrJFg4eoTEqwAILMC2uOWR1fOA/hjYBVW89Gb6KgbMaJJXe3lq46x+7QSsB0OPF8wdi2GqhvlBjw0I7LtxjlT8CSmx4K2KnExjjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U737ElsizDcdAU1CbZOBTNpw0GeVapqpLxIHAymc9hU=;
 b=lRnmArUjqyUbHWJ590t1oBzBCcFunUMep0jLsxxoF2AWTK6x3u4g5G6C1kNK4ZEN0Pf3NXV16dCrur8wdCbVQFNHP4sNMqhUK8PLhczOVn1qXZLc3uA27ybw6Tzr7A/OEismgLx0YGT/b43JYYmzxk6Lmr4VpGlOTMysl/gWMRQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3628.namprd11.prod.outlook.com (2603:10b6:5:144::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 15:58:29 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3846.025; Wed, 10 Feb 2021
 15:58:29 +0000
Date:   Wed, 10 Feb 2021 10:58:25 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <20210210155825.GA28155@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-7-paul.gortmaker@windriver.com>
 <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 10 Feb 2021 15:58:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea39acac-a694-4acc-6d66-08d8cddcb54a
X-MS-TrafficTypeDiagnostic: DM6PR11MB3628:
X-Microsoft-Antispam-PRVS: <DM6PR11MB362805C5B28426B3CF7AB6F4838D9@DM6PR11MB3628.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ+lhj65gMlwtopWFue9tU2qo7B6ZfEmrhbJDV3KpQPVyvRL4TzdLP6IYqUChIntvKxmJFhH9XLMo9nmJG2HAKCAObddnfWjjwm5xqDR+TrOO/Tl1vjLV5KCGYIyQBEPy1d5dZ6F1D21Zlm2ktOCTEzyGlD5U7mvzBQq/AYCXmKxx9Y1I7KX4frT5B58MBaB5Zo7YqhV8jqnFUEN4+2CXZ+0XQmhjl3LfQOXXk8ev/IW5709HSz7zWm+uDIqLd7UMVyjo74Vx1KLjy8rAVpFM0mX6xNNfsPomOqGi4whHpmNYj6RNfyVcDcDY/CNzHLGcFmRmnA5EWkwOmX9B7oFb75YYgrey0IU8TzQVUAhS73QGPtT7NutS7cmCfOd0PW3F5PcjgwSqksz6rjGY2Y6nnhJJoQxXHEigYTstCrIB97C8q3OSBJY209SChEjkirAmgR/JzCb79l7uMRYgDH0FCWMqUYa7m21bi/619P0RDkDjxHB7BV6ZTxMUJmbRkgtqXSabu146gK0cvsEBDLAnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39840400004)(136003)(346002)(55016002)(44832011)(2616005)(956004)(52116002)(7696005)(36756003)(186003)(53546011)(8936002)(26005)(6916009)(16526019)(2906002)(316002)(7416002)(54906003)(33656002)(8676002)(83380400001)(86362001)(478600001)(1076003)(6666004)(5660300002)(4326008)(66476007)(66556008)(66946007)(8886007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E+FjNlgM57W27/Xm+1o8U7e04ELUfpugUYDGsGrTuj3zED8yZgVYQoLiiDs3?=
 =?us-ascii?Q?DvknVDCzUENHhTiY+Nz7Rw3qsEs9oyN4A7bQ+GEOKXrUZCgDYebM1C8uy5/D?=
 =?us-ascii?Q?svCL3jwfh7dg1wstVT7UXibyrnP0RvSDj5gmaMwMnsvrjQsooVaOophmCsHF?=
 =?us-ascii?Q?H78W1cMAsjy0R6H/gxr0lg0VA4AbfQRvjqGD5rOv9QhsFyKezpwaXDnhZuUT?=
 =?us-ascii?Q?RifBU52h7Tz2EfraIBaGtYGPlATXXyhCv4kB5YRKxSRhUMEXragbkpXMikCk?=
 =?us-ascii?Q?JCvYiYKsxkcKIhK6msQxA9syRHlx8XVbnZHyWR91sJ+H0+dndi6sqyr2bp/+?=
 =?us-ascii?Q?QPqAuhDTG5SzmRkbs5My7egVOgBt0LRGDY+WZ8/gbEcx37lc1EHeh5NkyIcJ?=
 =?us-ascii?Q?0wt8GR/aHVA1BfXV2nvONPNXed4xPrsLnahCM56oxkRE4H+DBI1H/BgWcUzc?=
 =?us-ascii?Q?qclUfyNpFTVFDc+8NhlssNUwHgElu4En81LHsZzXNHBEqHy8RO6hgF2eARQG?=
 =?us-ascii?Q?Dx23mFCcj0K2Qd+7SjbgNSoEaEmfRtNquFVWm6lzieOiG0PoHvExTdlvYqqm?=
 =?us-ascii?Q?1VGXhGcidp8OZ68BrBnPtlT8wMeti9dOCxlGduh5Lt78sVWoGkmR8geTr/qG?=
 =?us-ascii?Q?Ua/2pJfqXl9HczUtNQXBjaqvyDMPEB3yghAXVi58g08HWWeU+FtMEK8nOGYI?=
 =?us-ascii?Q?O5AxKMkE9gT/TtOq+6AJKsFYk1fMKCJul/73m0eAuc5uqEqooqpozysF6H7k?=
 =?us-ascii?Q?s713uAa6w9fQ0aQNPxByN265FuvT4zTomXOcu6fIdw68DOksLPoBU6PQ+gXp?=
 =?us-ascii?Q?hYwx5EdschyR8gJTqy8Hd9XXQ+doHhZVkkW7Sw/yfOeQ9oylb6irZyZ87ZVh?=
 =?us-ascii?Q?SQERL8FCQAj+UKTW3AjX5IqxM/HuqtQDdQlQ5ffZ0EXwf+RNtwFVwmrvEtAx?=
 =?us-ascii?Q?ku8zOccUIsclBPBa6PzOyq4dKxdKUkLKF5RCWZR1FiDjgT1Oz+32LA+gEwu4?=
 =?us-ascii?Q?exvco+za5slZ8IP6doPQjt5dmd4qicf/FCgApJbzJ8xYiMmai65WdYBPWH3g?=
 =?us-ascii?Q?5nlmbkGINcegwO1ctDRMaM4FQ9BCghql+feNy8RX+b8DfZiz9yJoK/rVHSwD?=
 =?us-ascii?Q?9naZX4fOGjCsXTXiPygktsq6Yr/XQik6LhBAj4YGM5p+/+q4q2dWratUIWTG?=
 =?us-ascii?Q?XJeDS/3prRqJa1vaV7LhP3JrBmJDNa70J3wTAUVI/gTNIgIbsn/C0uGaOjNo?=
 =?us-ascii?Q?Q8Cwc+ilX96+M3LbIhdgsdz9YofGZjIDMGDAxIQRY2TMSHwudfrBab7X+8rB?=
 =?us-ascii?Q?kDhm/09UBKpqMT4Vk+1wVi2V?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea39acac-a694-4acc-6d66-08d8cddcb54a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 15:58:29.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2jlRSvWFPCIdLEvmw4AGaazmXtSCbcXE+OvnQ1fOLf4CtOvkisvtJjc+DStP4xUwFM1IyeZeboxNaWJvPFLcxgLG8ecV/PzrfXHZjnYzL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 09/02/2021 (Tue 15:16) Yury Norov wrote:

> On Tue, Feb 9, 2021 at 3:01 PM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:

[...]

> >
> > -static const char *bitmap_getnum(const char *str, unsigned int *num)
> > +static const char *bitmap_getnum(const char *str, unsigned int *num,
> > +                                unsigned int lastbit)
> 
> The idea of struct bitmap_region is avoid passing the lastbit to the functions.
> But here you do pass. Can you please be consistent? Or if I misunderstand
> the idea of struct bitmap_region, can you please clarify it?
> 
> Also, I don't think that in this specific case it's worth it to create
> a hierarchy of
> structures. Just adding lastbits to struct region will be simpler and more
> transparent.

I'm getting mixed messages from different people as to what is wanted here.

Here is what the code looks like now; only relevant lines shown:

 -------------------------------
int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
{

        struct region r;

        bitmap_parse_region(buf, &r);       <-----------
        bitmap_check_region(&r);
        bitmap_set_region(&r, maskp, nmaskbits);
}

static const char *bitmap_parse_region(const char *str, struct region *r)
{
        bitmap_getnum(str, &r->start);
        bitmap_getnum(str + 1, &r->end);
        bitmap_getnum(str + 1, &r->off);
        bitmap_getnum(str + 1, &r->group_len);
}

static const char *bitmap_getnum(const char *str, unsigned int *num)
{
	/* PG: We need nmaskbits here for N processing. */
}
 -------------------------------


Note the final function - the one where you asked to locate the N
processing into -- does not take a region.  So even if we bundle nbits
into the region struct, it doesn't get the data to where we need it.

Choices:

1) pass in nbits just like bitmap_set_region() does currently.

2) add nbits to region and pass full region instead of start/end/off.

2a) add nbits to region and pass full region and also start/end/off.

3) use *num as a bi-directional data path and initialize with nbits.


Yury doesn't want us add any function args -- i.e. not to do #1.

Andy didn't like #2 because it "hides" that we are writing to r.

I ruled out sending 2a -- bitmap_getnum(str, r, &r->end)  because
it adds an arg, AND seems rather redundant to pass r and r->field.

The #3 is the smallest change - but seems like we are trying to be
too clever just to save a line of code or a couple bytes. (see below)

Yury - in your reply to patch 5, you indicate you wrote the region
code and want me to go back to putting nbits into region directly.

Can you guys please clarify who is maintainer and hence exactly how
you want this relatively minor detail handled?  I'll gladly do it
in whatever way the maintainer wants just to get this finally done.

I'd rather not keep going in circles and guessing and annoying everyone
else on the Cc: list by filling their inbox any more than I already have.

That would help a lot in getting this finished.

Thanks,
Paul.
--

Example #3 -- not sent..

+#define DECLARE_REGION(rname, initval) \
+struct region rname = {                \
+       .start = initval,               \
+       .off = initval,                 \
+       .group_len = initval,           \
+       .end = initval,                 \
+}

[...]

-       struct region r;
+       DECLARE_REGION(r, nmaskbits - 1);       /* "N-N:N/N" */

[...]

+/*
+ * Seeing 'N' tells us to leave the value of "num" unchanged (which will
+ * be the max value for the width of the bitmap, set via DECLARE_REGION).
+ */
 static const char *bitmap_getnum(const char *str, unsigned int *num)
 {
        unsigned long long n;
        unsigned int len;
 
+       if (str[0] == 'N')      /* nothing to do, just advance str */
+               return str + 1;


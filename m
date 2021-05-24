Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022EC38E3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEXKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:10:03 -0400
Received: from mail-bn8nam08on2058.outbound.protection.outlook.com ([40.107.100.58]:40719
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232445AbhEXKI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3jblEco8koxS+C5FwrneLb7JVBLOn+QPc1Rz3TX0bqr9OG93yeN+COkOxdMt8EdGqY//lQfMYzMXKiCJNBMyGztrolVkUHmH8VxarAFFmf88nmQh+c5WUkKBXWnYfdMFC7Ru4Z0mtkRqT0MyuV668xrrPO7bNfvvwbNxmjEaEB02xlaENdL7oyX/k8tUCoZiFHD58xToQjvljEmej0w1aeuHGV9jsQ0wKqNXnVFv3Yjnv9Sp7pdPMgHpAbSzhyRAmbC4Af524mdCu9vF+jN5jhC4fwjRa2Zhx8nr1EwaEzGy3SU+oyXanWh7bujjo9DcRMDlYlkMIsXTZ98iIXaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwcl5RsaNsLK1+EwM2BkldY1b/SklL+hPVRv3Co2kE0=;
 b=im/OnC7vC52azxvxrwUpoJ1A131BtcOS+g/i0vL47cjqbQtfdiQ1hUvhJIqa6+TXnhBWGsN2jAxafW+VXE7+m1Quuq7JcrQA1lg1MRwMYEq3RbSHMg1VsLs33iiK40l0xbPdqJWxTxulB2Sfh0fx7hR+PUXMSsmYlvRYa4SmZF5TKCmPRKvbBq6OHOMgO0etboD2+PJ2ans1u9QjB6UvYaWNYSOk7hp+CbAn4biTEd6e8yNgFH4BWdJ1NAYzrMyCWZo7AyhNL19ub4mAmOEBBxdqSht6WmT2xU5TJxqt/TyM/k+VgWVBHZgrb/3gPsgJJ6YL066p9YR7ndYtHiH2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwcl5RsaNsLK1+EwM2BkldY1b/SklL+hPVRv3Co2kE0=;
 b=SjS3pH8R97Yt8nwt3ztNsEVWYIimIHef8aEJg9/S/I3XVb1He3IIsTNOweiA1YWrgHaphYLflanslXka+WwVdgKozbOprHVVxCxxcOzVSoGSvkXHazqSri9BQwYbatuogf8tNCFBbKsf8Ej5QVEg2fqknsiBICHxAeQMSkmLOnM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB2916.namprd03.prod.outlook.com (2603:10b6:404:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 10:07:08 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 10:07:08 +0000
Date:   Mon, 24 May 2021 18:06:56 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] arm64: remove page granularity limitation from
 KFENCE
Message-ID: <20210524180656.395e45f6@xhacker.debian>
In-Reply-To: <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
References: <20210524172433.015b3b6b@xhacker.debian>
        <20210524172606.08dac28d@xhacker.debian>
        <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Mon, 24 May 2021 10:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3914c7d-b5ae-4d04-7e04-08d91e9bb03f
X-MS-TrafficTypeDiagnostic: BN6PR03MB2916:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2916B9FFF837C639BF9EF83DED269@BN6PR03MB2916.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pST88dq3lqlrbynmMAD/WXSjL7IyJtNjFfzTk4DWyWQ6S5+eAl9gJZF9NaqE5I0AF8aAmiMkZyjjG2tpb9UgQbcAykR3O6mg3PPgU/84aE5578PqwCG51oRmPzMn+WgpE2G1WRVemx7tQY3dgL2mxkAH9U+v1FJEW32mQAEPgqz4LG48K3JrNIVNHqwGfshiLli6z8SOZvaECOArEmg8lvX4ULSFr3F4HnNYziBQ+OrjyDlrTPDV1bKm8NcnNRL0G71eXqUaTgb2V5wjPWIa2lD2R8DzSaXmNN2P28za+hlInM3+o0jy6/7ueQS/scy4cIeUGmlg0A0jUt9JlgfTfsT722FSWGQcUwNLdeEhDKrdVtHB54J2uuIyPvc+4cP+yiYb7yzqQxTtmLIA5WJ6GCMYLRerDrpKkxqMSy1tl4UrZfHf8BxHQ6hMTzFI9SgLJo87KNYMn036HsSLeH4Hfjus+sSou4aLNFY/1e1ZQ4CGk19/kBnQgOmvS+WuHMjB0qudnafa4lCju8/k+sGb3Vaoy+yjN6PUOBZ6rLbQ4FgpPdNu2ExuwhLvCXy7oK+FoduQhS9P9vtdb/QgSN6v4+p9AnaI/6uRUg7dv8Dx98VBlr0A3VcZ4YMEGV6mm5kMJxpgm4B32MfJhYj9SKy+2az31h2u6mzNgcpPb973QEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39850400004)(136003)(366004)(6666004)(55016002)(316002)(54906003)(9686003)(8936002)(8676002)(38350700002)(2906002)(478600001)(956004)(5660300002)(52116002)(7696005)(186003)(83380400001)(7416002)(6916009)(4326008)(26005)(66476007)(16526019)(38100700002)(6506007)(66556008)(66946007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s3pQEW5PV1jGpW1PylaIre/b3KZp2HZepQRkwm5SrAhL2HnJCVksSk217O1r?=
 =?us-ascii?Q?O05Gu73Tky1pGIm53DDM4/R5q/YQeJSTS62D03gTdkDSR8FNAgAoEqnKah6W?=
 =?us-ascii?Q?gfq4rY0DCUte1UKkWK3Y5cu0W3WR2Egeox9boOw2psjmrwSJ07BJuMro68Ii?=
 =?us-ascii?Q?2IpY/7EuePH8mDFON2douoME9RBNapg1x9VIYnRdLauZXTXTMl5y6KHD5DIO?=
 =?us-ascii?Q?dKpFEwjNG4hcd3WSESzCFL3vHUBDzXCQQD7/RHXWH8m4aw96J+eJAm7/oXm1?=
 =?us-ascii?Q?s3NBsAbTLejXzCMVKcOiQlFLYVpoCUmSk45hZOeE9cSXR1F5pHX2oy+TlHL3?=
 =?us-ascii?Q?VDWSn4NwBHjzcTADN3bWsCRvJJh0dwpV7/8f9oOoIlqlnFL4t9D+cYQYdR/7?=
 =?us-ascii?Q?wBiPbPrcIrWBRgeQvdhBi2cj/ZEIUsUKgcso7QEU2nLzQnG8vG0co/nqRbDw?=
 =?us-ascii?Q?MF06HtLbb7iYH5tQHSOLsww3AAF1HCvqNrt5MIANT8503G4jh9aip7zMhhv2?=
 =?us-ascii?Q?Xk5jZaC//gitgxwRmEN5upvFkiBBfzgSJ8erINwCT2RH3vPVCd6LdP2yMONX?=
 =?us-ascii?Q?6RTapTXwbdHFJ5KF6TBgC//6y2xLo5ZzALy4R/6FfXWfuG6sYp7S6SK+GGl7?=
 =?us-ascii?Q?y9pF6/MM0X4N+iqMaNFDeN0u4YjS4ak3+L2z3yzEnsONspACntHs3WjKSqa5?=
 =?us-ascii?Q?gxzW56Ke3+IzVIcxjpCrFeiJkrpf5ckX0LdmDPBHdC/7+aYLJ0HNIb4jQ/3a?=
 =?us-ascii?Q?LuRZXxo/Ze54Xwy2cGHUGEIQISUmtb4U8CQm7S92vYEf3jEx5FaEpYAQ4Rw8?=
 =?us-ascii?Q?4y0dsHDwrxjGN4B3pTpaajio918qsINr0WYsOAuFkf3bONKdu8ImhiwHhJdJ?=
 =?us-ascii?Q?2qIgfLQakPXj7fTjrnCvfBXRzHf4V/XO4cECX9MFzjUBaqK+Eod1h3hiAQE7?=
 =?us-ascii?Q?8Z6YUHeMDfZmmAs8WQT9Apqjxl0EPFvj2LAzJFC9PRYxMzFv635BTEUcLmcq?=
 =?us-ascii?Q?m1D/rH9XtaaxZv+2+uWfbGl6Xf4QGcKXr9YjQl5DuSJDY4Bijtge9kALNa79?=
 =?us-ascii?Q?ryCoKFfyl1fnA2AVmXSGqpShzsioWqXCg8QmwkQTmmg5qaomyH2hhP3OhHRC?=
 =?us-ascii?Q?sacCH6vchlv5lplTs8h05EgVuV95C1JLP7tAqfxGtUlpTta/LKUi54ZGzOK9?=
 =?us-ascii?Q?H4q8rDdl07FwfsfxSd2d3tkoiOLjF3UoTLMV4Hh9Oql/MMotGyFodowtGJ7x?=
 =?us-ascii?Q?5DO3baNiUs9w6oatPrku7dCvHwnTt6D0AHuT7urkDPgzXQ1so4eBaQyEU6S8?=
 =?us-ascii?Q?ElcZOec1XrdZHGeYJQL6KYyN?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3914c7d-b5ae-4d04-7e04-08d91e9bb03f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 10:07:07.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc7LqYPjiEPZ/yvkGkdgVinOeYTOaXXWd0+8rEZTMmt+V9d2qK9jZ/2tb/8bqZZW/Nq+kOlUeNV7f5v+LBWiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 12:04:18 +0200 Marco Elver wrote:


> 
> 
> +Cc Mark
> 
> On Mon, 24 May 2021 at 11:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > KFENCE requires linear map to be mapped at page granularity, so that
> > it is possible to protect/unprotect single pages in the KFENCE pool.
> > Currently if KFENCE is enabled, arm64 maps all pages at page
> > granularity, it seems overkilled. In fact, we only need to map the
> > pages in KFENCE pool itself at page granularity. We acchieve this goal
> > by allocating KFENCE pool before paging_init() so we know the KFENCE
> > pool address, then we take care to map the pool at page granularity
> > during map_mem().
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  arch/arm64/kernel/setup.c |  3 +++
> >  arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 61845c0821d9..51c0d6e8b67b 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/screen_info.h>
> >  #include <linux/init.h>
> >  #include <linux/kexec.h>
> > +#include <linux/kfence.h>
> >  #include <linux/root_dev.h>
> >  #include <linux/cpu.h>
> >  #include <linux/interrupt.h>
> > @@ -345,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >
> >         arm64_memblock_init();
> >
> > +       kfence_alloc_pool();
> > +
> >         paging_init();
> >
> >         acpi_table_upgrade();
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 89b66ef43a0f..12712d31a054 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> >  #include <linux/kexec.h>
> > +#include <linux/kfence.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/mman.h>
> >  #include <linux/nodemask.h>
> > @@ -515,10 +516,16 @@ static void __init map_mem(pgd_t *pgdp)
> >          */
> >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> >
> > -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> > -           IS_ENABLED(CONFIG_KFENCE))
> > +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> > +       /*
> > +        * KFENCE requires linear map to be mapped at page granularity, so
> > +        * temporarily skip mapping for __kfence_pool in the following
> > +        * for-loop
> > +        */
> > +       memblock_mark_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> > +  
> 
> Did you build this with CONFIG_KFENCE unset? I don't think it builds.
> 

Oops, nice catch! I will fix it in v2

thanks for your review

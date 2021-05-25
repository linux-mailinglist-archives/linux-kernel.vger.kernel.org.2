Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01838F7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEYCRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:17:13 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:42209
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230026AbhEYCRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKobQDw/RpTDt0j2ENYF1M3yU2ehIMrofhwnA4Tvdb2V+uNKN6M8htPAvJmb0WyJEQctJQvwmnypS4Jw4Ybt4sGATwgsgRACML3+rY8WindNYpIyaX2vKnavK1rWBNKyj8kPTDvq93pOp7T0zb2187ww6bsfOfy283NxTcvmGZXDp8QpQ1VaJz8pKRS6ko1SmnL2KOZ8GOr74fBFBVweAPJZkS+sXo8iBjwK/wxqmBPX8YUT4ujMN63PP9lvEmXov9vid3PkQdXcgsfdn1tahRjYohmQi/sO4oLsh/xDbkp65HOna23goiKO+tMLMCx/EySUepB0AmCAJsz4/eSXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqqF+n+11qDDy72k7ENFhqnzOGZxQVziq1p3+y0CQQU=;
 b=lpBqq4/8tFdEgyG+R5jFKtBVdcZfllFirKk9eZrJby5ArrbvW67i7Ggxk4deJ25Tbh5YBxt8Y/SHd6AhCRlTRNHPpCSN23aE9GfGQ5sWD7Pjt5MSevUjkBxJWSCP9OWG0G85Gg6Yobu8KAVvPlTvjQlqcP7D0kWrpJhRJXitoH3u+GU+i74ZUsVvzwr7U/OFi1K4bxYBrdsBlJREk69sr0aIoLIj27mjfVvCpxYFR2GmEEFYpt0KXUvXKRC8mNL9vXU53zrlwJyLQdZKas0RPXysCLsLPS1nMOAIEvHxeFkVqACq4x+QR+DgEtuHY2YIEnXB45QYfTD9/gEh6R9Bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqqF+n+11qDDy72k7ENFhqnzOGZxQVziq1p3+y0CQQU=;
 b=dGIYpE6/DbnRvuomDRQRB1Nn2lPVyA2njiHftDQFvZX1xr15EnKTLiw7qD8oWVUAf0mkSl13/HhoW7ITena6CbIK9p/MDsknzPCg1RXho1TbA9uBaXZNcnyfNDNIRb30PxzDGfBHLZOjzHCnGJKKmi0f7a/PcX2G2QFItzmzrPc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN7PR03MB4452.namprd03.prod.outlook.com (2603:10b6:408:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 02:15:40 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 02:15:40 +0000
Date:   Tue, 25 May 2021 10:15:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] arm64: remove page granularity limitation from
 KFENCE
Message-ID: <20210525101530.7e7b1f6c@xhacker.debian>
In-Reply-To: <CAMj1kXGtguQ=rG4wM2=xXaDLBvN3+w7DRFeCGCeVabTGLinPuQ@mail.gmail.com>
References: <20210524172433.015b3b6b@xhacker.debian>
        <20210524172606.08dac28d@xhacker.debian>
        <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
        <CAMj1kXGtguQ=rG4wM2=xXaDLBvN3+w7DRFeCGCeVabTGLinPuQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 02:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515e258f-3da1-45fd-946a-08d91f22fe68
X-MS-TrafficTypeDiagnostic: BN7PR03MB4452:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4452C59F831D2739C53ABB78ED259@BN7PR03MB4452.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zviMw5jEdEdVoz8yZ2arhAEuLxIRvb2J6BRMeu5DMgqmd5G1NSeuVTD5+RqEC+aiPCOmSOpRWFSF0LWjDDt/av5b54PoL7sY6JSHr/xqsRXAND/qaHwOivNgJ2VjvkJBM0rvHYQlvlfg0OJFs+LAfX03PznlgW+kL7ThZVaeX1Hnxd97nHXcr0aHPQBoJ+cvcDhlahakAyHUArreMMQb/klBFFItTCoRhpguWlnGWrqv+tzwMWMv11bxXY/ipvnW6Hp0OUmykJ3q/QIDL2PwKYC8L2LAfQPUVWfw+oLIRGDGlbhe5ThlkhCA7c3uSKT881r7OkI732jOOTX/YxmtkWpBIquzv6P9ozyhTN+W4U44HWMxgSrS46TXE9Sg/+90BjO3vtZLzsO9GNVII/+LNC/quu9gkH/Cy2TzcP1b9UOciqPKuDqmYT8qIJNt4eTf1JUoCS3cNuBFX8O7/xF+fBx+OnjCxxiAF6+U/OMhm50Z2zgN3OuhuCsFX8/vOJJgTZHoudRxwY2UDI+AzzEdxD22vA61g9cC30k/fWkzHmbXPYs2P0SQoisk8npXqHUdaNCJgGFzHHsHi/GFbp+PCXk/g0Ve6iQb+ow80SkZn2ysaMYdUuRudYDM+0qraKrilFbDZ9MziMibOBeKEbcN3Z3pU4ZZVTVEKn8se2456wcKF1orDcTZ0SCr6OX9Xk792z2W2+CVTHW6ZYYRfRdavjeDHfkygkowXycLWNhuBpNLUIGCxM5MuSQ2UuClPVPcAIp4gpo9uMpwSZmwPjh94A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39850400004)(6506007)(7416002)(52116002)(83380400001)(1076003)(66556008)(478600001)(66476007)(66946007)(26005)(6666004)(9686003)(7696005)(110136005)(54906003)(2906002)(316002)(966005)(5660300002)(4326008)(8676002)(38100700002)(86362001)(956004)(16526019)(8936002)(186003)(38350700002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iS/p+j6CaoGKcTmVO1Uez8ZbQwUIGuTJTCOn3wz1x/DjcR46KjrTcWLryP3Y?=
 =?us-ascii?Q?AgUFosk2WIZO5LTxoB6hm1v3vELokznP/pxZoMy4JvkKFWGycO7FqCngQ579?=
 =?us-ascii?Q?1X4OyIHqdyxzBzCdKW9HjPy9eMLbbihE5X/9iz1reQUkc29gw/U4140+yti9?=
 =?us-ascii?Q?8uOeOTVBE7QBg1qWwdY7cobEKmpM2wuVgxFvCzAi02ODVtzVUmhlt2uXbMjT?=
 =?us-ascii?Q?X58U9l2aQk6wKQ6uOdfYq4ot7w4fMaKOxMByLoWW1Y2Uq59teVMFi/A5JhQM?=
 =?us-ascii?Q?tIQAkzduA1XOpljTQSelsU9bsAZaSybtQiEVmCQ8b+WO/tvQwsaoeWVEtYcf?=
 =?us-ascii?Q?QdDIo/9fXjBFC/3yuvnXRCiDeuO6Y3qQtsVNXKd4YTqlh+miL5Zf001TJms2?=
 =?us-ascii?Q?B1E7UAiNAhHp0BiNQO78CnRrrHXz2GJox6cuReNv1tcaYoCCTQNLg+qYgXt2?=
 =?us-ascii?Q?i67msQw5oaJgJM8wqKnzkGDyU9r3CbcgjCW3VWNtBrJnDExtcXv5+SBlNsYS?=
 =?us-ascii?Q?44JjymdQf2+0b/j01Gm0YyLbGfxtIbq0ZHcaWbmxYAGr4mjplgUgnhzm+AAn?=
 =?us-ascii?Q?28jAoEaUITe0QMW5HWxyNzz6Hu9xydD2Wsvq7Qk3SCXyKw1j9aK2Wsu452z0?=
 =?us-ascii?Q?VqR8lliE8NKhgCFbEPEFlAwNXQx+9hoShQ3SKfvIfoko+NlMieJEDBoUWFLC?=
 =?us-ascii?Q?dWu6d+e2SCVpr4nfUxwXZrhG+FkZgjo8SgkYkK8HAKsG/d+mvAEo+55cqpEP?=
 =?us-ascii?Q?uJ/Nvp+eLO3YWH4K2i5K36xr/tqglhB8B5wWWIUXlkoCCCL+RUydNklA9KW3?=
 =?us-ascii?Q?dxn9ubGrKcndwrBQ40GJuOpIy5EdcwwUMgnQ3vtNEzfiYambcU/4QEbCWvLp?=
 =?us-ascii?Q?ibfw/tLGBdpQHvDMhLoq2+k/6xkiiDarf6/D19ZXCPa4hbEm2teJRU2Gcspk?=
 =?us-ascii?Q?d5ZRWnsHD6l02pphS7lbruf4pvCYI3UQiJvbf6gCeYWIqy4dvvpSMq4UOL32?=
 =?us-ascii?Q?9OELBz06jjwpU608HmSx4fEnnwIsCnOxF2k5txJr6vqGTPAR2bPQW5iIUpeT?=
 =?us-ascii?Q?du5i9sP3ucBQyRXNVicN904nn2eeNkRv4zJv1jvtjhTVspcaF0SamSeR46M6?=
 =?us-ascii?Q?twE00SIPcL7yxd2ST5STF9inaB74Ex447GPURiJYfzJ1o18pi2VOfVXBEAVR?=
 =?us-ascii?Q?70pDER6QabSUWoLvwEpQ7g3dpY1rABfxeaUfhJ7fgu26l7ICXVWDuBTW4r6p?=
 =?us-ascii?Q?mkhdrQ5yJv5gSanY3JhQqmRzSXhM6drDC4fp053wVfeDlBArSF0VJ1lFU7c0?=
 =?us-ascii?Q?E1PZlm1tkstux9SCzdsjjky7?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e258f-3da1-45fd-946a-08d91f22fe68
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 02:15:40.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW+HA/6VA4ROoTGovVdaZ+5YWB888K2uyWI4uZti5TIZaQJU3d0b+LQ7CTYDf5sEQoNBg/lNAAUsaVJCTB/ngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4452
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 20:04:53 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:


> 
> 
> On Mon, 24 May 2021 at 19:31, Marco Elver <elver@google.com> wrote:
> >
> > +Cc Mark
> >
> > On Mon, 24 May 2021 at 11:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:  
> > >
> > > KFENCE requires linear map to be mapped at page granularity, so that
> > > it is possible to protect/unprotect single pages in the KFENCE pool.
> > > Currently if KFENCE is enabled, arm64 maps all pages at page
> > > granularity, it seems overkilled. In fact, we only need to map the
> > > pages in KFENCE pool itself at page granularity. We acchieve this goal
> > > by allocating KFENCE pool before paging_init() so we know the KFENCE
> > > pool address, then we take care to map the pool at page granularity
> > > during map_mem().
> > >
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> 
> Could you please share some performance numbers that result from this
> optimization?

I didn't have performance numbers so far, in fact I even didn't find a suitable
benchmark tool to show the gain numbers. IMHO the performance gain comes from
two aspects: the efficient use of TLB entries and the depth of page table walk
when TLB missing. IOW, the performance benchmark tool used to demonstrate the
optimization of arm64 block and cont support can be used here too. Would you
please give some clues?

> 
> (There are other reasons why we may need to map the linear region down
> to pages unconditionally in the future, so it would be good to have
> some solid numbers about the potential impact of doing so)

I suppose this feature is similar as RODATA_FULL which can be disabled if
not used. Take the RODATA_FULL for example, it can be disabled if all
modules/drivers are builtin, there's no secure side affect too.

This series tries to keep block mappings or contiguous hints as much as
possible. In fact, as for KFENCE, it's achievable.

PS: Searching the KFENCE patches history, arm64 experts said there's no
safe way to break block mapping into page mapping on arm64, I suppose this
is true during system running. I'm not sure whether "no safe way" conclusion
still applies to kernel initialization or not. Maybe for arm64 KFENCE case,
it's safe to break block mapping as x86 platform does?


Thanks in advance


> 
> 
> > > ---
> > >  arch/arm64/kernel/setup.c |  3 +++
> > >  arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
> > >  2 files changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 61845c0821d9..51c0d6e8b67b 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/screen_info.h>
> > >  #include <linux/init.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/kfence.h>
> > >  #include <linux/root_dev.h>
> > >  #include <linux/cpu.h>
> > >  #include <linux/interrupt.h>
> > > @@ -345,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> > >
> > >         arm64_memblock_init();
> > >
> > > +       kfence_alloc_pool();
> > > +
> > >         paging_init();
> > >
> > >         acpi_table_upgrade();
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index 89b66ef43a0f..12712d31a054 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/ioport.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/kfence.h>
> > >  #include <linux/libfdt.h>
> > >  #include <linux/mman.h>
> > >  #include <linux/nodemask.h>
> > > @@ -515,10 +516,16 @@ static void __init map_mem(pgd_t *pgdp)
> > >          */
> > >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> > >
> > > -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> > > -           IS_ENABLED(CONFIG_KFENCE))
> > > +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
> > >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > >
> > > +       /*
> > > +        * KFENCE requires linear map to be mapped at page granularity, so
> > > +        * temporarily skip mapping for __kfence_pool in the following
> > > +        * for-loop
> > > +        */
> > > +       memblock_mark_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> > > +  
> >
> > Did you build this with CONFIG_KFENCE unset? I don't think it builds.
> >  
> > >         /*
> > >          * Take care not to create a writable alias for the
> > >          * read-only text and rodata sections of the kernel image.
> > > @@ -553,6 +560,15 @@ static void __init map_mem(pgd_t *pgdp)
> > >         __map_memblock(pgdp, kernel_start, kernel_end,
> > >                        PAGE_KERNEL, NO_CONT_MAPPINGS);
> > >         memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> > > +
> > > +       /*
> > > +        * Map the __kfence_pool at page granularity now.
> > > +        */
> > > +       __map_memblock(pgdp, __pa(__kfence_pool),
> > > +                      __pa(__kfence_pool + KFENCE_POOL_SIZE),
> > > +                      pgprot_tagged(PAGE_KERNEL),
> > > +                      NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > > +       memblock_clear_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> > >  }
> > >
> > >  void mark_rodata_ro(void)
> > > @@ -1480,12 +1496,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> > >
> > >         VM_BUG_ON(!mhp_range_allowed(start, size, true));
> > >
> > > -       /*
> > > -        * KFENCE requires linear map to be mapped at page granularity, so that
> > > -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> > > -        */
> > > -       if (rodata_full || debug_pagealloc_enabled() ||
> > > -           IS_ENABLED(CONFIG_KFENCE))
> > > +       if (rodata_full || debug_pagealloc_enabled())
> > >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > >
> > >         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > > --
> > > 2.31.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://urldefense.proofpoint.com/v2/url?u=https-3A__groups.google.com_d_msgid_kasan-2Ddev_20210524172606.08dac28d-2540xhacker.debian&d=DwIBaQ&c=7dfBJ8cXbWjhc0BhImu8wQ&r=wlaKTGoVCDxOzHc2QUzpzGEf9oY3eidXlAe3OF1omvo&m=tRid6vgpMdeQY77uEe7j0LTyjaW0r0d36StAfCnvb0A&s=tcnSvCZSGJgJk-0AOpFpY1Aaiq27DeGLpguxNv2M9yE&e= .  
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Darm-2Dkernel&d=DwIBaQ&c=7dfBJ8cXbWjhc0BhImu8wQ&r=wlaKTGoVCDxOzHc2QUzpzGEf9oY3eidXlAe3OF1omvo&m=tRid6vgpMdeQY77uEe7j0LTyjaW0r0d36StAfCnvb0A&s=yI-AmsxRY2eoRcsCUfVwogWd3PeVgXO2-3bc6juyiXw&e=  


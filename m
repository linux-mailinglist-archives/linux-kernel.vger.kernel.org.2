Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87035BA15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhDLGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:22:32 -0400
Received: from mail-bn8nam08on2042.outbound.protection.outlook.com ([40.107.100.42]:35808
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhDLGWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:22:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiujYO0gX1jOrFRg1K1CzYiVkdo3Q7+XbZbvG1u53c7E/Mbu4CWdXDP/33XRPNJLmQSWqWeCMYB88jY1cpADrQK3XRswp2rDdLu/JTqElcpMk40mtZLFXHhVypZ7r0N7tUxDk5BXSXUd7FcKj+GKsZaM++DO67l0bZ4ITlqGK3muzzPfcVszIOpqcOJA7SYyH3Sr6/RWTgTA1HQckTZAIEie7zjEutKUgX0KKcJmxMIffis+LG/NDhl7NuQhF482r2tjRmB2x7kDjTT1ZjnQWHWyWgPKkyaWNR6mfKDJ+Jbbs5FJ52GUa0MBMmeoQCnyqVizECyxlFpfmkIE2jRKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV52orzhaGVrKDc9ehYqvL/uLA4wpO1m63w0z2/cOBE=;
 b=nK+cKhvKfXQgO6qFhKi4gmIu6edzAhI/GedExYng7J3sGUQNPHQe1l1bsVY79EHVndgHrU2dvDP/FGbbf68KteZzPYrpg2cUv6DwctWwduOXH+clp0wPJPxp5mZ7iIF8K+W6GOygUGfR/jRSJtUiL1dMhgd+D7k63t8H+dukS+PY/pTSR7jHUMmZxhfWFdGSSdKiSzhdsaAAdtDxxi33PyfohxlG1/m6N+UaOumEhoaa8/qWeih9HZffcmLEM9K2O3F8DcHPFC4wfKPMzOHicWxIHRPNAoKzI1CuSMKPP0wIL4kxP8jTQh3LeqimAAEtMyNffNNRH26aLsfq6f4Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV52orzhaGVrKDc9ehYqvL/uLA4wpO1m63w0z2/cOBE=;
 b=YSGWsixkl4yH7zb/A/waYrvauSqWbotqbZsR4zqpal97GtWAJN0WQBHCGE5sNJVuTiYLgh9GwF22gehlXm2kGah5KoXicofrF1wASotCiXD/+hfjTnvVa4ox9FZTBRDCBa8YBiwiP8HkXmXIY8YeTXT/EzJTD+3k/E+moRoa4aQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4485.namprd03.prod.outlook.com (2603:10b6:a03:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 06:22:11 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:22:11 +0000
Date:   Mon, 12 Apr 2021 14:22:03 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     liu@jiuyang.me, alex@ghiti.fr, waterman@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        geert@linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for
 RISC-V
Message-ID: <20210412142203.6d86e5c6@xhacker.debian>
In-Reply-To: <mhng-92e28f5c-ced0-4a92-949f-0fd865c0bbf5@palmerdabbelt-glaptop>
References: <20210329015510.44110-1-liu@jiuyang.me>
        <mhng-92e28f5c-ced0-4a92-949f-0fd865c0bbf5@palmerdabbelt-glaptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 06:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd0bc45-19fd-49c8-3892-08d8fd7b4e2e
X-MS-TrafficTypeDiagnostic: BYAPR03MB4485:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4485B2A456492665A0C58FE3ED709@BYAPR03MB4485.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Svg0rtE/qkz1YeJdMqdr8HnPA/ckRl6ek8h+fOAZTYGkLylg/ITSfdAAA+5DqGn35AWQ2iWg3x59M+xRUssvg7MX3bKppIx7iG5JtPE7bU4hzW/4K4xNnO2dxWTDeLUAcPRCgRwbZNGvpr/NtKFdcG2KQg26vdSqeQxcLE5zKASd8d9gWNHNekqD6KLxgAs9HWUm2NvDUNHfRDGd4wGtWW7OiEOQtAF+fl8qWKlqHRJ9sjscEgVSjSwSozxUSh5KcOOnhDB4Z3e66KuouzMIMC8JFruu5OxbHA5q55GDsnS169hOR6t6qViZX8dasPJeoqqK94lflpt7z+Iik9Wdk/9EA1jmpeEWJSvZIpvoyf9dIM4Uyyv1vk0X+9VRBUw36cg4a54OQcwwE+HOnpic37DmvHOCBA1SYow9MMxLgP7EO7mW13BaIE85+N/f7B0P3+1VSpOJPe0x7I0UiSWljU8ugY95kQu7vbuEjLAOcJkOkCEc5eIDZZeabb3sy7NA6FhuBRPuZpyrIVcfyRfGnbo5MZLL+i6qlouYFjPhY+5yGRk8bjTdkj1a0qgrnPnQg2GTI2yyhdmWmG7t0sLlTQY15r887LzY/QzrDExPKa9g4JttN5Mvrx6h/VxaPBVw3ZS0va6aHFQqRoMJL0qwXbPv5zg3XK21DkXxBEIQv+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39850400004)(16526019)(186003)(6666004)(26005)(2906002)(1076003)(316002)(4326008)(6506007)(9686003)(6916009)(55016002)(83380400001)(86362001)(7416002)(8936002)(38350700002)(956004)(38100700002)(478600001)(66476007)(66556008)(66946007)(7696005)(5660300002)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kp8CwY7Gl9TP1X1DN1cqWqE3XyBNwjAekCY4pJu5bFhch+VqHPB8RNGwVees?=
 =?us-ascii?Q?6c3NCPT4Nhw6AUaiYEteTxgSElG7sbIbowFV3lcUPFyiKQq6BWjQ/1PcVITI?=
 =?us-ascii?Q?cZQ+9WRTUKs6zGf+TClLVzFEy0hc0K82x2fqETJ44oYSOd2/9RNxfw66TCEo?=
 =?us-ascii?Q?ssK4g1r3Pc7MYFZWebERUMNR3neT5gXccTjlc8cpD2932WZO5IrRNJ65abuQ?=
 =?us-ascii?Q?rQL1VAQtYjobYbSFrWXeEUJSILETl3U8df3PTPnoqxHttZpe3A+woxFi77lX?=
 =?us-ascii?Q?q0FL2atypmYMom5Nax71PRGq9p8l0G3t+1Oqe4xSX3ZBTD2oQKLOi0U0uDpA?=
 =?us-ascii?Q?asWvRaL4BdS3RiMcVbwZaKDPSjw5FXxk3zOUjo8RFnQwzuHiVa2G6FLvHaLQ?=
 =?us-ascii?Q?nhMUtTv30PV5MhpSVy+dgxYhgmTbW7CTcOTDjerbJ+92i0nbcAvyNTqf08ed?=
 =?us-ascii?Q?k8OQzLfTE1MFjFbQ3scOVAEV6pAxCAObc588jMgEUdy1L/BH4ClOgYgTsWSC?=
 =?us-ascii?Q?nPKa4JdCay87e84IpS0WuTe/IdgnJknFRs4BKVtrH6JY1joXsQ+9EE7Ajmw7?=
 =?us-ascii?Q?XF+VcvXLG/tAzOgYkP2uHW7blVOiAUo75wSllHTi9///4/Nx5cPqtr/8/Na/?=
 =?us-ascii?Q?ymZum3kXF3EuSL3/xd6f/FikruxjpG02fsUPdNu3PfpN02752VMzGHPQpOb9?=
 =?us-ascii?Q?VQzWM3Oag/N6SMa4vSmHafLznnY8zJ8nS9+fuKUcT2W3Vn2fzgIIXtXBwKB4?=
 =?us-ascii?Q?+Fl9wHkVwoWVzZi8afTZGQ1M0CC+9Fp/Dele8p4dTjbYFskFFzEEfPI9or9C?=
 =?us-ascii?Q?t/mjwErNqQM7AuMjw1f6h4k0WB8hgVP2OSN3N8bQC57oG7bqvNo5mrj3YsIy?=
 =?us-ascii?Q?tWuQiHlin7aWDGy12TtDKSdim8vpAOZF9i9nyVj1hh4vXFnO3BVeGPnIDfPt?=
 =?us-ascii?Q?k/Ylo5B6SKiZv2PrJuKLFsAia76l2xIRS5yWYJLe67IX/VMdRsK0cgN4Wq87?=
 =?us-ascii?Q?wZmcK0eeROYzLILL8EPt7J7ymZYHLj7uO6Pj1W3DUKR5bHNb5xsiQf6HP2Nc?=
 =?us-ascii?Q?3XH4KThF6OXkKDNrJee0FRxGmDmK9ThjQoQ5LTZPwl+7vu/ik5hv3nJyRsgj?=
 =?us-ascii?Q?CpvwfzIuXFKhLD0CCt8YbxlXafeWsB3n4E6IxXkQ7pNYWiw3R5CcaVyJsx0u?=
 =?us-ascii?Q?98NEmpSC3TipVdcW/tTQV+VHe9O7rD6szEj9DEzhgBluNJLNEJPJO7g4VW+h?=
 =?us-ascii?Q?0QdqRNaeYYtmcRDSCGqEZJAooLLgIEC6aDlO1Z3FDga5/qK9U+Ew3cx5IwQ8?=
 =?us-ascii?Q?x/qDpHFTnA1poL6PGakxeiVd?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd0bc45-19fd-49c8-3892-08d8fd7b4e2e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 06:22:10.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qoS8PfFhcol+bEBsn1qKBigM0ariuH9vGMM3UT8y8bO0oI5HGotbtTNJ7LdJnpzc3xJQpbaF9A6nl40lOuTCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4485
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 14:41:07 -0700 (PDT)=20
Palmer Dabbelt <palmer@dabbelt.com> wrote:


>=20
>=20
> On Sun, 28 Mar 2021 18:55:09 PDT (-0700), liu@jiuyang.me wrote:
> > This patch implements flush_cache_vmap and flush_cache_vunmap for
> > RISC-V, since these functions might modify PTE. Without this patch,
> > SFENCE.VMA won't be added to related codes, which might introduce a bug
> > in some out-of-order micro-architecture implementations.
> >
> > Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> > ---
> >  arch/riscv/include/asm/cacheflush.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/a=
sm/cacheflush.h
> > index 23ff70350992..4adf25248c43 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -8,6 +8,14 @@
> >
> >  #include <linux/mm.h>
> >
> > +/*
> > + * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs SFE=
NCE.VMA.
> > + * - flush_cache_vmap is invoked after map_kernel_range() has installe=
d the page table entries.
> > + * - flush_cache_vunmap is invoked before unmap_kernel_range() deletes=
 the page table entries =20
>=20
> These should have line breaks.
>=20
> > + */
> > +#define flush_cache_vmap(start, end) flush_tlb_all() =20
>=20
> We shouldn't need cache flushes for permission upgrades: the ISA allows
> the old mappings to be visible until a fence, but the theory is that
> window will be sort for reasonable architectures so the overhead of
> flushing the entire TLB will overwhelm the extra faults.  There are a
> handful of places where we preemptively flush, but those are generally
> because we can't handle the faults correctly.
>=20
> If you have some benchmark that demonstrates a performance issue on real
> hardware here then I'm happy to talk about this further, but this
> assumption is all over arch/riscv so I'd prefer to keep things
> consistent for now.

IMHO the flush_cache_vmap() isn't necessary. From previous discussion, it
seems the reason to implement flush_cache_vmap() is we missed sfence.vma
in vmalloc related code path. But...
The riscv privileged spec says "In particular, if a leaf PTE is modified bu=
t
a subsuming SFENCE.VMA is not executed, either the old translation or the
new translation will be used, but the choice is unpredictable. The behavior
is otherwise well-defined"

*If old translation, we do have a page fault, but the vmalloc_fault() will
take care of it, then local_flush_tlb_page() will sfence.vma properly.

*If new translation, we don't do anything.

In both cases, we don't need to implement the flush_cache_vmap()

From another side, even we insert sfence.vma() in advance rather than
rely on the vmalloc_fault() we still can't ensure other harts use the
new translation. Take below small window case for example:

	cpu0				cpu1
map_kernel_range()
  map_kernel_range_noflush()
					access the new vmalloced space.

  flush_cache_vmap()

That's to say, we sill rely on the vmalloc_fault().


>=20
> > +#define flush_cache_vunmap(start, end) flush_tlb_all() =20
>=20

In flush_cache_vunmap() caller's code path, the translation is modified
*after* the flush_cache_vunmap(), for example:

unmap_kernel_range()
  flush_cache_vunmap()
  vunmap_page_range()
  flush_tlb_kernel_range()

IOW, when we call flush_cache_vunmap(), the translation has not changed.
Instead, I believe it's the flush_tlb_kernel_range() to flush the translati=
ons
after we changed the translation in vunmap_page_range()

Regards

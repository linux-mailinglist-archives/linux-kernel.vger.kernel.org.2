Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0904E39EF79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFHH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:26:31 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:41185
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHH03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqlqRD2fTJByTY7dol34WBo2An/PyfWzOlepXuoKuhMpKqz3Up/cPsVR88PqByoZEyzAcOsQiMQxFCAAH7Rl5iaGQTarxe1fOHjzxpIYtX5ahqEIrX0X/X/x7EsiG7T4j8WzVW3jCbPuoMdxfpsgpqx/Co5snr9ragDwI77pxS6ZPtuOfW/mNf+GYStUSozp5drpuKMZqHEYCg3r2aYKMDEusYq+aBh0trbJ4Vb632E14V7hL+Dhg9W0x8iT3FSndoIW++f877bfLQJ96ntbzEkjqOqwd9ogG95UgHPnbfmQ1HYJC88s34waOm775RZPQWMj+3RCthqRvgY53J3atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9iufL7HbpDDcJY1BA63yvDZ6PVmiejL3UYYj+309Yk=;
 b=cVPrl8IUdK3Y94lGzCnWj5Y1HFicypQ0afUyc1yrgWK3tprjmETGobaKx7gLIgSsdE2RQnPOdhsDqsl3tBiZ9UsMqwAPb23QbZKhtSP20UXtwhabTevJln4dVw2SBiGd3spdUrpVLCEKl0h0A65lYQsNYocSSl/o1OuiduaM2diKZai/UFRF2guHxsgz551JSwLbj3Zf0LdJO3OZk59FfNauAooNLW9eixt9DZlbs/38mqKNkflJGmQreG+hm/4vemvzcidZ9jqa/EPwxkvmyy2BDc+iU+pSP5pEyj0cOMbiGV9A/1aWlBTxPy+4TiXnLc/f9MkWKKsNXUqbzW/2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9iufL7HbpDDcJY1BA63yvDZ6PVmiejL3UYYj+309Yk=;
 b=ksKD1V6HXu3j8V6DPE00TYUIqm7kXc+vH9vRT+eQgpayihsukuprpC2JsovCfHb64AOgIvLMWXOswRSFmrzakVdfvd8Vhpq941f2Ddjp627h3Y+TLQyxFbBLRAcTohZKrXqjoGXNd0E9zuHS6P7NZ6cydr+wrCblIkaTHl9M3SM=
Authentication-Results: konsulko.com; dkim=none (message not signed)
 header.d=none;konsulko.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6138.namprd03.prod.outlook.com (2603:10b6:408:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 07:24:34 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%4]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 07:24:34 +0000
Date:   Tue, 8 Jun 2021 15:24:21 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
Message-ID: <20210608152406.36a973d0@xhacker.debian>
In-Reply-To: <CAM4kBBK1BJSE-LeDiEJL-z+tgZMi6Zcb+6AnnQiB8ceaU98k0w@mail.gmail.com>
References: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
        <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
        <CAM4kBBK1BJSE-LeDiEJL-z+tgZMi6Zcb+6AnnQiB8ceaU98k0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 07:24:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8bc3d18-e134-4ae9-6cae-08d92a4e76e6
X-MS-TrafficTypeDiagnostic: BN9PR03MB6138:
X-Microsoft-Antispam-PRVS: <BN9PR03MB6138DB5A47806DE1D379A112ED379@BN9PR03MB6138.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyRVrn8STPFExruiM6LgplmoF+jWq0N7p1470o9z17zgCxKRfQriDdMs1aMD8yxHrmWm5uUB20Z4hFQx4Gbk25fAqZI5/xcwoqKElZokHoRNUNph0jWQnJ2vebHgmFpsSgfox1+FPlFRUfGnS367SZ38EZAkZMN2b7Ff3jiEWF/3rThOYp0jP+FKf5+ENWL1lacvVLrbyFIiSBL1XllE0/a0ixVSw6WW4h/eHfc8c5FzIEY5GaYAwZi+BYCAd25eje7NRIgiLE3j565RWs4TDggouBDPK13PoRbMRjSbw7BfTUhOMy5SuWRNLNTWobCnYN0krLm3i3xKlcKOUwFcr6m/n72BwyqYAiNV49Sg/buhnAC/aEr3mTis7kSnJh2eMTIbT0mgNieftdaGQv9d2w0mMJTrQy9acAHSQggrKhdzby1BnYw54rWYP1nfIcpVJAthXNPqpMSU2YU1o8ABQCrD3ngpqBDlsp1BznOI+w+ZvwOgiyZAKGUguFmtcg0eEQpCkX9GwT0R5i6jxuZ4cym5Zc/OAnFwA8my0W+tQEIMYqmmsNeRtS9rTFGdAg9nidqLxcL+pfU5mlnPZ50RaSoWqPQ4MUCkw6sGDfO3V4NEVUYsajP69GO+60X7N2nfAGs79l47iUo/x1ex3KuFDpUd0YTKRALAS32gWkxvhRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39850400004)(66476007)(9686003)(66556008)(5660300002)(2906002)(1076003)(38100700002)(956004)(38350700002)(7696005)(8676002)(6506007)(55016002)(53546011)(52116002)(66946007)(8936002)(186003)(54906003)(6916009)(16526019)(86362001)(316002)(6666004)(478600001)(4326008)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJ+7NUhSZCzqu+C+urZZfGqYxIXwYU3Dq1GthzjDbaYcBkHOLJCPTobDuNqZ?=
 =?us-ascii?Q?8Zgd5CqkxG1AARy8AXnJv6ifPsq7Gqh7XxjFSORvOOZx26YUvAY+mRiTL8Vr?=
 =?us-ascii?Q?tp5E1N3FUkc+75p+UruvVhkMmhviAMLSk6x+zf1RS/EfmRfRMZXzZCojr2Ee?=
 =?us-ascii?Q?HHWwUDlZNu/8a2R0ydT1wA3zyZOC/YxRlyFJLxG2Ux2cUtTBxG5WD93BwBCW?=
 =?us-ascii?Q?QkpAqUYxp3pdEhZtr8bIHzngkmTuM0UjScSFSZOyvrW/LJacgt0Y5OWcycgK?=
 =?us-ascii?Q?xbkmUlfFuz5sLWBUbj8B13Oi5cOqpOUtwRarlhHJhEExoCFi1D9gVXD5jmq7?=
 =?us-ascii?Q?jb09JgVD3lzMJZrqnGNhq6TkdXnoCBWGf7RnopgMyKDFf23eqZcqO8uo4fTg?=
 =?us-ascii?Q?TGIxa1ET6y7WAXIVgeNNWNzukWFh1xTlhwjosM9fc0Zh1+qXzVEXX7OuDjdA?=
 =?us-ascii?Q?/Mx51QkwTFvkBWI6wgdd5i6z2OPmv8uswxmOjMAz8WN62d/cOhXc/LnAuZ21?=
 =?us-ascii?Q?9mkcTV5bh/odRuWDA6RPTHmSga8K1Vhxw+B46sDSJEuCDf5gwIZe0y0lRGSX?=
 =?us-ascii?Q?rxn4h0JKdLNtYwh9VE4RGtOgat2hwD1NgaVpy942bwCvR56Q34P2jsA1jndV?=
 =?us-ascii?Q?QJ6+bHic88qHnapH53m7X7gGn6f+pXSMsrcEoXhFddk+ZEBfp38Agi0/2Tv1?=
 =?us-ascii?Q?XcfE20yxRCLb8sty74cnGo7W5fqXSoZVqtrN5BdoHkZtFfwAxGrzh5xa2JF8?=
 =?us-ascii?Q?q6qIWaLNyhZ8yie8RUabGtl9qcznIQEZSLw+cU5MJO0orNMj0OeDmHUyd8/b?=
 =?us-ascii?Q?7OgaOfnwFa/5omaN9zdW/GsUeyugIsas9Z1oz2MR4oy2bdc0mcrbOTzHAzzF?=
 =?us-ascii?Q?Ntio5zAgqtQoWm/LQ93DE8/DshlCisoIGcJLjgV4i8pwczB4MzHdHq9cjk7V?=
 =?us-ascii?Q?Xwtm6W7XWQCMZs5HsP0pw35ib0wHApPpDXQCo7n1jaQKATkU4M8yyJd/gnvd?=
 =?us-ascii?Q?idOmROdpViOm1hDNLlhtDDWaZVJKsbiDS4cVLeb5DhyDpYlLm11kN8mIbvxM?=
 =?us-ascii?Q?H0ZusjUIIahOMmfpzdigubccFyQGPYrBIuJdvCXJEYMVfxN5Wea+zK+0a/K5?=
 =?us-ascii?Q?cwe1qK2Q9dlGi2FMc9EmTwPfx0FRey40hvUfMmJcsyYXBCAqrjxuhlAB4XpK?=
 =?us-ascii?Q?y+y4p2WuDKP+kgIuodJuSJkRUCNS2DI799pXuuHiWxPtDJnNEevml6dJbD/6?=
 =?us-ascii?Q?sdZ+q7covb5asFJcQgaj7vLKOWvCqkPpFiyJvS6tvhRtm1lCzGFY+NTyrv85?=
 =?us-ascii?Q?0dgtXWBduRPll9tKV9VNdbcT?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bc3d18-e134-4ae9-6cae-08d92a4e76e6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 07:24:34.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc9Fm6cOMqHrDlOLWXrg6X/Hh6HR8MvMns1/VOnP0+mbM70Wyqoef0Y3HvuLjcjdoyymhG92j9CR/KIrKN+jlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 21:32:38 +0200
Vitaly Wool <vitaly.wool@konsulko.com> wrote:


> 
> 
> On Sat, May 22, 2021 at 7:15 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Mon, 10 May 2021 11:19:30 PDT (-0700), vitaly.wool@konsulko.com wrote:  
> > > On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:  
> > >>
> > >> From: Jisheng Zhang <jszhang@kernel.org>
> > >>
> > >> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
> > >> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
> > >> that rely on code patching.  
> > >
> > > Since we can define extra RW sections to place some tiny code bits in
> > > RAM, I would suggest that you hold back this patch for a while.
> > > I am not going to support the idea of e. g. compiling KGDB support
> > > into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
> > > hardly the way to go.  
> >
> > Do you have any updates on this?  The SOC_SIFIVE disable thread floated
> > back to the top of my inbox and I didn't see anything there.  I'd prefer
> > to avoid chasing around Kconfig disables for a bunch of stuff that we're
> > just going to fix soon, but if this is going to be a big change then
> > it's likely for next cycle anyway so in that case I'll start picking up
> > these compile disable patches.  
> 
> Sorry, was caught up in fixing other stuff but now I'm on it so expect
> some updates soon.

Hi Vitaly,

Based on your "[PATCH] riscv: xip: support runtime trap patching", IMHO, it
solves ERRATA patching issue(And it makes use of the fact that the ERRATA
only touches traps at the moment), but can't make code patching tech such as
KPROBES, DYNAMIC_FTRACE etc. work properly, so my patch is still needed.

What do you think?

Regards

> 
> Best regards,
>    Vitaly
> 
> > Not trying to rush any thing here, just don't want to have a bunch of
> > broken configs.
> >  
> > >
> > > Best regards,
> > >    Vitaly
> > >  
> > >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > >> ---
> > >> Hi,
> > >>
> > >> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
> > >> but from the maillist it seem there's effort to make the co-exist, so
> > >> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
> > >>
> > >> Thanks
> > >>
> > >>  arch/riscv/Kconfig | 18 +++++++++---------
> > >>  1 file changed, 9 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >> index a8ad8eb76120..61320b94ef97 100644
> > >> --- a/arch/riscv/Kconfig
> > >> +++ b/arch/riscv/Kconfig
> > >> @@ -60,11 +60,11 @@ config RISCV
> > >>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> > >>         select HANDLE_DOMAIN_IRQ
> > >>         select HAVE_ARCH_AUDITSYSCALL
> > >> -       select HAVE_ARCH_JUMP_LABEL
> > >> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > >> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> > >> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> > >>         select HAVE_ARCH_KASAN if MMU && 64BIT
> > >>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> > >> -       select HAVE_ARCH_KGDB
> > >> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
> > >>         select HAVE_ARCH_KGDB_QXFER_PKT
> > >>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> > >>         select HAVE_ARCH_SECCOMP_FILTER
> > >> @@ -79,9 +79,9 @@ config RISCV
> > >>         select HAVE_GCC_PLUGINS
> > >>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> > >>         select HAVE_IRQ_TIME_ACCOUNTING
> > >> -       select HAVE_KPROBES
> > >> -       select HAVE_KPROBES_ON_FTRACE
> > >> -       select HAVE_KRETPROBES
> > >> +       select HAVE_KPROBES if !XIP_KERNEL
> > >> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > >> +       select HAVE_KRETPROBES if !XIP_KERNEL
> > >>         select HAVE_PCI
> > >>         select HAVE_PERF_EVENTS
> > >>         select HAVE_PERF_REGS
> > >> @@ -230,11 +230,11 @@ config ARCH_RV64I
> > >>         bool "RV64I"
> > >>         select 64BIT
> > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> > >> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> > >> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > >> -       select HAVE_FTRACE_MCOUNT_RECORD
> > >> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > >> -       select HAVE_FUNCTION_TRACER
> > >> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > >>         select SWIOTLB if MMU
> > >>
> > >>  endchoice
> > >> --
> > >> 2.31.0
> > >>
> > >>
> > >>
> > >> _______________________________________________

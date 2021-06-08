Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870439F080
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHIRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:17:02 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:14944
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHIRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+m7lyd7YW7zELImAh64oV8Kz4y/a/RUI/YeM0BWuRItFhyLu3pWGCoYfhgD9UGfnXXj946M9m90P2OX7+yrvGrah8bIOUD3kGlqVtUhjsGGvYUxMqn8PwG2SzSgBC2+5VxbkM6g3ZpEcWuE6y+q3d6sGPq/wfWAbzii5SvDhnECzMdw87iifTKN2ponnIp2vZssID7LG50w3oen6sZMZcGrX9L6lu22w0EIc6dfmHWM/5suwfJTQ6Qmhaam99h2Qw8WF6dyIIXk8dsQ09QgEqMrkSs/kVDpR+LcV0RV9qwBhjR0rEgp/5ESMd6vAqSnF8/LUnfuaNBu3MwN1/cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UGsogIMJlr+I0vAsoiEWPdQtycebwNWfls9V3dG+XE=;
 b=ZpJCA1nZJYiQdIoKWqItpn81S9+8pvRE6+CBq+Nby+nCNZxtRqNx5Rct7TEMkQF6jvXGnihozjmJmNDzOhDXMGR5kPfLbP4rDn97VbxhF5PZRddPYRcwceXSURsm876+Gml1lY4XwaxRIl1qYwr71tPMEkNm1JN2s+IFdsx7W7scktc7HNts780oxPxNlKwmBc/uC/rgFQD6lZncu3OGmaNhzj6inXBKTC+hzCGexkLkbFSYeVS07g+KdAYwmp6Nl6lmZgDIB+WpCAcBzptx+iVFOPBwH8WxLjxw+OI40lJylNZAC+hPTu3n9ZTzmRmQUx/mG2gTPYHoUrhWHwdbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UGsogIMJlr+I0vAsoiEWPdQtycebwNWfls9V3dG+XE=;
 b=V6Xt7bIhzSEYU/EX7UcnduxIN00sbPktlSwUJ/JGGIiIQ8Jv3TLleMrG5DnHFbxq5UAogurDOsM72FL2G4FHipfhY0htGuXPd2ti0tEHAZTmv6/wn3hpNfORPUEOAixmWfO58M8qDnMEVBjGNLKQNBIr+j16wj/5lnYKyKo8XBI=
Authentication-Results: konsulko.com; dkim=none (message not signed)
 header.d=none;konsulko.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2290.namprd03.prod.outlook.com (2a01:111:e400:c5f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 08:15:06 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%4]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 08:15:06 +0000
Date:   Tue, 8 Jun 2021 16:14:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
Message-ID: <20210608161457.192b3ca3@xhacker.debian>
In-Reply-To: <CAM4kBBL9pobU73oX8WJbEph90GWJPy1nHmUHfwByJry9+GsyJw@mail.gmail.com>
References: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
        <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
        <CAM4kBBK1BJSE-LeDiEJL-z+tgZMi6Zcb+6AnnQiB8ceaU98k0w@mail.gmail.com>
        <20210608152406.36a973d0@xhacker.debian>
        <CAM4kBBL9pobU73oX8WJbEph90GWJPy1nHmUHfwByJry9+GsyJw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Tue, 8 Jun 2021 08:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7c763a-e851-4d96-1485-08d92a55865c
X-MS-TrafficTypeDiagnostic: BN3PR03MB2290:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22906D48A0BF9095C0ABAE10ED379@BN3PR03MB2290.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0Y+x5SMsIKqQvOVtnJvntxweQscYnTpM1QenfgXvW/s53J3+02bLe6nNlZjA4hXymc50i8YGBGDEKOc16QWG7BKhDsyK3q/x6vPI1qL1SJN5CQYYMhwSLK8DZABdSS86hq6a4oL+zlghMrtd+0YXkTDhT/51UfFq26CW3TZF7o1uoMKrp00j9TNuv/9Zi4dvrHGC9HsvHlVlWYWUl4r7F1tUYNDJF5aHiyITppAn6KWVd1F1BgY1UfbgCojTXRYGYwAErClY22SIAzN5/7hIF7QBlgndMSNcZpVOJYxPdGlkHtpUWU7ElBiKjAPzQscPxfqjxqTv+QnYjmRjVaWjRJdht/4VzqDBfOEEFnVm4mglhZzxzPiJKYyxl6wiI1AQCmf5tp4jLsU7P4qDxjMN71/q+lbF6Co9zIPcUWcRW03iJ0kz5N2HJXiU6gAJDu6QaIzI4gVp/QQwrWCi6dC8RGVEjc8G5HIGLfIJXM1XalsJZKyUovHJGA9GXAbp2cjUImKJqAtffUp9oTEq9KuXQ7pjz3AX/fVKTAWhmEEAvAsZhNKcSe2CleWJXnY8nQaWrgaKk8wn1ryvx6GRuy7YcUg6qc2NqnZyjVojyN1lgJw9IdQ9eqj/imGgfN67jwi/kcSX0Lrr1/bNzps2LFuZNUiIElzoCPopwKt1H0u91U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39850400004)(376002)(136003)(26005)(6666004)(4326008)(956004)(8936002)(8676002)(55016002)(83380400001)(9686003)(66946007)(66476007)(66556008)(186003)(86362001)(2906002)(1076003)(5660300002)(7696005)(52116002)(6916009)(478600001)(316002)(6506007)(53546011)(54906003)(38350700002)(38100700002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?toCmAQMXrtH09P1yMr1DTW99oa0kMx7SoFgemLPxzgMLxtyIMHWZhttCLCQE?=
 =?us-ascii?Q?Z2ygMCJfTwYLb2HfZ6x93iWruoDk94osNPRYh4XVpxY7SgG22++qEWlOsn0B?=
 =?us-ascii?Q?nw3Ey7N9djHVb3R49XCbxbRHEZ5WhaYfIBkix87AVHXZcBx+122cwdTfJQh7?=
 =?us-ascii?Q?zLiRFlfP6dIgWK01yVTJZzQNn3xjmOtIadtcol6vGPVdcz5ATjlhXIvm5GIg?=
 =?us-ascii?Q?KDQrRljtDhM/R+b9DELbNLQp0ZMXTaI+GlUByiA4URSpEL+LepOZ9wsFX7CR?=
 =?us-ascii?Q?MTD3nl1WveN9+uybXmWmj+s670Ofg0GuAP0NKCLzAELiJ1WPw1JnHChIQNdR?=
 =?us-ascii?Q?L6rng3ypyJvl6GXqOf9f/7j206Zv51PxYOwFX6G0bWQsTmLLvq2t3EhxP+LW?=
 =?us-ascii?Q?T4HTL4GTGNY1WGwRtHCsSpq3yCYgwrZZ0bSwRP0L9GXESsbZU8p5dk2nBe39?=
 =?us-ascii?Q?rb3EV7kxZxmaI9h5T5Xh49BUvpxPsyKAC/5ISu0+FV/HCYmgw3P6LXRHrbg8?=
 =?us-ascii?Q?1+T3kAkq43PJsSYJopX6xmsoaiJ3hIJ8kY1baN/F5qXNmwft+kuBmvyDEoo1?=
 =?us-ascii?Q?nhUjLa/NYWyZahG3haZylDrTkTOBJpb02+J8nvSV3GaYU+hohVIJgmFni+zr?=
 =?us-ascii?Q?+jNv+6UTr5HOwAZ2RcB98Qfqizpgi4o27BNTa+Agjt6cdkPMUqZ525jB+23D?=
 =?us-ascii?Q?FgWsiUiZpvkuVGPLYGq6vL8S9TcqLxeHfxymhmtcU6k0Jjt1KLCR9SNbV+4T?=
 =?us-ascii?Q?Y2A+ccSKrWoucNV1FIR3OULMhpZHiwWCxTFlCC58DNcY23gKdWX9efcKNL66?=
 =?us-ascii?Q?Hh76YbsFZ1PyjQI7tdbQujQbZs12uNq/k668ytWw2V3DzZ16670cScuBkZG/?=
 =?us-ascii?Q?Hn2L/TUt1KGkAltY0yrz6PbIxgWPOWVLtb9yBTWIgWnGKuMZ2rhxv2EfE3q4?=
 =?us-ascii?Q?fPp8nBmhmtbZ9/yXQ26MW5/cfYmWgpg5mfA9JFZ26Q/Zjc+0JAW7a4yz8mOI?=
 =?us-ascii?Q?tg6Z6pOTeGvmE24fK+Y72GhCqwthC7B9IZ/PlygGuQVqGFhP48IFQjRNoINo?=
 =?us-ascii?Q?VAV6cTJuR1+B1NMayFSjIgiuhdLdNTjTOoqAxYKJQqclrNvOKibDaZdQ8QXX?=
 =?us-ascii?Q?/IaPav6PQyPb2mRwcOQucRSyCDNO4IhpHrrYABq4sIz5AJYGAHOZdmaKFJ6A?=
 =?us-ascii?Q?zly/PZV31Rq3q6/YP1uWo92PC0YF0Eytzv7TZuj8csNqTAjiZRKaJRASarOM?=
 =?us-ascii?Q?jof7lgkHmOmmuYf1UOAd1JtUeqF6TCloSqsYtwdO32mqFktPKdD1JpnKsU6R?=
 =?us-ascii?Q?6jM0maR3a0y4BpPA1mz0E64s?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7c763a-e851-4d96-1485-08d92a55865c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 08:15:06.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+mlzxNzGd8xb+oAR2hwqBauS70rMbdI51NAGnY3G5sjNQuHziTiUq1L2THXTWf5/EjhiA7bvaS8Qqul1mRVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 09:50:00 +0200
Vitaly Wool <vitaly.wool@konsulko.com> wrote:


> 
> 
> Hi Jisheng,
> 
> On Tue, Jun 8, 2021 at 9:24 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > On Mon, 24 May 2021 21:32:38 +0200
> > Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> >  
> > >
> > >
> > > On Sat, May 22, 2021 at 7:15 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:  
> > > >
> > > > On Mon, 10 May 2021 11:19:30 PDT (-0700), vitaly.wool@konsulko.com wrote:  
> > > > > On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:  
> > > > >>
> > > > >> From: Jisheng Zhang <jszhang@kernel.org>
> > > > >>
> > > > >> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
> > > > >> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
> > > > >> that rely on code patching.  
> > > > >
> > > > > Since we can define extra RW sections to place some tiny code bits in
> > > > > RAM, I would suggest that you hold back this patch for a while.
> > > > > I am not going to support the idea of e. g. compiling KGDB support
> > > > > into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
> > > > > hardly the way to go.  
> > > >
> > > > Do you have any updates on this?  The SOC_SIFIVE disable thread floated
> > > > back to the top of my inbox and I didn't see anything there.  I'd prefer
> > > > to avoid chasing around Kconfig disables for a bunch of stuff that we're
> > > > just going to fix soon, but if this is going to be a big change then
> > > > it's likely for next cycle anyway so in that case I'll start picking up
> > > > these compile disable patches.  
> > >
> > > Sorry, was caught up in fixing other stuff but now I'm on it so expect
> > > some updates soon.  
> >
> > Hi Vitaly,
> >
> > Based on your "[PATCH] riscv: xip: support runtime trap patching", IMHO, it
> > solves ERRATA patching issue(And it makes use of the fact that the ERRATA
> > only touches traps at the moment), but can't make code patching tech such as
> > KPROBES, DYNAMIC_FTRACE etc. work properly, so my patch is still needed.  
> 
> At this point it is needed, yes.
> 
> The thing is, I thought I'd go with one problem at a time, so I posted
> the patch which solves build issues for SOC_SIFIVE and XIP, and
> runtime patching for ERRATA (and I hope it gets accepted and makes its
> way into -stable, too).
> I gathered that addressing your issue had lower priority and so it's

It's at lower priority, in fact I didn't have XIP riscv platform ;)

> still underway. All in all, I don't mind going on with your patch,
> when the initial issue is addressed, we may want to revert some part
> of it but I guess that would be ok with you, wouldn't it?

We could revert some part of it later although I suspect the incompatibility
between code patching tech and XIP could be addressed, take the KPROBES
for example, it needs an ability to patch almost *every* can_be_kprobed insn
this isn't achievable/necessary in XIP case.

Thanks

> 
> Best regards,
>    Vitaly
> 
> > What do you think?
> >
> > Regards
> >  
> > >
> > > Best regards,
> > >    Vitaly
> > >  
> > > > Not trying to rush any thing here, just don't want to have a bunch of
> > > > broken configs.
> > > >  
> > > > >
> > > > > Best regards,
> > > > >    Vitaly
> > > > >  
> > > > >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > >> ---
> > > > >> Hi,
> > > > >>
> > > > >> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
> > > > >> but from the maillist it seem there's effort to make the co-exist, so
> > > > >> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
> > > > >>
> > > > >> Thanks
> > > > >>
> > > > >>  arch/riscv/Kconfig | 18 +++++++++---------
> > > > >>  1 file changed, 9 insertions(+), 9 deletions(-)
> > > > >>
> > > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > >> index a8ad8eb76120..61320b94ef97 100644
> > > > >> --- a/arch/riscv/Kconfig
> > > > >> +++ b/arch/riscv/Kconfig
> > > > >> @@ -60,11 +60,11 @@ config RISCV
> > > > >>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> > > > >>         select HANDLE_DOMAIN_IRQ
> > > > >>         select HAVE_ARCH_AUDITSYSCALL
> > > > >> -       select HAVE_ARCH_JUMP_LABEL
> > > > >> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > > > >> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> > > > >> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> > > > >>         select HAVE_ARCH_KASAN if MMU && 64BIT
> > > > >>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> > > > >> -       select HAVE_ARCH_KGDB
> > > > >> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
> > > > >>         select HAVE_ARCH_KGDB_QXFER_PKT
> > > > >>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> > > > >>         select HAVE_ARCH_SECCOMP_FILTER
> > > > >> @@ -79,9 +79,9 @@ config RISCV
> > > > >>         select HAVE_GCC_PLUGINS
> > > > >>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> > > > >>         select HAVE_IRQ_TIME_ACCOUNTING
> > > > >> -       select HAVE_KPROBES
> > > > >> -       select HAVE_KPROBES_ON_FTRACE
> > > > >> -       select HAVE_KRETPROBES
> > > > >> +       select HAVE_KPROBES if !XIP_KERNEL
> > > > >> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > > > >> +       select HAVE_KRETPROBES if !XIP_KERNEL
> > > > >>         select HAVE_PCI
> > > > >>         select HAVE_PERF_EVENTS
> > > > >>         select HAVE_PERF_REGS
> > > > >> @@ -230,11 +230,11 @@ config ARCH_RV64I
> > > > >>         bool "RV64I"
> > > > >>         select 64BIT
> > > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> > > > >> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> > > > >> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> > > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > > > >> -       select HAVE_FTRACE_MCOUNT_RECORD
> > > > >> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > > >> -       select HAVE_FUNCTION_TRACER
> > > > >> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > > > >>         select SWIOTLB if MMU
> > > > >>
> > > > >>  endchoice
> > > > >> --
> > > > >> 2.31.0
> > > > >>
> > > > >>
> > > > >>
> > > > >> _______________________________________________  


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0A38A292
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhETJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:43:18 -0400
Received: from mail-mw2nam08on2057.outbound.protection.outlook.com ([40.107.101.57]:1746
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233221AbhETJke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:40:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVoOelredfCzd7E5cp8n/eWUglQ147kCcBxiOlSYcjkgkMfw6efiqcek70NiGpGS8JMx2kEyi6TsYp7DUd2+qno55ovEZ7v8K7FVHBCCCc3Dg5ZD+xciOhtDSekOFlDVJGWJrbzkXrIslv4brtY1bPocye4Dtf2Tw7PH3GoXm2fGfA9NvcRXQy6fOvqg0mNu2y96sB8wOGFKsdgw8pvtvLNzI1Y6i7kjChaRGKDCnZfMYTPJs74U0pmwXre6tW3qnQ++dpUJ4gBPYdcrVH4lNyBJUG31Q2yZWynoQG9dCpww3Ow4Ol0Lhu6x9xt6zCZi9xwKfFOq19yQEM8XiNIOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mmaVy1i0fqEIqp/AxWr/JCdoWVx8SbuB1FXHfbVNyc=;
 b=dDonV5uoDrgls4G7yLGwBh3vueaLZgKIexE2Sr8HAuLTqG8cTLKHxPK239numyiAKk75YYqBu/8N175OS1ilGhtlzJSRtjA6hHLUXSin5pFdTrxtvXCbvfb1sGMlAi2/dzrooLOHRsV9AI00Y5SlFgOeHKJC2s7ehBKsNvxsHEM87eUCS47wQiY2/t9I/1v0hKQtKCiPcviDPi+izwJlo3yFDM6YeBgbx248oJlct46e5ZuWqO51FxPmDUZ8MVThUIYyLXnLP/o1fpvhyyHEGhOMYiH89EOYAx9VX96/hz5W0sUoIjIk9Nh60tE3qqEYtwp3/st/pJoiPmdraXPkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mmaVy1i0fqEIqp/AxWr/JCdoWVx8SbuB1FXHfbVNyc=;
 b=NTq0FYcYz33Wm/sflWII85+ZRzFZec8Ve2hjUjWg6Bz4aETKV5XcQ9oBf2m78vKGRY5cCt3d68cg+5ahuqFRhI2UWh//a001geAF6ELQRWLWuW0aiOyVAhlfer6uPTTJJkXQUu8i+xrtfzSBg2Un2UJ3nb/qVIR8+fSF++CfNFY=
Authentication-Results: beagleboard.org; dkim=none (message not signed)
 header.d=none;beagleboard.org; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB3009.namprd03.prod.outlook.com (2603:10b6:404:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 09:39:10 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 09:39:10 +0000
Date:   Thu, 20 May 2021 17:38:59 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Drew Fustini <drew@beagleboard.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wei Fu <tekkamanninja@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>
Subject: Re: [PATCH] riscv: mm: Fix W+X mappings at boot
Message-ID: <20210520173859.7441aed8@xhacker.debian>
In-Reply-To: <20210520045540.GA3236664@x1>
References: <20210516170038.7de9c866@xhacker>
        <20210520045540.GA3236664@x1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Thu, 20 May 2021 09:39:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa76237e-b3c5-4363-09cd-08d91b731f13
X-MS-TrafficTypeDiagnostic: BN6PR03MB3009:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3009479C9477445E6401582BED2A9@BN6PR03MB3009.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ga80qDLIyL+U5/W/eh9NvnD5vkjnVY8QwalT9jukA7cNTw/wcq12+kRZMg7Of9OE9DvXoLd2iD2RloogeXZCc+x+u/AXZfoWR0GMpwywm+ElmvymGBxB1Jz4zIcuhL49y8TXOfmzQAJZpvMyn/fBN7gCtDTEwH3z4vDeHJcyzz4UqmeaWRZitsQFrsLAACWowrCiB7zmatrOGAX26Xp4NfwO/fRPt2JHH972fs4VCdetri2lo8ZwsZLg5iBY6K058ugcTpUnA1fV/BOtful76H9+CnrZ3z3oHBugsPbueBPtK6nXDLv7H1hG2a6nZBZCUEPdZZmpTOX196E0MEzRuzL7Wwr2qG1J0ntJLEzb4KkJQ/rDXHNgs/DYhBPH6V8KlCTxtp0hA3SU5IVWeOpFhosoKNu0e3a8ptK0ettR+56WycUNX3qYi7f3O9h6sX4qbxDrRs719Of/n11qER8FRIK4a6Dfggt8+xzbYOd/yB/iwwZppzTQ7mr7BL8hdLqXNPJFAptSKHC1xtRlmsYsWyf5ZuyIJSQYcBAOZD4BVErmQicVJMYaMq/LP5NfcDgCvV9lM65FhGet8ItMuNCNscu+8ZTRBy9fejNybWBHtng9cxXraXC6gI98OpCym54LdL0iUfyelGsqhfjP1rlANT9S3LAD1XDjO6Q+7hv/nbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(346002)(366004)(38100700002)(38350700002)(45080400002)(66556008)(316002)(956004)(54906003)(7696005)(5660300002)(478600001)(66476007)(1076003)(66946007)(110136005)(52116002)(7416002)(6506007)(86362001)(55016002)(9686003)(186003)(16526019)(4326008)(26005)(2906002)(6666004)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/kwwTiTdjNRQrg5/Okm9iWSGRXUzl+uxQWOZ59aGZI8JzWULB5xFWM/2yr7R?=
 =?us-ascii?Q?IqUZdVArc4YmeP2JbDL3E+H3oGSLGZsJ7qvp3gNiBUuGcrpzCct77S7vJRz4?=
 =?us-ascii?Q?tlPQ+OPM9FkI3LxaaObQcQHYIg4QXzMfFdS3MzatXzxe4Hl8tQ4rOigqrid6?=
 =?us-ascii?Q?yACv4B7MctU70j3LeRiBUwjIKGypGmShvmKlrG9AM5hhJwN60mhV5Mfuk5Q+?=
 =?us-ascii?Q?bYHmSShNC4ZoePPTo7ACRvfr6UF7n/xJ+lu0rZOkNgaPUMAfuWTJ6ZegK51G?=
 =?us-ascii?Q?RHU6A9Kk6Yd2v9xVd+LQ8880Y4hHYW2DA8rMebHRf8qUAPOFJFpPBheL4esR?=
 =?us-ascii?Q?G4yp/d5YP8zdsXhAirEzvKxz5Ka5t7efXdVZhji7zQGyNulhWaw89h8xVi47?=
 =?us-ascii?Q?Q1e+jNqwrGrZgfkb3Q3hZ88jtxLG0taZdYEuGR+nKXNukvGTO35+4o9qOr7b?=
 =?us-ascii?Q?ZMETy0WH3DIwJ91wCZHLURYSe3xx9iYHoFjPashdmjKXFOj8Z29SRokEZdNi?=
 =?us-ascii?Q?hn+7hxptH/A4YuSs8KqO1alHQ2WGf82A1flow81Jq37JalKK17IhkzLjGi6L?=
 =?us-ascii?Q?q6FpbKP7bHqNR0y4ySu9tMKxT7PKrPjy3HU+n+QOmbqblqQIKaP2LVxjtI0r?=
 =?us-ascii?Q?t0YzFFgT/b3isyZpY+1xdgxr9VDbKcp72ECiKmAEEVQblT5zHRHJpuXiOIs0?=
 =?us-ascii?Q?txlFxKkroiEL5rE1ubATBefXbq/r1tNHZyYm6GmqPRoeYEzjRcxhqPmZ4Ynd?=
 =?us-ascii?Q?pAAW03/8Klb/0oKHfyZcmlXF30Mb3VxUJTUHm/pEQYGIBGOWJkEYtUGSTjxY?=
 =?us-ascii?Q?osHvxCKFRk2cRPAlkh3YmGl6iJxz4skR4PuJxpqXjxxLq+W0Q0n628Kx4IC4?=
 =?us-ascii?Q?WrADEOasYxX5TYGSH1tRjqT5AE7fAY3VrQznCOqqvqK/2PIE/Mnfgv0r4WLE?=
 =?us-ascii?Q?G0ex8gRHfQG9+k276MXgq4PkovYfbSrN12G8M5mmUBVVA9xZrIXE3Ntv2Waq?=
 =?us-ascii?Q?spqBwUXsyeEIeLBjqtXWByf7vGrgPJmTtoHD8VWuuW7jW7YMGPqvHSFXFEdb?=
 =?us-ascii?Q?vvxjJDL8QToBPQ93f+1QrBFCkyg/WOaAbCoAgHC4eWY7LQEheKEAtA+U7OhW?=
 =?us-ascii?Q?S3uTKvSwTcdE6xUiNDfr1IBim6LeYdvorHs4RtQMzcZPqp6ZEh2NT8xrDv+L?=
 =?us-ascii?Q?5x3/cOc54vKVnDz6hMSW1RMzOu94m39/zocMkReMqO8rtKpN2lwYaQ80Ed56?=
 =?us-ascii?Q?mvQBVqyst3pdFFdgklt88Xk7HBQwXkd9XlbaTmZ5ewtRt3OP3V1NGjcJMCzj?=
 =?us-ascii?Q?ZbiwgIX3vOsDQ/myGqv7RbHp?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76237e-b3c5-4363-09cd-08d91b731f13
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 09:39:10.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPYWKnoHXOgm9AabtKKwYcT77XoQWO0WMflYhZI4//hYh9GcO2IvHpOxy3gRHowtXNu2WXMCYQehN/sZ95gFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 21:55:40 -0700
Drew Fustini <drew@beagleboard.org> wrote:

> 
> 
> On Sun, May 16, 2021 at 05:00:38PM +0800, Jisheng Zhang wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > When the kernel mapping was moved the last 2GB of the address space,
> > (__va(PFN_PHYS(max_low_pfn))) is much smaller than the .data section
> > start address, the last set_memory_nx() in protect_kernel_text_data()
> > will fail, thus the .data section is still mapped as W+X. This results
> > in below W+X mapping waring at boot. Fix it by passing the correct
> > .data section page num to the set_memory_nx().
> >
> > [    0.396516] ------------[ cut here ]------------
> > [    0.396889] riscv/mm: Found insecure W+X mapping at address (____ptrval____)/0xffffffff80c00000
> > [    0.398347] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:258 note_page+0x244/0x24a
> > [    0.398964] Modules linked in:
> > [    0.399459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1+ #14
> > [    0.400003] Hardware name: riscv-virtio,qemu (DT)
> > [    0.400591] epc : note_page+0x244/0x24a
> > [    0.401368]  ra : note_page+0x244/0x24a
> > [    0.401772] epc : ffffffff80007c86 ra : ffffffff80007c86 sp : ffffffe000e7bc30
> > [    0.402304]  gp : ffffffff80caae88 tp : ffffffe000e70000 t0 : ffffffff80cb80cf
> > [    0.402800]  t1 : ffffffff80cb80c0 t2 : 0000000000000000 s0 : ffffffe000e7bc80
> > [    0.403310]  s1 : ffffffe000e7bde8 a0 : 0000000000000053 a1 : ffffffff80c83ff0
> > [    0.403805]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 6c7e7a5137233100
> > [    0.404298]  a5 : 6c7e7a5137233100 a6 : 0000000000000030 a7 : ffffffffffffffff
> > [    0.404849]  s2 : ffffffff80e00000 s3 : 0000000040000000 s4 : 0000000000000000
> > [    0.405393]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffffe000e7bd48
> > [    0.405935]  s8 : ffffffff81000000 s9 : ffffffffc0000000 s10: ffffffe000e7bd48
> > [    0.406476]  s11: 0000000000001000 t3 : 0000000000000072 t4 : ffffffffffffffff
> > [    0.407016]  t5 : 0000000000000002 t6 : ffffffe000e7b978
> > [    0.407435] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> > [    0.408052] Call Trace:
> > [    0.408343] [<ffffffff80007c86>] note_page+0x244/0x24a
> > [    0.408855] [<ffffffff8010c5a6>] ptdump_hole+0x14/0x1e
> > [    0.409263] [<ffffffff800f65c6>] walk_pgd_range+0x2a0/0x376
> > [    0.409690] [<ffffffff800f6828>] walk_page_range_novma+0x4e/0x6e
> > [    0.410146] [<ffffffff8010c5f8>] ptdump_walk_pgd+0x48/0x78
> > [    0.410570] [<ffffffff80007d66>] ptdump_check_wx+0xb4/0xf8
> > [    0.410990] [<ffffffff80006738>] mark_rodata_ro+0x26/0x2e
> > [    0.411407] [<ffffffff8031961e>] kernel_init+0x44/0x108
> > [    0.411814] [<ffffffff80002312>] ret_from_exception+0x0/0xc
> > [    0.412309] ---[ end trace 7ec3459f2547ea83 ]---
> > [    0.413141] Checked W+X mappings: failed, 512 W+X pages found
> >
> > Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/mm/init.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 4faf8bd157ea..4c4c92ce0bb8 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -746,14 +746,18 @@ void __init protect_kernel_text_data(void)
> >       unsigned long init_data_start = (unsigned long)__init_data_begin;
> >       unsigned long rodata_start = (unsigned long)__start_rodata;
> >       unsigned long data_start = (unsigned long)_data;
> > -     unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> > +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> > +     unsigned long end_va = kernel_virt_addr + load_sz;
> > +#else
> > +     unsigned long end_va = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> > +#endif
> >
> >       set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
> >       set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
> >       set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
> >       /* rodata section is marked readonly in mark_rodata_ro */
> >       set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> > -     set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> > +     set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
> >  }
> >
> >  void mark_rodata_ro(void)
> > --
> > 2.31.0
> >



> I know there is a new thread now with a different approach but I wanted
> to say that this did fix that warning on the BeagleV Starlight beta
> prototype board [1] with the StarFive JH7100 SoC [2]. I am using Emil's
> starlight branch [3] which is a set of StarFive patches on top of
> 5.13-rc2. Emil included this W+X mapping patch [4]. It does fix the
> warning on boot for me and the bootlog [5] shows:
> 
>   [    2.302598] Checked W+X mappings: passed, no W+X pages found
> 
> Thus if useful, here is my TB:
> 
> Tested-by: Drew Fustini <drew@beagleboard.org>
> 

Thank you. Alex's solution is better. It ensures there's no W+X mapping
from the beginning. So far, riscv's STRICT_KERNEL_RWX method is to create
W+X mapping from the beginning but remove W or X attribute at the end of kernel
booting. Alex's solution changes STRICT_KERNEL_RWX method, one effective side
of it is fixing this W+X mapping. I'm not sure whether Alex's patch should
be merged in this cycle or next window since rc1 is released. 

Two choice to fix:
Merge this small fix for linux-5.13 and bring Alex's patch for linux-next

Or

Use Alex's patch directly.


I would leave the decision to riscv maintainers.

Thanks

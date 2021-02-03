Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38830E35B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBCTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBCTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:36:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:35:57 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z32so587691qtd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lygUOItVONTyhsU88Z4pU+ueswAcSicxheoODoB+RTQ=;
        b=N3RNBnr13xQkoA/YwJzfafCwzd4tgZM6w2S+/aHtmkHyx8YmOeKNJxZ8KMSSTdARNY
         w2j+0cuO7oHxsgSsgiIEIp6i0C7Z24ZEQ61GsxKhDvClIZ6kIOYed3JtLLQATbdUVm+0
         RDBaDio/W7a3AYdbkMn3NnRClrVBQCp0pygHkcLt1DGw8fiDe7iYM3yQikJxH1yjTEGZ
         MXdgW4rPx72oE5SL2qAoVj5NEqo4LkoD9LsrbNN3btIz+2JJXZVC+QkOHCAK2gR4rkxp
         0GGlNkDluJF23Blx5FNmarGJl8fcXUgNKmEg38ZtF6A971HEusMlv73dCZMHC3Jv9dOn
         uhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lygUOItVONTyhsU88Z4pU+ueswAcSicxheoODoB+RTQ=;
        b=nbKNrewcqOsBK3Dbq3+9jIAHvk5mZp4XVZKtTmN6S7ija6hbxlxW3kkJrrfAFoGi4s
         8I4DHW3fYWD/0zU3KmXpL9rsh6SkU3bqr7dkZVg1eU/dmi9O9jNvydO2DbVO3pJV2pnJ
         hFYx0xSQRM8g+elCpas235jN7MPWYDqLjjxKcu1/3giIUIYuqYsvdwfniHJN4k1gdLBv
         dFGMHFZHCvg9XD5iVdtUrB4RNpu8BWhpHpthmvjpsmDA4jrrAXU0/0Vc6cTo6ooCoPVQ
         GTWfQ/NlELzbPGogCYEFeNeCW3GCC26dULkfKS1fE6hwwdGN9aZpMBxJoavIYGJ4Kjv7
         7laA==
X-Gm-Message-State: AOAM530yWzP6AUdUUSEs7wXfHLv+mskm+IlfdFzPrPdj28mtE4fY61Ao
        pOYEIz5Fd//ys2FcFCVckTdCLrR24jfJw4/dsLS7Ew==
X-Google-Smtp-Source: ABdhPJwMVcoyQBnWBMCitbzEVkAQRIcFmvlh/Qct2E5NFxiTOXFKlDOTJ3XkZl34NxYoaEpXy5UO39fq9WoNN2WpDU0=
X-Received: by 2002:ac8:7c82:: with SMTP id y2mr3906877qtv.67.1612380956634;
 Wed, 03 Feb 2021 11:35:56 -0800 (PST)
MIME-Version: 1.0
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
 <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local> <CACT4Y+a48smtXc6qJy9Wthwuqjk2gh6o7BK1tfWW46g7D_r-Lg@mail.gmail.com>
 <cc712c9c-7786-bb26-7082-04e564df98aa@oracle.com> <CACT4Y+bPDvmwk38DrKfGV8cbtS_abAMDCqr9OigcPfep0uk5AQ@mail.gmail.com>
 <20210203192856.GA324708@fedora>
In-Reply-To: <20210203192856.GA324708@fedora>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 Feb 2021 20:35:44 +0100
Message-ID: <CACT4Y+bscZGpMK-UXXzeFDeJtGYt-royR_=iTzTmBrwe3wOmTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in ibft_init()
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, pjones@redhat.com,
        konrad@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 8:29 PM Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:
>
> Hey Dmitry, Rafael, George, please see below..
>
> On Wed, Jan 27, 2021 at 10:10:07PM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 27, 2021 at 9:01 PM George Kennedy
> > <george.kennedy@oracle.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On 1/27/2021 1:48 PM, Dmitry Vyukov wrote:
> > >
> > > On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
> > > <konrad.wilk@oracle.com> wrote:
> > >
> > > On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
> > >
> > > During boot of kernel with CONFIG_KASAN the following KASAN false
> > > positive failure will occur when ibft_init() reads the
> > > ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
> > >
> > > The ACPI iBFT table is not allocated, and the iscsi driver uses
> > > a pointer to it to calculate checksum, etc. KASAN complains
> > > about this pointer with use-after-free, which this is not.
> > >
> > > Andrey, Alexander, Dmitry,
> > >
> > > I think this is the right way for this, but was wondering if you have
> > > other suggestions?
> > >
> > > Thanks!
> > >
> > > Hi George, Konrad,
> > >
> > > Please provide a sample KASAN report and kernel version to match line numbers.
> > >
> > > 5.4.17-2102.200.0.0.20210106_0000
> > >
> > > [   24.413536] iBFT detected.
> > > [   24.414074]
> > > ==================================================================
> > > [   24.407342] BUG: KASAN: use-after-free in ibft_init+0x134/0xb8b
> > > [   24.407342] Read of size 4 at addr ffff8880be452004 by task swapper/0/1
> > > [   24.407342]
> > > [   24.407342] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.17-2102.200.0.0.20210106_0000.syzk #1
> > > [   24.407342] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > > [   24.407342] Call Trace:
> > > [   24.407342]  dump_stack+0xd4/0x119
> > > [   24.407342]  ? ibft_init+0x134/0xb8b
> > > [   24.407342]  print_address_description.constprop.6+0x20/0x220
> > > [   24.407342]  ? ibft_init+0x134/0xb8b
> > > [   24.407342]  ? ibft_init+0x134/0xb8b
> > > [   24.407342]  __kasan_report.cold.9+0x37/0x77
> > > [   24.407342]  ? ibft_init+0x134/0xb8b
> > > [   24.407342]  kasan_report+0x14/0x1b
> > > [   24.407342]  __asan_report_load_n_noabort+0xf/0x11
> > > [   24.407342]  ibft_init+0x134/0xb8b
> > > [   24.407342]  ? dmi_sysfs_init+0x1a5/0x1a5
> > > [   24.407342]  ? dmi_walk+0x72/0x89
> > > [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
> > > [   24.407342]  ? rvt_init_port+0x110/0x101
> > > [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
> > > [   24.407342]  do_one_initcall+0xc3/0x44d
> > > [   24.407342]  ? perf_trace_initcall_level+0x410/0x405
> > > [   24.407342]  kernel_init_freeable+0x551/0x673
> > > [   24.407342]  ? start_kernel+0x94b/0x94b
> > > [   24.407342]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
> > > [   24.407342]  ? __kasan_check_write+0x14/0x16
> > > [   24.407342]  ? rest_init+0xe6/0xe6
> > > [   24.407342]  kernel_init+0x16/0x1bd
> > > [   24.407342]  ? rest_init+0xe6/0xe6
> > > [   24.407342]  ret_from_fork+0x2b/0x36
> > > [   24.407342]
> > > [   24.407342] The buggy address belongs to the page:
> > > [   24.407342] page:ffffea0002f91480 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1
> > > [   24.407342] flags: 0xfffffc0000000()
> > > [   24.407342] raw: 000fffffc0000000 ffffea0002fca588 ffffea0002fb1a88 0000000000000000
> > > [   24.407342] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> > > [   24.407342] page dumped because: kasan: bad access detected
> > > [   24.407342]
> > > [   24.407342] Memory state around the buggy address:
> > > [   24.407342]  ffff8880be451f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > [   24.407342]  ffff8880be451f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > [   24.407342] >ffff8880be452000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > [   24.407342]                    ^
> > > [   24.407342]  ffff8880be452080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > [   24.407342]  ffff8880be452100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > [   24.407342]
> > > ==================================================================
> > > [   24.407342] Disabling lock debugging due to kernel taint
> > > [   24.451021] Kernel panic - not syncing: panic_on_warn set ...
> > > [   24.452002] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B 5.4.17-2102.200.0.0.20210106_0000.syzk #1
> > > [   24.452002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > > [   24.452002] Call Trace:
> > > [   24.452002]  dump_stack+0xd4/0x119
> > > [   24.452002]  ? ibft_init+0x102/0xb8b
> > > [   24.452002]  panic+0x28f/0x6e0
> > > [   24.452002]  ? __warn_printk+0xe0/0xe0
> > > [   24.452002]  ? ibft_init+0x134/0xb8b
> > > [   24.452002]  ? add_taint+0x68/0xb3
> > > [   24.452002]  ? add_taint+0x68/0xb3
> > > [   24.452002]  ? ibft_init+0x134/0xb8b
> > > [   24.452002]  ? ibft_init+0x134/0xb8b
> > > [   24.452002]  end_report+0x4c/0x54
> > > [   24.452002]  __kasan_report.cold.9+0x55/0x77
> > > [   24.452002]  ? ibft_init+0x134/0xb8b
> > > [   24.452002]  kasan_report+0x14/0x1b
> > > [   24.452002]  __asan_report_load_n_noabort+0xf/0x11
> > > [   24.452002]  ibft_init+0x134/0xb8b
> > > [   24.452002]  ? dmi_sysfs_init+0x1a5/0x1a5
> > > [   24.452002]  ? dmi_walk+0x72/0x89
> > > [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
> > > [   24.452002]  ? rvt_init_port+0x110/0x101
> > > [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
> > > [   24.452002]  do_one_initcall+0xc3/0x44d
> > > [   24.452002]  ? perf_trace_initcall_level+0x410/0x405
> > > [   24.452002]  kernel_init_freeable+0x551/0x673
> > > [   24.452002]  ? start_kernel+0x94b/0x94b
> > > [   24.452002]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
> > > [   24.452002]  ? __kasan_check_write+0x14/0x16
> > > [   24.452002]  ? rest_init+0xe6/0xe6
> > > [   24.452002]  kernel_init+0x16/0x1bd
> > > [   24.452002]  ? rest_init+0xe6/0xe6
> > > [   24.452002]  ret_from_fork+0x2b/0x36
> > > [   24.452002] Dumping ftrace buffer:
> > > [   24.452002] ---------------------------------
> > > [   24.452002] swapper/-1         1.... 24564337us : rdmaip_init: 2924: rdmaip_init: Active Bonding is DISABLED
> > > [   24.452002] ---------------------------------
> > > [   24.452002] Kernel Offset: disabled
> > > [   24.452002] Rebooting in 1 seconds..
> > >
> > > Why does KASAN think the address is freed? For that to happen that
> > > memory should have been freed. I don't remember any similar false
> > > positives from KASAN, so this looks a bit suspicious.
> > >
> > > I'm not sure why KASAN thinks the address is freed. There are other modules where KASAN/KCOV is disabled on boot.
> > > Could this be for a similar reason?
> >
> > Most of these files are disabled because they cause recursion in
> > instrumentation, or execute too early in bootstrap process (before
> > kasan_init).
> >
> > Somehow the table pointer in ibft_init points to a freed page. I
> > tracked it down to here:
> > https://elixir.bootlin.com/linux/v5.4.17/source/drivers/acpi/acpica/tbutils.c#L399
> > but I can't find where this table_desc->pointer comes from. Perhaps it
>
> It is what the BIOS generated. It usually points to some memory
> location in right under 4GB and the BIOS stashes the DSDT, iBFT, and
> other tables in there.
>
> > uses some allocation method that's not supported by KASAN? However,
> > it's the only such case that I've seen, so it's a bit weird. Could it
> > use something like memblock_alloc? Or maybe that page was in fact
> > freed?... Too bad KASAN does not print free stack for pages, maybe
> > it's not too hard to do if CONFIG_PAGE_OWNER is enabled...
>
> Hm, there is a comment in the acpi_get_table speaking about the
> requirement of having a acpi_put_table and:
>
>
>  * DESCRIPTION: Finds and verifies an ACPI table. Table must be in the
>  *              RSDT/XSDT.
>  *              Note that an early stage acpi_get_table() call must be paired
>  *              with an early stage acpi_put_table() call. otherwise the table
>  *              pointer mapped by the early stage mapping implementation may be
>  *              erroneously unmapped by the late stage unmapping implementation
>  *              in an acpi_put_table() invoked during the late stage.
>  *
>
> Which would imply that I should use acpi_put_table in the error path
> (see below a patch), but also copy the structure instead of depending
> on ACPI keeping it mapped for me. I think.

Hi Konrad,

Thanks for looking into this.
If ACPI unmaps this page, that would perfectly explain the KASAN report.

George, does this patch eliminate the KASAN report for you?


> CC-ing Rafeal.
>
>
> From c37da50fdfc62cd4f7b23562b55661478c90a17d Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad@darnok.org>
> Date: Tue, 2 Feb 2021 17:28:28 +0000
> Subject: [PATCH] ibft: Put ibft_addr back
>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad@darnok.org>
> ---
>  drivers/firmware/iscsi_ibft.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 7127a04..2a1a033 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -811,6 +811,10 @@ static void ibft_cleanup(void)
>                 ibft_unregister();
>                 iscsi_boot_destroy_kset(boot_kset);
>         }
> +       if (ibft_addr) {
> +               acpi_put_table((struct acpi_table_header *)ibft_addr);
> +               ibft_addr = NULL;
> +       }
>  }
>
>  static void __exit ibft_exit(void)
> @@ -835,13 +839,15 @@ static void __init acpi_find_ibft_region(void)
>  {
>         int i;
>         struct acpi_table_header *table = NULL;
> +       acpi_status status;
>
>         if (acpi_disabled)
>                 return;
>
>         for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> -               acpi_get_table(ibft_signs[i].sign, 0, &table);
> -               ibft_addr = (struct acpi_table_ibft *)table;
> +               status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> +               if (ACPI_SUCCESS(status))
> +                       ibft_addr = (struct acpi_table_ibft *)table;
>         }
>  }
>  #else
> @@ -870,12 +876,13 @@ static int __init ibft_init(void)
>
>                 rc = ibft_check_device();
>                 if (rc)
> -                       return rc;
> +                       goto out_free;
>
>                 boot_kset = iscsi_boot_create_kset("ibft");
> -               if (!boot_kset)
> -                       return -ENOMEM;
> -
> +               if (!boot_kset) {
> +                       rc = -ENOMEM;
> +                       goto out_free;
> +               }
>                 /* Scan the IBFT for data and register the kobjects. */
>                 rc = ibft_register_kobjects(ibft_addr);
>                 if (rc)
> --
> 1.8.3.1
>

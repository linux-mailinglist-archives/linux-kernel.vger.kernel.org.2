Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DC3D7E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhG0TYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhG0TYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:24:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F410C061757;
        Tue, 27 Jul 2021 12:24:38 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l11so362633iln.4;
        Tue, 27 Jul 2021 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kwv/dzUFIVlUEF2u5j3qMikddidTR3I0tTI9oPy2vyY=;
        b=fHRBYJ9AcLwM4Plh8pN5stLPQ1MG0OW9GcNSIVod4HdgQbGGP4g529FssVeGTF5TBH
         upYZNU/YyFQl30E6rfPQJUULQrBPrh89GbftSQk7BoEfvvY5nGNX/04+AROqcuCa5vW3
         Fgf5SnxF6rKwHNdLvift796/q10rW2EgKv68zLUDkpHX3RhJyJqNU/g5qfT0tIZK5lJo
         CGQavnKG3/w1eTk6t3H5AbrxMin4ZDQaIQ6esd6CzE1m/DFjrGe+XzzzkqEnyEYmJiWl
         KDfc6IyTih45J4/cbpJGqimgC7bk/OndavyAcriOazKyQRqhRTVs19WiKoyuuqvNitfl
         cg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kwv/dzUFIVlUEF2u5j3qMikddidTR3I0tTI9oPy2vyY=;
        b=PjquuW27jCLTDeBb5GkGDetvfaHSBo6HMk6MVgl1pYXwSdBYYdA3gywhdtpnaInZOY
         ClH5ui7W8AuEO7ugdDAYV7P+nizFTiNV3mkHvJUsc9EHBSGCk4reVU8Ksy2AuQq416A3
         fe2z+q52ODh4wiaoTG2Mh89wJjYMBUAF3htuCtD8njShFBpYFBS1fk+h1346mJIH1wvz
         nnzpf6JU2BfbyDGgYVYvfbMYRlYJ9jxamN2JGueblXoUMlVF43ttR03ciahI9pxLMHu7
         TRHkUpIXeLSGo9zSq5VKrgVFt9muMZknHg9EoYEZGItQDRefeWLb6Uo+cvVwm2wwZzD8
         pA/A==
X-Gm-Message-State: AOAM531gBf7m0MsXZj0rmKjtLt9hyVOWO3A2ZKUiwZGJqMteMF2VRFRL
        9PlCjtWnb68x65UAljFJwi/3PtPvYsa96GnK3CnZG8UcAbUnTg==
X-Google-Smtp-Source: ABdhPJzNP5+BJprJhAGSh8qRImZlVz4hSQqRcTyoJK/7y+CFLOMm5fyooz9nV0o8zqbDumDEPB4IQIJseO9nnW4FtPI=
X-Received: by 2002:a92:c989:: with SMTP id y9mr17987249iln.183.1627413878093;
 Tue, 27 Jul 2021 12:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210726192311.uffqnanxw3ac5wwi@ivybridge> <YP8Vxt0xuV1m5EPS@linux.ibm.com>
 <CAEdQ38F2ddbM0WBjut6MH-0TpencKmx9Wu4++gLtfQ5HGRwxFQ@mail.gmail.com> <YP+rI9Fh4wl/O6/8@linux.ibm.com>
In-Reply-To: <YP+rI9Fh4wl/O6/8@linux.ibm.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 27 Jul 2021 12:24:26 -0700
Message-ID: <CAEdQ38G+ZfXmc01iZTc+q4dYpRqQJUz0KNFCPwTQ25AYqJVbMA@mail.gmail.com>
Subject: Re: Regression bisected to fa3354e4ea39 (mm: free_area_init: use
 maximal zone PFNs rather than zone sizes)
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-mm@kvack.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Jul 26, 2021 at 02:23:20PM -0700, Matt Turner wrote:
> > On Mon, Jul 26, 2021 at 1:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > Hi Matt,
> > >
> > > On Mon, Jul 26, 2021 at 12:27:50PM -0700, Matt Turner wrote:
> > > > Reply-To:
> > > >
> > > > Hi Mike!
> > > >
> > > > Since commit fa3354e4ea39 (mm: free_area_init: use maximal zone PFNs rather
> > > > than zone sizes), I get the following BUG on Alpha (an AlphaServer ES47 Marvel)
> > > > and loading userspace leads to a segfault:
> > > >
> > > > (I didn't notice this for a long time because of other unrelated regressions,
> > > > the pandemic, changing jobs, ...)
> > >
> > > I suspect there will be more surprises down the road :)
> > >
> > > > BUG: Bad page state in process swapper  pfn:2ffc53
> > > > page:fffffc000ecf14c0 refcount:0 mapcount:1 mapping:0000000000000000 index:0x0
> > > > flags: 0x0()
> > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > page dumped because: nonzero mapcount  Modules linked in:
> > > > CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-03841-gfa3354e4ea39-dirty #26
> > > >        fffffc0001b5bd68 fffffc0001b5be80 fffffc00011cd148 fffffc000ecf14c0
> > > >        fffffc00019803df fffffc0001b5be80 fffffc00011ce340 fffffc000ecf14c0
> > > >        0000000000000000 fffffc0001b5be80 fffffc0001b482c0 fffffc00027d6618
> > > >        fffffc00027da7d0 00000000002ff97a 0000000000000000 fffffc0001b5be80
> > > >        fffffc00011d1abc fffffc000ecf14c0 fffffc0002d00000 fffffc0001b5be80
> > > >        fffffc0001b2350c 0000000000300000 fffffc0001b48298 fffffc0001b482c0
> > > > Trace:
> > > > [<fffffc00011cd148>] bad_page+0x168/0x1b0
> > > > [<fffffc00011ce340>] free_pcp_prepare+0x1e0/0x290
> > > > [<fffffc00011d1abc>] free_unref_page+0x2c/0xa0
> > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > [<fffffc000101001c>] _stext+0x1c/0x20
> > > >
> > > > I haven't tried reproducing this on other machines or QEMU, but I'd be glad to
> > > > if that helps.
> > >
> > > If it's reproducible on QEMU I can debug it locally.
> > >
> > > > Any ideas?
> > >
> > > It seems like memory map is not properly initialized. Can you enable
> > > CONFIG_DEBUG_MEMORY_INIT and add mminit_debug=4 to the command line. The
> > > interesting part of the log would be before "Memory: xK/yK available ..."
> > > line.
> > >
> > > Hopefully it'll give some clues.
> >
> > Sure thing. Please find attached.
>
> > aboot: loading uncompressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > aboot: loading compressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > aboot: PHDR 0 vaddr 0xfffffc0001010000 offset 0xc0 size 0x17c5ae0
> > aboot: bss at 0xfffffc00027d5ae0, size 0xe4ea0
> > aboot: zero-filling 937632 bytes at 0xfffffc00027d5ae0
> > aboot: loading initrd (5965252 bytes/5825 blocks) at 0xfffffc05ff2cc000
> > aboot: starting kernel vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty with arguments ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > Linux version 5.7.0-03841-gfa3354e4ea39-dirty (mattst88@ivybridge) (gcc version 11.1.0 (Gentoo 11.1.0-r2 p3), GNU ld (Gentoo 2.36.1 p3) 2.36.1) #26 SMP Sun Jul 25 18:20:06 PDT 2021
> > printk: bootconsole [srm0] enabled
> > Booting on Marvel variation Marvel/EV7 using machine vector MARVEL/EV7 from SRM
> > Major Options: SMP EV67 VERBOSE_MCHECK DEBUG_SPINLOCK MAGIC_SYSRQ
> > Command line: ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > memcluster 0, usage 1, start        0, end     1984
> > memcluster 1, usage 0, start     1984, end  1048576
> > memcluster 2, usage 1, start  2097152, end  2097224
> > memcluster 3, usage 0, start  2097224, end  3145728
> > Initial ramdisk at: 0x(____ptrval____) (5965252 bytes)
> > Found an IO7 at PID 0
> > Initializing IO7 at PID 0
> > FIXME: disabling master aborts
> > FIXME: disabling master aborts
> > FIXME: disabling master aborts
> > FIXME: disabling master aborts
> > SMP: 2 CPUs probed -- cpu_present_mask = 3
> > Zone ranges:
> >   DMA      [mem 0x0000000000f80000-0x00000fffffffdfff]
> >   Normal   empty
> > Movable zone start for each node
> > Early memory node ranges
> >   node   0: [mem 0x0000000000f80000-0x00000001ffffffff]
> >   node   0: [mem 0x0000000400090000-0x00000005ffffffff]
>
> I think that the issue is that memory marked as used in memcluster is never
> added to memblock and it skews node/zone sizing calculations.

Thanks, this patch fixes it. With the patch applied, I see

Zone ranges:
  DMA      [mem 0x0000000000000000-0x00000fffffffdfff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x00000001ffffffff]
  node   0: [mem 0x0000000400000000-0x00000005ffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000005ffffffff]

If you want to send me this patch with your S-o-b I'll take it through
my alpha git tree.

Thanks Mike!
Matt

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E13DBF44
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhG3TyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhG3TyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:54:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DBDC06175F;
        Fri, 30 Jul 2021 12:54:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x90so14717274ede.8;
        Fri, 30 Jul 2021 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeJfjdB8dQaXLlibSvTDRTr2jwAVC8Vl9ftQs1pP0KQ=;
        b=IPNuArhUM9isk0MAOoVt2i+tkTJaozdPXz44bk3t6urE+/zBVFjz5T3jVAVgJSAiqY
         h4fYOwUzWPblvfgM1kLu2M7qN8N7E/m/ZVIVOAKcEeIb4YapSliadIYE39BMTP7k/frb
         v9OUCVQ+VLWQlBeS8T59S1kdZZrhqxCBLhHiCfXJWn9NOjkIZ79wUMjGMv7xDEM0/xAW
         UeV0DPnB0lUnq7n4zgewAdxuhYrT3a9eiVtc3RyXRRD+ABm95g0V2QP+8Wt5OXYoOy4k
         jVXbMtm9tAxlb8tols4XO64+M35dVL7a/sQo79k90sVlI428Y8/kpE0nrJjlvH5WGUce
         8shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeJfjdB8dQaXLlibSvTDRTr2jwAVC8Vl9ftQs1pP0KQ=;
        b=NSBWAr5qzFOHkMy1yPa8v1Ys1F7YP4okQZwRuaiTS4pdDh9/MG571aDBFodydeIEGb
         l3mLHbCkGc6+ECtytQKWE9OhJWEZ1VmRt5AtO6iBmiJUQ3e7MwGqSDZFZj/XZfxW52V2
         AxuctMkWkgHnVXnvbTFk+H4aBAU/BPaqPNsFzL4135gvhsSFT3FHnwMEdkkIycQtsfQs
         9ALAl+hJEbAgVJIgOvlFnsKVXV3vanWrW6f9ld1DaaoOdziZDrAf41RAsxJCVViW441l
         cjkU0+gYHHapembwHPgGkVxwL3BB7UFxYnIlw8/Y8LwvWD2EbtOzghJcqhKCCU/EiuFZ
         6B0Q==
X-Gm-Message-State: AOAM532p7bUtww2aCrLRfmQhHBx2NNV81wMLvxiK7Uyi3vxXsKcykdi2
        Y7Y9elnOlGhh2JKjxv8vqsIMSK0YdeLbt/tr43E=
X-Google-Smtp-Source: ABdhPJxFK7hBXr4nCZrmJU1jTnDfzmdYFbG9FDXubIFSS8nvM7m3c/F178lorDLFsMptjFAV0cn/wpAc3+8Dug9TfO0=
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr5031406edx.149.1627674850153;
 Fri, 30 Jul 2021 12:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210726192311.uffqnanxw3ac5wwi@ivybridge> <YP8Vxt0xuV1m5EPS@linux.ibm.com>
 <CAEdQ38F2ddbM0WBjut6MH-0TpencKmx9Wu4++gLtfQ5HGRwxFQ@mail.gmail.com>
 <YP+rI9Fh4wl/O6/8@linux.ibm.com> <CAEdQ38G+ZfXmc01iZTc+q4dYpRqQJUz0KNFCPwTQ25AYqJVbMA@mail.gmail.com>
 <YQBvYUupT/jgDMqI@linux.ibm.com>
In-Reply-To: <YQBvYUupT/jgDMqI@linux.ibm.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 30 Jul 2021 12:53:58 -0700
Message-ID: <CAEdQ38HZ4g_E3vtG=f6p_sfuWnk7haK_eJ0MZziLsOq0ZmfBoQ@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 1:41 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jul 27, 2021 at 12:24:26PM -0700, Matt Turner wrote:
> > On Mon, Jul 26, 2021 at 11:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Mon, Jul 26, 2021 at 02:23:20PM -0700, Matt Turner wrote:
> > > > On Mon, Jul 26, 2021 at 1:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > >
> > > > > Hi Matt,
> > > > >
> > > > > On Mon, Jul 26, 2021 at 12:27:50PM -0700, Matt Turner wrote:
> > > > > > Reply-To:
> > > > > >
> > > > > > Hi Mike!
> > > > > >
> > > > > > Since commit fa3354e4ea39 (mm: free_area_init: use maximal zone PFNs rather
> > > > > > than zone sizes), I get the following BUG on Alpha (an AlphaServer ES47 Marvel)
> > > > > > and loading userspace leads to a segfault:
> > > > > >
> > > > > > (I didn't notice this for a long time because of other unrelated regressions,
> > > > > > the pandemic, changing jobs, ...)
> > > > >
> > > > > I suspect there will be more surprises down the road :)
> > > > >
> > > > > > BUG: Bad page state in process swapper  pfn:2ffc53
> > > > > > page:fffffc000ecf14c0 refcount:0 mapcount:1 mapping:0000000000000000 index:0x0
> > > > > > flags: 0x0()
> > > > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > page dumped because: nonzero mapcount  Modules linked in:
> > > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-03841-gfa3354e4ea39-dirty #26
> > > > > >        fffffc0001b5bd68 fffffc0001b5be80 fffffc00011cd148 fffffc000ecf14c0
> > > > > >        fffffc00019803df fffffc0001b5be80 fffffc00011ce340 fffffc000ecf14c0
> > > > > >        0000000000000000 fffffc0001b5be80 fffffc0001b482c0 fffffc00027d6618
> > > > > >        fffffc00027da7d0 00000000002ff97a 0000000000000000 fffffc0001b5be80
> > > > > >        fffffc00011d1abc fffffc000ecf14c0 fffffc0002d00000 fffffc0001b5be80
> > > > > >        fffffc0001b2350c 0000000000300000 fffffc0001b48298 fffffc0001b482c0
> > > > > > Trace:
> > > > > > [<fffffc00011cd148>] bad_page+0x168/0x1b0
> > > > > > [<fffffc00011ce340>] free_pcp_prepare+0x1e0/0x290
> > > > > > [<fffffc00011d1abc>] free_unref_page+0x2c/0xa0
> > > > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > > > [<fffffc000101001c>] _stext+0x1c/0x20
> > > > > >
> > > > > > I haven't tried reproducing this on other machines or QEMU, but I'd be glad to
> > > > > > if that helps.
> > > > >
> > > > > If it's reproducible on QEMU I can debug it locally.
> > > > >
> > > > > > Any ideas?
> > > > >
> > > > > It seems like memory map is not properly initialized. Can you enable
> > > > > CONFIG_DEBUG_MEMORY_INIT and add mminit_debug=4 to the command line. The
> > > > > interesting part of the log would be before "Memory: xK/yK available ..."
> > > > > line.
> > > > >
> > > > > Hopefully it'll give some clues.
> > > >
> > > > Sure thing. Please find attached.
> > >
> > > > aboot: loading uncompressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > > > aboot: loading compressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > > > aboot: PHDR 0 vaddr 0xfffffc0001010000 offset 0xc0 size 0x17c5ae0
> > > > aboot: bss at 0xfffffc00027d5ae0, size 0xe4ea0
> > > > aboot: zero-filling 937632 bytes at 0xfffffc00027d5ae0
> > > > aboot: loading initrd (5965252 bytes/5825 blocks) at 0xfffffc05ff2cc000
> > > > aboot: starting kernel vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty with arguments ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > > > Linux version 5.7.0-03841-gfa3354e4ea39-dirty (mattst88@ivybridge) (gcc version 11.1.0 (Gentoo 11.1.0-r2 p3), GNU ld (Gentoo 2.36.1 p3) 2.36.1) #26 SMP Sun Jul 25 18:20:06 PDT 2021
> > > > printk: bootconsole [srm0] enabled
> > > > Booting on Marvel variation Marvel/EV7 using machine vector MARVEL/EV7 from SRM
> > > > Major Options: SMP EV67 VERBOSE_MCHECK DEBUG_SPINLOCK MAGIC_SYSRQ
> > > > Command line: ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > > > memcluster 0, usage 1, start        0, end     1984
> > > > memcluster 1, usage 0, start     1984, end  1048576
> > > > memcluster 2, usage 1, start  2097152, end  2097224
> > > > memcluster 3, usage 0, start  2097224, end  3145728
> > > > Initial ramdisk at: 0x(____ptrval____) (5965252 bytes)
> > > > Found an IO7 at PID 0
> > > > Initializing IO7 at PID 0
> > > > FIXME: disabling master aborts
> > > > FIXME: disabling master aborts
> > > > FIXME: disabling master aborts
> > > > FIXME: disabling master aborts
> > > > SMP: 2 CPUs probed -- cpu_present_mask = 3
> > > > Zone ranges:
> > > >   DMA      [mem 0x0000000000f80000-0x00000fffffffdfff]
> > > >   Normal   empty
> > > > Movable zone start for each node
> > > > Early memory node ranges
> > > >   node   0: [mem 0x0000000000f80000-0x00000001ffffffff]
> > > >   node   0: [mem 0x0000000400090000-0x00000005ffffffff]
> > >
> > > I think that the issue is that memory marked as used in memcluster is never
> > > added to memblock and it skews node/zone sizing calculations.
> >
> > Thanks, this patch fixes it. With the patch applied, I see
> >
> > Zone ranges:
> >   DMA      [mem 0x0000000000000000-0x00000fffffffdfff]
> >   Normal   empty
> > Movable zone start for each node
> > Early memory node ranges
> >   node   0: [mem 0x0000000000000000-0x00000001ffffffff]
> >   node   0: [mem 0x0000000400000000-0x00000005ffffffff]
> > Initmem setup node 0 [mem 0x0000000000000000-0x00000005ffffffff]
> >
> > If you want to send me this patch with your S-o-b I'll take it through
> > my alpha git tree.
>
> The patch is on its way :)

Thanks a bunch, Mike, for the patch and for all you do!

> Now I'm really curios how commit e7793e53901b ("arc: update comment about
> HIGHMEM implementation") will work out.

You probably mean fdb7d9b7acd0 ("alpha: remove DISCONTIGMEM and
NUMA"). Works well so far!

Maybe in some alternative universe where I have infinite free time
(and my own power plant!) I'll get a second AlphaServer ES47 with the
enormous "hose" [1] to link the two and I'll poke you for guidance on
restoring NUMA support :)

Thanks again!

[1] https://www.ebay.com/itm/302471226394

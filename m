Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1591D35A188
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhDIOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDIOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:53:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D7C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:53:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso4890130wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WZhzs2fZMnCvLImbVe1ILt0qaZorhkDyluFdReXvAHc=;
        b=h9BxHotDoXEBVsnrle/BweQClRGerwLjyRhRCEii9WEDO261Ket5Xxx9Av5nnMREtJ
         cmZtFDykdU5y+ZlGpIB7WsBSey9sEuUBgztX6BhJdmL/t8svjemUIppyFrksUHP2bQFf
         awdf3X0hrL25YRIzI+6iXTIhAvG4vNkhftpL2RHCFnyNEfSdzFgWgcrUhdv733luB+iP
         mpf0qGTnDzx85uXpqvkryP4ZUhJWJ64iGwO8JxayV53cMR34/lN3JG+/HwEElEVFR/3e
         ga8xYwihMFqkQYEaqfz+nvbfYOqTTMv63xgjOG0ytLYx97NIk9uIqUL2pTz/wwmVTDZq
         S/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WZhzs2fZMnCvLImbVe1ILt0qaZorhkDyluFdReXvAHc=;
        b=G+hG/H8CGYwbkiAN9e/lUknvDwecKHbWBuXsKgVsfcJAkcjuoFu8SLPT090HEj9dTy
         3+hDbb9uAl3sjIag3Ud7P8vhzAjaz6iP9VWehOZqpSVR0s6UoRCqMpFZP/tQdYBgnoIM
         PPfSqGwH0VX3CFv7+elKeHiFhb6GK6mpuNc6fuK8CGa6YPwIWLXKCOQROZYU46/RKEGs
         rHGL9CXxqPkvb8DLKVyoGLTQqkvf7DLgR+4g6p6ktdA/3+ZtWeRHBg73n3xcdhKIs+iv
         G9SSRslXLG1XfbpvmTasSKBP04bVmLFkotUveQkWy0tJF0/8jAJnyKUau1JtyBMoPr+I
         hYJw==
X-Gm-Message-State: AOAM530MGKNLdrWGQVI7Uo7GMBbiDE+3skgXVezjHT66Qc4nA2d0kRq6
        WhsrfB4OPHHKeDtJy1Hd4Z8=
X-Google-Smtp-Source: ABdhPJxXaj60oomqJma7XXV4N2rWpsm/kr4nMVJI+qqDdmqRoE4GK0FkKFCguA1Si+0m508t0Ly/iw==
X-Received: by 2002:a05:600c:49aa:: with SMTP id h42mr14294107wmp.80.1617979995485;
        Fri, 09 Apr 2021 07:53:15 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x11sm4655209wme.9.2021.04.09.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:53:14 -0700 (PDT)
Date:   Fri, 9 Apr 2021 16:53:13 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YHBqWY3+WtYY1QpW@Red>
References: <YG2rfzRvHIZKXkf/@Red>
 <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
 <YG3AZ4K2auqEz9BK@Red>
 <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
 <YG3GWxYU02UhOnUX@Red>
 <291254c6-97e3-f5ba-dcee-77f8e4d25f9b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <291254c6-97e3-f5ba-dcee-77f8e4d25f9b@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 07, 2021 at 07:59:27AM -0700, Bruce Mitchell a écrit :
> On 4/7/2021 07:48, Corentin Labbe wrote:
> > Le Wed, Apr 07, 2021 at 07:28:26AM -0700, Bruce Mitchell a écrit :
> >> On 4/7/2021 07:23, Corentin Labbe wrote:
> >>> Le Wed, Apr 07, 2021 at 07:13:04AM -0700, Bruce Mitchell a écrit :
> >>>> On 4/7/2021 05:54, Corentin Labbe wrote:
> >>>>> Hello
> >>>>>
> >>>>> I try to do kexec on a cortina/gemini SoC.
> >>>>> On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
> >>>>> But now, kernel fail to reserve memory:
> >>>>> Load Kern image from 0x30020000 to 0x800000 size 7340032
> >>>>> Booting Linux on physical CPU 0x0
> >>>>> Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
> >>>>> CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
> >>>>> CPU: VIVT data cache, VIVT instruction cache
> >>>>> OF: fdt: Machine model: Edimax NS-2502
> >>>>> Memory policy: Data cache writeback
> >>>>> Zone ranges:
> >>>>>      Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> >>>>>      HighMem  empty
> >>>>> Movable zone start for each node
> >>>>> Early memory node ranges
> >>>>>      node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> >>>>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> >>>>> crashkernel reservation failed - No suitable area found.
> >>>>> Built 1 zonelists, mobility grouping on.  Total pages: 32512
> >>>>> Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M
> >>>>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> >>>>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> >>>>> mem auto-init: stack:off, heap alloc:off, heap free:off
> >>>>> Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
> >>>>> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> >>>>>
> >>>>> What can I do ?
> >>>>>
> >>>>> Thanks
> >>>>> Regards
> >>>>>
> >>>>> _______________________________________________
> >>>>> kexec mailing list
> >>>>> kexec@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/kexec
> >>>>>
> >>>>
> >>>> Hello Corentin,
> >>>>
> >>>> I see much larger crashkernel=xxM being shown here
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kdump/kdump.rst
> >>>> and from many of my other searches.
> >>>>
> >>>> Here is an interesting article on kdump for ARM-32
> >>>> https://kaiwantech.wordpress.com/2017/07/13/setting-up-kdump-and-crash-for-arm-32-an-ongoing-saga/
> >>>>
> >>>>
> >>>> Here is the kernel command line reference
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v5.11#n732
> >>>>
> >>>> I feel your frustrations too.
> >>>
> >>> Hello
> >>>
> >>> Thanks but I have already read those documentation.
> >>> I search to know why the kernel cannot find 8M of memory ouf of 128.
> >>>
> >>> Regards
> >>>
> >>
> >> How much more memory does the kernel and initrd above and beyond just
> >> their physical size?  (heaps, stacks, buffers, virtual filesystems)
> > 
> > The kernel size include a rootfs.cpio.lzma of 3MB and dtb is appended.
> > The total kernel size is 7MB.
> > The uncompressed size of the kernel is 13M (size of vmlinux)
> > The uncompressed size of rootfs is 11M.
> > 
> > cat /proc/meminfo
> > MemTotal:         122496 kB
> > MemFree:          103700 kB
> > MemAvailable:     101936 kB
> > Buffers:               0 kB
> > Cached:            10904 kB
> > SwapCached:            0 kB
> > Active:             4304 kB
> > Inactive:           8012 kB
> > Active(anon):       4304 kB
> > Inactive(anon):     8012 kB
> > Active(file):          0 kB
> > Inactive(file):        0 kB
> > Unevictable:           0 kB
> > Mlocked:               0 kB
> > HighTotal:             0 kB
> > HighFree:              0 kB
> > LowTotal:         122496 kB
> > LowFree:          103700 kB
> > SwapTotal:             0 kB
> > SwapFree:              0 kB
> > Dirty:                 0 kB
> > Writeback:             0 kB
> > AnonPages:          1428 kB
> > Mapped:             3552 kB
> > Shmem:             10904 kB
> > KReclaimable:        608 kB
> > Slab:               2960 kB
> > SReclaimable:        608 kB
> > SUnreclaim:         2352 kB
> > KernelStack:         312 kB
> > PageTables:          136 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:       61248 kB
> > Committed_AS:      14336 kB
> > VmallocTotal:     901120 kB
> > VmallocUsed:          64 kB
> > VmallocChunk:          0 kB
> > Percpu:               32 kB
> > CmaTotal:              0 kB
> > CmaFree:               0 kB
> > 
> 
> I believe you need space for all of that,
> the smallest that would work for me was 20MB.

I tried without any change.

Anyway when trying to kexec I got:
kexec --no-ifdown --command-line="console=ttyS0,19200n8" /tmp/kernel                                                                        |
Could not find a free area of memory of 0x668a8a bytes...
Cannot load /tmp/kernel

So reserving 8M is enough according to what kexec said.

So anyone know why the kernel cannot reserve 8M ?
Thanks

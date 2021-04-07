Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE82356F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbhDGOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348818AbhDGOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:49:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69081C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:49:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f6so12202603wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YlgnuHeYHkIlwZWqKdtj564syi960rzQJLYLQDOe8Ww=;
        b=r3njU+ENP0K4zVP8dThBvirphS9V7vb7sHdwNiVovXrcEHKhjkN2M9qlh7aPgjbnaE
         SzHJMAYOlwVbYIl3+9GU2gG9yQm0TafUbnybLNhtPNCCEFw42tScgIC6R0+zyqVKmhFb
         5wF8LFddwB9IIrdZIyIbU76IURI9pYhxIbiyWqy/QwmUjecnGnsCpvcH7/KfAoM1XlwQ
         yvgmaaQWsrvOIeup+PBofpI7ONUOy9234dGP9inzC0Aw9l71mYYVEuSnbQoZhBQR4y8g
         TJUunewfEA327kkMgjDKsW+r+c8ZX+D5IE6iB0jbuXw4nKUO8aJhznKu6dQ63XqrRGSD
         ErFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YlgnuHeYHkIlwZWqKdtj564syi960rzQJLYLQDOe8Ww=;
        b=mu7IIvJriJtD3+i+092a7+NLYz5Mkq+0VWSg2FjvqgNV35ZgC1TrKwqrIJcUPfyDHn
         TSc4JK4PSiBcrhms3jIOL7z4jBgF8g/xMovTm0TF+mnQYTIum9XMRQ5R6roMjJWL4qJp
         CkkpPENvN3i706CowBC7zsh8rS85fexmPp8p8PZjU0kZeOia9MeLHiA8ew7SwDEntJi7
         7ifOJgAO6OHZ3LUCdc1IK3pQuRToY0tKQqbVXHSOgnKSXRLT+0OBRYY6DfsfNZlW4wzK
         LY0ZOiP3FLS6yEa7Eo8zVr9nsElZ3Ga8fxnu1V+oxYFXDFiGC7EJJ4eMWj1YUDHdXarP
         /ebg==
X-Gm-Message-State: AOAM533DWiQrsIVdHVEiZnmE98kqfUlgDqlVExWgTfchjrHmv02bAhdp
        Jq2qrTJ8TR4kZua1vym75j4=
X-Google-Smtp-Source: ABdhPJxl7tENphRlyAFgRA5Cf3uYmh+9b9rbl5yhsuHjQSAdKSgz/7QEhFgZcQDiBUoVpbKO5SMPVg==
X-Received: by 2002:adf:f948:: with SMTP id q8mr4943741wrr.296.1617806941967;
        Wed, 07 Apr 2021 07:49:01 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z15sm5984856wml.4.2021.04.07.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:49:01 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:48:59 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YG3GWxYU02UhOnUX@Red>
References: <YG2rfzRvHIZKXkf/@Red>
 <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
 <YG3AZ4K2auqEz9BK@Red>
 <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 07, 2021 at 07:28:26AM -0700, Bruce Mitchell a écrit :
> On 4/7/2021 07:23, Corentin Labbe wrote:
> > Le Wed, Apr 07, 2021 at 07:13:04AM -0700, Bruce Mitchell a écrit :
> >> On 4/7/2021 05:54, Corentin Labbe wrote:
> >>> Hello
> >>>
> >>> I try to do kexec on a cortina/gemini SoC.
> >>> On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
> >>> But now, kernel fail to reserve memory:
> >>> Load Kern image from 0x30020000 to 0x800000 size 7340032
> >>> Booting Linux on physical CPU 0x0
> >>> Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
> >>> CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
> >>> CPU: VIVT data cache, VIVT instruction cache
> >>> OF: fdt: Machine model: Edimax NS-2502
> >>> Memory policy: Data cache writeback
> >>> Zone ranges:
> >>>     Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> >>>     HighMem  empty
> >>> Movable zone start for each node
> >>> Early memory node ranges
> >>>     node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> >>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> >>> crashkernel reservation failed - No suitable area found.
> >>> Built 1 zonelists, mobility grouping on.  Total pages: 32512
> >>> Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M
> >>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> >>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> >>> mem auto-init: stack:off, heap alloc:off, heap free:off
> >>> Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
> >>> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> >>>
> >>> What can I do ?
> >>>
> >>> Thanks
> >>> Regards
> >>>
> >>> _______________________________________________
> >>> kexec mailing list
> >>> kexec@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/kexec
> >>>
> >>
> >> Hello Corentin,
> >>
> >> I see much larger crashkernel=xxM being shown here
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kdump/kdump.rst
> >> and from many of my other searches.
> >>
> >> Here is an interesting article on kdump for ARM-32
> >> https://kaiwantech.wordpress.com/2017/07/13/setting-up-kdump-and-crash-for-arm-32-an-ongoing-saga/
> >>
> >>
> >> Here is the kernel command line reference
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v5.11#n732
> >>
> >> I feel your frustrations too.
> > 
> > Hello
> > 
> > Thanks but I have already read those documentation.
> > I search to know why the kernel cannot find 8M of memory ouf of 128.
> > 
> > Regards
> > 
> 
> How much more memory does the kernel and initrd above and beyond just 
> their physical size?  (heaps, stacks, buffers, virtual filesystems)

The kernel size include a rootfs.cpio.lzma of 3MB and dtb is appended.
The total kernel size is 7MB.
The uncompressed size of the kernel is 13M (size of vmlinux)
The uncompressed size of rootfs is 11M.

cat /proc/meminfo 
MemTotal:         122496 kB
MemFree:          103700 kB
MemAvailable:     101936 kB
Buffers:               0 kB
Cached:            10904 kB
SwapCached:            0 kB
Active:             4304 kB
Inactive:           8012 kB
Active(anon):       4304 kB
Inactive(anon):     8012 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:         122496 kB
LowFree:          103700 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          1428 kB
Mapped:             3552 kB
Shmem:             10904 kB
KReclaimable:        608 kB
Slab:               2960 kB
SReclaimable:        608 kB
SUnreclaim:         2352 kB
KernelStack:         312 kB
PageTables:          136 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       61248 kB
Committed_AS:      14336 kB
VmallocTotal:     901120 kB
VmallocUsed:          64 kB
VmallocChunk:          0 kB
Percpu:               32 kB
CmaTotal:              0 kB
CmaFree:               0 kB


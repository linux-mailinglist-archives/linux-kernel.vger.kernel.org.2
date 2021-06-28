Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3363B5A31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhF1IFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1IFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:05:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07260C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:02:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b15so2921019iow.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ns/J/jAD19w/UcSLKGzsF0dU21lyguifW+h/KHpJbtk=;
        b=gDQmUfudP2ofDhYCFF8F1SxIIe0j9Ox8Gdb83df7cUdc/fYbyND4La9L7oR8/+O9E2
         fz6qSM7aF5qNP3Y1/WhJGRIUDWD2uxlDNwiGIS0SHth7DbS9uhBtq2bNf3nmWH15+k0q
         7z1AkmjCpWP5pYpkZPZ2++U0S/4RE83WqMAaQ/ig1YalomI4rs8gsI2Ahd6yf4tsRMmP
         sL/Tfa607/MkjKg8UhIJD9hINn2tMbjxd7XESLA1WCwa+P3c8ATSMLo9/8KCU9qCPqV7
         RKMUBSJhaHsmmF9cL1v4+gbow0LUcmMIerPv/+ZpTpnmM1uPinrG7mxksL2f+3Y5I0ji
         hFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ns/J/jAD19w/UcSLKGzsF0dU21lyguifW+h/KHpJbtk=;
        b=egF3kagJWxitBaglGkAMb1tQ1+sGh6qfZrNughFiM6EK8SOdV9z+u6Nz1MxRiTzuZX
         U5o/5acWjjb2HlTaR7vfC1u4RI4j9cQfGcb/CpOw5hKiNRUukMEVBGoF6h/q1OdC9ejN
         vvv3HA61pXOP0ChZcqjXdoRR+V4S/c5ipyEUJbijHlSdtPqTKNYV4lv3OUmLgR+01xwM
         Hm86/SdV6p5xreBMQJXPd5SlAEMm3KW2qsFqRhSfgh6Qs2vj7mdlxh0yu2K7D4sUcNQt
         2POws720E1ZsDIDEv5sj7isSyLFNVRhVSc3f7mPAcXRCBBPxi58/VjdvnPy09Swriwd8
         eI2g==
X-Gm-Message-State: AOAM533egPpxytSJwnEkUjcMJsFEgAP+qk2uVY07VIudZs0Mphinzf8W
        TzjoBt/4Kb5jhk57Ju9Cd1wRqGspVIKuqYo+Sj4=
X-Google-Smtp-Source: ABdhPJxFfKC1TnQ+DwDlRdACDd6FOFZdgArm6gmSLt5YFV6FTMA6xilMopFIRb3mTis9YvLbRr2HoxArFmpX2sC0jxM=
X-Received: by 2002:a02:b393:: with SMTP id p19mr5756183jan.69.1624867378365;
 Mon, 28 Jun 2021 01:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <202106280955.VUsBSyHq-lkp@intel.com>
In-Reply-To: <202106280955.VUsBSyHq-lkp@intel.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 28 Jun 2021 10:02:40 +0200
Message-ID: <CAOi1vP-FR2PpqdW4WuhJaaFPZifxthf0B45dV03v00ef66R8wg@mail.gmail.com>
Subject: Re: net/ceph/messenger_v2.c:2808:5: warning: stack frame size (2336)
 exceeds limit (2048) in function 'ceph_con_v2_try_read'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 3:25 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   62fb9874f5da54fdb243003b386128037319b219
> commit: cd1a677cad994021b19665ed476aea63f5d54f31 libceph, ceph: implement msgr2.1 protocol (crc and secure modes)
> date:   7 months ago
> config: powerpc64-randconfig-r034-20210628 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 59558129276098d62046c8cda92240d292cbfb1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd1a677cad994021b19665ed476aea63f5d54f31
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cd1a677cad994021b19665ed476aea63f5d54f31
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:2:1: note: expanded from here
>    __do_outl
>    ^
>    arch/powerpc/include/asm/io.h:522:62: note: expanded from macro '__do_outl'
>    #define __do_outl(val, port)    writel(val,(PCI_IO_ADDR)_IO_BASE+port);
>                                               ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:30:1: note: expanded from here
>    __do_insb
>    ^
>    arch/powerpc/include/asm/io.h:541:56: note: expanded from macro '__do_insb'
>    #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:34:1: note: expanded from here
>    __do_insw
>    ^
>    arch/powerpc/include/asm/io.h:542:56: note: expanded from macro '__do_insw'
>    #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:38:1: note: expanded from here
>    __do_insl
>    ^
>    arch/powerpc/include/asm/io.h:543:56: note: expanded from macro '__do_insl'
>    #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:42:1: note: expanded from here
>    __do_outsb
>    ^
>    arch/powerpc/include/asm/io.h:544:58: note: expanded from macro '__do_outsb'
>    #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:46:1: note: expanded from here
>    __do_outsw
>    ^
>    arch/powerpc/include/asm/io.h:545:58: note: expanded from macro '__do_outsw'
>    #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v2.c:17:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:50:1: note: expanded from here
>    __do_outsl
>    ^
>    arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
>    #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
> >> net/ceph/messenger_v2.c:2808:5: warning: stack frame size (2336) exceeds limit (2048) in function 'ceph_con_v2_try_read' [-Wframe-larger-than]

Same as for ceph_con_v1_try_read(), please add this instance to the
allowlist.

Thanks,

                Ilya

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E85307F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhA1ULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhA1UI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:08:27 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:07:47 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q9so6426287ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yc0cCbs1djyd0FuZIi9VgflfqN74WZxddsSTT80OwBg=;
        b=lxbJRGCLDdaUbid3RMhCMwlmgkMmDcLeKDXezA2/LOksG8yOSjQ1UqsNlROasSjJJU
         7O6nwi2rFw294IPMrGxxCL70PXnUl8QZnnlZyS98F+pSYAQpLg6IpZDZwVhJSGoCXHJt
         NEjFT3uuRAunB4oDvzooA6Wtqip3oMTiWGMfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yc0cCbs1djyd0FuZIi9VgflfqN74WZxddsSTT80OwBg=;
        b=N2dQz73TYkbT9qgpWsgCmcv+6/Waer+Q02k5u7K78IvN2TjDk8dkY47JOqB33xIYZi
         pCW6zhPdlIlp/XY6YyCr+v39koPCVDkQYOa0HqVH3yc3hwfP7LSbCqPawP5tCsqhGrGi
         kyRTJgHXYmFvmvAyqufYjh4MpK+xS933WxD22/30F6wUW4C+xKd+PCczEEV5GI1y9nXZ
         V3prx9jJF4AYRThwlUqslhspzBuKipnCpH5Kyd5cn3EFE10nrc4hl3Tx9wOogcNMhLwN
         DhbW5i0FInhbMW7VrKn7KJiTjQMd872fLdKyC7Mp40j2zkBoNXJYPZUsP+WbU9F3rhOI
         ejwQ==
X-Gm-Message-State: AOAM533i3jSxc7j9Ety5b3sGPlWAw7tyDQzSdQ3MkRMC2XmFhwAV8QoK
        6N/lzEzrSvCK4cRb8xnLLDY+9plld+pEpPLG4eMT
X-Google-Smtp-Source: ABdhPJwWYzYtP8x+TenCxXMmxvh5r+deUf8+214MHNss6gD/s2ewWJvdhGP/YUde6nLL46FZesuI3nljn79b33Q0qmE=
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr598106ilb.77.1611864466662;
 Thu, 28 Jan 2021 12:07:46 -0800 (PST)
MIME-Version: 1.0
References: <b67f8941-6624-d814-e6d3-2ddfdfbdf7dd@infradead.org>
In-Reply-To: <b67f8941-6624-d814-e6d3-2ddfdfbdf7dd@infradead.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 Jan 2021 12:07:35 -0800
Message-ID: <CAOnJCUJc0-x-gmLAKxb9ULjOX1yBjxZvwi4=_0ETH-L7JtKhNw@mail.gmail.com>
Subject: Re: Kconfig-induced build errors: CONFIG_PAGE_OFFSET
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 7:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> I took a riscv-32 .config from kernel test robot (it was for a clang build)
> and did a "make olddefconfig" (using gcc tools) and got build errors
> due to this config item from arch/riscv/Kconfig;
>
>
> config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
>         default 0x80000000 if 64BIT && !MMU
>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
> PAGE_OFFSET is undefined for the case of 32BIT && MAXPHYSMEM_2GB.

Because, RV32 doesn't support 2GB physical memory yet.

The compilation errors can be fixed by not allowing MAXPHYSMEM_2GB for RV32 and
MAXPHYSMEM_1GB for RV64. How about this ?

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -253,8 +253,10 @@ choice
        default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY

        config MAXPHYSMEM_1GB
+               depends on 32BIT
                bool "1GiB"
        config MAXPHYSMEM_2GB
+               depends on 64BIT && CMODEL_MEDLOW
                bool "2GiB"
        config MAXPHYSMEM_128GB
                depends on 64BIT && CMODEL_MEDANY


> That causes lots of errors when _AC() is used to paste
> CONFIG_PAGE_OFFSET to "UL", like these:
>
> In file included from ../include/vdso/const.h:5,
>                  from ../include/linux/const.h:4,
>                  from ../include/linux/bits.h:5,
>                  from ../include/linux/bitops.h:6,
>                  from ../include/linux/kernel.h:11,
>                  from ../init/do_mounts_initrd.c:3:
> ../arch/riscv/include/asm/uaccess.h: In function '__access_ok':
> ../arch/riscv/include/asm/page.h:34:46: error: 'UL' undeclared (first use in this function)
>    34 | #define PAGE_OFFSET  _AC(CONFIG_PAGE_OFFSET, UL)
>       |                                              ^~
> ../include/uapi/linux/const.h:20:23: note: in definition of macro '__AC'
>    20 | #define __AC(X,Y) (X##Y)
>       |                       ^
> ../arch/riscv/include/asm/page.h:34:22: note: in expansion of macro '_AC'
>    34 | #define PAGE_OFFSET  _AC(CONFIG_PAGE_OFFSET, UL)
>       |                      ^~~
> ../arch/riscv/include/asm/pgtable.h:26:27: note: in expansion of macro 'PAGE_OFFSET'
>    26 | #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>       |                           ^~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:41:24: note: in expansion of macro 'VMALLOC_START'
>    41 | #define VMEMMAP_START (VMALLOC_START - VMEMMAP_SIZE)
>       |                        ^~~~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:50:26: note: in expansion of macro 'VMEMMAP_START'
>    50 | #define PCI_IO_END       VMEMMAP_START
>       |                          ^~~~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:51:27: note: in expansion of macro 'PCI_IO_END'
>    51 | #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
>       |                           ^~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:53:26: note: in expansion of macro 'PCI_IO_START'
>    53 | #define FIXADDR_TOP      PCI_IO_START
>       |                          ^~~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:59:27: note: in expansion of macro 'FIXADDR_TOP'
>    59 | #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>       |                           ^~~~~~~~~~~
> ../arch/riscv/include/asm/pgtable.h:471:19: note: in expansion of macro 'FIXADDR_START'
>   471 | #define TASK_SIZE FIXADDR_START
>       |                   ^~~~~~~~~~~~~
> ../arch/riscv/include/asm/uaccess.h:56:17: note: in expansion of macro 'TASK_SIZE'
>    56 |  return size <= TASK_SIZE && addr <= TASK_SIZE - size;
>
>
> I suppose that it wants something like this, but someone else can
> fix/use the correct default value here:
>
> ---
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Provide a default value for PAGE_OFFSET for the case of
> 32BIT and MAXPHYSMEM_2GB.
>
> Fixes many build errors.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  arch/riscv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20210125.orig/arch/riscv/Kconfig
> +++ linux-next-20210125/arch/riscv/Kconfig
> @@ -143,6 +143,7 @@ config PA_BITS
>  config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
> +       default 0x80000000 if 32BIT && MAXPHYSMEM_2GB
>         default 0x80000000 if 64BIT && !MMU
>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish

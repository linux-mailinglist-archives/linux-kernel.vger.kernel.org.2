Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC033D941
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhCPQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhCPQXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:23:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51470C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:23:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m22so63331889lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9/mKkjqDmqgztA1c+9tojdTY3QmdTa/Mj2dq9ukTTI=;
        b=oIzhrCUP8uEFhorRa9bXRKUnCNw5P7uxU7YeQNiVmYyG2BvkcJbS6zl23A4SBAOGdG
         yn3kvlNpGxAiYocjG97D4zXnIklE4MZsuiZllIzDbCA1tjZ+435tFUwJA16biGKJ3si3
         TNCU41auU5xeQYbn6hj5BY+cgEV2C+lvXrfax/NrK8PhOQmUy4mZVJiQMKjJBhh7rnTh
         PthhaqHipyHleu8UEU/GpMwWL3aowzpRMrFEA7AkH3PDVBQ5aLQRxwZb6o6QMS/H8aT6
         ZgH/ZVDbwV+mDTi/pY1MIcnL8uzfSPUcpYO+u1H+QQh9xkufOoK0z329pDR5dV/zPgem
         gB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9/mKkjqDmqgztA1c+9tojdTY3QmdTa/Mj2dq9ukTTI=;
        b=UrUybvQ3x/DWYO6IreJ1CryVHxWg0toykK4/z99Rvo70EcQ6SE/IOEOmDNctD1SS3B
         ZoXopiKuHHXhKDOPWHbjbvHQ0XNQI0tWbLxRxDPup1EBxaI8dioqdbv60XheCidWdgIQ
         W7+eAl7eAVRVsMw8gbU4vBOx+kSV+yq7XnsR2ZNEg/qhGUzA6mdfL+VGYBoupZyb5sej
         3pDiv5RAJhlxIlCC7tt373YmcH/mmcC829JKGQN7QoVLb6Mk0XntrTYk0JPRv4ZRNtI9
         /Fr3mDPYzlRTzXyM4uEuvs9zfrInfmy4hRJUukMjW2OcvBN1lcw6nbdKifTz2cr66hZe
         aebA==
X-Gm-Message-State: AOAM5319vz4kPR2DwYyf04NTnKoLKyO4l6a4DXWRURjdH9JzZfOAFU4U
        BV6XA5rkf2hlJNibqWYXJlELxYYVi57ARnbYdvmnVg==
X-Google-Smtp-Source: ABdhPJxuWanoucLXm4wggJ26jJCzAvFNlj63TFQMKAVOOBhYcNtUY/h9SGFVfpiMVZ3evu02HsYbPIzPxq8/sPXKw7s=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr11895567lfd.547.1615911802020;
 Tue, 16 Mar 2021 09:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <202103160133.UzhgY0wt-lkp@intel.com> <YFBYWjtWJrnGyiVp@linux.ibm.com>
In-Reply-To: <YFBYWjtWJrnGyiVp@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Mar 2021 09:23:09 -0700
Message-ID: <CAKwvOdmMvvOYBJRZh9w8uQH1ZXZ97Gq+Rs0S4Xi0ZnWufYoxAA@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in
 reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:04 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Mar 16, 2021 at 01:23:08AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> > commit: 34dc2efb39a231280fd6696a59bbe712bf3c5c4a memblock: fix section mismatch warning
> > date:   2 days ago
> > config: arm64-randconfig-r013-20210315 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a28facba1ccdc957f386b7753f4958307f1bfde8)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34dc2efb39a231280fd6696a59bbe712bf3c5c4a
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 34dc2efb39a231280fd6696a59bbe712bf3c5c4a
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
> > The function memblock_find_in_range_node() references
> > the function __init memblock_bottom_up().
> > This is often because memblock_find_in_range_node lacks a __init
> > annotation or the annotation of memblock_bottom_up is wrong.
>
> I don't have clang-13 setup handy so I could not check, but I think this
> should be the fix:

Thanks for taking another look:
https://lore.kernel.org/lkml/20210225205908.GM1447004@kernel.org/
Do we want to switch the above to the below?

>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d13e3cd938b4..5984fff3f175 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
>  /*
>   * Set the allocation direction to bottom-up or top-down.
>   */
> -static inline __init void memblock_set_bottom_up(bool enable)
> +static inline __init_memblock void memblock_set_bottom_up(bool enable)
>  {
>         memblock.bottom_up = enable;
>  }
> @@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
>   * if this is true, that said, memblock will allocate memory
>   * in bottom-up direction.
>   */
> -static inline __init bool memblock_bottom_up(void)
> +static inline __init_memblock bool memblock_bottom_up(void)
>  {
>         return memblock.bottom_up;
>  }
>
>
> --
> Sincerely yours,
> Mike.
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/YFBYWjtWJrnGyiVp%40linux.ibm.com.



-- 
Thanks,
~Nick Desaulniers

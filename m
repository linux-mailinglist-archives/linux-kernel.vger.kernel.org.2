Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B241B5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbhI1SLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:11:39 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43652 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbhI1SLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:11:37 -0400
Received: by mail-vs1-f44.google.com with SMTP id n17so23057435vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr1N3OdR9r/bSiG1VxeyejkeCTjyewOKJdAHjGzabZA=;
        b=JfQvH8x9nNo54Kg5HNcyVuUUrpSshMOgPklbdeTgLoZGb9KTeZaAg4AX3Npg0QdLH3
         CeOCtJXhIRxocregBMg3UZphPL9AEke/AYIUuK4WcUoBuMB/fSn9OqiQzm9vG5OFdoid
         ORhQxZBOVi78PmSnfoJ64Bt3eXMTFp//EAFB8JtOghlr5NzHMdDZRKC6NyriQ7dVgvpv
         0+vAGHkgSzWoJJYeVkPBaf+DTneiME6520qpwy+oowEH+sgAWEtBWcQqQ8aZlBdkN5m5
         Zx1JJ3Dox/anJuHZWtutYfHXcc4QIhX3pOnC00glFk+bI61V4JECXVMjOUJ598c7bcLy
         i4nw==
X-Gm-Message-State: AOAM533EVRXlZSpuwVq+GcWdYFUiKFuLJTX0UnAq9ST75Sq+z6xI22gL
        VNh+MnM7rbpBxA7J5VACT+2edhgv4+gcbVWBscTY+ybA
X-Google-Smtp-Source: ABdhPJwN5gXFR0tjZSDhFmg+f0NFG4JJ6iP9/Qypk5MWyQdIWLY3eox0kHc0hmuU+a19StfWP+Ieloi5kCItsQ7douo=
X-Received: by 2002:a67:f147:: with SMTP id t7mr6925773vsm.41.1632852597572;
 Tue, 28 Sep 2021 11:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <202109282205.VsHhj6PP-lkp@intel.com> <CAMuHMdX0Zm_hMheZ0e1Xu991jnUr=aY_cDBHHGFvQ1sKqM1b9A@mail.gmail.com>
 <YVNGMg/TI+jo/1R1@archlinux-ax161>
In-Reply-To: <YVNGMg/TI+jo/1R1@archlinux-ax161>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Sep 2021 20:09:46 +0200
Message-ID: <CAMuHMdVfbAhCCxzKgbW1rPrzkS6Z7DU5vu4G6wTsBvHRb6yBpA@mail.gmail.com>
Subject: Re: drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, Sep 28, 2021 at 6:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Tue, Sep 28, 2021 at 05:39:19PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 28, 2021 at 5:09 PM kernel test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   0513e464f9007b70b96740271a948ca5ab6e7dd7
> > > commit: ade896460e4a62f5e4a892a98d254937f6f5b64c drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
> > > date:   11 months ago
> > > config: mips-randconfig-r013-20210928 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install mips cross compiling tool for clang build
> > >         # apt-get install binutils-mips-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ade896460e4a62f5e4a892a98d254937f6f5b64c
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout ade896460e4a62f5e4a892a98d254937f6f5b64c
> > >         # save the attached .config to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/kmb/ drivers/net/ethernet/mellanox/mlxsw/ mm/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
> > >    set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi
> > >    ^
> > > >> drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'
> > >    set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi
> >
> > These two functions are "static inline", so there should not be such
> > warning. Toolchain issue?
>
> No toolchain issue, Masahiro specifically made clang W=1 builds warns on
> static inline unused functions because of instances like this, see
> commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
> functions for W=1 build").

IC, I wasn't aware of that work.

Anyway, the "first bad commit" is the commit introducing the code, not
my commit enabling compile-testing (nor Yamada-san's commit to warn
about it ;-).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

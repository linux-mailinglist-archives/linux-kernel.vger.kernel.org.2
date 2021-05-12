Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3937B434
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhELCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhELCe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:34:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC2DB616ED;
        Wed, 12 May 2021 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620786822;
        bh=xqZbwCyE8nxSLmtMoLnpjhoPdg0FHuoWAMNJYrN/75E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F5h7bSy6043IfwzAJSDQVXQe7fzkrg5baNzjW2LRMTdWivNfxcL5Tt1iXAqZH/b5R
         zuFaFnWpzaawJr2VwreVIS0DEcsmcKQL5WkuxdV0+BcLRFhqP+NfRwn4czlj9UZ6of
         EYT2qZ3hBpC8MuuriJyKvz+k0dKZqab4iekLUVely4DHucdZoSiCFMM7S1GQ8bojHQ
         ae6EOgTRhtODZ0KEEZ8CaX2uCstKggN0l1jZueB6zPwx2j20vRrSMDues8Wm9YKBwl
         WC99NV4+WyYhsywL3Yo7/6F6UxWNyKcl2UnY74prx3eGknwtA1j/OC2uWdTFe+5TX2
         j5D7psdE6fDqg==
Received: by mail-lj1-f180.google.com with SMTP id v5so27666688ljg.12;
        Tue, 11 May 2021 19:33:42 -0700 (PDT)
X-Gm-Message-State: AOAM531fG/eOnEXTkU9Eagj4mGrgPeiAiru7Zpa75P0XdpZo/R1Ft1qh
        pRk8ZnA/4Vl2qdkEeU/e7n0Jqj7n1wW4f4caHe0=
X-Google-Smtp-Source: ABdhPJzFWd6QZalPnljkVBWzSRmWMEc6JwLshWOm2oZC+5mG3gQUUhWoaqrkSWMLSb457PwohEGWMm8Sbkma3Xx/z1M=
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr26598055lja.498.1620786821112;
 Tue, 11 May 2021 19:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210511132257.1272-1-wangjunqiang@iscas.ac.cn> <202105120013.CKxQukHu-lkp@intel.com>
In-Reply-To: <202105120013.CKxQukHu-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 12 May 2021 10:33:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSeG5AeytW5cyjsp+tVkK9RvRkz43HWbxWC-u2gg7PQCg@mail.gmail.com>
Message-ID: <CAJF2gTSeG5AeytW5cyjsp+tVkK9RvRkz43HWbxWC-u2gg7PQCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] csky: add CSKY 810/860 FPU instruction simulation
To:     kernel test robot <lkp@intel.com>
Cc:     Wang Junqiang <wangjunqiang@iscas.ac.cn>, kbuild-all@lists.01.org,
        Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 860 is on the way:
https://gcc.gnu.org/pipermail/gcc-patches/2021-April/569272.html

On Wed, May 12, 2021 at 1:15 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Wang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.13-rc1 next-20210511]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Wang-Junqiang/csky-add-C=
SKY-810-860-FPU-instruction-simulation/20210511-212648
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 1140ab592e2ebf8153d2b322604031a8868ce7a5
> config: csky-randconfig-r005-20210511 (attached as .config)
> compiler: csky-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/ba3d3b92b548373cb84c691=
5a02dda46ef1c5d38
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Wang-Junqiang/csky-add-CSKY-810-=
860-FPU-instruction-simulation/20210511-212648
>         git checkout ba3d3b92b548373cb84c6915a02dda46ef1c5d38
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s W=3D1 ARCH=3Dcsky
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> error: arch/csky/include/uapi/asm/siginfo.h: missing "WITH Linux-sysca=
ll-note" for SPDX-License-Identifier
>    make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm/siginfo=
.h] Error 1
>    make[2]: Target '__headers' not remade because of errors.
>    make[1]: *** [Makefile:1334: headers] Error 2
>    make[1]: Target 'headers_install' not remade because of errors.
>    make: *** [Makefile:215: __sub-make] Error 2
>    make: Target 'headers_install' not remade because of errors.
> --
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
> >> error: arch/csky/include/uapi/asm/siginfo.h: missing "WITH Linux-sysca=
ll-note" for SPDX-License-Identifier
>    make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm/siginfo=
.h] Error 1
>    make[2]: Target '__headers' not remade because of errors.
>    make[1]: *** [Makefile:1334: headers] Error 2
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
>    make[2]: *** [scripts/Makefile.build:272: scripts/mod/empty.o] Error 1
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
>    make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offs=
ets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1226: prepare0] Error 2
>    make[1]: Target 'modules_prepare' not remade because of errors.
>    make: *** [Makefile:215: __sub-make] Error 2
>    make: Target 'modules_prepare' not remade because of errors.
> --
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflic=
ts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconfli=
cts-rr]
> >> error: arch/csky/include/uapi/asm/siginfo.h: missing "WITH Linux-sysca=
ll-note" for SPDX-License-Identifier
>    make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm/siginfo=
.h] Error 1
>    make[2]: Target '__headers' not remade because of errors.
>    make[1]: *** [Makefile:1334: headers] Error 2
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
>    make[2]: *** [scripts/Makefile.build:272: scripts/mod/empty.o] Error 1
>    csky-linux-gcc: error: unrecognized argument in option '-mcpu=3Dck860'
>    csky-linux-gcc: note: valid arguments to '-mcpu=3D' are: ck801 ck801t =
ck802 ck802j ck802t ck803 ck803e ck803ef ck803efh ck803efhr1 ck803efht ck80=
3efhtr1 ck803efr1 ck803eft ck803eftr1 ck803eh ck803ehr1 ck803eht ck803ehtr1=
 ck803er1 ck803et ck803etr1 ck803f ck803fh ck803fhr1 ck803fr1 ck803ft ck803=
ftr1 ck803h ck803hr1 ck803ht ck803htr1 ck803r1 ck803s ck803se ck803sef ck80=
3seft ck803sf ck803st ck803t ck803tr1 ck807 ck807e ck807ef ck807f ck810 ck8=
10e ck810ef ck810eft ck810et ck810f ck810ft ck810ftv ck810fv ck810t ck810tv=
 ck810v; did you mean 'ck810'?
>    make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offs=
ets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1226: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:215: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for LOCKDEP
>    Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER ||=
 MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>    Selected by
>    - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>    - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

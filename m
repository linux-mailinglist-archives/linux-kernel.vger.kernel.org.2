Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FC388E24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbhESMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhESMfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:35:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE7D6108B
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621427629;
        bh=7CPIGIQvezLC1c9ITFa2R7RXJhwogSY4l6pRpvXCCyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hEdMUhXvTUqUawnnQvOXNT5PT/qWopRqoelhPllIBcuNkvrskvBe22OHRWDW6h8fU
         9inKA1tPckNguB+v48Xua8bxy2JtUUHy1pncLjhhZFuNCVWkKy4XNPXJlbaDKmPEkw
         fHcDf9TEmbIxlnvg/JK65PhQhcx25/19MzigZrmrpTDf+eMdXU13geqpw1kpanxwCt
         tfP6HS+66rlds+aVgGORxNJ1a6U5WWsnuavTtHgvT9D7ClrKDoFFRpoHk4IxBZdRcX
         +BmdaC+rB36Re7hQgeCN0pnIWLIciZ3n9J0di7oqmk62FT9vQ6pnX2XNjdFGrT47nn
         Bf62LTADuF6Rg==
Received: by mail-wm1-f42.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so3362995wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:33:49 -0700 (PDT)
X-Gm-Message-State: AOAM531F2+sllQyqrMiVr30n1F/GI1oKzDW9EKYuzlZuxW+4T3k3Latn
        7z5mX27Dl+JCkCE1x9OhtYrHzs062icnahErco0=
X-Google-Smtp-Source: ABdhPJxKzG3pycmHewy5Fq6E/mda5o70tHjzY9owaaCQwm0sQOcDLPbn65c9WNrBm1ZZfGsUfPuXDINXnn+6wNzHZDI=
X-Received: by 2002:a1c:9895:: with SMTP id a143mr11003201wme.43.1621427627819;
 Wed, 19 May 2021 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <202105112356.JuDlybKz-lkp@intel.com> <CAKfTPtB9B9jv_uSk0fS7uOTtH5FCwLcAOrPjtXzRuURLUMFnoA@mail.gmail.com>
In-Reply-To: <CAKfTPtB9B9jv_uSk0fS7uOTtH5FCwLcAOrPjtXzRuURLUMFnoA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 19 May 2021 14:32:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YVh=hoBthjH7N=mSXOi0fEdwvyuHUJ36qricqVUZ9jA@mail.gmail.com>
Message-ID: <CAK8P3a0YVh=hoBthjH7N=mSXOi0fEdwvyuHUJ36qricqVUZ9jA@mail.gmail.com>
Subject: Re: kernel/sched/fair.c:9551:12: warning: stack frame size of 1376
 bytes in function 'load_balance'
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 3:45 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 11 May 2021 at 18:01, kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
> > commit: 0826530de3cbdc89e60a89e86def94a5f0fc81ca sched/fair: Remove update of blocked load from newidle_balance
> > date:   9 weeks ago
> > config: mips-randconfig-r022-20210511 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a0fed635fe1701470062495a6ffee1c608f3f1bc)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0826530de3cbdc89e60a89e86def94a5f0fc81ca
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 0826530de3cbdc89e60a89e86def94a5f0fc81ca
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips
>
> It was a bit difficult to find the warning among the thousand

I opened an issue against clang about it:

See https://github.com/ClangBuiltLinux/linux/issues/1379

but then found that this is already known. I think it would be best to
make the kernel test robot
set CONFIG_COMPILE_TEST to avoid issues like this. I have annotated a
number of symbols
that are known to cause unnecessary false positives in a similar way
to get a clean build.

        Arnd

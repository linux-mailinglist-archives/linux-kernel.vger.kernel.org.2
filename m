Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B20D409A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhIMRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhIMRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:01:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:00:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j12so18490686ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrGAcwwTUwAfpY/24fWLxW114H7zq5jNLexfHma71jY=;
        b=mHAp4peCIYAwNG5WNuKgb3pHkoOfCgtS1Yiu+1wpKhX5XhhvReydT9+OXRhmkBWTVt
         Ue/G6xc2TPg0aRNhhexVlIDCBI1s9BxJ9GN8GuRjRfdr5WqNT0mBbZVLTprD4aVrECxm
         RvtGqmfK8DbTM6d/EU9EFSB+gtN37H84ocYYCsUNXY9gSEzR5Q2q33Gw3d9WNURu36dY
         dfdYnVf6O4c6eWtUYg02qPBEUAUMsne4IQQQl3NkLdn4uAMDpfq26547HRtDEsbJF1Ag
         /nmszn7VajgH9HHZhUKZ98eirDph23GHXV2Bgiau2c6j+pacusJ2syJlheoQnEux+20c
         Hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrGAcwwTUwAfpY/24fWLxW114H7zq5jNLexfHma71jY=;
        b=yYcP9HjwVAhyiGC+TGLx9FPMfpeNL0QhclLWnnrlUp3ZBLqNdVNEA4AE1KlR1ussmZ
         6u1rgIdWQXzk1B/z4fnsiGXg6NGql5Msa4qVPNv1oK11xIC7SIpxwURVLz3PeA90rtMk
         bJ7snKsO8oo6VBWsp5iA20uDCf2H5e+7ZQA5OUKdjugqKCIMSABbPjV6sgjcxBs4Tm4j
         1X/ljgK9004u15RiU9Xqk04ITWSnwiNwUfszoq6H+x5hjDTd76uRTSXXWukraK0YZ+NM
         m4FarJFjPf1YCfPra7NOefgbROttqymnmE8pVey5dXzRhuZ8p83j0yJUbCOhXa4eAJxI
         wVwA==
X-Gm-Message-State: AOAM532j6d+TzZRxazS5V0hTyERUtiwpSJKn2g3hf95MO7kJ5SbavFXj
        2FMSVBhZt8fQo4asIZxUYfFjDwGH/mJCTWj41mpqnj6HLuLrYA==
X-Google-Smtp-Source: ABdhPJzoiNYIDIZade21ErQ+cWwkQb5QbnppgTRQJiF/5A71DI6icZ4c9Fh8syGhQUQvbgecet9vm7FdrolvNg/ovAc=
X-Received: by 2002:a2e:99da:: with SMTP id l26mr10864789ljj.339.1631552413892;
 Mon, 13 Sep 2021 10:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <202109112002.NZceUwiC-lkp@intel.com> <20210913165317.GX2505917@nvidia.com>
In-Reply-To: <20210913165317.GX2505917@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Sep 2021 10:00:02 -0700
Message-ID: <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert
 expression is not an integral constant expression
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:53 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, Sep 11, 2021 at 08:17:08PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   926de8c4326c14fcf35f1de142019043597a4fac
> > commit: 84f969e1c48ed3825986e91a0786e363d57f69d1 IB/qib: Fix null pointer subtraction compiler warning
> > date:   3 days ago
> > config: x86_64-randconfig-a014-20210911 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84f969e1c48ed3825986e91a0786e363d57f69d1
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 84f969e1c48ed3825986e91a0786e363d57f69d1
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert expression is not an integral constant expression
> >    QIB_DIAGC_ATTR(rc_resends);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/infiniband/hw/qib/qib_sysfs.c:406:16: note: expanded from macro 'QIB_DIAGC_ATTR'
> >            static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
> >            ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> >    #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> >                                     ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> >    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> >                                                           ^~~~
> >    drivers/infiniband/hw/qib/qib_sysfs.c:413:1: note: cannot access field of null pointer
> >    drivers/infiniband/hw/qib/qib_sysfs.c:406:43: note: expanded from macro 'QIB_DIAGC_ATTR'
> >            static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
> >                                                     ^
> >    drivers/infiniband/hw/qib/qib_sysfs.c:414:1: error: static_assert expression is not an integral constant expression
> >    QIB_DIAGC_ATTR(seq_naks);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Nick/Nathan
>
> Clang is being a real PITA here - do you know of a solution?

Hi Jason,
Thanks for wrestling with this.  We filed a quick thread last week to
track this:
https://github.com/ClangBuiltLinux/linux/issues/1452
With conferences this and next week, and -Werror fallout, there's a
lot of fire right now and not a lot of time to triage.

I guess I'm curious, what is the intent of what this code is trying to
do, and can this be replaced with BUILD_BUG_ON?

>
> This macro would like to know that the passed in member name has a u64
> type, all the things I've come up with fail on clang - but many work
> fine on gcc. Frankly I think this case is a clang bug myself..

Perhaps, though this assertion looks a bit like offsetof() to me. I
wonder if that can help here?
-- 
Thanks,
~Nick Desaulniers

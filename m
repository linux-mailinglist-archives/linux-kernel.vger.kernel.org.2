Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71427345AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCWJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:24:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCWJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:24:41 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6YEz-1lHkRt04CX-006uhR for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021
 10:24:40 +0100
Received: by mail-oi1-f178.google.com with SMTP id w70so16301258oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:24:39 -0700 (PDT)
X-Gm-Message-State: AOAM532hSlNViU+vCGGJotQ+5F9AazEH425ULH2Pxpp4OKzIcDyHyaGy
        /RbLmkL0yEEPmpU80mrndl01oivPKwKiZ7R51g4=
X-Google-Smtp-Source: ABdhPJzkjT06QHKssuQjlo3Ttjd+0UF9EMTv3asSeiVjCUUJqhG1uKKwGKxBDanCZmib+FBO7zmGWor5ud5WR7JkE0c=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr2735713oie.4.1616491478766;
 Tue, 23 Mar 2021 02:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <202103231438.XJtqZjmF-lkp@intel.com>
In-Reply-To: <202103231438.XJtqZjmF-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Mar 2021 10:24:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wQzLv47RGV-9n0EfTNpwE_E_VgCE57+tYeguWhJXitQ@mail.gmail.com>
Message-ID: <CAK8P3a3wQzLv47RGV-9n0EfTNpwE_E_VgCE57+tYeguWhJXitQ@mail.gmail.com>
Subject: Re: drivers/net/ethernet/chelsio/cxgb4/sge.c:2396:13: warning: stack
 frame size of 1168 bytes in function 'ethofld_xmit'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vj68oROUKyzKyFGk5rGAXs8YAiS688oILFrM55JzZHiXsc9l1eP
 aQ+FTBmbzuwV9mXgK8cXHDUq12HM8ZQrx4TUjlV+R22qTr8qXNkWXLOWRBfXsLEvwa2eOl+
 e1PxRUWHLjEUuHnrYjmyzAyECk9cSCOy2Sh9UvT2M8MEfH1PyTcbM1mc8QFJ4ad8RY5GutY
 e2F0R4FQYb2N15B/hnKfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pn8MX7B0eno=:/n7M/L2jjbYz1JwHWOlN3s
 PBwHNYhaue0qJY06u1XUsshjSHnwlR9i5F/AulVB3tAXdPJbwUD2m5Ozy9Mfyz3Y7aqT2ILcj
 Si1MEp2po7smIHr6wabRnJO0DVdTx2AQ8kG7taKMocPnaH1TxC5Xy6t7j8Rnl1zjtjdNXmS0X
 biXjqMzyabhJExLmAyT5tOoFEO19zucwpFU27c4NvXzogA+IuM8FUmt7nxc5S5Q4B9uGOmyyE
 dRh2iysHR203iIOMIA0X/pyPPAE0oTILkt49nC9YS7lJQWTSzC2J77kA0lgL6NOxonIRPn2Rq
 aKdxBrZqqXIHQS29mQf6yDKKD9hKrRcG5eqGvZANKZJ3ozcmfgw1oqdF1BiErTLZxA2Cy4dvR
 A3HvK5aYJ7pN1H5Xh1WW+jYR7++wLqnF2OnmEYnwebYg2Vwpjr+RB0AVfI1XWMBY3oCTcHHKu
 XpY5+YTymh78bolO96vXUtuGl8BoUm5lhqQL07W9smxLY6yUSAig5GJQwgDM4Vu+H4itledlc
 oPEBNqpgrDJHT/P34zrkY2JxEmJQ6f0gGF09pxcmCqO4WkSv9m34x9WX6Zyifu+8A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 7:37 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   84196390620ac0e5070ae36af84c137c6216a7dc
> commit: 97e4910232fa1f81e806aa60c25a0450276d99a2 linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
> date:   9 days ago
> config: mips-randconfig-r023-20210322 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 78a65cd945d006ff02f9d24d9cc20a302ed93b08)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97e4910232fa1f81e806aa60c25a0450276d99a2
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 97e4910232fa1f81e806aa60c25a0450276d99a2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/net/ethernet/chelsio/cxgb4/sge.c:814:28: warning: unused function 'calc_tx_descs' [-Wunused-function]
>    static inline unsigned int calc_tx_descs(const struct sk_buff *skb,
>                               ^
> >> drivers/net/ethernet/chelsio/cxgb4/sge.c:2396:13: warning: stack frame size of 1168 bytes in function 'ethofld_xmit' [-Wframe-larger-than=]
>    static void ethofld_xmit(struct net_device *dev, struct sge_eosw_txq *eosw_txq)
>                ^
>    2 warnings generated.

This looks related to a warning we saw on powerpc. I've tried digging
into it a little
bit more, but all I found is that the use of __builtin_bswap32() changes the
inlining decisions but doesn't actively cause worse code.

In fact, if I force the inlining like this:

--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2257,7 +2257,7 @@ static void *write_eo_wr(struct adapter *adap,
struct sge_eosw_txq *eosw_txq,
        return cpl;
 }

-static int ethofld_hard_xmit(struct net_device *dev,
+static __attribute__((flatten)) __always_inline int
ethofld_hard_xmit(struct net_device *dev,
                             struct sge_eosw_txq *eosw_txq)
 {
        struct port_info *pi = netdev2pinfo(dev);
@@ -2393,7 +2393,7 @@ static int ethofld_hard_xmit(struct net_device *dev,
        return ret;
 }

-static void ethofld_xmit(struct net_device *dev, struct sge_eosw_txq *eosw_txq)
+static noinline void ethofld_xmit(struct net_device *dev, struct
sge_eosw_txq *eosw_txq)
 {
        struct sk_buff *skb;
        int pktcount, ret;

I see a different effect: the function's frame grows to 2232 bytes with the
open-coded bswap32 slightly less at 2200 bytes with the builtin bswap32,
all because of too many variables getting spilled.

On the other hand, marking ethofld_hard_xmit as flatten+noinline, I don't
get these spills with either version of bswap32, and the stack usage of
ethofld_hard_xmit()/ethofld_xmit() goes down to 472+112 bytes.

If I remove -fsanitize=alignment, the total stack size for these functions is
no more than 368 bytes regardless of the inlining or the bswap32()
implementation.

I would conclude that there is something wrong in clang that leads to badly
optimized code in this file, but that my __builtin_bswap32() change is only
what triggers the right conditions here, not the root cause.

        Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E132941A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbhCAVrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbhCARXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:23:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FAC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:22:27 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o11so10670281iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EwKg80MLnuasfcujpzhyzwoNIEZZ7+pbJM40fdjDf4=;
        b=H+MBoDAZ1daiKv5GTnXamavbgWErHeIXezrE7UJFZRZxdl13u1QUgfAIQussSTuVvP
         lrj9EpVc2O4P+FOAZaTOqbPRa85h4l7I4YoZt87/OFu201mImTGbRwscmBT/X9kriTBf
         6Ps/16BDLI1GcX9i9deN+UO5kZBjvrdZrV6wVj6nMtxAE1uESID9zZqD791h5iZhj9Vi
         TGkjcfBga5ew0uRxsglrOyoY6p1q08/CTmktRYudgwpBgk+EEiqLSF8Xsizanp+W3oJL
         HzI1gOSMOow2STNHe1hsVKdmpsw7RuiTP8nhQWOW1+73pjnrncN15C1hPMKG9Nyw0D1K
         YV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EwKg80MLnuasfcujpzhyzwoNIEZZ7+pbJM40fdjDf4=;
        b=lOwpLs7czEbZeWjG+JhgEFljIz7eIcP1CZwxwG5r4mvj4dfSZmPks9MIS/b24Z5XZz
         e+mYuHXi7phB5XYbd/+h2bTU8DssjuZLd2pgjnka8rlBOrjdIy68Wecwpj/0zQf0r3DH
         AjehkAgk/JZnSJtiR2NkwzKENja4ITctv3b+KJTk1LR7+FIXOmMlYNYKc9LpkISJU7pw
         zoH6A6brzcevUFV1b1+95Bt81n6k31VbX8gvbWRcVZOfUaCATmNUmxZ3nzBeGHEhkOIt
         7zXK8qPqhHiC2mv1R/BNMu/CT2V3T3cELn5TbYP06B3gMa7jSSXvBtkGmpDpl7Im1dmn
         yAnw==
X-Gm-Message-State: AOAM533+VW6HEdeL1M0kUC+8tC7vUlrtDVAndmNcz46f92g9v5ZR38ef
        5frs0pZaQzN5mjWoW9MLH8+fZ+LM1LS5j+ydA8JOrg==
X-Google-Smtp-Source: ABdhPJzSgM2cqzH+Bbpm+78dSY425PxfW5lfkpsdYLshi+9XCUS2e7mtwppj9kQEbTNSqmKHj8IgXZsLcnDanUNRPzU=
X-Received: by 2002:a05:6602:2486:: with SMTP id g6mr14411979ioe.134.1614619346724;
 Mon, 01 Mar 2021 09:22:26 -0800 (PST)
MIME-Version: 1.0
References: <202102280728.9KxiUPjh-lkp@intel.com>
In-Reply-To: <202102280728.9KxiUPjh-lkp@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 1 Mar 2021 09:22:15 -0800
Message-ID: <CANgfPd8K-SmOYjQgubn0NjtxmLXnyLafMTCQ6KppiWR7ZeOYig@mail.gmail.com>
Subject: Re: arch/x86/kvm/mmu/tdp_mmu.c:533:9: sparse: sparse: cast removes
 address space '__rcu' of expression
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the __rcu tags aren't being propagated around to all the
different references to PT memory. I'll look into what it would take
to fix this. I don't believe these kernel test warnings indicate a
correctness issue in the kernel, but propagating the __rcu annotations
will be helpful for developers in the future.

On Sat, Feb 27, 2021 at 3:48 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5695e51619745d4fe3ec2506a2f0cd982c5e27a4
> commit: 08f07c800e9d35b59d0c8346333f189160bd67d4 KVM: x86/mmu: Flush TLBs after zap in TDP MMU PF handler
> date:   3 weeks ago
> config: x86_64-randconfig-s022-20210228 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-241-geaceeafa-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08f07c800e9d35b59d0c8346333f189160bd67d4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 08f07c800e9d35b59d0c8346333f189160bd67d4
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> "sparse warnings: (new ones prefixed by >>)"
>    arch/x86/kvm/mmu/tdp_mmu.c:459:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:459:49: sparse:     expected unsigned long long [usertype] *pt
>    arch/x86/kvm/mmu/tdp_mmu.c:459:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:291:9: sparse: sparse: context imbalance in 'tdp_mmu_link_page' - different lock contexts for basic block
>    arch/x86/kvm/mmu/tdp_mmu.c:316:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_page' - different lock contexts for basic block
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     got unsigned long long [noderef] [usertype] __rcu *
> >> arch/x86/kvm/mmu/tdp_mmu.c:533:9: sparse: sparse: cast removes address space '__rcu' of expression
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:487:40: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *root_pt @@     got unsigned long long [noderef] [usertype] __rcu * @@
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     expected unsigned long long [usertype] *root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:654:51: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt @@
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     expected unsigned long long [usertype] *sptep
>    arch/x86/kvm/mmu/tdp_mmu.c:560:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] root_pt
>
> vim +/__rcu +533 arch/x86/kvm/mmu/tdp_mmu.c
>
>    509
>    510  static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
>    511                                             struct tdp_iter *iter)
>    512  {
>    513          /*
>    514           * Freeze the SPTE by setting it to a special,
>    515           * non-present value. This will stop other threads from
>    516           * immediately installing a present entry in its place
>    517           * before the TLBs are flushed.
>    518           */
>    519          if (!tdp_mmu_set_spte_atomic(kvm, iter, REMOVED_SPTE))
>    520                  return false;
>    521
>    522          kvm_flush_remote_tlbs_with_address(kvm, iter->gfn,
>    523                                             KVM_PAGES_PER_HPAGE(iter->level));
>    524
>    525          /*
>    526           * No other thread can overwrite the removed SPTE as they
>    527           * must either wait on the MMU lock or use
>    528           * tdp_mmu_set_spte_atomic which will not overrite the
>    529           * special removed SPTE value. No bookkeeping is needed
>    530           * here since the SPTE is going from non-present
>    531           * to non-present.
>    532           */
>  > 533          WRITE_ONCE(*iter->sptep, 0);
>    534
>    535          return true;
>    536  }
>    537
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

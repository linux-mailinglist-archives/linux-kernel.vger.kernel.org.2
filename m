Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F93DB152
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhG3CvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG3CvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:51:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A6EC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:51:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yk17so6359769ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBVECk4Cf8zNQ/paNSAey4afTOvfduBc6GZ0rSNn0hE=;
        b=vpWrE9KO4tHiiCYQjSVFBolVW7yjOwQUOv3Vw/UpWP1G4jOXNfNfvuKanQeDkD4+v2
         QZJ17x+GjYpdBxMHHED04X8ToVGTDbUzohC0T4Q7JnTWn9PytuurRD6lNZBVCBITinXc
         U6xHO8ggtGfuAT01YAEt0bl+X7DEDHVOgCyg/f/uM0EWUxrzfXl67B9HJ+d8GUiU2dIv
         QBr6F3mDJCeomwaEsWDVeWLQz+lxye/5FaWBiL02saXweGHzNwE6eN5yJ0PyIT0BLXyd
         NjfOHc88X0Xy2U9s1zBTMC0oA/KTQLlapD3Bg+/8RLr+5eWntQ/w4unNShGvM/ACU/XC
         wzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBVECk4Cf8zNQ/paNSAey4afTOvfduBc6GZ0rSNn0hE=;
        b=Y/8e2kgKUgq/zf8JhXfzr4PForLoB3UTw6VVWOQCRzhOBFRXSsSzlbwKH7U4ZcNoeG
         ymfYyD6sWaDkE5aCr0/5hHBaFOgwyM0vubAbbl/zncpClPRbqOMBLkMnsLPQT/+DVSA1
         Q5O6PfNV2yXftIK+9fG6AgRLxu1gu6Me9pFLrvXnRmrJvR62V6A5te1jYlML77rnh4tJ
         bLbipd0t++wZ0KMYCOzohttNctSlB5RxKzkjdRhXqPfkIv2bRAlJS3Zh7rEv8KTL8Io1
         EoWPxfGXcuzORu31Btxi0YbQ3EmuQaX8kWqqCabHBYDCI0Ax8gJAhwpuZTJWi0WKVoy3
         IYVw==
X-Gm-Message-State: AOAM531yRlgoO+XOz0lP6G9wt7YdBX/Y/LrmfCsKWnq4GBfv8Q1OvGqw
        DyAwJ6almhjzliAsH81q0zDQ4jeI6yMrGG3cbSlLtQ==
X-Google-Smtp-Source: ABdhPJy3+a+e2wwQdj59UrZ9/47KrLg15NfqpJAqivUuCzE5Y3HU1JK8vKlH+vv055cXM5hWqFF4SzJhA7qdu/3x8Tk=
X-Received: by 2002:a17:906:f20a:: with SMTP id gt10mr439083ejb.267.1627613464372;
 Thu, 29 Jul 2021 19:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210729093003.146166-1-wangrui@loongson.cn> <20210729095551.GE21151@willie-the-truck>
 <CAK8P3a3ru0VSYLohoFOd=P=Fjb8BS=1qpMGSf4jdxF4oxmH-ag@mail.gmail.com> <20210729123522.GB21766@willie-the-truck>
In-Reply-To: <20210729123522.GB21766@willie-the-truck>
From:   hev <r@hev.cc>
Date:   Fri, 30 Jul 2021 10:50:53 +0800
Message-ID: <CAHirt9iYhmQPjMNn_RxBib8fumR0RhjVoBN1ggGm-9MSMHu4Rw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 8:35 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 29, 2021 at 01:43:41PM +0200, Arnd Bergmann wrote:
> > On Thu, Jul 29, 2021 at 11:56 AM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Jul 29, 2021 at 05:30:03PM +0800, Rui Wang wrote:
> > > > This patch introduce a new atomic primitive andnot_or:
> > >
> > > Please see my other comments on the other patches you posted:
> > >
> > > https://lore.kernel.org/r/20210729093923.GD21151@willie-the-truck
> > >
> > > Overall, I'm not thrilled to bits by extending the atomics API with
> > > operations that cannot be implemented efficiently on any (?) architectures
> > > and are only used by the qspinlock slowpath on machines with more than 16K
> > > CPUs.
> >
> > Wouldn't this also help improve set_mask_bits()? That one at least has
> > a handful of users in the kernel.
>
> For pure LL/SC architectures, yes, but I don't think it helps anybody else.
>
> Afaict, an architecture can already override set_mask_bits, so why do we
> need to add this primitive to the atomic API?
>
> Will

So what's next?

Now the set_mask_bits return oldval, return newval before 5.0. :-D
commit 1db604f676b("include/linux/bitops.h: set_mask_bits() to return
old value")

Regards,
Rui

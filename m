Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB9C435B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJUHWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJUHWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:22:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3578160F5D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634800808;
        bh=43pO5T59WNNBTSvDZ/15HN0qNsYc6BB2mYcutQPQZb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qZP8Wqy8lCgm9a+nKCbcfyHPOmEg3+15OtkUCE3DxCGYuYryfaUirXhVm2V3a8hOI
         1WS4O0ynItYO1us2GdYv0lkmFKSFZUTC0et7YKyf7wFUjfrugVBWZGbjbaqP8NGqBz
         o82zKA8WlbVSb3tf+iIpAgeUWBZhwdUyeriOgmTfHxkgUL4t/KhjHlt5efUIhoV159
         QWZcE1lL+RaAZKvcaWRiSvrwwEN8XaIjetyHj3u9rLqnhvYvxpGvQb5KedTCj2Vijm
         UCyBgNsx2y9dxhBwyiNaWTrgwszFi3n0wSBYTrRk+k7AILaMNV5o0XEqZais9FWMac
         podF1KzE4BdAA==
Received: by mail-wm1-f52.google.com with SMTP id v127so21902944wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:20:08 -0700 (PDT)
X-Gm-Message-State: AOAM533REDwHDJ801za7sfnyj9cceM5ojBi5YDbQZ8QYDXy4dhaUbLKb
        N6aP06tIBGZCbNE2XRKFsIH3Qanv1C3pkNXlwhw=
X-Google-Smtp-Source: ABdhPJw/z58fZLDJTbPf9HpyiDZ54iUJbEkQ5PNF/R2XdWkDlPbJwN5mSyp4ngOeqZsP6n0kxAo5a9Zj4ZQ70Y91Lvg=
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr19235671wmq.82.1634800806678;
 Thu, 21 Oct 2021 00:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <202110051030.J3Ub7djT-lkp@intel.com> <CAK8P3a3uOV=AMmOTP09rBhyq2zJutDJiof-4uQ-7MbX9xyVivg@mail.gmail.com>
 <CAMj1kXHem8-qpNswtRcEKErncpO65JpQJQL3-8k_-qzUm4S4_Q@mail.gmail.com>
In-Reply-To: <CAMj1kXHem8-qpNswtRcEKErncpO65JpQJQL3-8k_-qzUm4S4_Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Oct 2021 09:19:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yRTcRgVD_o7YCwKckePPPcy9Btneh6TC1b_ThUzkmtg@mail.gmail.com>
Message-ID: <CAK8P3a1yRTcRgVD_o7YCwKckePPPcy9Btneh6TC1b_ThUzkmtg@mail.gmail.com>
Subject: Re: [ardb:arm-vmap-stacks 5/20] arch/arm/mm/context.c:112:28: error:
 no member named 'task' in 'struct thread_info'
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 9:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 21 Oct 2021 at 08:55, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Oct 5, 2021 at 4:03 AM kernel test robot <lkp@intel.com> wrote:
> > >
> >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> arch/arm/mm/context.c:112:28: error: no member named 'task' in 'struct thread_info'
> > >            pid = task_pid_nr(thread->task) << ASID_BITS;
> > >                              ~~~~~~  ^
> > >    1 error generated.
> >
> > I ran into this as well on my randconfig builds, though it happens very rarely.
> >
> > Apparently CONFIG_THREAD_INFO_IN_TASK is incompatible with
> > CONFIG_PID_IN_CONTEXTIDR, but should be easy to fix by changing that
> > one line to do the right thing.
> >
>
> None of the existing configs enable that, so that is why I never saw
> this even with all the kernelci coverage.

Right, I have no idea what makes this configuration so rare, it took me
hundreds of randconfig builds before I first ran into it.

          Arnd

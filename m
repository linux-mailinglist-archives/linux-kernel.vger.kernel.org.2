Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B0435B47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhJUHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhJUHFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D293F61183
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634799764;
        bh=N9e50nuGo9dSlul8hisBaWU2MocV5pjunVpoO9qay7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JVbYV5yaOD1l+L4/Q4dYLTvdACbOH0039wVQIwg9X5hDmjxctc+CnLrsB3Q3aeCfK
         uw/hh57wW2fvzaQIarNnC+KJ9rOJsEEzL+wjBm2vEmjTESoOv58HgGrObi0x1ywxvE
         Kknneu54qtxoYyZ8lmh2O2WuRmaFP+Ieg+SLTOYTTdCulTyRLmt2uwyfB19J/wEyxC
         p8wfvwG5EdAt1Np3vybY77kyED3YiaQmnZLnYh8N+4xspBKd4lQMgaGNelbzDbW9Jb
         mdEJ8hxCJ0mIFJEuyvPC4YcH3EKolSYPvMIy8zHN0B4tPvGM3WpmBV73x+LyQg1VvE
         RH85UtXHFzR9Q==
Received: by mail-oi1-f170.google.com with SMTP id g125so12598151oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:02:44 -0700 (PDT)
X-Gm-Message-State: AOAM533TOL+yjE0CE+eTlC5b50ngOZFeGhZ3c3QeJ3HH+xU8MLmSS/LY
        1TTVTDIroKyJxMoQBRZAXc8Hyi14G1x5EKcvB7k=
X-Google-Smtp-Source: ABdhPJwVwdSM2DTKCeM6BAPs5VX1qV2yThkHPYhwqe1jU0c3k6dzi9ulQUHRzIKTwb3+xBoR5e3pMSC1PHg0buy6vFk=
X-Received: by 2002:aca:4bc4:: with SMTP id y187mr2922485oia.174.1634799764139;
 Thu, 21 Oct 2021 00:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <202110051030.J3Ub7djT-lkp@intel.com> <CAK8P3a3uOV=AMmOTP09rBhyq2zJutDJiof-4uQ-7MbX9xyVivg@mail.gmail.com>
In-Reply-To: <CAK8P3a3uOV=AMmOTP09rBhyq2zJutDJiof-4uQ-7MbX9xyVivg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Oct 2021 09:02:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHem8-qpNswtRcEKErncpO65JpQJQL3-8k_-qzUm4S4_Q@mail.gmail.com>
Message-ID: <CAMj1kXHem8-qpNswtRcEKErncpO65JpQJQL3-8k_-qzUm4S4_Q@mail.gmail.com>
Subject: Re: [ardb:arm-vmap-stacks 5/20] arch/arm/mm/context.c:112:28: error:
 no member named 'task' in 'struct thread_info'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 08:55, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Oct 5, 2021 at 4:03 AM kernel test robot <lkp@intel.com> wrote:
> >
>
> > All errors (new ones prefixed by >>):
> >
> > >> arch/arm/mm/context.c:112:28: error: no member named 'task' in 'struct thread_info'
> >            pid = task_pid_nr(thread->task) << ASID_BITS;
> >                              ~~~~~~  ^
> >    1 error generated.
>
> I ran into this as well on my randconfig builds, though it happens very rarely.
>
> Apparently CONFIG_THREAD_INFO_IN_TASK is incompatible with
> CONFIG_PID_IN_CONTEXTIDR, but should be easy to fix by changing that
> one line to do the right thing.
>

None of the existing configs enable that, so that is why I never saw
this even with all the kernelci coverage.

I'll send a patch to fix this.

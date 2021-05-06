Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0E3755B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhEFOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234002AbhEFOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D2CB613C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620311489;
        bh=PeA2L4rCIen/I3ke1UnmLtRTGivZxcELOrycUhqdHAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fXD3/CY/gbX4K69U9WRyFRoZKFujjh/VmHGskZYSI4OUl/RKLEa36WA8csAbI3H+K
         Zxzr4AqAR5iKpOQUvTQQXHiZg762Z8Q9tMxvADb2PMpg/c/TFAOls7jhiBojVctA52
         wyF7ch5YzMsepzoYe+iE1nNLq/4n5KlSCELiO6uzn8pN05o+UoES1je0owfyg5f2kh
         l+JjQrzenxqwMoanaDP78kDx4QML3PCalQoSPfnOf5N8zOuSeidhZHcmmSm+wfKIPw
         QEQX5dpSzKMD4obhkxhPtQWHQyP3kL8OfJqfwk44a75D5EgdK2RvyIXoYOKb7yTRFf
         caAFwWcqHlX+A==
Received: by mail-wr1-f52.google.com with SMTP id d11so5854777wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:31:29 -0700 (PDT)
X-Gm-Message-State: AOAM530V0xY2L8tSaxp4lCkznvYXSa3dw6MIA5BppMoMtMVvSFHtes2S
        yuYBBhWPMn9CFB0uDK1rhZOjocP7yY47GZTdh34=
X-Google-Smtp-Source: ABdhPJzx7JT0wobUYUDqy695yNwJs0M8UbUKzaFX3dgLKpbqrLXh7LgUpsCPgzAYiPW7KNY1rvB06FG78OKf49Lr9F0=
X-Received: by 2002:a5d:4452:: with SMTP id x18mr5773518wrr.286.1620311487652;
 Thu, 06 May 2021 07:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210505211300.3174456-1-arnd@kernel.org> <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com>
 <877dkcs2h8.fsf@yhuang6-desk1.ccr.corp.intel.com> <CAK8P3a3kZ9_VoKV+2eZh=WqncRqFKzRmRHUjAT9iFMtJpKzb1w@mail.gmail.com>
 <87pmy4qdb9.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87pmy4qdb9.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 6 May 2021 16:30:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36r9S_AYfp8Myf+3sfHvGVsBM36HmdoeVFi9BaNdS9Lg@mail.gmail.com>
Message-ID: <CAK8P3a36r9S_AYfp8Myf+3sfHvGVsBM36HmdoeVFi9BaNdS9Lg@mail.gmail.com>
Subject: Re: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 2:03 PM Huang, Ying <ying.huang@intel.com> wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
> > On Thu, May 6, 2021 at 10:14 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> We cannot avoid type cast in Linux kernel, such as container_of(), is
> >> there some difference here?
> >
> > container_of() does not cause any alignment problems. Assuming the outer
> > structure is aligned correctly, then the inner structure also is.
>
> So you think that the compiler may generate different code depends on
> the data structure alignment (8 vs. 32 here)?  I think that it doesn't
> on x86.  Do you know it does that on any architecture?  But I understand
> that this is possible at least in theory.

It probably won't generate any different code because that would be silly, but
it's also not a good idea to rely on that. In theory the compiler might e.g.
construct an offset into the structure using a bitwise-or instruction instead of
an addition if the alignment tells it that the lower bits are always zero.

        Arnd

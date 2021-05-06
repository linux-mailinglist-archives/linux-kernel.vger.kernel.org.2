Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220E3750E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhEFIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhEFIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D41613BA
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620289895;
        bh=tXoVVhjMUlqtpW3yZ+4IlGtS4t3/pnMFT/53JNA7qRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YQcghHsUBUdRYVj63qX5JqPfgwar7Q+0InI1U2ymGYvDBNauESDgXfrws+AuqX7QD
         MAO+nQI/m9pM7kABDkPe04LITaLqmY7qjpYLbDj5lcQHlb9nu15z2cbeZ1oTxWqLfD
         6smnk05vfRhHga/+5MsSkuYGAdLyS5U4aC0hFRQb5mum+/wzvZK1HuNliXIdD+RJ/z
         2gcmcw5RE1P7UPnCKrg9e9AxhDwx+yq/hawOFC7KPRyEeJd68vGjSwFzCWAzbwW2mH
         ounIGIzaSjm500C1/pQ4VHVw0QjWvvmLCS5mwfa5kPDzshPiE5FzjiVQtvegM42sNJ
         SUYNiRl+zVzxg==
Received: by mail-wr1-f49.google.com with SMTP id z6so4650416wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 01:31:35 -0700 (PDT)
X-Gm-Message-State: AOAM5307dV3DS8d5FL2Gm7EJfTIS0Lv4otR6Nzr26N9YFa6vXx8HEOr1
        YqLpUIxfPstaam8gQrJzo+onLJIbEV96D08NUCc=
X-Google-Smtp-Source: ABdhPJzNR7fHlt24feGy7yyLHVNwGnN5mAc84FS0FJ3pbuLAjyZFwPPDidP62YWYi8FRgyGc0R44O+MVwLCCCUtcNw4=
X-Received: by 2002:adf:d223:: with SMTP id k3mr3557467wrh.99.1620289894075;
 Thu, 06 May 2021 01:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210505211300.3174456-1-arnd@kernel.org> <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com> <877dkcs2h8.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <877dkcs2h8.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 6 May 2021 10:30:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3kZ9_VoKV+2eZh=WqncRqFKzRmRHUjAT9iFMtJpKzb1w@mail.gmail.com>
Message-ID: <CAK8P3a3kZ9_VoKV+2eZh=WqncRqFKzRmRHUjAT9iFMtJpKzb1w@mail.gmail.com>
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

On Thu, May 6, 2021 at 10:14 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Arnd Bergmann <arnd@kernel.org> writes:
>
> > On Thu, May 6, 2021 at 3:20 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Arnd Bergmann <arnd@kernel.org> writes:
> >>
> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
> >> > call_single_data"), the smp code prefers 32-byte aligned call_single_data
> >> > objects for performance reasons, but the block layer includes an instance
> >> > of this structure in the main 'struct request' that is more senstive
> >> > to size than to performance here, see 4ccafe032005 ("block: unalign
> >> > call_single_data in struct request").
> >> >
> >> > The result is a violation of the calling conventions that clang correctly
> >> > points out:
> >> >
> >> > block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
> >> >                 smp_call_function_single_async(cpu, &rq->csd);
> >>
> >> Can this be silenced by
> >>
> >>                 smp_call_function_single_async(cpu, (call_single_data_t *)&rq->csd);
> >
> > Probably, but casting from smaller alignment to larger alignment is undefined
> > behavior
>
> We cannot avoid type cast in Linux kernel, such as container_of(), is
> there some difference here?

container_of() does not cause any alignment problems. Assuming the outer
structure is aligned correctly, then the inner structure also is.

> > and I'd rather not go there in case this triggers some runtime
> > misbehavior or ubsan check in the future. Making the function accept a
> > pointer with the smaller alignment avoids getting into undefined behavior
> > and doesn't require a cast.
>
> In its raw form as above, this looks bad.  If we encapsulate it, it may
> look better, for example,
>
> static inline int __smp_call_function_single_async(int cpu, struct __call_single_data *csd)
> {
>         smp_call_function_single_async(cpu, (call_single_data_t *)csd);
> }
>
> Then, we can do
>
>         __smp_call_function_single_async(cpu, &rq->csd);

Same problem, it's still calling a function that expects stricter alignment.
It would work if we do it the other way around though:

static inline int smp_call_function_single_async(int cpu,
call_single_data_t *csd)
{
        return __smp_call_function_single_async(cpu, csd);
}

That should even work without the cast.

        Arnd

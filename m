Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD23AAA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFQFCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:02:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:00:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r16so5149029oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raWnpeEpxmUtNl6jyZ72+EBz8BQP/7m6BAr11HMTgc4=;
        b=Wdp8p0jivNWxEa36llPlZAKbN++nCXMC/w4zhw0j9mwbX/n9bbZhd66sNDN+uNW6ax
         dCEK779euvve5yCuGpHnmPcT8I7O6qjbzXKzT/k2KUu8cVeIXUq6aXiFroHl9JFiATPB
         ++H5PrQkKCIOmrCA7LKOf/RFgDsCN7GLKYMZxrZKxaBn0iomOmvC0Ea8Bi2fs+N1uz12
         OTRTSFhinwsznxxHCwQ/vJEKf3v9whn4BnvaKV88fuVdR3QkkxxjZ+6iitnXvLNrmYUX
         sKdZhcNSviDBciqm8Yge3yHATxStOdCbSkYPczIIBHlxrfED6CqJRWuceiGY1Z9raonm
         t0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raWnpeEpxmUtNl6jyZ72+EBz8BQP/7m6BAr11HMTgc4=;
        b=dXYu+7YvsBGsd1519yCikJTvMg85ql+5EMKwfJ1qmKfTM1xZebeP+y2qgAyE/FONjU
         wYstq96Zai0nc2ibiHVPO9zSGUE6hUVWvNhPA5C4uO4uN4z+VeVVF42Ky9Kd+vwGjTKa
         W5N9c/QNraINya8TljYWYJVO0AbmjXy1VSACgjz1jZXsyN0mf9r8oFXYWknCOkrjPQlQ
         2BsyEMMESc+b9MK/f3HQO00BghOdCuec36nAIjcnjwQMPEuLpjc5ilWC51+amWFij/qD
         6VCvv+tt1ZvPxhri97GiphaX+Bb8vGhgfvNrGohhtm30rNgeNEsuGy8rL2aYDsIG/GDt
         bn3A==
X-Gm-Message-State: AOAM5317UL/SspO3laWwIaSazWW3wMwg+OwayPa2mRE/T+RSlo+nkv+s
        UIwYnSLP1hudRwFq2hzmXLXnxq6e5m9OLfqgHd4=
X-Google-Smtp-Source: ABdhPJzB/f7CbHYttt9ltSAFKe7qMJhNLyiqvvfOf0zVxA+TOWnT8dUdVnScq55ZLfB2CXGwwVYzNNKQTKj7PAkuK/k=
X-Received: by 2002:aca:f5d6:: with SMTP id t205mr2047840oih.58.1623906023577;
 Wed, 16 Jun 2021 22:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
 <YMni2eclmqf05cL4@hirez.programming.kicks-ass.net> <c81ac071-c648-54ac-72ad-2dab0fa1dd4b@arm.com>
In-Reply-To: <c81ac071-c648-54ac-72ad-2dab0fa1dd4b@arm.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Thu, 17 Jun 2021 13:00:12 +0800
Message-ID: <CAFiDJ5-j8UER1mGggC62C309T+t+y6-vy_NuKOJL6TQHrHAGtA@mail.gmail.com>
Subject: Re: sched: Question about big and little cores system with SMP and EAS
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 9:20 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> - Quentin Perret <quentin.perret@arm.com>
> + Quentin Perret <qperret@google.com>
>
> On 16/06/2021 13:39, Peter Zijlstra wrote:
> > On Wed, Jun 16, 2021 at 07:29:26PM +0800, Ley Foon Tan wrote:
> >> Hi all
> >>
> >> Would like to ask the experts here regarding the Symmetric
> >> Multi-Processing mode (SMP) with Energy aware scheduler (EAS) support
> >> on the big + little cores system.
> >
> > And the you ask a question unrelated to either Symmetric MP or EAS :-)
> >
> >> Hardware system:
> >> Big and little cores have almost the same ISA, but the big core has
> >> some extension instructions that little core doesn't have.
> >
> > That problem is unrelated to big.Little / EAS, also by definition that
> > is not SMP seeing how the 'S' is a blatant lie.
> >
> > The simplest solution is to simply disallow usage of the extended ISA
> > and force mandate the common subset. The complicated answer is something
> > along the lines of:
> >
> >   https://lkml.kernel.org/r/20210608180313.11502-1-will@kernel.org
>
> We don't encourage asymmetric ISA extensions for EAS*/CAS** on
> big.Little systems.
> It would be simply a nightmare to schedule tasks on such systems.
>
> The exception to this is the 'asymmetric 32-bit Soc' to support 32bit
> legacy Apps. The nightmare for scheduling is reduced in this case to CPU
> affinity, something the task scheduler has to live with already today.
> (+ DL admission control for 32bit tasks).
>
> *  Documentation/scheduler/sched-energy.rst
> ** Documentation/scheduler/sched-capacity.rst

Thanks for the reply.
Yes, forsee it is very complicated and nightmare for software to
support for SMP mode but HW is not real "symmetric".
That's why post the question here to ask the advice and comment from
experts here. So that can feedback to HW team.
Asymmetric extension instructions issue should more complicated than
asymmetric 32-bit app support, it can happen in all the areas (kernel,
app, library and etc).

Thanks!

Regards
Ley Foon

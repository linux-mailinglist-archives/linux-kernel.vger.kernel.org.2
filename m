Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F2376A27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhEGSvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 14:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhEGSvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 14:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9600261480
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620413436;
        bh=nu9gk8X4jBTmgeiETWHNXdh2I0I6lDvEUX4MoVO8sYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hrN9Pv39mSVCQunPwzc5WxTr9Bh+rAVWVBauW8cDRE+TFGBPsIwCUM2g+J6VlNtyf
         RvgbA+xFvcuvHwrtUibWB0CXkXPM/l/r2gUyhqADinzP5xF9F5LsVPrPopPMorvSR8
         rCYN37VvzLmZanUEo3ghIEyNKyRE0XhFlCyAVay2TZ119eeVfX21iwjGcwE6UQZOdn
         e8YZS8Y1CPqcfcEHCOurNaXf4Al/uk/SwsyK0AICv+casHxJLVmoZGMaZVGiZdzlR+
         kpExWwjhjZCwHpxxQw/M7Gbn4afuk7sQDeke84Rp5eUZu6LgKyQMGTCd+IfSAMj5Tn
         iUkkHPlF07nDw==
Received: by mail-ed1-f51.google.com with SMTP id g14so11371775edy.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 11:50:36 -0700 (PDT)
X-Gm-Message-State: AOAM532e9lMS5xIq5d2ruQDXY6ajQsVduvMQJmrrhirJNOvc33un/mXe
        +sLEq0bpJekDXXopuabwB2b9Xutf0xl/WITeXGaEGQ==
X-Google-Smtp-Source: ABdhPJwaDCEq2PmFhwg76/x6fKTGXB1Im1noTBYi9pl4gmoPbTsfXNBKILjGmSRRSTT+Yg5CHU832WaiPIQvIFmIRFM=
X-Received: by 2002:a50:fc91:: with SMTP id f17mr13185057edq.23.1620413434996;
 Fri, 07 May 2021 11:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <87bl9s8kfb.fsf@oldenburg.str.redhat.com> <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com>
 <87o8dmmljh.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87o8dmmljh.ffs@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 May 2021 11:50:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWG7E2LCSyvaay05R4Sa3mU_t5C5W4rYGuA3+dzaBF9tQ@mail.gmail.com>
Message-ID: <CALCETrWG7E2LCSyvaay05R4Sa3mU_t5C5W4rYGuA3+dzaBF9tQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 03 2021 at 06:43, Dave Hansen wrote:
> > On 5/2/21 10:18 PM, Florian Weimer wrote:
> >>> 5. If the feature is enabled in XCR0, the user happily uses it.
> >>>
> >>>     For AMX, Linux implements "transparent first use"
> >>>     so that it doesn't have to allocate 8KB context switch
> >>>     buffers for tasks that don't actually use AMX.
> >>>     It does this by arming XFD for all tasks, and taking a #NM
> >>>     to allocate a context switch buffer only for those tasks
> >>>     that actually execute AMX instructions.
> >> What happens if the kernel cannot allocate that additional context
> >> switch buffer?
> >
> > Well, it's vmalloc()'d and currently smaller that the kernel stack,
> > which is also vmalloc()'d.  While it can theoretically fail, if it
> > happens you have bigger problems on your hands.
>
> Such a buffer allocation might also exceed a per process/cgroup
> limitation. Anything else which is accounted happens in syscall context
> which then returns an error on which the application can react.
>
> So what's the consequence when the allocation fails? Kill it right away
> from #NM? Kill it on the first signal? Do nothing and see what happens?
>

It has to be an immediate signal or kill.  A failure to load FPU state
is somewhat tolerable (and has to be for CET), but a failure to *save*
FPU state on a context switch would be a really nasty can of worms.
At the very least we will want arch_prctl(ARCH_ALLOCTE_XSTATE, mask)
to allow HPC workloads to manually allocate the state and get an error
code if it fails.

--Andy

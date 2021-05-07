Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69237376AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhEGTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:23:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhEGTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:23:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620415339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORUuoUk8DJpvMhKQmGSDce5dSlAguNz2DeA4Kqt7HbQ=;
        b=bjhQDjeBlOjjsz24EuAiTVQam0CwX43eBcx/62NQHMC/Gb5w0WUzKL9Udvo20IvjRLQeoV
        GeumJrz+67KiP6l60XJiDJq0BFWsn8qS0rFknBhS6SbOHYk6qX1tj3X6gc8kvSEbrdx5p0
        7OZpcEiZhtsn5KA9Y0zOAN9dWrnIGvTA/voSCJdcXK5RgMhWCdZf5oe1322Oe8ULw+RF1V
        /RQss4faY0+057dfPvfMP8uXrMb9hSC8igfriVyw27yKci7iXHk7ZdRIKWcclpOA5faVWE
        208MneA3Q5/7KgtJiLzOAz+e5GWyoM0tiFVJ/k18y4guswq9zgGnqStvTUNuEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620415339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORUuoUk8DJpvMhKQmGSDce5dSlAguNz2DeA4Kqt7HbQ=;
        b=tclfaHK/1ZJRJghVXP1ksCNWC85cpf/DqYc+NVH3+t2rPEjNLEtjYGBffvj0+MxFoT6CLy
        H/sAnp8YPNvZiRDA==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-abi@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CALCETrWG7E2LCSyvaay05R4Sa3mU_t5C5W4rYGuA3+dzaBF9tQ@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <87bl9s8kfb.fsf@oldenburg.str.redhat.com> <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com> <87o8dmmljh.ffs@nanos.tec.linutronix.de> <CALCETrWG7E2LCSyvaay05R4Sa3mU_t5C5W4rYGuA3+dzaBF9tQ@mail.gmail.com>
Date:   Fri, 07 May 2021 21:22:18 +0200
Message-ID: <87lf8qmjrp.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07 2021 at 11:50, Andy Lutomirski wrote:

> On Fri, May 7, 2021 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, May 03 2021 at 06:43, Dave Hansen wrote:
>> > On 5/2/21 10:18 PM, Florian Weimer wrote:
>> >>> 5. If the feature is enabled in XCR0, the user happily uses it.
>> >>>
>> >>>     For AMX, Linux implements "transparent first use"
>> >>>     so that it doesn't have to allocate 8KB context switch
>> >>>     buffers for tasks that don't actually use AMX.
>> >>>     It does this by arming XFD for all tasks, and taking a #NM
>> >>>     to allocate a context switch buffer only for those tasks
>> >>>     that actually execute AMX instructions.
>> >> What happens if the kernel cannot allocate that additional context
>> >> switch buffer?
>> >
>> > Well, it's vmalloc()'d and currently smaller that the kernel stack,
>> > which is also vmalloc()'d.  While it can theoretically fail, if it
>> > happens you have bigger problems on your hands.
>>
>> Such a buffer allocation might also exceed a per process/cgroup
>> limitation. Anything else which is accounted happens in syscall context
>> which then returns an error on which the application can react.
>>
>> So what's the consequence when the allocation fails? Kill it right away
>> from #NM? Kill it on the first signal? Do nothing and see what happens?
>>
> It has to be an immediate signal or kill.

Killing it right there is the only sensible thing to do.

> A failure to load FPU state is somewhat tolerable (and has to be for
> CET), but a failure to *save* FPU state on a context switch would be a
> really nasty can of worms.

:)

> At the very least we will want arch_prctl(ARCH_ALLOCTE_XSTATE, mask)
> to allow HPC workloads to manually allocate the state and get an error
> code if it fails.

Yes.

Thanks,

        tglx

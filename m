Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9EB34EE12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhC3QjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:39:07 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:40812 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhC3Qib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:38:31 -0400
Received: by mail-ej1-f49.google.com with SMTP id u9so25772498ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brTbFJ3l/AhVj/GuXWRgZxcXsdvUH+rOgnTlTOkQOkQ=;
        b=tzeh7+ZC5tdYwdXTYB5Ul0P2vaSif5LygpdbG+8vo+2tbHmJdcy/aX0/wl0kwsO0Kk
         ieA1o34kBw02T5qSQxPQz5ZoGewVWFhqQlV6nrc8cpO8FvkR1NHvMaNsj++BIS/UyrK4
         KLm0zxExxGDka+8lnNiUlYDYapYLkqEeJtqqF7BA3JjgdkZIF2sZ85zfhwTVYBoodBC9
         W2cJThIRjhwYpuAy9I1+A85tcada+Q/Exc+NAl+Mi0FgaP0ivG17wM/Q0V2ALIyNi2Su
         as0VRZWxzyDxE9osUO1mUEt4w/wCJ78UO+fX9FmSn0J9wnyi8HesiaKwziDH3haEybP6
         gnrA==
X-Gm-Message-State: AOAM530k63kKCOdhL0ydRDhcVWJcH/MxIwG3nhZt8/TtImWBo4PpzL9v
        Ttob6fE0rWE/Iul54ZZup2HnAltmx3HRPeMkL1U=
X-Google-Smtp-Source: ABdhPJwokplcWMgbzPtC3bqSxrnt6uB/h+u+eZuR9F2stqDcqzh+w8x8pFNj7nc7kB5auOeFLqJdI+GUksVP4hSqIRg=
X-Received: by 2002:a17:906:340f:: with SMTP id c15mr21573839ejb.317.1617122310278;
 Tue, 30 Mar 2021 09:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
 <87r1jyaxum.ffs@nanos.tec.linutronix.de> <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
 <87ft0d7q2q.ffs@nanos.tec.linutronix.de> <CAJvTdK=mfc3giXCy_fteyR4UiZfnN5f0hvREN4TjXc5KxtiP+w@mail.gmail.com>
 <8735wd6o67.ffs@nanos.tec.linutronix.de>
In-Reply-To: <8735wd6o67.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Mar 2021 12:38:19 -0400
Message-ID: <CAJvTdK=RfX1F69Q3OvkW0qCSysr_Tqx3WhF34NCd00Y0qrGOXA@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 4:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Len,
>
> On Mon, Mar 29 2021 at 18:16, Len Brown wrote:
> > On Mon, Mar 29, 2021 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Let me know if this problem description is fair:
> >
> > Many-core Xeon servers will support AMX, and when I run an AMX application
> > on one, when I take an interrupt with AMX INIT=0, Linux may go idle on my CPU.
> > If Linux cpuidle requests C6, the hardware will demote to C1E.
> >
> > The concern is that a core in C1E will negatively impact power of
> > self, or performance
> > of a neighboring core.
> >
> > This is what we are talking about, right?
>
> Correct.
>
> > I'm delighted that there are Xeon customers, who care about this power savings.
> > Unfortunately, they are the exception, not the rule.
>
> That maybe true or not. The point is that there is some side effect and
> from a correctness point of view it needs to be addressed.

I don't see how demoting C6 to C1E is a "correctness" issue.
There is nothing "incorrect" about demoting to C1E when software permits C6,
and as I mentioned, this happens all the time.
All architectural state, including the AMX state, is preserved by hardware.

I do agree that there is the possibility that this scenario can result
may not be optimal power savings.
It isn't clear how often that situation might occur.

> >>    - Use TILERELEASE on context switch after XSAVES?
> >
> > Yes, that would be perfectly reasonable.
> >
> >>    - Any other mechanism on context switch
> >
> > XRESTOR of a context with INIT=1 would also do it.
> >
> >>    - Clear XFD[18] when going idle and issue TILERELEASE depending
> >>      on the last state
> >
> > I think you mean to *set* XFD.
> > When the task touched AMX, he took a #NM, and we cleared XFD for that task.
> > So when we get here, XFD is already clear (unarmed).
> > Nevertheless, the setting of XFD is moot here.
>
> No. We set XFD when the task which used AMX schedules out. If the CPU
> reaches idle without going back to user space then XFD is still set and
> AMX INIT still 0. So my assumption was that in order to issue
> TILERELEASE before going idle, you need to clear XFD[18] first, but I
> just saw in the spec that it is not necessary.

Right, XFD setting is moot here.

> >>    - Use any other means to set the thing back into INIT=1 state when
> >>      going idle
> >
> > TILERELEASE and XRESTOR are the tools in the toolbox, if necessary.
> >
> >> There is no option 'shrug and ignore' unfortunately.
> >
> > I'm not going to say it is impossible that this path will matter.
> > If some terrible things go wrong with the hardware, and the hardware
> > is configured and used in a very specific way, yes, this could matter.
>
> So then let me summarize for the bare metal case:
>
>    1) The paragraph in the specification is unclear and needs to be
>       rephrased.
>
>       What I understood from your explanations so far:
>
>       When AMX is disabled by clearing XCR0[18:17], by clearing
>       CR4.OSXSAVE, or by setting IA32_XFD[18], then there are no
>       negative side effects due to AMX INIT=0 as long as the CPU is
>       executing.

Right.

>       The only possible side effect is when the CPU goes idle because
>       AMX INIT=0 limits C states.

Right.

>    2) As a consequence of #1 there is no further action required on
>       context switch when XFD[18] is set.

I agree.

>    3) When the CPU goes idle with AMX INIT=0 then the idle code should
>       invoke TILERELEASE. Maybe the condition is not even necessary and
>       TILERELEASE can be invoked unconditionally before trying to enter
>       idle.
>
> If that's correct, then this should be part of the next series.

If you insist, then that is fine with me.

Personally, I would prefer to be able to measure an actual benefit
before adding code, but this one is small, and so I'm not religious about it.

> > In the grand scheme of things, this is a pretty small issue, say,
> > compared to the API discussion.
>
> No argument about that.
>
> Thanks,
>
>         tglx



-- 
Len Brown, Intel Open Source Technology Center

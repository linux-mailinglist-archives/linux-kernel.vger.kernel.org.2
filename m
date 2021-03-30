Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35C34E322
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC3I2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:28:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhC3I2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:28:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617092896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CbpkIY+md4AV0ieNuiibnRZBKdn1SgoB6/rmycE6Vw=;
        b=nZ/KQkp3jWadgpCro9EXJeYoD5n6dxAn+fzUxY9KzEOwSXyJ5C0eko0G/n99rWFUOpolp2
        OpcZOkLcR4kJu/pmDOgRHFjSVJ7nfM323v9jOSYzjbqM8lNLif7X7/99JcTvzAkzmuSF6e
        W4oWtu7nGEKlV0LVrQOjPwcfR7KXhZMfY6LqKpK1gLkbAUAj0Hbu6N6MfkWRJ6l3UJLu+m
        3mUGQMqpqOUe9zkv7h86KcylW42NWrfLzZdBHKsDDdHr+Ife3y/rzFtaPEucumBqJMlPz8
        vtXIXq0OGvco5OReGW7oSeRRcOy8SB47AJ7FNl58f9R5PqmmS9VU0QrKTZt3mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617092896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CbpkIY+md4AV0ieNuiibnRZBKdn1SgoB6/rmycE6Vw=;
        b=SPXzEzCtUXId8x40RKqgrv6iNdiaAF7U4Vt+FINPkNBGFWBd3Cox4389x/csSD3dye1yGY
        hn5F8qhpSMnsq+AQ==
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
In-Reply-To: <CAJvTdK=mfc3giXCy_fteyR4UiZfnN5f0hvREN4TjXc5KxtiP+w@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de> <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com> <87r1jyaxum.ffs@nanos.tec.linutronix.de> <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com> <87ft0d7q2q.ffs@nanos.tec.linutronix.de> <CAJvTdK=mfc3giXCy_fteyR4UiZfnN5f0hvREN4TjXc5KxtiP+w@mail.gmail.com>
Date:   Tue, 30 Mar 2021 10:28:16 +0200
Message-ID: <8735wd6o67.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

On Mon, Mar 29 2021 at 18:16, Len Brown wrote:
> On Mon, Mar 29, 2021 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Let me know if this problem description is fair:
>
> Many-core Xeon servers will support AMX, and when I run an AMX application
> on one, when I take an interrupt with AMX INIT=0, Linux may go idle on my CPU.
> If Linux cpuidle requests C6, the hardware will demote to C1E.
>
> The concern is that a core in C1E will negatively impact power of
> self, or performance
> of a neighboring core.
>
> This is what we are talking about, right?

Correct.

> I'm delighted that there are Xeon customers, who care about this power savings.
> Unfortunately, they are the exception, not the rule.

That maybe true or not. The point is that there is some side effect and
from a correctness point of view it needs to be addressed.

>>    - Use TILERELEASE on context switch after XSAVES?
>
> Yes, that would be perfectly reasonable.
>
>>    - Any other mechanism on context switch
>
> XRESTOR of a context with INIT=1 would also do it.
>
>>    - Clear XFD[18] when going idle and issue TILERELEASE depending
>>      on the last state
>
> I think you mean to *set* XFD.
> When the task touched AMX, he took a #NM, and we cleared XFD for that task.
> So when we get here, XFD is already clear (unarmed).
> Nevertheless, the setting of XFD is moot here.

No. We set XFD when the task which used AMX schedules out. If the CPU
reaches idle without going back to user space then XFD is still set and
AMX INIT still 0. So my assumption was that in order to issue
TILERELEASE before going idle, you need to clear XFD[18] first, but I
just saw in the spec that it is not necessary.

>>    - Use any other means to set the thing back into INIT=1 state when
>>      going idle
>
> TILERELEASE and XRESTOR are the tools in the toolbox, if necessary.
>
>> There is no option 'shrug and ignore' unfortunately.
>
> I'm not going to say it is impossible that this path will matter.
> If some terrible things go wrong with the hardware, and the hardware
> is configured and used in a very specific way, yes, this could matter.

So then let me summarize for the bare metal case:

   1) The paragraph in the specification is unclear and needs to be
      rephrased.

      What I understood from your explanations so far:

      When AMX is disabled by clearing XCR0[18:17], by clearing
      CR4.OSXSAVE, or by setting IA32_XFD[18], then there are no
      negative side effects due to AMX INIT=0 as long as the CPU is
      executing.

      The only possible side effect is when the CPU goes idle because
      AMX INIT=0 limits C states.

   2) As a consequence of #1 there is no further action required on
      context switch when XFD[18] is set.

   3) When the CPU goes idle with AMX INIT=0 then the idle code should
      invoke TILERELEASE. Maybe the condition is not even necessary and
      TILERELEASE can be invoked unconditionally before trying to enter
      idle.

If that's correct, then this should be part of the next series.

> In the grand scheme of things, this is a pretty small issue, say,
> compared to the API discussion.

No argument about that.

Thanks,

        tglx

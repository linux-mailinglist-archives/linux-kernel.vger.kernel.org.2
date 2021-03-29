Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E382334DA01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2WQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:16:54 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37781 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC2WQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:16:40 -0400
Received: by mail-ej1-f45.google.com with SMTP id w3so21816775ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQzIDcWuiHAyXRwih35ciaqMW2/DmFDACcc42yRYS2k=;
        b=Rn9XImGceiHBLK+km6SGms6h0hc5aW8JgKxKM53TSUZa/QayRU7sHLOlIsHK1Lsfka
         NUGP2r7efbn5gMlFnb9bdh2wpY3RX0GRgGtuHEQcR9QZ/q8/hqE1AMk6xQaMP4yWgD+r
         uPSXpZ2gp36MeUb6Rz+X4BOukPyf0RoaalNnC6gI+OzqRmZ7CUM3QEIiOpGH5Jqlg0QU
         6uHaRhoU34GEMFsn1lMbnwlVayYCbBTcX4pOj+XGiakL+0HuciE3YDx24gxqntqm7zYw
         OXsopa0/evPu2/TLsQYMLGb8AnDixI7kxhnqB5iHz+3CGmLCLLrZkP6VOyQWR394LKnw
         cKnw==
X-Gm-Message-State: AOAM533osUvx/O0Rd+YK/qsxZiIwqwmMTaFffIM5GyW2yw0CwqsJjusw
        aB2gw46wgaMkfRpYkd3EIWAKNJ+VusGhzH3s/KU=
X-Google-Smtp-Source: ABdhPJx6CPFcHJiMC5wf94BMQoWnoiz4MEwX5AhrAY5/XJp1AvowCU2TgxnrqxhIVNOK/tBXOaHlpCbo4zoLtPw/EHs=
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr20808560ejr.501.1617056199371;
 Mon, 29 Mar 2021 15:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
 <87r1jyaxum.ffs@nanos.tec.linutronix.de> <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
 <87ft0d7q2q.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87ft0d7q2q.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 18:16:28 -0400
Message-ID: <CAJvTdK=mfc3giXCy_fteyR4UiZfnN5f0hvREN4TjXc5KxtiP+w@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> According to documentation it is irrelevant whether AMX usage is
> disabled via XCR0, CR4.OSXSAVE or XFD[18]. In any case the effect of
> AMX INIT=0 will prevent C6.
>
> As I explained in great length there are enough ways to get into a
> situation where this can happen and a CPU goes idle with AMX INIT=0.
>
> So what are we supposed to do?

Let me know if this problem description is fair:

Many-core Xeon servers will support AMX, and when I run an AMX application
on one, when I take an interrupt with AMX INIT=0, Linux may go idle on my CPU.
If Linux cpuidle requests C6, the hardware will demote to C1E.

The concern is that a core in C1E will negatively impact power of
self, or performance
of a neighboring core.

This is what we are talking about, right?

First, I should mention that if I threw a dart at a map of Xeons
deployed across the universe, the chances are "significant" that I'd
hit one that is configured with C6 disabled, and this discussion would be moot.

Second, I should mention that Linux cpuidle demotes from deep C-states
to shallow ones all day long.  This is typically due to expected timer
expiration,
and other heuristics.

Third, I should mention that the processor itself demotes from C6 to C1E
for a number of reasons -- basically like what Linux is doing, but in HW.

Albeit, the hardware does have the capability to "un-demote" when it demotes
and recognizes it made a mistake, and that "un-demote" capability would
not be present if the reason for demotion was AVX INIT=0.

Okay, that said, let's assume we have found a system where this problem
could happen, and we use it in a way that makes it happen.  Would we notice?

If your system were profoundly idle, and one or more cores were in C1E,
then it would prevent the SOC from entering Package C6 (if enabled).
Yes, there is a measurable idle power difference between Package C1E
and Package C6.  (indeed, this is why Package C6 exists).

I'm delighted that there are Xeon customers, who care about this power savings.
Unfortunately, they are the exception, not the rule.

If you were to provoke this scenario on many cores simultaneously, then
I expect you could detect a power difference between C1E and CC6.
However, that difference would be smaller than the difference
in power due to the frequency choice of the running cores,
because it is basically just the L2-leakage vs L2-off difference.

Regarding frequency credits for a core being in C1E vs C6.
Yes, this is factored into the frequency credits for turbo mode.
How much impact, I can't say, because that information is not yet available.
However, this is mitigated by the fact that Xeon single core turbo
is deployed differently than client.  Xeon's are deployed
more with multi-core turbo in mind, and so how much you'll
notice C1E vs C6 may not be significant, unless perhaps it happened
on all the cores across the system.

>    - Use TILERELEASE on context switch after XSAVES?

Yes, that would be perfectly reasonable.

>    - Any other mechanism on context switch

XRESTOR of a context with INIT=1 would also do it.

>    - Clear XFD[18] when going idle and issue TILERELEASE depending
>      on the last state

I think you mean to *set* XFD.
When the task touched AMX, he took a #NM, and we cleared XFD for that task.
So when we get here, XFD is already clear (unarmed).
Nevertheless, the setting of XFD is moot here.

>    - Use any other means to set the thing back into INIT=1 state when
>      going idle

TILERELEASE and XRESTOR are the tools in the toolbox, if necessary.

> There is no option 'shrug and ignore' unfortunately.

I'm not going to say it is impossible that this path will matter.
If some terrible things go wrong with the hardware, and the hardware
is configured and used in a very specific way, yes, this could matter.

In the grand scheme of things, this is a pretty small issue,
say, compared to the API discussion.

thanks,
Len Brown, Intel Open Source Technology Center


-Len

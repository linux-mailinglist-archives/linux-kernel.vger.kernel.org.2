Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7DC39FEEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhFHSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:21:35 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43525 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhFHSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:21:34 -0400
Received: by mail-lj1-f182.google.com with SMTP id r14so9105837ljd.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5x5dJs8d2mi+sk6vZuhsX9aDnrxEX5BFKyzyJmLqRU=;
        b=iLG7QObByXRfzCEVH5a+QeLgxXMzL96RiXSA+cbqVM5VcqnLoFIbQJoalLeH4x5JQj
         Oqz9smXP3uZNArqCtYaBM2R6dHYk02bGMI4FxZdd8lD47Nwc6Rt0iT/B+bPe/Q1w4hum
         wmWVSqXpRldvYl1rfTectH5HegCHSQJPYoehm34rX2y4u8rR+7J6aN7p2t97MNip/FEk
         b6JT9D2PzjZq+uWagIXCpclqgypQ2sqySHtpyNGW0PKYGtchrX2zIUd+PBL6/oA73lq8
         6UPe30prIoXzJgYCfmT/vPB5rSczdSNWHBmK2PQslwCw1J8+1GQXG54ZkvCULM/GCzRK
         MprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5x5dJs8d2mi+sk6vZuhsX9aDnrxEX5BFKyzyJmLqRU=;
        b=jENv6ydUI9guc3CfwvrpzJoksNbg3V3nHIvGnoCBS/HGBLR6oUPclE8ir3ybeLPH7D
         Stzt5UnsZO1ompJisT7PM9V+b5Bo19CA9MmAM3nCS9lHtkaDGZqxqQbgLEpZjjpc/L6V
         MdiPwx0ys0xvJgvpTLgCXMQIxl/bbCGARfapk/nimlbSguXtQnLaxI3qP9xdyamu+9lt
         WovSTPQKhdHZaao+mpls+SfCQzPE8Zt61MaXgqvTWnRoTTN9sMkqS9KJiJLxQZ5LFR18
         0HucN90s4DxEOjr6HSzhhqk+sl9Y9TbS+ZeXz53dHgpRRFP2huDcplOcbgyjuBYbF1Ei
         70wA==
X-Gm-Message-State: AOAM532Sy2uBlB7pRSqFraqkoWZc7kCmcsmPyNzTQTnU0eN8MRbwG0ik
        gJIob1TNVd/vdJnm73CxEhkOO95sESNZF0xjoJaZNQ==
X-Google-Smtp-Source: ABdhPJxuDoKNh7yfgWTKWMFI21Dq8Womw0ZptxsOU8YiXYVlpAbV94ccNkW0IcJm/KN8vhRtxsB/WzCuJCiTmtzQ9kM=
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr2537698ljj.0.1623176306424;
 Tue, 08 Jun 2021 11:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com> <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net> <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net> <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org> <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
In-Reply-To: <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:18:15 -0700
Message-ID: <CAKwvOdmgx8HG5i=MMsOtvJcpMnF-R3FxLrMhd5bHYNSGxZWp=w@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 10:30 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 6/8/2021 10:22 AM, Peter Zijlstra wrote:
> > On Tue, Jun 08, 2021 at 09:58:03AM -0700, Nathan Chancellor wrote:
> >> On 6/7/2021 1:54 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> >>> Nathan,
> >>> Can you please test the below diff and see if that resolves your boot
> >>> issue reported in:
> >>> https://github.com/ClangBuiltLinux/linux/issues/1384
> >>
> >> Unfortunately, it does not appear to resolve that issue.
> >>
> >> $ git log -2 --decorate=no --oneline
> >> eea6a9d6d277 Peter's fix
> >> 614124bea77e Linux 5.13-rc5
> >>
> >> $ strings /mnt/c/Users/natec/Linux/kernel-investigation | grep microsoft
> >> 5.13.0-rc5-microsoft-standard-WSL2-00001-geea6a9d6d277
> >> (nathan@archlinux-ax161) #3 SMP Tue Jun 8 09:46:19 MST 2021
> >>
> >> My VM still never makes it to userspace.
> >
> > Since it's a VM, can you use the gdb-stub to ask it where it's stuck?
> >
>
> Unfortunately, this is the VM provided by the Windows Subsystem for
> Linux so examining it is nigh-impossible :/ I am considering bisecting
> the transforms that objtool does to try and figure out the one that
> causes the machine to fail to boot or try to reproduce in a different
> hypervisor, unless you have any other ideas.

Assuming this is an optimization and not required to boot/run; you
could test that quickly by putting a return statement as the first
statement in the list_for_each_entry loop in arch_rewrite_retpolines.
If that works, you could instead use a counter to try to see which
symbol is bad; once you bisect a counter value where things start/stop
booting, you could try to print the corresponding symbol (ie `name`).
(Optimization Fuel)  (Sorry if any of that is unclear, let's follow up
off thread if so).  Maybe that symbol will give us further clues?  I
think that would tell us whether it's a problematic jump vs call, and
via which register.
-- 
Thanks,
~Nick Desaulniers

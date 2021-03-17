Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEE33F757
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCQRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhCQRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70D4064F0C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616003121;
        bh=8Tj3I72LOIK6tGuJySNUpX/YpMZm0lEhjA0kPdspS2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TwuYHZC3p1sJh9532eVEf9MmSLSSIlLSwkcC7r5E8hR4vFvwqoGnrVGDXlN0htlG5
         9P1Uocs7y5BiRW4r3L7/iLQ3VG/P2NRRyKFdS0cvBZVIWEWlZEK1+MA1sPo96BW4EF
         /jsn1PbdXCZLaoXAr0y7MGod2LagmOH0ZsGc9feM/GEpyRUFUxcc19lRdUByLxVaJF
         d2Pc2zzAw02DUaQJpBUMDkNIzHGbJExuAF43SzAyNUTGmxMNKC8Nf36qPhi3d4l5ZO
         E4elGY2g1AdCymvs0FwEJUjxyd5UJ/qeS2TfgsCK3/k398BlFOrFY+KkXfiG0GYfKF
         pS/XYUd4W3owQ==
Received: by mail-ej1-f48.google.com with SMTP id p7so4009320eju.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:45:21 -0700 (PDT)
X-Gm-Message-State: AOAM530IDoEWAvCG0delZ1hT4UC4bQHvINnMbggFHRAovxDoVzVoOud3
        Yw8G9cOVr+JU9XGwaBGAQ/CqBPi0ASkXVyIkexsUJg==
X-Google-Smtp-Source: ABdhPJyG3JGQxjCqucEkDMgzctVaiZggmcu1+XhtQwlSQl66Bv+Vns3Nl0Z9qJqd0QqCWboDs4Xmx+D3EsRC5AWPXc8=
X-Received: by 2002:a17:906:7e12:: with SMTP id e18mr38033207ejr.316.1616003119842;
 Wed, 17 Mar 2021 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
 <161469871251.49483.9142858308048988638.stgit@devnote2> <20210317235522.f327f2a8f43af2e27e5bccea@kernel.org>
 <YFIttoNvw1TTMR3a@hirez.programming.kicks-ass.net>
In-Reply-To: <YFIttoNvw1TTMR3a@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Mar 2021 10:45:08 -0700
X-Gmail-Original-Message-ID: <CALCETrW6=UTa6DmrPHcjkbpNTBNoTxkxn=kqX2FMnHWcmZYs=g@mail.gmail.com>
Message-ID: <CALCETrW6=UTa6DmrPHcjkbpNTBNoTxkxn=kqX2FMnHWcmZYs=g@mail.gmail.com>
Subject: Re: [PATCH -tip 0/3] x86/kprobes: Remoev single-step trap from x86 kprobes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 17, 2021 at 11:55:22PM +0900, Masami Hiramatsu wrote:
> > Hi Andy,
> >
> > Would you think you still need this series to remove iret to kernel?
>
> They're an improvement anyway, let me queue them so that they don't get
> lost.
>
> I'll line them up for tip/x86/core unless anybody else thinks of a
> better place for them and tells me in time ;-)

I agree.  The new code is quite nice.  I'm still not quite sure what
I'm doing with IRET, but thank you very much for the kprobe
improvements.

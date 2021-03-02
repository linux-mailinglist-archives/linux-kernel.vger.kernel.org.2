Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A32A0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576446AbhCBE3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235206AbhCBBhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:37:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F91361601
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614648987;
        bh=pO3aMhZfip5Y1Te1GeBDK/SbHcQtZ+PFnl6fzHdLA34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uJ69Nc7XMOoMa58r585JHBISndzEhfDf5jUB6b4YY9gfrRxp393lYBQIw19YoFY2W
         LFqdnKy8ipDGVxXsua6XWcSj/YwJ4lootKsTxq2Pwo2+8gCgmo6G4Il/5hRMhBqb7g
         ulgaBV4cTXu5v4PQNJLNIVxGbXD36kp7w0diMMeUyU/sVCqg+kRIQx4lqbAh/RuH07
         B3trlV1o0vE0d8i3kvhuRcqkLCISpgBFkq1aP5c6PW1uWs+rcJrNDMOnYjhiUCYEMT
         6AcGeGNlP+4yu8/2eNmBXts91gittWAIditlAR58Yk4+zDfimYcFLhlzGJLgnFGpJc
         iTQPhJwEYgRsw==
Received: by mail-ej1-f53.google.com with SMTP id gt32so20565453ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 17:36:27 -0800 (PST)
X-Gm-Message-State: AOAM533+i5p32bevbQTiiPVrlwNvcCwodhlDE6Iids0nh2Q7XlwfaKwr
        yGlU7XfY06bPcERj1xtowOPu52dmIg2E+BcXzj4DXQ==
X-Google-Smtp-Source: ABdhPJyt1YOJyGEPyr8Jz7qB8qBZsCyyyKniB71j5O3eCU+ZtA7MtDi9GmLZMjKqHeBxNodebuyP3bRJz1bBD1jOka0=
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr12882390ejj.204.1614648985636;
 Mon, 01 Mar 2021 17:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210301165130.GA5351@redhat.com>
In-Reply-To: <20210301165130.GA5351@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Mar 2021 17:36:13 -0800
X-Gmail-Original-Message-ID: <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
Message-ID: <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
Subject: Re: Why do kprobes and uprobes singlestep?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 8:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Hi Andy,
>
> sorry for delay.
>
> On 02/23, Andy Lutomirski wrote:
> >
> > A while back, I let myself be convinced that kprobes genuinely need to
> > single-step the kernel on occasion, and I decided that this sucked but
> > I could live with it.  it would, however, be Really Really Nice (tm)
> > if we could have a rule that anyone running x86 Linux who single-steps
> > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > when the system falls apart around them.  Specifically, if we don't
> > allow kernel single-stepping and if we suitably limit kernel
> > instruction breakpoints (the latter isn't actually a major problem),
> > then we don't really really need to use IRET to return to the kernel,
> > and that means we can avoid some massive NMI nastiness.
>
> Not sure I understand you correctly, I know almost nothing about low-level
> x86  magic.
>
> But I guess this has nothing to do with uprobes, they do not single-step
> in kernel mode, right?

They single-step user code, though, and the code that makes this work
is quite ugly.  Single-stepping on x86 is a mess.

>
> > Uprobes seem to single-step user code for no discernable reason.
> > (They want to trap after executing an out of line instruction, AFAICT.
> > Surely INT3 or even CALL after the out-of-line insn would work as well
> > or better.)
>
> Uprobes use single-step from the very beginning, probably because this
> is the most simple and "standard" way to implement xol.
>
> And please note that CALL/JMP/etc emulation was added much later to fix the
> problems with non-canonical addresses, and this emulation it still incomplete.

Is there something like a uprobe test suite?  How maintained /
actively used is uprobe?

--Andy

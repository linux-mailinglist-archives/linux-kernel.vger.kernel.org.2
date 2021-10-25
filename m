Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369C43989B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJYOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhJYOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30C4C61040
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635172306;
        bh=YQoHO4ZpYmdFlmGOcwSkvmsVimif+mkXV5GbbYqtXAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kBNwx69bzjyxzoQsy2AuBpJGr5/qNxR8SbS7we12Y1zuM4BQaZ49/8TNX5OJbMA6Q
         Xgf1NVjhGDJWPGNo7FpLjmkRSx/2e/iSqtuAo240hF49zhvvIq/kgtCsDO+edy9dzk
         HQgIl/TYOaXwdaVUEPE/Z1e0SRlSfgQ2J/jPiOnl+HIY0f/jcGtBzgzSfKrnSvbcOU
         VRexAipW51rEDtJmn1X8n9atYTEhMkDiMwolRIgXouNNRSrtESYhUtZwshOLPIllQF
         +D6R37Y+0KxhQX36SoBI2NQPlhE7RA0KWRrE/tP59UW/bzZivdEGbNVgmPNCupirEF
         Pnx7V2t2SJ9vw==
Received: by mail-oi1-f178.google.com with SMTP id y207so15780058oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:31:46 -0700 (PDT)
X-Gm-Message-State: AOAM533ros80imxu00Ydz4sOMDU3DD1sJU0KcSHvvYDTQViNTzEIuWoE
        kweazfoxfmSQuNEhQGu7rlrM0dq5qlrxo03ho2c=
X-Google-Smtp-Source: ABdhPJx0Fonlea6hUhHNXZIy7lGplUKDU2OzT5iCrRa5BsimBHP72FqeXWBXoCMSs4nbev9m4FTbnioPmtPvnWtIptM=
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr22615854oib.47.1635172305463;
 Mon, 25 Oct 2021 07:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025122102.46089-1-frederic@kernel.org> <20211025122102.46089-3-frederic@kernel.org>
 <1b19fbeccf3d4a75a5ed3a507d29f7dd@AcuMS.aculab.com>
In-Reply-To: <1b19fbeccf3d4a75a5ed3a507d29f7dd@AcuMS.aculab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Oct 2021 16:31:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuVdSVe29WoensbxC5fqp4HFQeBK2-oLxHA_BQLp2jww@mail.gmail.com>
Message-ID: <CAMj1kXGuVdSVe29WoensbxC5fqp4HFQeBK2-oLxHA_BQLp2jww@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     David Laight <David.Laight@aculab.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:25, David Laight <David.Laight@aculab.com> wrote:
>
> From: Frederic Weisbecker
> > Sent: 25 October 2021 13:21
> >
> > Implement arm64 support for the 'unoptimized' static call variety, which
> > routes all calls through a single trampoline that is patched to perform a
> > tail call to the selected function.
> >
> > It is expected that the direct branch instruction will be able to cover
> > the common case. However, given that static call targets may be located
> > in modules loaded out of direct branching range, we need a fallback path
> > that loads the address into R16 and uses a branch-to-register (BR)
> > instruction to perform an indirect call.
> >
> ...
> > +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> > +{
> > +     /*
> > +      * -0x8 <literal>
> > +      *  0x0 bti c           <--- trampoline entry point
> > +      *  0x4 <branch or nop>
> > +      *  0x8 ldr x16, <literal>
> > +      *  0xc cbz x16, 20
> > +      * 0x10 br x16
> > +      * 0x14 ret
> > +      */
>
> Since the 'ldr x16, <literal>' is just a 32bit constant
> (for a pc-relative load).
>

I don't follow. Are you saying it is a 32-bit opcode? This applies to
all AArch64 opcodes.

> Can't you save a word by making offset 0x4 <branch or ldr x16, <literal>> ?
>
> Or am I missing something?
>

On arm64, we can only patch NOPs into branch instructions or vice
versa, or we'd have to run the whole thing under stop_machine() to
ensure that other cores don't fetch garbage.

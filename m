Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699733970F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhCLTEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhCLTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:04:14 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221FFC061574;
        Fri, 12 Mar 2021 11:04:12 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v14so3509088ilj.11;
        Fri, 12 Mar 2021 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=VJwZKksBLqWOLKIVeeVCDVuN/NQu3d0SvSfrF/DUXH0=;
        b=pnFP9Ih8Cgn6K57eZGKwqkXC/tKNWFqsrj9Rmuryl/2zU4dy+oUAcSppGNo9PX9ggV
         IGnwutgzJCVT52e28SlDL0BOcPJUMf8wCR5VzdHnQh+nUy0Wyg4z2YKhKWhynagIiG7R
         8uAEuM6b1ny+QX6AUANO/QTv+og4cAmZmZ6gh98cXSH8mMj3N6n7tLvCPf8sOAf4DWCJ
         r1RCaPgEwGo7dCbr5AnkX1UR7Jl154IRaUTxGWnjD2f0sOC5P62+DRwr/bW0ptPPiIbI
         0mOOCVZ7KxItJTm3soBvqghyxyw/iwrGezcNaa3HEMtIR5UXzntO898/Mc5vtln73Gd1
         p/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=VJwZKksBLqWOLKIVeeVCDVuN/NQu3d0SvSfrF/DUXH0=;
        b=eAW0VJ2dSBBUOND/WKs7rUcdL5G8ia6gFIC5G1ohWWZjqNHRWOmtd6T1wsT0J/eM1p
         UdHUHhJ+NtH1c2s6x3VX38P6lS0WfdlGmChSD16/5y6Gkvomr92fDGGvPx9vPpH8uhVT
         Sh6w05glX755HNtoHPv6lqByQxxXSiDqNDQuDutNqhu+StQSdtixNPLKH1xsk7hHHXiO
         86kI/tWRPqbQ1fC56ec0lLG+8bssw51fL0PHEVb/0fIx+b9LpRRv63lw2qQ4hkZhZpiw
         vHLy8Rw0FGZWn53M5dz5+y1HWyd9Wtzz7eOc1ZXrqO7On1I4/a1RxqjlUkUHbsuzfoZD
         64zg==
X-Gm-Message-State: AOAM533gclfy3SggggyIdHqaAjjlxzRpmdsmMtG6+QBPl1x+lbi+bLVT
        ECLhOukRoQjcVjB485stKzFiq3x3SBnr6qTnWf0hW6i1FyBlTQ==
X-Google-Smtp-Source: ABdhPJygFehE6EIZNqBWrR4JsfTLxa6K8An2UJr0pcpXRC54ANDg66jSaMBuJ5y0iFZ5onBck31MhyJhYbUDKYUUpHY=
X-Received: by 2002:a92:ce84:: with SMTP id r4mr3846395ilo.112.1615575851379;
 Fri, 12 Mar 2021 11:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
 <20210312144726.GA22098@zn.tnic> <20210312122622.603bd82c@gandalf.local.home>
 <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
 <20210312124751.5e6aee98@gandalf.local.home> <CA+icZUW83q4L0xYVYXtO6TW+f+bkQ2rXdaW0MsZn20gtM=+UeQ@mail.gmail.com>
In-Reply-To: <CA+icZUW83q4L0xYVYXtO6TW+f+bkQ2rXdaW0MsZn20gtM=+UeQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 20:03:35 +0100
Message-ID: <CA+icZUX+1GjfRK1TiGvOMkwUDmy9ewH+AauZ+uR6OnpPcDOuJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 7:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 12, 2021 at 6:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 12 Mar 2021 18:35:45 +0100
> > Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> >
> > > Hey Steve, you degraded me to a number :-).
> >
> > It's the internet, everyone is a number.
> >
> > >
> > > I dunno which Git tree this patchset applies to, but I check if I can
> > > apply the patchset to my current local Git.
> >
> > Try Linus's latest.
> >
>
> $ git describe origin/HEAD
> v5.12-rc2-338-gf78d76e72a46
>
> I adapted 1/2 in arch/x86/include/asm/jump_label.h to fit ^^^, see attachment.
>

Forget this.

With latest Linus Git you need to apply "x86/jump_label: Mark
arguments as const to satisfy asm constraints" from tip Git.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=864b435514b286c0be2a38a02f487aa28d990ef8

>
> > > Then build a kernel in the same build-environment.
> > > Lemme see.
> > >
> > > To say with Linus's words:
> > > "Numbers talk - bullshit walks."
> >
> > Exactly.
> >
> > -- Steve

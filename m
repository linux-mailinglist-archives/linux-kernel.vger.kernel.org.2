Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03C3309F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhAaXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhAaXlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:41:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D34164E2F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612136454;
        bh=XbzouG8PydFCDTlas8eNfcrwuHLUjTspuJx0Lwu9f2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qMP4MnEQD5ElKte9/fC/X+aYzmUlWwi1djfofXeFU1pTMcZBpAjJZn7U2m/MX9x2Q
         6TF0B+5NKkZZHGo8wtXvxcHJ6lw3+LDC7R0ezosqziLNfBIXPjyb/K6Zmk3IPTQSzF
         7OSxLO6cRdRpXiDkfh0At+IUEhnI2aOEhQL1zXBvFh+ZPYY58RSN0J49iQe/AWAPK1
         9HmUxD+WBun2dd1HFhUAlxjHYqqgAjt0wqI9tJpvpEv5OR4u8BfUoqW/7E30MWtD22
         Au+Yn7kftelRTM+tyj4+7VwCenR3N7ur9FYvxfiGrJbm8XxHmR3sAmEXYo3fG6Csbp
         SQfZsLMNcmiFg==
Received: by mail-ej1-f41.google.com with SMTP id kg20so21540503ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:40:54 -0800 (PST)
X-Gm-Message-State: AOAM532sNpS9ufCDr0AAepZXK0kBFEa/spdjlLabT+HoZNJ6e7A4xEKZ
        A0puw6v5Gx1dBXEKwrgFBf4FkXKrMFgIg4GpOymrew==
X-Google-Smtp-Source: ABdhPJyVwaM987Sl32fARVfZXIqxw02Dmt3Ne1s1GG8wotUsU4PeDQjTQaAy1QUi7WZ+1+h4wUiMoQja+0i6Qf9pgXs=
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr15001661ejb.503.1612136452670;
 Sun, 31 Jan 2021 15:40:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
 <BFAB82E3-267B-4CF5-B6F2-8E6A2A3DB42B@amacapital.net> <CAP045Aq7PNQyhkT0S5GBzSRUTY4-SGsjs47Z0cCxoPeE-Od_+A@mail.gmail.com>
In-Reply-To: <CAP045Aq7PNQyhkT0S5GBzSRUTY4-SGsjs47Z0cCxoPeE-Od_+A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Jan 2021 15:40:41 -0800
X-Gmail-Original-Message-ID: <CALCETrVZp6-1Rg_DEKggUqZAzQ_iXXMd4d690ByPGb8B9F6dzQ@mail.gmail.com>
Message-ID: <CALCETrVZp6-1Rg_DEKggUqZAzQ_iXXMd4d690ByPGb8B9F6dzQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 3:39 PM Kyle Huey <me@kylehuey.com> wrote:
>
> On Sun, Jan 31, 2021 at 3:36 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > > The odd system call tracing part I have no idea who depends on it
> > > (apparently "rr", which I assume is some replay thing), and I suspect
> > > our semantics for it has been basically random historical one, and
> > > it's apparently what changed.
> > >
> > > That's the one that we _really_ should have a test-case for, along
> > > with some documentation and code comment what the actual semantics
> > > need to be so that we don't break it again.
> >
> > This rr thing may be tangled up with the nonsense semantics of SYSRET. =
 I=E2=80=99ll muck around with Kyle=E2=80=99s test and try to figure out wh=
at broke.
> >
> > I=E2=80=99m guessing the issue is that we are correctly setting TF in t=
he EFLAGS image, but IRET helpfully only traps after the first user insn ex=
ecutes, which isn=E2=80=99t what the tracer is expects.
>
> The state of TF shouldn't really matter here. There should be no user
> space code execution in the example I gave. This behavior all happens
> in the kernel and not on the silicon.
>

I admit that PTRACE_SINGLESTEP seems like an odd way to spell "advance
to the end of the syscall", but you're right, it should work.

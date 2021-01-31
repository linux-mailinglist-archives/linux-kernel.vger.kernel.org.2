Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39963309F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhAaXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhAaXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:37:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:36:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so9875343pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+DHYDL7w8VhpjSa59jEOypJo9aMjHR9h4IvRm60SiP8=;
        b=yYMnymv6gtf6EbcGV1hXWTybjceYtSIQhLLio6VTHQaIFLADGye/shGcou2dcZCklI
         Bh1XMTY6BZIL7Engi7Rv2V5f/6+8gHfuhiZ19WBNvK/a5psapcsQEnYec3UJBnJfo/IR
         oexSXzJwyZwL0i74T8hHm6z/86n/tjfXLpUHILurVHCANjo6Lol0L/gd7SLiHcNfVi1A
         +VMa7JvHnjMCHAP2ylxkrO4KQUZdZk6zm7N3sNorTK3J1OkqiPy3bXgpoEV1ECW7nLBG
         E85jJaRP9DE9RZrh+mY2+hZ6WZc0MHytEnEYO7nUC8G7ZS8s4F3COBhFEK1Pm/mjJm3D
         Gj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+DHYDL7w8VhpjSa59jEOypJo9aMjHR9h4IvRm60SiP8=;
        b=IrJ11f2C2Lp35csrHpTtISns6M3o4Ny6q3x6HdlrRtEj7EEfUXm2lXEwJXh/C8JtvU
         ql62Dro9QrVi75IFez6J7CwXrUWCnI+pSuzh5DQp3aaHk+ApQ2vdbNFA9XG/qYRWnXNz
         yRUwR0oQ7DBZ90+Pa90srLhAgogog7C1zZC6YteMMbnLvLALAzLp6n5dp5/Drnna2uPL
         WukXXm36P4oxjAK+fUaELTau7noHiIPhR4ie536UQUsLVgxt1JJS2ot0EIUVpIg1Uzy0
         dbjNXtueMjPM3Ua4CfVZKWqYvBwAq9uJ4HTzDnofZl89wsQyccyNqNlmMoJk5/uNaEAd
         VDOQ==
X-Gm-Message-State: AOAM531RXV8llx7TIrGYZsBd6QI9ua0O73IKdtVW0pos9K1ftvG+t26z
        E9lt4NcPf5zuZgLsejizBY0OXw==
X-Google-Smtp-Source: ABdhPJw3OY949vrhlicMm7plcWZRvTH3uKMV4aiQSt25VbPPE7a/yjZORhcNy6zAjS42BZQzdujvTg==
X-Received: by 2002:a17:90a:17af:: with SMTP id q44mr4677524pja.64.1612136215562;
        Sun, 31 Jan 2021 15:36:55 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8031:8295:6b02:ca64? ([2601:646:c200:1ef2:8031:8295:6b02:ca64])
        by smtp.gmail.com with ESMTPSA id 78sm14679553pfx.127.2021.01.31.15.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 15:36:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
Date:   Sun, 31 Jan 2021 15:36:53 -0800
Message-Id: <BFAB82E3-267B-4CF5-B6F2-8E6A2A3DB42B@amacapital.net>
References: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
Cc:     Kyle Huey <me@kylehuey.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>
In-Reply-To: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 31, 2021, at 2:57 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Sun, Jan 31, 2021 at 2:20 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>>=20
>> A smallish test that we could stick in selftests would be great if that=E2=
=80=99s straightforward.
>=20
> Side note: it would be good to have a test-case for the interaction
> with the "block step" code too.
>=20
> I hate our name for it ("block step"?), but it modifies TF, to only
> trap on taken branches, not after each instruction.
>=20
> So there's all these things that interact:
>=20
> - you can set TF yourself in user space with 'popf' and get a debug
> signal (not after the popf, but after the instruction _after_ popf,
> iirc)
>=20
> - you can set TF as a debugger and that's basically what
> TIF_SINGLESTEP fundamentally means
>=20
> - we have TIF_FORCED_TF, which says whether TF was set by ptrace, or
> whether it was already set independently by the application before
> ptrace, so that we can know whether to clear it or keep it set *after*
> the single-step.
>=20
> - you can then *modify* the behavior of TF to trap only on control
> flow changes (and we use TIF_BLOCKSTEP to specify that behavior)
>=20
> - and there's also obviously some very subtle and unclear rules about
> when system call instructions cause debug traps
>=20
> The basic TF behavior is fairly simple: it caused #DB, and we send a signa=
l.

This is all fundamentally impossible to do fully correctly because a program=
 can use PUSHF to read TF, and there is only one TF bit, and the app and the=
 debugger can fight over it. The insn breakpoint mechanism is much better, b=
ut even AMD CPUs can=E2=80=99t (I think) be programmed to breakpoint the ent=
ire user address space. So we do our best to fudge it.

>=20
> The "app set TF _itself_, and we want to debug across that event" is a
> lot more interesting, but it's unclear whether anybody does it. It's
> really just a "we want to be able to debug that case too", and
> TIF_FORCED_TF means that it should be possible.
>=20
> I didn't test that it works, though. Sounds worth a test-case?
>=20

I can look. We do have tests for apps setting TF with no debugger attached.

> The TIF_BLOCKSTEP thing changes no other logic, but basically sets the
> bit in the MSR that modifies just when TF traps. I may hate the name,
> but I think it works.
>=20

It has certainly been busted in the past in corner cases. I don=E2=80=99t th=
ink we have tests.

> The odd system call tracing part I have no idea who depends on it
> (apparently "rr", which I assume is some replay thing), and I suspect
> our semantics for it has been basically random historical one, and
> it's apparently what changed.
>=20
> That's the one that we _really_ should have a test-case for, along
> with some documentation and code comment what the actual semantics
> need to be so that we don't break it again.

This rr thing may be tangled up with the nonsense semantics of SYSRET.  I=E2=
=80=99ll muck around with Kyle=E2=80=99s test and try to figure out what bro=
ke.

I=E2=80=99m guessing the issue is that we are correctly setting TF in the EFL=
AGS image, but IRET helpfully only traps after the first user insn executes,=
 which isn=E2=80=99t what the tracer is expects.=20

>=20
>             Linus

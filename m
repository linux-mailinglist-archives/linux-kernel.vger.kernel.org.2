Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB36309F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhAaW6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhAaW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:58:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E000C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:57:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c18so17308316ljd.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=odJg7LCAAuxnlbDUm0ok/Gw50wuADGShJ7tvrAZA3Ew=;
        b=aDq4P0ghH5k2m/NduAcjxWd7RCM30ISfHLBcpbYHjubdOzxDASzGymXB7SmrwA9+DH
         WI7BR5riokCPDKtDgNyvMWJkfIYzCCDBNr/cggqDydA8dfIP4pQIOahpfNrDh1mMmTK0
         fJ+klVlP88iUou+14fFHi8ZHqZaX5o2mT+csw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odJg7LCAAuxnlbDUm0ok/Gw50wuADGShJ7tvrAZA3Ew=;
        b=j9Jvs3ZagQD0B+B+df7bki6w1tD+CuFR1DqqEnrrcqYHGJixDO7/yHHf3TvkP8gQmo
         kPlrGCFg+p0G1j4wq3l9HBvJIIc5rMgFdkzzxEy7W4gcQIU7xvAGH5SzsjkXbICOKapt
         9HoJu8d4rmLzKkLr6/+cs9H/pc6h11GRFDt4ROgJe2qQZ4GDZxFN3OsGuOp36ZgM6r6O
         JW3Ja1B+NL5BoCdDqmcf7euiPkd/xz0I/Tl2v+q12INnnRplhF0Fx3Wi7nGtiOAO9ymf
         WqKL5S9CIOo1ns6jYA84gEH2C/h/9bCx3xu0JmpK1vFNbBqJo8Ydai3sJPfSI8tTriwe
         pE1w==
X-Gm-Message-State: AOAM530sQjdKZLayET1PZohOA8KLgDBAgw/eB/VSq6wtgpBUrcgt4Jrl
        O4GVjpF9ix2GBSU+H+39thkRrj5UCjv+Pg==
X-Google-Smtp-Source: ABdhPJzFsL/LatkM/GbbC85dGL49dNJRa5QMjtQj6kuUjuSCc9cJST/ck3+RzgcZE3wrbnFPCUDpsw==
X-Received: by 2002:a2e:a590:: with SMTP id m16mr8971125ljp.325.1612133853475;
        Sun, 31 Jan 2021 14:57:33 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q3sm2637447ljm.5.2021.01.31.14.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 14:57:32 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id f19so17313321ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:57:31 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr9122051ljc.220.1612133851384;
 Sun, 31 Jan 2021 14:57:31 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
In-Reply-To: <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 14:57:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
Message-ID: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kyle Huey <me@kylehuey.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:20 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> A smallish test that we could stick in selftests would be great if that=
=E2=80=99s straightforward.

Side note: it would be good to have a test-case for the interaction
with the "block step" code too.

I hate our name for it ("block step"?), but it modifies TF, to only
trap on taken branches, not after each instruction.

So there's all these things that interact:

 - you can set TF yourself in user space with 'popf' and get a debug
signal (not after the popf, but after the instruction _after_ popf,
iirc)

 - you can set TF as a debugger and that's basically what
TIF_SINGLESTEP fundamentally means

 - we have TIF_FORCED_TF, which says whether TF was set by ptrace, or
whether it was already set independently by the application before
ptrace, so that we can know whether to clear it or keep it set *after*
the single-step.

 - you can then *modify* the behavior of TF to trap only on control
flow changes (and we use TIF_BLOCKSTEP to specify that behavior)

 - and there's also obviously some very subtle and unclear rules about
when system call instructions cause debug traps

The basic TF behavior is fairly simple: it caused #DB, and we send a signal=
.

The "app set TF _itself_, and we want to debug across that event" is a
lot more interesting, but it's unclear whether anybody does it. It's
really just a "we want to be able to debug that case too", and
TIF_FORCED_TF means that it should be possible.

I didn't test that it works, though. Sounds worth a test-case?

The TIF_BLOCKSTEP thing changes no other logic, but basically sets the
bit in the MSR that modifies just when TF traps. I may hate the name,
but I think it works.

The odd system call tracing part I have no idea who depends on it
(apparently "rr", which I assume is some replay thing), and I suspect
our semantics for it has been basically random historical one, and
it's apparently what changed.

That's the one that we _really_ should have a test-case for, along
with some documentation and code comment what the actual semantics
need to be so that we don't break it again.

             Linus

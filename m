Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4533722E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhECWJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:09:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE46C061573
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 15:08:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so8690295ljf.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iHBd8+drdOghBy/DbtPuVvH8pwlCcE8s9OIRRC6qmI=;
        b=W54cMamUz2HN8pD7jq73F3NLwwnJiSjwtZgXapdq2dzVUgmh+rxdcWsUDjWO63XjxN
         L5UuMkA8bSHH3GdHGXY5kK6HI1JABIDXvF72ZWQo3kQloS0IekvXuFTXSqYDb2D+mqGi
         EPCZ/mcFme8B8gyPmkMiBzBs+YvXM9ykavVh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iHBd8+drdOghBy/DbtPuVvH8pwlCcE8s9OIRRC6qmI=;
        b=Y1Zpg+i0sT6adV+CGcO0Z50/Vr9LUflqWqtURt0UAKDL2gLq28P7Hl5hqbLf1NMl00
         F36DAXmzsrzH5S4L1OdkDU11NNfiIhyojhFvCoGvgFIR50U/lDiC3C2PpkyLe+oxVu2u
         vWfHd25NA+wH2+C/D0DdChroe2MZndc+hJcGIaFdS9IUCViOwvoFm6gMWFmmz8x5DIua
         PR8XrsexfK39U4OAVRykVW3th6BxgjyrNLJXfU/RCT+17zeXNFzheIKViNEXpKgYZF8V
         TmcKCTR2ovgxyuumoF7CO/RJiQVWoyG6IlUzzuS5Z0Vk2Q+P8dPOI23uB6dBLXgvKURT
         kNiA==
X-Gm-Message-State: AOAM532ruMRfmAyqMH12gNpPp+Vp9Ui3n23T6IMj2n7UM/NGXRmbwgwR
        PallriL+AKp+Y29LYBABI6JN7y+nosfE7xD2
X-Google-Smtp-Source: ABdhPJykImhKknndmVnA479xrQ4KAX63rlgutBUIBMDxm/Lyz/mJaPOwNPOPumxINbHTEtocfGJioA==
X-Received: by 2002:a05:651c:307:: with SMTP id a7mr15141363ljp.166.1620079704257;
        Mon, 03 May 2021 15:08:24 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k8sm76797lfo.123.2021.05.03.15.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 15:08:23 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id b21so8690244ljf.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 15:08:23 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr2790137lji.465.1620079703516;
 Mon, 03 May 2021 15:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <8735v3ex3h.ffs@nanos.tec.linutronix.de> <3C41339D-29A2-4AB1-958F-19DB0A92D8D7@amacapital.net>
 <CAHk-=wh0KoEZXPYMGkfkeVEerSCEF1AiCZSvz9TRrx=Kj74D+Q@mail.gmail.com>
 <CALCETrV9bCenqzzaW6Ra18tCvNP-my09decTjmLDVZZAQxR6VA@mail.gmail.com>
 <CAHk-=wgo6XEz3VQ9ntqzWLR3-hm1YXrXUz4_heDs4wcLe9NYvA@mail.gmail.com>
 <d26e3a82-8a2c-7354-d36b-cac945c208c7@kernel.dk> <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
In-Reply-To: <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 15:08:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
Message-ID: <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
Subject: Re: [PATCH] io_thread/x86: don't reset 'cs', 'ss', 'ds' and 'es'
 registers for io_threads
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Stefan Metzmacher <metze@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> To be clear, I'm suggesting that we -EINVAL the PTRACE_GETREGS calls
> and such, not the ATTACH.  I have no idea what gdb will do if this
> happens, though.

I feel like the likelihood that it will make gdb work any better is
basically zero.

I think we should just do Stefan's patch - I assume it generates
something like four instructions (two loads, two stores) on x86-64,
and it "just works".

Yeah, yeah, it presumably generates 8 instructions on 32-bit x86, and
we could fix that by just using the constant __USER_CS/DS instead (no
loads necessary) since 32-bit doesn't have any compat issues.

But is it worth complicating the patch for a couple of instructions in
a non-critical path?

And I don't see anybody stepping up to say "yes, I will do the patch
for gdb", so I really think the least pain is to just take the very
straightforward and tested kernel patch.

Yes, yes, that also means admitting to ourselves that the gdb
situation isn't likely going to improve, but hey, if nobody in this
thread is willing to work on the gdb side to fix the known issues
there, isn't that the honest thing to do anyway?

            Linus

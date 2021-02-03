Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99730E21A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBCSLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhBCSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:11:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAECC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:10:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b2so561547lfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFXCAVCvdE4leeiqwZ8GWgSDSdNV/A3WBUdTkZX4UbY=;
        b=OrBhEbnyo/XZUMBBvytRNE26lRBineus1YdnTJHiM+Y67CNInq2iAOHp71uC9JNWSr
         g+mSObkseSofSfARkErTuSJENECRsrcfsJiaitkgVgJWMlVsUoi/DI07rzVk3KGXuQ18
         Ww+tukeCLDnTK8i61qN955q2PduKmHgCKvPQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFXCAVCvdE4leeiqwZ8GWgSDSdNV/A3WBUdTkZX4UbY=;
        b=suTum+EdUnbX5XRwD0ALH1QJRGt3/BLtcTRTfYyP8LhHmK7NYGT0BWxuHR67PGh1ME
         QEtowNWa09UrB1FcWUhpIl9ZTOiJoyqrefgr6e0yh0SC5GshrSw2/mJcW5QigEtrLBHJ
         vkNusnnrlrV06Hpx2ZdGmokTYnnuaY+z6jxD8luN4XGUzxDMrSYyQsiYw3nw94XaKocC
         SO6nGppZ4/eun0t6dchS23JEt4hBq3hb3ZqJqXiwczxfMlMAUtsza9e4Y6pUyaN25Meg
         zZ7Svkm/iqPi30zNIqKZRi3kyg3qW3rzD+wA5ML3F2Bt3aO5unu+6dHlRfrYtfXcN/kh
         zyBA==
X-Gm-Message-State: AOAM5334F3JlEa+VoZW5ef+JFJkRUNn+zbK7z4yoXXtJSfLjP1FG6m1V
        Djn1iTTVuqnCvsuDt13RabAQoNO//p5tjQ==
X-Google-Smtp-Source: ABdhPJwRjuoWExRyROw+Y8b1GK7MWBUZQxI/zuDO8F1n2zIKQs/N5M3kUcp6FacNl24F1sHO3tmp/A==
X-Received: by 2002:a19:5509:: with SMTP id n9mr2468732lfe.111.1612375853276;
        Wed, 03 Feb 2021 10:10:53 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m16sm315643lfu.220.2021.02.03.10.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:10:52 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id f2so100788ljp.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:10:52 -0800 (PST)
X-Received: by 2002:a2e:860f:: with SMTP id a15mr2399715lji.411.1612375851966;
 Wed, 03 Feb 2021 10:10:51 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
 <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
 <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com> <87h7mtc9pr.fsf_-_@collabora.com>
In-Reply-To: <87h7mtc9pr.fsf_-_@collabora.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Feb 2021 10:10:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFV8j03vyvuY4qhKnJ6Vy2DLfjzgTJ1n+LO9EsVsJmDg@mail.gmail.com>
Message-ID: <CAHk-=wjFV8j03vyvuY4qhKnJ6Vy2DLfjzgTJ1n+LO9EsVsJmDg@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix missed trap after single-step on system call return
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:00 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Does the patch below follows your suggestion?  I'm setting the
> SYSCALL_WORK shadowing TIF_SINGLESTEP every time, instead of only when
> the child is inside a system call.  Is this acceptable?

Looks sane to me.

My main worry would be about "what about the next system call"? It's
not what Kyle's case cares about, but let me just give an example:

 - task A traces task B, and starts single-stepping. Task B was *not*
in a system call at this point.

 - task B happily executes one instruction at a time, takes a TF
fault, everything is good

 - task B now does a system call. That will disable single-stepping
while in the kernel

 - task B returns from the system call. TF will be set in eflags, but
the first instruction *after* the system call will execute unless we
go through the system call exit path

So I think the tracer basically misses one instruction when single-stepping.

I think your patch works for this case (because the SYSCALL_EXIT_TRAP
flag stays set until single-stepping is done), so I think it's all
good. But can you verify, just to allay my worry?

         Linus

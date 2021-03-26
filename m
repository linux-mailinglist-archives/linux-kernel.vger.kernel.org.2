Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF634AF84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCZTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCZTrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:47:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 509C1619C7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616788075;
        bh=ldQbRSOsMcZhW+K5U8HflJSb4bpOOQG6YAbj+7IGdQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bj4/IXZQNw5++PhwvsX+J5QvLk4gLq7cAbS7qtDVWXhoAtp6sfAwS8iIjpWf/h+az
         BjXRgZrW/Nd8Nh4Tgr+9hxfJyP4H8RRucT3xU5LaptcPkAFda9qoze39/Hjigb2+tw
         NK7HQRq02Y6Q0xzr4YT6pEIzcA61crrBOcVyTBbxw5hE1dznIcjVFmptB4D7wMUhLK
         anZbFxKs+y1ZWRr2kpvwO6Qkyzx6aqdNKAYx6hjoKLs9+2a9ckf1TNZf/dqzhKv+yo
         2WiKeJRCE9nxhXjOivKxlfeTzeH132R7GTy044gU7EQTTXY0v5GsC5NYot/P/JZjcH
         HTEbIQsugmmYw==
Received: by mail-ed1-f42.google.com with SMTP id e7so7570478edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:47:55 -0700 (PDT)
X-Gm-Message-State: AOAM530JsUFVMxVNVR7xsyfyZOfjFfjswbxUXDvnjNUofAoVb+E8y0ND
        Agv+T+oq5dRypNm3L+7rX1B3USvz06dAyAvKTXpYIA==
X-Google-Smtp-Source: ABdhPJz7m/lyPJlaRnXSVlCOG5Tbm9pQ/e4xOvscQ3KDIWjqcXihaVUkLlhMMuTR/eEmzLaOIDvxLC8LPD1rR6tX5uA=
X-Received: by 2002:aa7:da98:: with SMTP id q24mr17497772eds.84.1616788073594;
 Fri, 26 Mar 2021 12:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <87a6qqi064.fsf@mid.deneb.enyo.de> <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
 <87blb5d7zx.fsf@mid.deneb.enyo.de>
In-Reply-To: <87blb5d7zx.fsf@mid.deneb.enyo.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 12:47:42 -0700
X-Gmail-Original-Message-ID: <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
Message-ID: <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
Subject: Re: Why does glibc use AVX-512?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:34 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Andy Lutomirski:
>
> >> > AVX-512 cleared, and programs need to explicitly request enablement.
> >> > This would allow programs to opt into not saving/restoring across
> >> > signals or to save/restore in buffers supplied when the feature is
> >> > enabled.
> >>
> >> Isn't XSAVEOPT already able to handle that?
> >>
> >
> > Yes, but we need a place to put the data, and we need to acknowledge
> > that, with the current save-everything-on-signal model, the amount of
> > time and memory used is essentially unbounded.  This isn't great.
>
> The size has to have a known upper bound, but the save amount can be
> dynamic, right?
>
> How was the old lazy FPU initialization support for i386 implemented?
>
> >> Assuming you can make XSAVEOPT work for you on the kernel side, my
> >> instincts tell me that we should have markup for RTM, not for AVX-512.
> >> This way, we could avoid use of the AVX-512 registers and keep using
> >> VZEROUPPER, without run-time transaction checks, and deal with other
> >> idiosyncrasies needed for transaction support that users might
> >> encounter once this feature sees more use.  But the VZEROUPPER vs RTM
> >> issues is currently stuck in some internal process issue on my end (or
> >> two, come to think of it), which I hope to untangle next month.
> >
> > Can you elaborate on the issue?
>
> This is the bug:
>
>   vzeroupper use in AVX2 multiarch string functions cause HTM aborts
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=27457>
>
> Unfortunately we have a bug (outside of glibc) that makes me wonder if
> we can actually roll out RTM transaction checks (or any RTM
> instruction) on a large scale:
>
>   x86: Sporadic failures in tst-cpu-features-cpuinfo
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=27398#c3>

It's worth noting that recent microcode updates have make RTM
considerably less likely to actually work on many parts.  It's
possible you should just disable it. :(

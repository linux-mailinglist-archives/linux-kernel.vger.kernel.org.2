Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333F3309F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhAaXk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhAaXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:40:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:39:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a9so3141758ejr.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GyBu0JZcnq0VY67Dekhkms4BkqM7epUKoJLuU5aP8zA=;
        b=LR0bgNlucGtOGUrKZh3HxAmPoFA3qddXH4x9MIv2gL/0DKzLMepvXXjHsTbJrcgw+d
         w+Re8IxShUjAYJqIeAvmq3EadsA450V38lKBKEuc7OcJZpbaXBaAHPIE/jXEFzVI2zQ2
         yNILImjz4obinmX+/nfOdFS7aOtDieiHDt9TkXyj6PV5eqxV7xV06XPCO4AkyDAh1OZ9
         OFro6nV3isxs22zAifAe9Q6hp0lpb0TXrpXaTZqN1GhfLNyHjxt1aJamvKcdKxNMUHCU
         AKvtQYpN+we++FIYlKHFDAX+78D9hnW1Fgopq59QAQl7GR71JAnYL13lHFtDC6rUGZcC
         08lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GyBu0JZcnq0VY67Dekhkms4BkqM7epUKoJLuU5aP8zA=;
        b=ikCiD/yksAws+y20PWs7p5YRfR9iUcLleFMvQ+R8r7B6RPACBwqZstjBMC03zQZTUx
         186nPK9v8pIGEzltYufOTij1LgnYFyavgvAIPD6SWqJ7uSknUZAdlYkz7z+Me6PQGZfO
         yPIP1Z1GkSiP1nrvDZvmvT7RgkFRjF9/jP7zMLTbRJI0Yf8Gu46kK+jEr9veHJi1Sx5L
         VDn/N39Yc4P9tg7Zvf/JPNfHr4lpB8Si9wjls6oCgSgAexzl5uqTmiAKmAwDZZd+qgnw
         OB/YzNpAnQPUSqXo3rvp1rN2jT220ApyxVqigCKlZ6wYTnD3L2URpWAR2jP0817nDVBn
         jDCQ==
X-Gm-Message-State: AOAM5331/7C2rmhsajsNOfAgPBPixT3xyuorym5brdcRR0xhWW2/zS/K
        UPTLiqbZVZKlHPeD92TX6dQY8fSRhfUImB46MQtlHw==
X-Google-Smtp-Source: ABdhPJwnZ+x+OtuQrQ1xHlAwoqez2ya2fX3U4RppMROFQe4Sa4K8VEz4xWZO2Jg4KhV9EbvnH69P//t60sny+ewJlgM=
X-Received: by 2002:a17:906:e09:: with SMTP id l9mr15274194eji.196.1612136379634;
 Sun, 31 Jan 2021 15:39:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
 <BFAB82E3-267B-4CF5-B6F2-8E6A2A3DB42B@amacapital.net>
In-Reply-To: <BFAB82E3-267B-4CF5-B6F2-8E6A2A3DB42B@amacapital.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sun, 31 Jan 2021 15:39:28 -0800
Message-ID: <CAP045Aq7PNQyhkT0S5GBzSRUTY4-SGsjs47Z0cCxoPeE-Od_+A@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@amacapital.net>
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

On Sun, Jan 31, 2021 at 3:36 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > The odd system call tracing part I have no idea who depends on it
> > (apparently "rr", which I assume is some replay thing), and I suspect
> > our semantics for it has been basically random historical one, and
> > it's apparently what changed.
> >
> > That's the one that we _really_ should have a test-case for, along
> > with some documentation and code comment what the actual semantics
> > need to be so that we don't break it again.
>
> This rr thing may be tangled up with the nonsense semantics of SYSRET.  I=
=E2=80=99ll muck around with Kyle=E2=80=99s test and try to figure out what=
 broke.
>
> I=E2=80=99m guessing the issue is that we are correctly setting TF in the=
 EFLAGS image, but IRET helpfully only traps after the first user insn exec=
utes, which isn=E2=80=99t what the tracer is expects.

The state of TF shouldn't really matter here. There should be no user
space code execution in the example I gave. This behavior all happens
in the kernel and not on the silicon.

- Kyle

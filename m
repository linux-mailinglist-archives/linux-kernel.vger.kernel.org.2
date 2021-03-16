Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADE33D1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhCPKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhCPKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:17:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:17:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 94so11202096qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFQPVLUfS53IJIXq7EsY2KvnwcOJrlsdzLKjZq2BXDY=;
        b=fUXspIhe4anHCXrLL7/6HWBV51o5i52Sepbas3YvuBJJQqOxGi1Q6dIpdMoFteNiAc
         Hf2jwwtlEcoBAEMTMq4HF2rCF5qlnYbca9Jo8WPWi0ufHJt+JcsFezmBEZ+/4AvvtYT0
         aoSnMKmomgxVY+COSxxGoOc6gxx0NlnsafuaCXjXVZG9cI3Y4NPkt4tfevqcd8i0uCCB
         HtSyEVSXqZSsID+nVqqYIwXvNzrARebAcSiXxg9DOMWcwa2X0OWBq+wSAXISRGAMA0r1
         Uh1nir4VmWooaNbvXAS+fraTgXXrpvkurwFNjCRIUgFsSJ31Ta6Ve4NecUBo9LUwsmTp
         /DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFQPVLUfS53IJIXq7EsY2KvnwcOJrlsdzLKjZq2BXDY=;
        b=HCgvugyNzWV6heyE+krG7HaraO+y1FrfZCWbvrgpyD/DuM/LBJWXkLIMbfvjjLkeLv
         Jr5Sp6byo3Xbg5x9NQ9Je1v2vWP9GLiZkKD3AC+mOYV+J0aqrKok1sbBjY/f0Xib6GdR
         emIq89kND+XPPC04RfXI2Fh2KmoRPQmqKSUdw5+p2f6EV4MdbISaGkJI1vYg1Cy8d1jJ
         8tnSnAAgOvkrBLlHq8VbCAhATK32OdjVYHfD0yORr7JjUjAkJ+YtcpMpzDbWkcNRki2I
         ki03PW/H4ZquUL4JfvD6bWAWQPReEQoCvIN5iLKTqDYqjnpVAqtZO63neey7xNAboqkU
         JmsQ==
X-Gm-Message-State: AOAM533t9T2PEETO6Xp5c2ger6oymJvejiUHlzSmQ1VPJe4AcN19vjPY
        jKyGy7wYBx6ymojMdKEgzNeSwrxt5h4vLsnzpila8A==
X-Google-Smtp-Source: ABdhPJyrXdmYgwLW+yfTnxygbHdMoq3RO7SC7RN94L7krldLOgF8gr2zvcrbMSKWZX9r1msisPxjBQrY95SB8Ipcf3I=
X-Received: by 2002:aed:2c61:: with SMTP id f88mr26277893qtd.337.1615889877043;
 Tue, 16 Mar 2021 03:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 11:17:45 +0100
Message-ID: <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 16, 2021 at 8:18 AM syzbot
> > <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1e28eed1 Linux 5.12-rc3
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=167535e6d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e0cee1f53de33ca3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b06ef9b44d00d600183
> > > userspace arch: arm
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com
> >
> > +arm32 maintainer
> > I think this is a real stack overflow on arm32, the stack is indeed deep.
>
> Nice find. I see there was already a second report, so it seems to be
> reproducible as well.
> If you are able to trigger this reliably, you could try printing the frame
> pointer while unwinding to see what is actually going on:
>
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -68,8 +68,8 @@ void dump_backtrace_entry(unsigned long where,
> unsigned long from,
>         unsigned long end = frame + 4 + sizeof(struct pt_regs);
>
>  #ifdef CONFIG_KALLSYMS
> -       printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
> -               loglvl, where, (void *)where, from, (void *)from);
> +       printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS), frame %08lx\n",
> +               loglvl, where, (void *)where, from, (void *)from, frame);
>  #else
>         printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>                 loglvl, where, from);
>
> If that doesn't help, I could have a look at the binary to see which
> functions in the call chain take a lot of stack space, if any.
>
> Which exact compiler version do you use for building these
> kernels? I can try doing a build with the same commit and config.
>
> This one function is one that I have seen before when looking at build
> warnings with KASAN:
>
> > > [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_calc_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)
>
> ima_calc_file_hash_tfm() has a SHASH_DESC_ON_STACK(), which by itself can
> use up 512 bytes, but KASAN sometimes triples this number. However, I see
> you do not actually have KASAN enabled, so there is probably more to it.

The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
It's available in gcr.io/syzkaller/syzbot container.
(syzbot should have been provided the compiler version, something
broke, I've filed https://github.com/google/syzkaller/issues/2498 for
this)

Yes, KASAN is not enabled on arm32 for now.

Re printing FP, syzbot does not use custom patches:
http://bit.do/syzbot#no-custom-patches
But this does not seem to be syzbot-specific. It seems that any arm32
stack overflow report will be unactionable, so I think it would be
useful to include this into the mainline kernel to make overflow
reports useful for everybody (and for syzbot as a side effect).

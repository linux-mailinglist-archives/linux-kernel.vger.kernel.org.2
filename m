Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443A433D1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhCPKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236696AbhCPKhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCB36502E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615891060;
        bh=8vg3j4KbPfPGCtaZq86t7nyqRbHFTsK5OFjgTIYKfE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+Qjn9VAZhU8320HlfH2CF0EbAoM7HkH3DWSmpdhX16QM3iC/iWgU3NrykWSeIqI5
         6PwLg9/I7L/rXuiwbV+B7CPS2qWTZEW9he9zJBT/s1ENhdiwqX/cOER+oWPAEirl57
         L/C3bXCfxio2noARTJbjXLxLPN794rCyy+oEqfUGTeiTCF+/hNrcfUlP7zd05wuHDU
         NCbstAr9gGzL9CTPQhIGHfpYU923DO/qYj8QVaVaiaeDVVq64YfT2WTAIdnhex62s9
         FvpdoeXGZzfEbZCFIzEmUtI/EepUF0A4sB+9TR2DbUOS3Lr8D4R8V7rX2/53dTszGw
         EtxPP3KLOUh2Q==
Received: by mail-ot1-f48.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6578003otk.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:37:40 -0700 (PDT)
X-Gm-Message-State: AOAM530ST5W4xycyV21S/zSfPJukSU7zSFqv+dfw2rLnXDd52LnH+sVe
        NsXNFINiQt3Uxe/jypjHzN+Q5kVLbvIu2FSFsQw=
X-Google-Smtp-Source: ABdhPJzBZsC6BebipGpd9qkQLkv5f4JpjNvG8vPxGY97HQYtsk7jXKK3lV51bWXjlBbggbKWr0LEZj3gGa0q79LDMx0=
X-Received: by 2002:a9d:7512:: with SMTP id r18mr3234126otk.90.1615891059931;
 Tue, 16 Mar 2021 03:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 11:37:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXES3N8pqOy_MJD9Xma8Z1pb0dMV86wir09TdbVz2V4niQ@mail.gmail.com>
Message-ID: <CAMj1kXES3N8pqOy_MJD9Xma8Z1pb0dMV86wir09TdbVz2V4niQ@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
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

On Tue, 16 Mar 2021 at 11:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 16, 2021 at 8:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
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
>

FYI, as an aside, the SHASH_DESC_ON_STACK() issue was fixed in

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=660d2062190db131d2feaf19914e90f868fe285c

(note that the size of SHASH_DESC_ON_STACK() accounts for two struct
shash_desc instances)

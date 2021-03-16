Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D550333D155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhCPKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:03:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhCPKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:02:50 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6DSo-1lJvkV34XY-006gYF for <linux-kernel@vger.kernel.org>; Tue, 16 Mar
 2021 11:02:47 +0100
Received: by mail-oi1-f180.google.com with SMTP id v192so29952080oia.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:02:47 -0700 (PDT)
X-Gm-Message-State: AOAM531n21IrRWgHnkh1mMCl5Z4QeCNkp9pwHtAuLrdR7IMwNQyjz3Lg
        ML2mi2gUD5bENsoj9DOeDT+SrwC3hPTYKHZRZZY=
X-Google-Smtp-Source: ABdhPJyYZK17O7imUFiCMQCKTR9o6avqVRy81Vy+rKf9jK4uQItjRrZQ+4IBE3PjAG0Gjt7XQmlapzBIrGJRdYy/zMM=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr2915607oie.4.1615888966485;
 Tue, 16 Mar 2021 03:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
In-Reply-To: <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 11:02:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
Message-ID: <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:y9JUqt5bJpWbp5GO62rcqqmFUkOLAcxSn1DwmeHgb5HjAsGLJn8
 sgaHjeiv41FLxrKd/uuN/ubtWGaruoijKSJ/Xqgqh5idy7FIipXvrFIY2SDZdLfCmMfyfyU
 4qwDYDpjSNSJkpe6C2ZmjCyeLJanS6t6gVwBWZtA27dgFy9FLgmgAT2czOSOeGhqUHCf44y
 eZyIfSuuPGVCSLD4FmlMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDV3J6L76Vo=:w/IaYkw2lW2sdy/QY8cUAB
 lzJn0wFZQtqNgaHeYapqS193/lV0boNCEEjL5ebz2srPSikFm859ifu4c9tgreUYF7NM0Aq/e
 gYf0iPoyAgDj9TLLxZOSh7y4JrCu2XwofYmbAM8qgx/niXDVJeL1p6D8pa62ulzgW51Ev5pX1
 g5CXCVFUX0O4dFlGGWhbpwvNadrvGCTBZkWwAeStEBd1YmMsePu3Bdsye5VS+IFOXnnGcLMzH
 qm1n6SUb9F3SV/IPMH2+5JKXLtJWuuiMg0MMLe8WjbPymsFAkuJNf5RaIX+6JEd3deo4SWDC5
 Uj0kI4k0oAH+w78CFDM1E/CLrp5Edz7NxVw6RLxL2DbDjbwxt1dYqac8veRHQkaTaAe3PSK+p
 IYpKiK44dIOkbuCXCEvRdl+Axn9WY2AGihp86tuoZEokA3Qo34iVUV6Xua36y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 8:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 16, 2021 at 8:18 AM syzbot
> <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1e28eed1 Linux 5.12-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167535e6d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e0cee1f53de33ca3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0b06ef9b44d00d600183
> > userspace arch: arm
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com
>
> +arm32 maintainer
> I think this is a real stack overflow on arm32, the stack is indeed deep.

Nice find. I see there was already a second report, so it seems to be
reproducible as well.
If you are able to trigger this reliably, you could try printing the frame
pointer while unwinding to see what is actually going on:

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -68,8 +68,8 @@ void dump_backtrace_entry(unsigned long where,
unsigned long from,
        unsigned long end = frame + 4 + sizeof(struct pt_regs);

 #ifdef CONFIG_KALLSYMS
-       printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
-               loglvl, where, (void *)where, from, (void *)from);
+       printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS), frame %08lx\n",
+               loglvl, where, (void *)where, from, (void *)from, frame);
 #else
        printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
                loglvl, where, from);

If that doesn't help, I could have a look at the binary to see which
functions in the call chain take a lot of stack space, if any.

Which exact compiler version do you use for building these
kernels? I can try doing a build with the same commit and config.

This one function is one that I have seen before when looking at build
warnings with KASAN:

> > [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_calc_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)

ima_calc_file_hash_tfm() has a SHASH_DESC_ON_STACK(), which by itself can
use up 512 bytes, but KASAN sometimes triples this number. However, I see
you do not actually have KASAN enabled, so there is probably more to it.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580D942E677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhJOCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhJOCYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:24:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:22:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g36so18504912lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL/eM01bE/aS6X0zXPcOYzUNCevVbzhFRYi8UnwKms4=;
        b=i/wXc2a4QGZJM/LikZATahyR7wEe+YVAFX6vwdnzX8yWosi7g3BSuAIPIB57T9OoZl
         IhYLJcQLBoUEJxKrT6NNeG+3Q5d0rsi75irx2ivwqJNcyt2ZETMRq1xeTmVAX6Tl6G7c
         GyBbdV79MBhuFNjHvIApxqfRWjI9rhLRrsbC3OYTzrlM4up53VLlVA7n8OYzMBZGnmVU
         0cRe/kye1GLoRgU0VbnpJ2nDHS8WkA6il4GkzxTYf0iDgw01LAznqxYuyyj8EMvysGoC
         pEM5psS7Dfwwz648cA/WrRrq27c37mABcPNb/E9GUQ4ldz3bKQYa+KMe/TdNKXnONw22
         GyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL/eM01bE/aS6X0zXPcOYzUNCevVbzhFRYi8UnwKms4=;
        b=0GYUkdE81gwWP7mVZ7/pky+NXdSmidd8ritq/WCdAlBjys/anJ08fFEhczV0I1vvLH
         UVMFNA/9MjqI5qOpdbRmajsngkaudTnGGJMqArAO73hVrwZ3ymJcS6pvaWa9MrkCi0dy
         QPg+gpFKyx1/ZTQpCArkg+nufqJNf3AwXgjoGw3mHPLvQ06trnzNI35v8mrSwBIgiPS+
         6zoAekl+fjjOp4As5dzu7Cu1/x29JEqOs2yM26rWT9kMEpsoR51D5wDohsvEhFzWiXKO
         8xvJcK5kKSAoiKVP6PkQaEEyws/bUe3BnuKCK5Lh4SHhaw9uQ3QheeXRcnAjvsYbu3c5
         +8OQ==
X-Gm-Message-State: AOAM531bS/atxFrwbYmvE/TQ4GHn8Ip8/6UirO5j8bKgts29Dij/rJaA
        Qg+UlB/NVOSdHExZ6wPq6//bvAgGVk/I4uUHCok=
X-Google-Smtp-Source: ABdhPJwu2ua0mdpYfvSxMQuBHe1bXIVkmL4HoE6skIASKYdpJXBdm7brw21YKZOaX2OhqIgEPI2AR7fDv3xSM4CtqkM=
X-Received: by 2002:a2e:6818:: with SMTP id c24mr9808909lja.471.1634264544754;
 Thu, 14 Oct 2021 19:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132736.266553-1-sxwjean@me.com> <202110140909.8CFD5377@keescook>
In-Reply-To: <202110140909.8CFD5377@keescook>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 15 Oct 2021 10:21:58 +0800
Message-ID: <CAEVVKH9eF9ifwTXZyE5LKEvUcDPAr9rcEmqdM=vwBLcrPvyAKw@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/elf: Fix incorrect STACK_RND_MASK for x86_64
To:     Kees Cook <keescook@chromium.org>
Cc:     Xiongwei Song <sxwjean@me.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:10 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 14, 2021 at 09:27:36PM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > According to the comment for stack randomization of x86, the range of
> > randomization is 1GB, which occupies 30 valid bits in binary. And in
> > x86_64, PAGE_SHIFT occupies 12 bits, then the STACK_RND_MASK should
> > occupy 18 bits for 1GB.
> >
> > The current range of randomization is :
> >       0x3fffff << PAGE_SHIFT
> > , which occupies 34 bits.
> >
> > This patch changed 0x3fffff to 0x3ffff, which makes the range of stack
> > randomization is real 1GB.
>
> Why do we want to _reduce_ entropy here? Perhaps adjust the comment
> instead?

Hi Kees,

Shouldn't x86_64 have consistent behavior like arm64, riscv or powerpc
on this? I'm not sure if 34 bits is too wasteful for stack. If 34 bits have no
side effects, then I have no objection with your suggestion.

Regards,
Xiongwei


>
> -Kees
>
> >
> > Before this patch(bit0 ~ bit33 randomized):
> >       root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
> >       7ffddf971000-7ffddf992000 rw-p 00000000 00:00 0                          [stack]
> >       7ffc4e0d4000-7ffc4e0f5000 rw-p 00000000 00:00 0                          [stack]
> >       7fff5898e000-7fff589af000 rw-p 00000000 00:00 0                          [stack]
> >       7ffcf910b000-7ffcf912c000 rw-p 00000000 00:00 0                          [stack]
> >       7ffce829d000-7ffce82be000 rw-p 00000000 00:00 0                          [stack]
> >       7ffec72d9000-7ffec72fa000 rw-p 00000000 00:00 0                          [stack]
> >       7ffd6e256000-7ffd6e277000 rw-p 00000000 00:00 0                          [stack]
> >       7ffe14120000-7ffe14141000 rw-p 00000000 00:00 0                          [stack]
> >       7ffe21549000-7ffe2156a000 rw-p 00000000 00:00 0                          [stack]
> >       7ffdc9d33000-7ffdc9d54000 rw-p 00000000 00:00 0                          [stack]
> >       7ffe1ced4000-7ffe1cef5000 rw-p 00000000 00:00 0                          [stack]
> >       7ffcb0440000-7ffcb0461000 rw-p 00000000 00:00 0                          [stack]
> >       7ffc84515000-7ffc84536000 rw-p 00000000 00:00 0                          [stack]
> >       7ffe557dd000-7ffe557fe000 rw-p 00000000 00:00 0                          [stack]
> >       7ffdcb7e4000-7ffdcb805000 rw-p 00000000 00:00 0                          [stack]
> >       7ffc6f989000-7ffc6f9aa000 rw-p 00000000 00:00 0                          [stack]
> >       7ffd9322a000-7ffd9324b000 rw-p 00000000 00:00 0                          [stack]
> >       7ffea8e34000-7ffea8e55000 rw-p 00000000 00:00 0                          [stack]
> >       7ffc594ff000-7ffc59520000 rw-p 00000000 00:00 0                          [stack]
> >       7ffe8db65000-7ffe8db86000 rw-p 00000000 00:00 0                          [stack]
> >
> > After this patch(bit0 ~ bit29 randomized):
> >       root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
> >       7fffd0ed2000-7fffd0ef3000 rw-p 00000000 00:00 0                          [stack]
> >       7fffdf555000-7fffdf576000 rw-p 00000000 00:00 0                          [stack]
> >       7ffffec0e000-7ffffec2f000 rw-p 00000000 00:00 0                          [stack]
> >       7fffcfa0f000-7fffcfa30000 rw-p 00000000 00:00 0                          [stack]
> >       7fffff75d000-7fffff77e000 rw-p 00000000 00:00 0                          [stack]
> >       7fffd1d11000-7fffd1d32000 rw-p 00000000 00:00 0                          [stack]
> >       7fffc7850000-7fffc7871000 rw-p 00000000 00:00 0                          [stack]
> >       7fffc956e000-7fffc958f000 rw-p 00000000 00:00 0                          [stack]
> >       7fffdf7be000-7fffdf7df000 rw-p 00000000 00:00 0                          [stack]
> >       7fffeffdf000-7ffff0000000 rw-p 00000000 00:00 0                          [stack]
> >       7fffd7d7f000-7fffd7da0000 rw-p 00000000 00:00 0                          [stack]
> >       7fffe3d23000-7fffe3d44000 rw-p 00000000 00:00 0                          [stack]
> >       7fffde4b7000-7fffde4d8000 rw-p 00000000 00:00 0                          [stack]
> >       7fffd477a000-7fffd479b000 rw-p 00000000 00:00 0                          [stack]
> >       7fffc0e95000-7fffc0eb6000 rw-p 00000000 00:00 0                          [stack]
> >       7fffdbdda000-7fffdbdfb000 rw-p 00000000 00:00 0                          [stack]
> >       7fffec737000-7fffec758000 rw-p 00000000 00:00 0                          [stack]
> >       7fffed163000-7fffed184000 rw-p 00000000 00:00 0                          [stack]
> >       7ffff9a9c000-7ffff9abd000 rw-p 00000000 00:00 0                          [stack]
> >       7fffff945000-7fffff966000 rw-p 00000000 00:00 0                          [stack]
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  arch/x86/include/asm/elf.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 29fea180a665..0b7a5510ebd5 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -343,7 +343,7 @@ extern unsigned long get_sigframe_size(void);
> >  #else /* CONFIG_X86_32 */
> >
> >  /* 1GB for 64bit, 8MB for 32bit */
> > -#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3fffff)
> > +#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3ffff)
> >  #define STACK_RND_MASK __STACK_RND_MASK(mmap_is_ia32())
> >
> >  #define ARCH_DLINFO                                                  \
> > --
> > 2.30.2
> >
>
> --
> Kees Cook

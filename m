Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8A454E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbhKQUWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:22:15 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:36354 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhKQUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:22:10 -0500
Received: by mail-ua1-f49.google.com with SMTP id r15so8701956uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 12:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKWUf574lUCz4mhkC+epdrPctSRHiHVlt/y3bwC9aKY=;
        b=tIdYhAArPDD63mkfwG7Ycrj7wFnkP+bJbDeHrxK7OEwPKEaWqOsPtsps4fWCkYdxYq
         zytQ3NU+NT85chnXgCiiOH2Iei3L9PwuxtlUU5JxxnyA9CAnid7k6BSU0wZ8PfUxVCrq
         SZf6TSmQfGjWKn/BvcFJRv2jUDoevRL/JSi/LHQTfybINfJnuV6JZ80kMetMtXxDHaoy
         BODpOM9Z/7HE0iexOik1w4gc4QVNsQJNcdwzsA7rLJd5v8rN9S7USvTkcVjzOCqDeSIN
         xlm8fT9Rfy8ZEjWiwPN+8CkqNiQkl7veOPO/7Q2cJYugxVNoGfBe87fv7RkbzD/Va+bs
         w7ng==
X-Gm-Message-State: AOAM530L3FKNdhLeeCA+ktAMpmGzL47fkxj848U53zAvKLIRw2ZvOb/i
        n3h4VnebzV8BA17tdfhUvmPbJGJ/pMrvdw==
X-Google-Smtp-Source: ABdhPJzgsjW4F60Hb7os3O8U9T9khwTKooNouI26RXtD545m4VmmI60hz8g352egoVe3/q7mBVF//Q==
X-Received: by 2002:a67:cd8b:: with SMTP id r11mr73268590vsl.27.1637180350766;
        Wed, 17 Nov 2021 12:19:10 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id b129sm555117vsc.5.2021.11.17.12.19.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 12:19:10 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id l24so8686153uak.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 12:19:09 -0800 (PST)
X-Received: by 2002:a67:c38f:: with SMTP id s15mr72611029vsj.50.1637180349098;
 Wed, 17 Nov 2021 12:19:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net> <87a6i4miwu.fsf@mpe.ellerman.id.au>
In-Reply-To: <87a6i4miwu.fsf@mpe.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 21:18:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
Message-ID: <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Nov 16, 2021 at 12:39 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> > fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> > fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes
> >
> > Bisect points to commit f22969a6604 ("powerpc/64s: Default to 64K pages for
> > 64 bit book3s"), and reverting that commit does fix the problem.
> > The problem is
> >       ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
> >
> > I don't see the problem in next-20211115, but I don't immediately see how it was fixed there.
>
> I still see it in next.
>
> I don't know what to do about it though. The NTFS folks presumably don't
> want to rewrite their code to avoid a warning on powerpc, we have no
> real interest in NTFS, and definitely no expertise in the NTFS code. We
> don't want to revert the 64K change, and even if we did the warning
> would still be there for other 64K page configs.

Do you have a pointer to that discussion? I couldn't find it.

Why does the ntfs code have a need to allocate an array
(regardless whether it's on the stack or not) with a size related to
PAGE_SIZE? Shouldn't the array's size be related to a parameter of
the file system on the storage device, instead of a parameter of the
system it is running on?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F32455264
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhKRB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKRB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:57:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C4C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:54:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so19916184edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQjLVKTFCyg54+MPkexuKzcwdgRy8r7qz4+tCabQRds=;
        b=BI6fQpoMzDr/NIPyXsnzRf6xEGwkyY2l7YJ3C4/3nzasNA24ySVmck0yjtyHRSTWwx
         2nBSubXTgx7Kem0XSaUPl17mzkqWwrrECub6ejVlg84mPAuEFmOkrGQlghzzx0m25h4N
         jmdM1gs18w+GbPbcog9/hZdK9bvc/mKgep3do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQjLVKTFCyg54+MPkexuKzcwdgRy8r7qz4+tCabQRds=;
        b=pZJ1O1qTwmWvuD2dgQzxKKnrtVu2pdPjigwpXln/knrmRelJdjylNLsnCg97tqjJ67
         y8YvBDwnH0wjlv0/ztHya0yC4FYvju37YYy/CZbItJ7m9/n+x8eSFDFmAb4ickCzihiE
         h7KlKeYSQpK83EO1pD/jkB4/IPPx0oucS5mfRR6IJcm5Ez9JjAx0ohTk6n4GBHw+GUvx
         OQvUv7jHBlbuqfgmYrQnyUK9qDRhyI7nQoF/O8CaQxu52Jf7hYEU2XuiuqdMB+gtvAcJ
         BgxCAYfgbNSI/4mpLQa+J/vsMjUGjJF+zV8iTeIlO3zhCWSWwduTvxuPk8U8Xxgh9tQG
         vowg==
X-Gm-Message-State: AOAM533w/xQ8iHaZB2t5LlcqgV3EUnJ2mVv0Dx5Xsc3vlx+mkZcb7BKI
        BcVdlvaTNDGc/LPws/P1nGu+VujEYGmcudCQ
X-Google-Smtp-Source: ABdhPJy6o5l9NwbA3ZmMO/1rTQrocrrVd8aR/l1KACxQeRmMYmbg2/dnWxBeBt6wqgbYZwOwioXxXQ==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr29552179ejj.113.1637200463466;
        Wed, 17 Nov 2021 17:54:23 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id dm5sm380038ejc.81.2021.11.17.17.54.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 17:54:23 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id u1so8252405wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:54:22 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr27149051wrj.325.1637200462289;
 Wed, 17 Nov 2021 17:54:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net> <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
 <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com> <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
 <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com>
In-Reply-To: <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 17:54:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
Message-ID: <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 5:26 PM Anton Altaparmakov <anton@tuxera.com> wrote:
>
> So is it worth doing the singly linked list to fix one file only to have compilation fail a few files later when it gets to mft.c?

Heh.

That does sound dubious.

Honestly, maybe the solution here is to just make the Kconfig depend
on the page size not being excessive for what NTFS wants to do.

Because I'm not sure that "powerpc with 64kB pages" is all that
relevant for NTFS to begin with.

The main problem is that the page size thing isn't some generic
Kconfig entry, different architectures have different names for it. On
PPC, the confic name is PPC_*K_PAGES and PPC_PAGE_SHIFT.

And arm64 has something very similar.

We have other things that do that, ie KASAN support has

        select HAVE_ARCH_KASAN  if PPC32 && PPC_PAGE_SHIFT <= 14

(and something very similar for arm64).

But those KASAN dependencies are inside the core architecture Kconfig
files, so it can fairly naturally use that page size config variable
as a conditional.

For something like NTFS, we don't really have a generic Kconfig
variable to test.

It wouldn't be _hard_ to add, but it would have to be done somewhat
sensibly and preferably in a way that doesn't require every
architecture to change how their page size selection (or lack of
selection) is done.

The simplest thing would probably be to add something like
     config BIG_PAGES
          bool

to some generic file, and then add

        select BIG_PAGES

to PPC and arm64 for the 64kB+ page size, and add a

        depends on !BIG_PAGES

to the NTFS Kconfig entry.

But that honestly looks a bit hacky to me. It would be less hacky to
just add a PAGE_SIZE config variable, and have architectures just set
it, and then NTFS could do

        depends on PAGE_SIZE < 65536

or whatever. I just don't know if it's worth it if this is only for NTFS.

I dunno. It all seems a bit dubious.

                Linus

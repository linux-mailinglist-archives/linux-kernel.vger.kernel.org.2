Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6643CEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhJ0Qap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhJ0Qao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:30:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:28:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v20so2356954plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRr1te1ShebQrHtW4iDsunLCdf1ZTZ4EhJL4RXfWiUo=;
        b=ZIU6heVZdj9EjpyklKXt0yOgMPyairYCnlVa0HEf7d5RoBl9GAj4gSkyYzn4dCm2GM
         wLrIbE7kY+Wl5yfNrB5JRnuaRZf06YYgTLOYA60W4SpzMur4LlyDZYSfGtWWyribsLSq
         LUnI0DkLwylDIU7OYLisDbMOCu+MDZiJJ56H9kDdb9MpGPlNtDlfYz9k3eQqPfDDtxBe
         yZzI/Z9TiJ8npewcGUeqesfPwUa3qg7NILi0DAZ66HlLDY2D+OHl4JZYvFiW391XohzV
         HDUIVWuAo72K/ZgjYsSlK1n/qinzT/KH91xPVefZRRuejPWSIEPIJ4MCAXN/J+8JuDDJ
         ueHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRr1te1ShebQrHtW4iDsunLCdf1ZTZ4EhJL4RXfWiUo=;
        b=w3SS8jHya1O3o3nwjkRK2nxGpwwgmFHqkIvJb4zh5AqpziqEm7ZhiApkD8TazfVoIa
         GFWvyDm9gjtM1CGteT21jIHL9JRPio37BaR1tJxP6TTg8d9BvmvCQdKCS3io3WSiYWjI
         J8y86zwHrNKC3d2oe2k29w+fQsb72CkHUfbI4noTQfTW8RvEaYcgWUr+LI+3amlOmD/g
         bXSLJnyM1rjbkMxYzoVrghVlPXmCBQPdFWAnXe+c6LdvrinQHwC4CbCI1/DWCJpMBPuV
         mwRDhIBeag2cJu2tXWxVEkomDL8+sGAnVgbJYGk0UNpFVJP8npas7AnCtNOOvG/piF8u
         8zKQ==
X-Gm-Message-State: AOAM530sHWvJS/Ru9dhbsX6KL0lPQBxrwN772rMIGi8yVCPxuhcIU+md
        f5Jj38NA1cNth0OY9iAh3luInfr4yQgJcR89tltBmY30
X-Google-Smtp-Source: ABdhPJxXqO+Tbltt6IO3vkvNA6ToEeWdCtUOlf//rlyoikqb9lx+BY+rm4aHwh9l67LSIH7gBBoG7H70qlFdRTjQgSw=
X-Received: by 2002:a17:902:7c94:b0:13b:8d10:cc4f with SMTP id
 y20-20020a1709027c9400b0013b8d10cc4fmr29259274pll.54.1635352097817; Wed, 27
 Oct 2021 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211015204713.2855996-2-goldstein.w.n@gmail.com> <YXky/qrRSvvhI3JN@zn.tnic>
In-Reply-To: <YXky/qrRSvvhI3JN@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 27 Oct 2021 11:28:07 -0500
Message-ID: <CAFUsyfJGxpLz14pZ-_nC-3651WaeZeb6p1yteCP2J4=aTKRsrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 6:07 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 15, 2021 at 03:47:17PM -0500, Noah Goldstein wrote:
> > This patch splits the timestamps for tracking the AVX512 status into
>
> For future submissions, please avoid having "This patch" or "This
> commit" in the commit message. It is tautologically useless.

Got it. Thanks.
>
> ...
>
> > @@ -1282,8 +1292,27 @@ static void avx512_status(struct seq_file *m, struct task_struct *task)
> >                       delta = LONG_MAX;
> >               delta = jiffies_to_msecs(delta);
> >       }
> > +     return delta;
> > +}
> >
> > -     seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
>
> Regardless of whether I think this exposing of AVX512 usage is silly
> or not, we do not break userspace by changing those strings which some
> script or tool already probably relies upon.

Fixed. Added 'delta_unified' which will report the most recent usage of
either.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

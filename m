Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0E45095A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhKOQSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:18:08 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35533 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKOQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:18:01 -0500
Received: by mail-ua1-f44.google.com with SMTP id l24so31711071uak.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxRPJItaasT4SOe+d6LbIBPgeLudSMVEfUnFbIzPv7I=;
        b=3IcfiRoXt6S42dwjV4GxtLNjLy/7lxYcyJWo4MPFIUQpI+91DLf2G+CLNzC3N13XJq
         a6Wk9aiMdT+usFZxl0XWIAyrV1N/MOIuMM6xSw+BZmcR24gQQ1cm8F3Cx8ZUFA/HvX/m
         +ow1s0WWpTWrZi3iWmIuIOap3TL1wRcl8GW0TWJOc5RmI1f/3aXMegnriiK13FvT11tG
         xa6C6mihWkZjpwaJ4uBObU0imglL55fJAmoGEvfVYwA4GE6ggt+jYpH19zxK/zWE+f90
         7nip7FbXwHhlYjEyKC8o7HxknSdXNY0S2kz6rpSGCXCvQ9ccHqGOQ78Ime1wgIaU8/Eu
         gLpg==
X-Gm-Message-State: AOAM530jnhjWwX2gdkB3y+pn0Gx2skvpGE9xOO191lqpcQAyMhfBApZr
        kELnBVQePOy3iQPRfwaoXNpFBCOoTlwnjw==
X-Google-Smtp-Source: ABdhPJzXKbHyK1/VryZ409d3/LVev5uVgwx7WqzfsHZa1K1tXDK6yQ3enZKLbSAH6Wtkyry7vIGepw==
X-Received: by 2002:ab0:2498:: with SMTP id i24mr45173uan.18.1636992904964;
        Mon, 15 Nov 2021 08:15:04 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id t193sm9209969vst.9.2021.11.15.08.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:15:04 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id i6so35973558uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:15:04 -0800 (PST)
X-Received: by 2002:ab0:5552:: with SMTP id u18mr8268uaa.78.1636992904443;
 Mon, 15 Nov 2021 08:15:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
In-Reply-To: <20211115045616.GA1012538@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 17:14:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVB6rJVHM0V2NkzAadT=A2+13Twg0bXM+=0Ac-=Fzu8A@mail.gmail.com>
Message-ID: <CAMuHMdWVB6rJVHM0V2NkzAadT=A2+13Twg0bXM+=0Ac-=Fzu8A@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 5:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Nov 14, 2021 at 02:28:55PM -0800, Linus Torvalds wrote:
> > It's been two weeks, and the merge window is thus closed.
> >
> > I actually anticipated more problems during the merge window than we
> > hit - I was traveling with a laptop for a few days early on in the
> > merge window, and that's usually fairly painful. But - knock wood - it
> > all worked out fine. Partly thanks to a lot of people sending in their
> > pull requests fairly early, so that I could get a bit of a head start
> > before travels. But partly also because I didn't end up having any
> > "uhhuh, things aren't working and now I need to bisect where they
> > broke" events for me on any of my machines. At least yet.
> >
> > So who knows? Maybe this will be one of those painless releases where
> > everything just works.
> >
>
> I don't think so.
>
> Build results:
>         total: 153 pass: 141 fail: 12

Yeah, it doesn't look pretty.  See also
https://lore.kernel.org/lkml/20211115155105.3797527-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

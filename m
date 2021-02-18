Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E431EE08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhBRSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:09:37 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44928 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBRPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:39:34 -0500
Received: by mail-oi1-f179.google.com with SMTP id r75so2368646oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNlmKXcHFwKXZ3lQCip3Cekwn845MPPEly4w3zH9oAw=;
        b=qY47nFzDnF6IigBIrFMvZbELu3PrTqJlYDUHVW7rCn4MrmukFO4BaHss8A4w3/u2jG
         0luQMzqQcWOxJxhBAfJEt3oDF4LjGIVljQLEHYvG1GU3oQzdlMALyvWWxYk7C27KASgc
         JfqfYb4blYb3+4Cm5bUgsAiNjSzLtjumpGbO5Y9NRM3DruMH8giRVlGGlbZ0ukFbLmNw
         ZXECd9rHHVhmmJLCkeOVYddHNnN0UlFqdG3NAknHvFEvyN5CXRycD2DrpE+BGOGWxBrn
         GNb2ndt0MwC5ZnlMrd9gEExC9vD06pRjSktx3yVx/iFEaoG+q4jIDNsVs9LFgfgEqhu0
         LVnA==
X-Gm-Message-State: AOAM532Y2jHVmVgNsmPVEIN0nd+nbE9/LBBkDb62Y5ClHzBkvjClIwvX
        vK6wAYsajGLCHdZpLp/Xwsnz8TgR2/2Lp+6Jd+issil+
X-Google-Smtp-Source: ABdhPJz+hnXV9XKu4Qs5llxekDws7JX+4rMLAVZn4bS4sxC/WmxV29bRbkemdZu88iGtN0DQrzt7zVcSA8HNw2VeFP0=
X-Received: by 2002:aca:d8c6:: with SMTP id p189mr3206817oig.54.1613662732142;
 Thu, 18 Feb 2021 07:38:52 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com> <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
 <CAMuHMdUFv2r+YAttodcXhLxEVe+2KXgAG=q8Z3vA6WUKQj7zVA@mail.gmail.com> <CAK8P3a08y3pH6OGtPnPs_HMHRh0Q8xnKr40Lt=vMCW6T1yjz6w@mail.gmail.com>
In-Reply-To: <CAK8P3a08y3pH6OGtPnPs_HMHRh0Q8xnKr40Lt=vMCW6T1yjz6w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Feb 2021 16:38:40 +0100
Message-ID: <CAMuHMdVD+BhxXcmZYvVK5QgtNsmbgyzS_Yx+dbFYmN8xdw0kDA@mail.gmail.com>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Feb 18, 2021 at 2:59 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Thu, Feb 18, 2021 at 1:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The reason drivers/ide is doing that may be related to IDE hard drive
> > quirks.  The old WD Caviar drives didn't obey disabling the IDE interrupt
> > at the drive level.  On PC, that worked fine, as IRQs 14 and 15 weren't
> > shared with other devices.  On systems with shared interrupts, that
> > broke badly, and led to an interrupt storm.
>
> So presumably anyone that has one of those old drives will not be
> able to move to drivers/ata then? I see that drivers/ata doesn't do
> the transfers in interrupt mode, so it would seem to rely on masking
> at the device level.

I don't know.  This was an issue I debugged on a friend's Amiga in 1995
or so ;-)  All bad WD Caviars may have died in the meantime...

BTW, it wouldn't be the first time a drive quirk handling wasn't ported
from drivers/ide/ to drivers/ata/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

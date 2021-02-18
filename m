Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49E331EAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhBROQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:16:49 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44068 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhBRMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:31:35 -0500
Received: by mail-oo1-f53.google.com with SMTP id n19so393409ooj.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLFWnxyElxblI6vJcZgv/haPPfA2hlisE2SESMOZ5uE=;
        b=Kkrst1BaXzFbT/boYl+Wjjnv1Nu9hGvfg8E2zbvXww0CO2Gh+Nff4YQ7kYph/w5tKL
         6JZbJhIkHbCR2mXzs5Jr9WGITnXCe9sfMXTW2r/5meC+BvHLm+y5PsDOgspXuOXwhcJS
         sf8ZiXrT01mevz3fpXbab8FgEcxidcsCPcAY2z0f8ep+hRYIOB4x/QUb7+HO2s/Nrkm2
         kwEPzMPRl/IFECBEowrQSM+1BQIEDW0hxabRZprWcw6SMNTWz0VmCUNcdpbKpe4eSFPr
         e7WJSQFRZ5rQ4l7fWbNp4mGrU7BhN0WM2Mdnpi8opCiWMzOqfdRZOUb0GcT1an/8bv6C
         Zg8w==
X-Gm-Message-State: AOAM5306ht5K+e7FwMiQUdT+JDorsd3SsUX++XeBajtZTmwKE2mBhxUB
        /qXgV40jmQERUpTYBFERwqQ3WwfK59w+JGtTyGzFFJKd
X-Google-Smtp-Source: ABdhPJwrzpZYIOHp//3CdHCqEXC35mKObMW0c55p0aDKVL+a8XY5NAEksaI4blqI4iA4A8A0X7O2KGFsZk4hUJKR3gw=
X-Received: by 2002:a4a:3bcb:: with SMTP id s194mr2788989oos.1.1613651454338;
 Thu, 18 Feb 2021 04:30:54 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com> <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Feb 2021 13:30:43 +0100
Message-ID: <CAMuHMdUFv2r+YAttodcXhLxEVe+2KXgAG=q8Z3vA6WUKQj7zVA@mail.gmail.com>
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

On Thu, Feb 18, 2021 at 12:20 PM Arnd Bergmann <arnd@kernel.org> wrote:
> Most of these are normal short-lived interrupts that only transfer
> a few bytes or schedule deferred processing of some sort.
> Most of the scsi and network drivers process the data in
> a softirq, so those are generally fine here, but I do see that 8390
> (ne2000) ethernet and the drivers/ide drivers do transfer their
> data in hardirq context.

The reason drivers/ide is doing that may be related to IDE hard drive
quirks.  The old WD Caviar drives didn't obey disabling the IDE interrupt
at the drive level.  On PC, that worked fine, as IRQs 14 and 15 weren't
shared with other devices.  On systems with shared interrupts, that
broke badly, and led to an interrupt storm.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

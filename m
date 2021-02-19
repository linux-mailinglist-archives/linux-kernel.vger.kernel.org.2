Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE11731F5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBSILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:11:52 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33365 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:11:50 -0500
Received: by mail-oi1-f172.google.com with SMTP id w1so5071623oic.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPT6wduAtrMWTggH0orR+C1UazQfve0OuOkS45gl8nY=;
        b=H4gwMIdGQuFtr1/78mrPDy4Gy1kELWKS68hAuBOvj1bg6lySsCDFmwfKrBwsU47EFB
         fGCVoPxV9SMwVLsDChilR0XWGGz6PqJKskoUOnSWJ5UsI0b0YPsMRaKyY710PQ1WQf7O
         hBXTpCIZdOdlO0Q3hQ/zLyXRC/lRvKZTdVoLusSCGBSm9mC7KpgNfmrn5vXnRRV9YfxD
         OnhGAtvlVFyjQHqB/foI1K7j09lTN0J1QEiln6qMgJatdlq3uQ5aJMk7E0HRceFgrlhz
         0qgeT1Q6npGJZyLv98tsr8zQRY1n2d0WR975t3rxsJ1ikgk7NJLoJFPj4uW+ieojo8Nl
         7c0A==
X-Gm-Message-State: AOAM530RmBP9inJJrIGr3n70ukklK1zpTZ6DzOv/heDLsdjd9+MQj5Uc
        iWiCJDVTKBHrU100MdmgyUVWskarNOUh6aDycsw=
X-Google-Smtp-Source: ABdhPJyfSiGUOklDk+pZ7+kPOH7+UKy79ImXV69aDZPSdlOwo5+D+0gSw7MvtoDHZ/JLtkZo/RFJZ+PEKeY7w0i2roc=
X-Received: by 2002:aca:744:: with SMTP id 65mr5573246oih.153.1613722269299;
 Fri, 19 Feb 2021 00:11:09 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com> <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com> <a8595ec5-88db-072c-9cc3-7a3a301fe191@gmail.com>
In-Reply-To: <a8595ec5-88db-072c-9cc3-7a3a301fe191@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Feb 2021 09:10:57 +0100
Message-ID: <CAMuHMdWBsupz06wVyVENHfjxP0uQ+1b7cnz6xGEMyqQkJFTeAA@mail.gmail.com>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>,
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

Hi Michael,

On Thu, Feb 18, 2021 at 11:11 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 19/02/21 12:19 am, Arnd Bergmann wrote:
> > drivers/net/ethernet/8390/apne.c
> > drivers/net/ethernet/8390/ax88796.c
> > drivers/net/ethernet/8390/hydra.c
> > drivers/net/ethernet/8390/mac8390.c
> > drivers/net/ethernet/8390/ne.c
> > drivers/net/ethernet/8390/zorro8390.c
> [...]
> > Most of these are normal short-lived interrupts that only transfer
> > a few bytes or schedule deferred processing of some sort.
> > Most of the scsi and network drivers process the data in
> > a softirq, so those are generally fine here, but I do see that 8390
> > (ne2000) ethernet and the drivers/ide drivers do transfer their
> > data in hardirq context.
> >
> >          Arnd
>
> 8390 ethernet drivers are widely used on m68k platforms (Amiga and
> Atari). At least on Amiga, the corresponding interrupt is a hardirq so
> I'd advise caution. That said, the 8390 drivers might benefit from some
> refactoring (the way these drivers are compiled does prevent e.g. the
> APNE driver from being used with two different variants of PCMCIA
> interfaces. I had begun some work on making IO primitives runtime
> selected two years ago but that ended up looking too ugly ...).
>
> Can't recall what IPL the 8390 interrupts operate at - Geert?

#define IRQ_AMIGA_PORTS         IRQ_AUTO_2

Zorro expansion boards can also use

#define IRQ_AMIGA_EXTER         IRQ_AUTO_6

and some boards may have a jumper to select the latter, but all Amiga
Linux drivers use IRQ_AMIGA_PORTS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

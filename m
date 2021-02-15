Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582FC31B9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBONHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBONHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:07:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:06:27 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k13so4126976pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFFOxejaiAtToA7myl7RmqtoPYRgeW980AsV00ZQSl8=;
        b=unuQEYLtyT4/Ao8x5nwwOIRfvuaugs+eGRhuCaq0nuC+p0gTiJxTh1mObC6zZyWo6e
         cTaHZsu8vRwe4P7el44EMtKRA1LDuwGr3TYxaBGj6S/oSEaRey+AjH0MRweYn8o705lt
         +sf1BuHpDLdW4v3oSZSKRIbUg2t0ULo2eYpqK1yM6YAmyTg4ZU30V6nFpzFi2JxAJitH
         HhoxsnvY60nS2A/+Dt5J2o6NmGgdhR6Siho0FzwRtTYAWd4Gz7zbLHU3hhU9vvSX2Q61
         CgbuuFlnItxljUHcF7PXUHCSSnWlseFiZfPvfbWDV1QZCriGC6k1cMyXdJqhu1Nlgi5+
         nqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFFOxejaiAtToA7myl7RmqtoPYRgeW980AsV00ZQSl8=;
        b=BQAp+GLiEqR4fGlKEKccHJh/nS7QlmV5KCk2WYT8F6mf54QjfJCbT1JoKwBsk3z3jw
         VeiFSI6VdPmgS59VkYJh5d2wUkeuB2euci9zGjd2MW6kZ8GA67twKMS7q5a2bx1Lw8cb
         yMn/InpYHNm7RgY16vtM+talyK8VivK8Q1cK0Ojyp+SSekEm5+rwUINPNPgwaBlDt+Tg
         Y82GKPpW/WVo7UWmsAfMbOH4vRqMWUaSuwkA6H7VMDvpADMChb/dVlnECi+NKHSJk3aO
         tjuL0CkJn4EoTPMure3BC17Rlgq+7N/BgV3c267JMvT5++/bM1gYZsdUhI8Wf/FTKMzv
         srAw==
X-Gm-Message-State: AOAM533zPzlWdD1DUa3M1CdF5eHJp2/NOOIYmS5lFRicMP+nZ9ppGr1A
        5qrgUxXcco2VHCmkOU0WdNG0UFD1xIl2vig8mn0=
X-Google-Smtp-Source: ABdhPJyFfiW9cbacENW0DVWjDGRKgGe5GYOIsNaOn/t7pr0ukLADnJ+l0vTG4Ei3JUN4GA5joaDOggt+M3plgiWbs1g=
X-Received: by 2002:a63:3d0:: with SMTP id 199mr14876159pgd.4.1613394387088;
 Mon, 15 Feb 2021 05:06:27 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
In-Reply-To: <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Feb 2021 15:06:10 +0200
Message-ID: <CAHp75VeTKfSAnLUiwJ_SO-r4hUn7aQVTquG0j=k95QO_gk+c1g@mail.gmail.com>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 7:12 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > So what is really confusing and a pain to me is that:
> > For years people like me have been writing device drivers
> > with the idea that irq handlers run with interrupts
> > disabled after those commits in genirq. So I don't need
> > to care about if some other IRQs on the same cpu will
> > jump out to access the data the current IRQ handler
> > is accessing.
> >
> > but it turns out the assumption is not true on some platform.
> > So should I start to program devices driver with the new idea
> > interrupts can actually come while irqhandler is running?
> >
> > That's the question which really bothers me.
> >
>
> That scenario seems a little contrived to me (drivers for two or more
> devices sharing state through their interrupt handlers). Is it real?
> I suppose every platform has its quirks. The irq lock in sonic_interrupt()
> is only there because of a platform quirk (the same device can trigger
> either of two IRQs). Anyway, no-one expects all drivers to work on all
> platforms; I don't know why it bothers you so much when platforms differ.

Isn't it any IRQ chip driver which may get IRQ on one or more lines
simultaneously?
The question here is can the handler be re-entrant on the same CPU in that case?

-- 
With Best Regards,
Andy Shevchenko

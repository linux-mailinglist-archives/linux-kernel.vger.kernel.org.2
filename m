Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F13DCDA9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhHAUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:20:16 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:47076 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhHAUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:20:13 -0400
Received: by mail-yb1-f171.google.com with SMTP id k65so3488825yba.13;
        Sun, 01 Aug 2021 13:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTzcaASLfYxMeVh/o9ndu1xjmQQug01BHbzROqKqzyU=;
        b=px0lZQ/5SmYNXnwopKJT+0YZ7T1+yi8bKTXF/b2whzGFAfiQX0MworM9xeicikk2A4
         rNPKpeP4YHROpCJdSYniXQ+dd9/tsfxkgpoL7ETubsAtiDcbq24iAFJ36wBuhAaD8nJ6
         NGXydDXzWQqBE7iUr3lurzKMiKrGetcZPGYcJqO6ip6Mh3gOL/TyhoANvdfvE8fmVxyU
         JsTI/AzEdaOU1VPNOjp2x0kh4Lz5aRMQUyqM/ep3L0VDyeryfHWeVq5H0ER8EeI9nCxj
         8gek+hhMKKd6DHFTUyp83Io3zz2Lc2znaOx9Hw/eL+yhrnLsD+ebn5HaHttuuvTf/hXX
         9yNw==
X-Gm-Message-State: AOAM533PMalQavBQ4NkWQ0pwvzBqybWqIQwY24OsXiVDdy7+1EhsltTv
        IZhwGk1QUHlc7ZYu6NIL/i43CTO6fCPeCuxR3TaajYOB19k=
X-Google-Smtp-Source: ABdhPJw0qoZXs8yZhg9+B4MNZyQ9bGkX2cF86w6GcxDmRB+ZAk9qShy77Ng5GpqnTbA8RXQe0fpo0yKpG9QEuNRHeGM=
X-Received: by 2002:a25:aad2:: with SMTP id t76mr16609902ybi.18.1627849202760;
 Sun, 01 Aug 2021 13:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210726171802.1052716-1-kernel@esmil.dk> <bcc9de67-f006-0a81-8c3f-2ae5188dca48@roeck-us.net>
 <CANBLGcxpaFt-bokq8=Tie-bJnWk5AqLyr-1Ns-+Xtobxs5bYQQ@mail.gmail.com>
In-Reply-To: <CANBLGcxpaFt-bokq8=Tie-bJnWk5AqLyr-1Ns-+Xtobxs5bYQQ@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sun, 1 Aug 2021 22:19:51 +0200
Message-ID: <CANBLGcyhKYwsLOwaO=BOhaCzP0T2CqKruJZexypRAY3HmEJUMA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: Add StarFive JH7100 temperature sensor
To:     Guenter Roeck <linux@roeck-us.net>,
        Drew Fustini <drew@beagleboard.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 19:05, Emil Renner Berthing <kernel@esmil.dk> wrote:
> On Wed, 28 Jul 2021 at 18:54, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 7/26/21 10:18 AM, Emil Renner Berthing wrote:
> > > This adds a driver for the temperature sensor on the JH7100, a RISC-V
> > > SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
> > > JH7110 version.
> > >
> > > The SoC is used on the BeagleV Starlight board:
> > > https://github.com/beagleboard/beaglev-starlight
> > >
> > > Support for this SoC is not yet upstreamed, but is actively worked on,
> > > so it should only be a matter of time before that happens.
> > >
> >
> > Hmm, makes me wonder if I should apply the series now or later,
> > when the chip is actually supported by the kernel. Comments/thoughts ?
> >
> > Guenter
>
> I'd of course love if it was applied now. That would at least mean
> fewer patches to rebase when keeping the beaglev patches [1] up to
> date, and I'd be very surprised if SoC support doesn't make it
> upstream eventually. But I'd also fully understand the position that
> this only makes sense to add when support for the SoC is upstream too.
> I'm adding Drew, as he might have something to say about this.

Hi Guenter,

Things have changed. The BeagleBoard.org foundation is no longer
planning to make any further boards using the JH7100 or upcoming
JH7110 SoCs from StarFive. I still think support for the JH7100 will
make it upstream eventually, but I'm no longer confident enough to
recommend merging this before there are more concrete plans for the
SoC. So thanks for the reviews. I'll repost it when I think it's time
to consider it for upstream again.

/Emil

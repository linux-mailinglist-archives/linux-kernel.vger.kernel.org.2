Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C94226F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJEMnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhJEMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:43:35 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 05:41:44 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id e7so5516352ual.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXDISnOh7ZckzDfw/rbcZvXrMiBYqKScksuW8yTohwo=;
        b=Id6GY7R7KVW4uvhaDGqG/LWrQ6RRdE1WY7dKbzLj7Ytnar8nAL98hjwk25jwOwdofa
         Q3p8KNC0hBivELcvg9UIHnpq1LPqrMc0WJKGt3BEx3jHkBLz9ZqJX2SYqT0Sxc3st3hJ
         8KRWyAE9Hj3qmrXrXDrLVL8wgFVdiQq6C+nTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXDISnOh7ZckzDfw/rbcZvXrMiBYqKScksuW8yTohwo=;
        b=vlV1lpC0WyWN0HWrWfVoXYzTEUVd2KPyiUtg1WRivyLo6apw69iOkWOWYs7Jf9n6p+
         YD1AWLjUS107UyiVkIKV0H+gg7Tod9a8fRxSFLsccBCVUgjjTyVbJD3Ogll6qTj2/ZZI
         Tqfb5BWY/Fg71XhoRgS7C8C5HYAYBIbUnnqi3AToOdJjhfvnRbLbA3HA3ZxybbBLdWy/
         UdSLOKN2MoF/qZFVNDc1LTAcQg9MdCuOFhqO2n4kwb45Z+s5lGHVUrqTjUCM0b2XlS4L
         Fx5hCGHCLDvAerCPiDTd/A/8OFOgOymJUMQLqoo/Yky3BcWtLEAFD/HpG8gcj+4v72NW
         SJKw==
X-Gm-Message-State: AOAM533OBtM/wyywICJu4QXWh0sD+tiFaQ0KYuhnXzgJAiR2N5OnjoqK
        0r99Se6Btg9oy5cBbpLftXL0/4HkbzXmI1TrfIfW6L/pZqgNzg==
X-Google-Smtp-Source: ABdhPJycar/1wBuMyd28y5qD07f3f9Qc3yBwJUToU1jHeLCtYVBM75fhfQEWYkGKlFKgB5ZSWIo29TnnTykxW5XfrIo=
X-Received: by 2002:ab0:494a:: with SMTP id a10mr11929782uad.90.1633437703878;
 Tue, 05 Oct 2021 05:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210930124950.3069638-1-daniel@0x0f.com> <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
 <YVYmTL8WsgYnxPwc@smile.fi.intel.com> <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
 <YVxBphzSDG2VmM4I@smile.fi.intel.com>
In-Reply-To: <YVxBphzSDG2VmM4I@smile.fi.intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 5 Oct 2021 21:41:33 +0900
Message-ID: <CAFr9PXkN-6MAExF-P8-Biej2yoQYB6eQDezwfPRX4bcXaayZfA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 5 Oct 2021 at 21:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > Ok, is there a reason it's not for the ID tables? Does it break something?
>
> It will look ugly. Why we define a table that may or may not be used?
> Sounds fishy.

I guess it's a toss up between is the attribute more ugly than #ifdefs
and is the ugliness of either worth it..
Not going to say I have an answer here. :)

> On top of that why you should tell linker to waste resources on something
> that you may well know beforehand will be thrown away?

That's true but the linker on my machine with 64GB of RAM compiling
for a single core machine with 64MB of RAM doesn't mind too much.

> > For what it's worth I think the OF ids are a bit wasteful.
>
> Exactly my point, but fixing one driver of zillions does not solve the issue
> in general.

I looked into making OF ids smaller globally. There seems to be 64
bytes wasted from the start for the name and type fields as nothing
uses them as far as I can tell.
Then you have the array for the compatible string which is currently
128 bytes but the longest compatible string in the kernel is less than
64 from what I can tell.
I understand that it's for future proofing etc. Adding a few hacks to
my kernel to remove the unused fields and reduce the size of the
compatible string saved a few tens of K.
Which isn't a lot but might be the difference between the kernel
fitting in a tiny SPI NOR partition or not.

> > For some
> > drivers where there are tons of broken variations they add a few K of
> > unneeded data. But since everyone now has gigabytes of memory I doubt
> > they care...
> Some actually cares.
>

Ok.. I might consider pushing my changes to remove unused ids all over
the place then.
drivers/cpufreq/cpufreq-dt-platdev.c is a really good example of
adding ~10K to kernels for no reason.

> > I'm working with 64MB. :)
>
> Then I would imagine that you already using as less kernel configuration as
> possible and have as many modules as you want for the hardware that might
> appear to be connected to that board, right?

I have a minimal config but compiling in macb for the ethernet
compiles in code and ids for stuff like zynq that I could do without.

>Then again one driver with 100+
> bytes doesn't affect really your case. Disabling, for example PRINTK, will
> win much more for you.

It's not *that* bad just yet. :)

Anyhow, thankyou for the interesting discussion. I'll just leave this
in my tree for now so I don't have to see the warning.

Cheers,

Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA638AD41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbhETMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbhETMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:00:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE8C0611C9;
        Thu, 20 May 2021 03:21:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t17so2329275ljd.9;
        Thu, 20 May 2021 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2cc8lrs7KTJ2rzXzsJVI1VFEnWT2ol2a83/8eM7dQs=;
        b=jHMAj+TPqUK6uCBdJ9yQMBnfh/ME17wsDvCEiziK9Mqs5YOmrpQcTkvOKoGM6tydQZ
         PqIpkU7FieU5u2Fv93H0TxQnA6ZzjXE3M84osHh0Y9hn7J6suhFrrPy7xxpI2NdBAAwT
         JZ2oxbt/Xv2Y/EnBUPNYNXmIVhe8Wj6YS64ldN7h7Nu07LxSPBvku/2tRTwXgnG+KkdZ
         UeKMv4ZNXcaWC/BjjYEol9GE47uU6MMUWIaH0rPbcOs1BLP6Hjvc9QC+ngHIpWpKEE6c
         qs7cGnGNQoZc6EhD7XDRLkf1lEYp26BStuc6kj4NgZ/myUBqoaL6yA4AN49/9yz8hxaO
         2mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2cc8lrs7KTJ2rzXzsJVI1VFEnWT2ol2a83/8eM7dQs=;
        b=sUhQ+Kp5pSVIv/GDkBY3Z7YBR04X0GLfp/6nFtDhKYBI9gmZwtIGz00jDvU5Jih2/Y
         USa43j3tFQMX5jxnq/bAGU9isEk7jIGYEwtGyfIKqc6DBvTB4lTx1FATXN7soO2v4Uwc
         eJE2iWP1b9wiqfBOI2AzOySHWxw2OMqgqMmm1+Y6geJHpE5/atSYDOukwoYJgKFKT00e
         b6xeqIfnMJlja8J5rNsur7oCNmya4aH47qXBx/3Sp0iv2D2SLbcRDuK3F5n9ycwnG47R
         aL/gpnUyzjL1WOZ6784cu019L1kOSfeb0OKio6kj0RSQNZh9ZKUc35ZrBaij7oNAiLdB
         lf6Q==
X-Gm-Message-State: AOAM533oGBoW0clfpzqGvDV+0F1u1U7T8E242pg8urat9eui/nHXPF/E
        b1WLoUahcyLKJ9YCVpUuHALlPqpm0IoyFQPzC9BFHMUHpcaMKg==
X-Google-Smtp-Source: ABdhPJzP0EzigPL60MzO730q2rJB5lyvpkC19VIvrAuQao49kViHZ8hbh47wf1reVrYu9RHb2Jjpg9oWxOU3efr1j7g=
X-Received: by 2002:a2e:1602:: with SMTP id w2mr2572231ljd.510.1621506073369;
 Thu, 20 May 2021 03:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210520015704.489737-1-andrew@aj.id.au> <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
 <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com> <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
 <72ed5aa8-bca5-451d-9458-48735fc17b84@www.fastmail.com>
In-Reply-To: <72ed5aa8-bca5-451d-9458-48735fc17b84@www.fastmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 20 May 2021 15:51:00 +0530
Message-ID: <CABJPP5AMPL22dJ2YKNqdTtHrTJRr=SKnxo05PKn9FoveNX7tow@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 3:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 20 May 2021, at 18:47, Dwaipayan Ray wrote:
> > On Thu, May 20, 2021 at 12:55 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > >
> > >
> > > On Thu, 20 May 2021, at 16:28, Lukas Bulwahn wrote:
> > > > On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> > > > > include/vdso/bits.h via [2].
> > > > >
> > > > > I think the move to the vDSO header can be considered a implementation
> > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > of include/linux/bits.h.
> > > > >
> > > > > [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> > > > > [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > > > >
> > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > >
> > > > Looks sound to me.
> > > >
> > > > I would prefer a bit of word-smithing the commit message by just
> > > > removing the references:
> > > >
> > > > So:
> > > >
> > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> > > > > include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
> > > > >
> > > > > I think the move to the vDSO header can be considered a implementation
> > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > of include/linux/bits.h.
> > > > >
> > > >
> > > > And then drop references [1] and [2].
> > > >
> > > > Andrew, what do you think?
> > >
> > > I mostly did this because initially I wrapped the commit message and
> > > checkpatch spat out errors when it failed to properly identify the
> > > commit description for [1]. But, leaving the description unwrapped
> > > inline in the text feels untidy as it's just a work-around to dodge a
> > > shortcoming of checkpatch.
> > >
> > > With the reference style the long line moves out of the way and
> > > checkpatch can identify the commit descriptions, at the expense of
> > > complaints about line length instead. But the line length issue was
> > > only a warning and so didn't seem quite so critical.
> > >
> > > While the referencing style is terse I felt it was a reasonable
> > > compromise that didn't involve fixing checkpatch to fix the checkpatch
> > > documentation :/
> > >
> >
> > Hey,
> > Can you share which wrap around caused the checkpatch errors
> > to be emitted? We can try to fix that.
> >
> > I was able to wrap it without checkpatch complaining. You might consider
> > replacing it with this if you wish?
> >
> > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> > Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
>
> This wording works because the commit description is only split across
> two lines. With the wording I had it was split across three, and this
> caused checkpatch to barf. If we do this:
>

Yes it won't work for 3 lines. We are checking only for an additional line
for split commit descriptions. Might be a thing to improve in the future.

> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> Move some macros from <linux/bitops.h> to a new <linux/bits.h>
> file").
>
> we get:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")'
> #7:
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
>
> total: 1 errors, 0 warnings, 8 lines checked
>
> Anyway, I've replaced the commit message with your suggestion:
>
> https://lore.kernel.org/linux-doc/20210520093949.511471-1-andrew@aj.id.au/
>
> Thanks for work-shopping it :)
>

Thanks for the patch :)

Dwaipayan.

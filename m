Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A691D3A1117
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhFIKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:34:21 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34722 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFIKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:34:19 -0400
Received: by mail-pg1-f178.google.com with SMTP id l1so19094810pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRGeSLE39DpeGIJGMmlMEVZV7lqFHBN7X0hjsqYQjFs=;
        b=AbrXfpUBAyIqW523w0ojdVtgqbAUg6k5d3bedeZ0zpeDcTYLnH35r0PAyj2igkoDxD
         wl+GpFzxfupceCrZda++kt6KQBISWwyC2NHsi2UCkAaY/Te0eAfSAGnck0qtBcIYyHsU
         xdZFQdayE++4+TYikThoCfYU0G3zH/4ruMJvP6S1WLqw7Qz0p0zOKM2YG9VIebfuFTRA
         X7r7yKPk9pHszI5+8ZjLPcu3TMhuMjN4+OrLmUyDYmV1uu5p+0hK6QaRd2xMVNYwmnla
         aPX9GMPyIPuE0ZTDHJX8rbebk3DUsZlsTnMzDxoEyTFXRlpT9/ik0Fy0nBueJYO9++O1
         jLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRGeSLE39DpeGIJGMmlMEVZV7lqFHBN7X0hjsqYQjFs=;
        b=lLu1Wfroh0kgLFEpoivHgvqW8qQ/5+OurCqP7c6a9bRmow4xvw8f3XmVlYUJ3Nbsrr
         +7Rl5HnkgMNqiVsU3VKUK7ICfj2fVX5p1NeE71iAZVZM1iXQYTmJB46oJzXpuXr1fNeu
         mqel69glR2WmRXPd8lF4zyi0rlu6sVaM5osxQL6tUHefXkoSXhjzwnMxj0+H4+dd8bYe
         /9N3E6ksz29jO0r5zVgwiAmiTjRbsG77l2xlj8zjDXdHanF2F6dQ05/MlzwyogSypVAj
         nlLoAaY8WKEnOemNgBApvfgWxLkm3qpzWJY+/8ctMtGtdh5j7pr7v0+Gc26C2LEVet6d
         ZC/Q==
X-Gm-Message-State: AOAM532GvuENdgBiFq5XbHyBBDUyuJdJq9rzWmYr14RFudFhdHBPj8Un
        92nVT2mpx8cLNaqCPaufKQQdB9CINZd1R+P65KCy1px7nIJBuqUY
X-Google-Smtp-Source: ABdhPJzF44RjQ7aiM8BqrQ3oatkh8KD92ZXldNDtJxttJNQKDISyJgCX8ViNYNymKmLNRaP3AVBP1aZTXFf2dQkIxHg=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr3154361pgc.203.1623234670105;
 Wed, 09 Jun 2021 03:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
 <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
 <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com> <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
 <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com> <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
In-Reply-To: <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Jun 2021 13:30:53 +0300
Message-ID: <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Joe Perches <joe@perches.com>, Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 9:21 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/6/9 13:15, Leizhen (ThunderTown) wrote:
> > On 2021/6/9 0:03, Joe Perches wrote:
> >> On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
> >>> On 2021/6/8 16:44, Andy Shevchenko wrote:
> >>>> On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>>>>
> >>>>> 1) Run the following command to find and remove the leading spaces before
> >>>>>    tabs:
> >>>>>    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> >>>>
> >>>> Hint for the future, try to use what Git provides, for example `git
> >>>> ls-files -- lib/`.
> >>>
> >>> Okay, thanks. I learned a new trick.

> >> For instance:
> >>
> >> $ git diff --stat lib
> >> $ git ls-files lib/ | \
> >>   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
>
> I just tried it. It's too slow.

If checkpath accepts infinite positional arguments, then proper way of
use (that's how I do with simple perl regexps) is to

scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace -- $(git
ls-files lib/)

Seems like we have a shell lesson :-)

> The command I used earlier, removing the line start match "^", can also do that.
>
> git ls-files lib/ | xargs sed -r -i 's/[ ]+\t/\t/'


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA939D481
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGFzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:55:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75779C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 22:53:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn21so20553221ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGKP73gxB2qcDB7wnS0TX4iRqIDKDNuyDeCdJKvegoc=;
        b=SMOBGE8ZsAc9uBH61muG+8ORSDD34YYziHkZybDK+kdM7a5H2LQN7fSzHYfYxx2uAn
         OocYSmRyQwxeBimhs0VxZGXbEh5iueZftT+4P5SR1HNjhfnytYu5nSo5bF0hAZhqP/Oa
         5FqK/UzrC7BwL4ah1vk/DV4iX/wkhF6z7grKMN8kWK6L5Cm6Dsfq5Urks4c5GPpKi4XB
         IXBajtu5aicWTdIT3b6ipWDs9DGBLR9rB1mLBfYcLlkh47KqSVx5m4ljM3ohsG/x8SzI
         4Oq8E7RRAoiq0qGOwS0UXZ/d/M3PkoIXoOA0Izmu/uEdcoTMPpWyv2Uo2UazmVxCxr4N
         c+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGKP73gxB2qcDB7wnS0TX4iRqIDKDNuyDeCdJKvegoc=;
        b=lHFXStYYyaJs0y3BI+XL76Q9Vn5+28dghwalkBlFDLkk4mj1Lu31bT1jCzR801tx8W
         5C9WiKh2o+gWhaqUC/hpr2RTY0MgCyH/ATlL/W9bGX1zjcPIDVHA91zm5ZlClKtlzb9i
         qIU5H3FmSY2JbKprcAfTlZ42Og/hNlJ8o10iWqdb8dOXwrqqRT9+0oHqFTcTVIjaTyxS
         06/CNtUFIZeU4J7D236Vhm1OcKGuqOr5XsQFZ6QGxuTg9D0GTNTVZirQlv9nJqZ5foNo
         3zLewgm6VmNGPvZFpG9Hn7OMeRdCpR7mQWxCJ/w7VLmuNq40D47cAdAxC4Nd5WFjTSyv
         EClA==
X-Gm-Message-State: AOAM533vNlWuwTDgzr04o6yiIIZzI08gsF8fzTOefPlYxRAme4FCnnEc
        AV8FRgXv4UVuN529FnSz06L0oIn+fZgKEKGnqX0=
X-Google-Smtp-Source: ABdhPJzFn8qRU9ZFO6U+SwM2mb7FPe5zu/JSHI6jMGCxNcVeM8U0+WvVDdjp3QTauJ0IZe2OWRZz1sj+fo92ILg9/6I=
X-Received: by 2002:a2e:a586:: with SMTP id m6mr13493448ljp.370.1623045204683;
 Sun, 06 Jun 2021 22:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605191754.28165-1-dwaipayanray1@gmail.com>
 <0c0bdfa2c0c1f2c7ebdcbe7d4a1366c1697ce57a.camel@perches.com> <CAKXUXMyoiEaYaqK9PX3PnUDV94RnVc_A4d6W7JkPOdr_1RCF2g@mail.gmail.com>
In-Reply-To: <CAKXUXMyoiEaYaqK9PX3PnUDV94RnVc_A4d6W7JkPOdr_1RCF2g@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 7 Jun 2021 11:23:13 +0530
Message-ID: <CABJPP5A0ZvbWH8rwR_YwF61ZBKGFef-kLBHKH5r5O=mLdiHZSA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: do not allow using -f/--file option without a filename
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 10:41 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Sat, Jun 5, 2021 at 9:32 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Sun, 2021-06-06 at 00:47 +0530, Dwaipayan Ray wrote:
> > > When checkpatch is run without a filename, it reads from stdin.
> > > But if --file option is used along with that, it may generate
>
> But if the --file option is used...
>
> > > false positives.
> > >
> > > Consider the following test file:
> > > $cat test.c
> > > int x = a - b;
> > >
> > > $cat test.c | ./scripts/checkpatch.pl -f
> > > WARNING: It's generally not useful to have the filename in the file
> > > +int x = a - b;
> > >
> > > This is a false positive and occurs because $realfile is set to "-".
> > > Also since checkpatch relies on the file's extension to run specific
> > > checks for c files, assembly files, etc, most of the checks are
> > > not run as well.
> > >
> > > So it is better to disable -f/--file option when checkpatch is
> > > run without a filename.
> >
> > That's a reasonable commit message, thanks.
> >
>
> That can be shortened to:
>
> Disable -f/--file option when checkpatch is run without a filename.
>
> How about adding a description in the checkpatch Documentation on this
> topic as well, as part of this patch?
>

I can also add it to the next batch of the documentation updates I am
working on. That can list all the flag combinations that's not
allowed. And we can let this patch go independently for now...

Thanks,
Dwaipayan.

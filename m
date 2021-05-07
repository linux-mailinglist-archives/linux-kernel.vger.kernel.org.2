Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCF37606D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEGGft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhEGGfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:35:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8422CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:34:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so11276000lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1t6g0zGx4VeNDuDUeIRnnzjEVtINE776QR3EkBQN80=;
        b=Bxg/Jsg363PqjZUUYaniGWlIExcV/R7L4z1GtfR/+XZpDv+bOqMxyyPg1B6ckjzcDB
         SwoW3LgtjtdyP82Tk4B1OmFdoISOu6P/knk8iViNNsawmufe+EqVqwpSHGjoEZ34G2/U
         JiIZJqnP3JRs9S+F5jvLR6sQJX4GzWr9pZ14k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1t6g0zGx4VeNDuDUeIRnnzjEVtINE776QR3EkBQN80=;
        b=TOhLBOR2EO2lrkPL1/eVfHbnC/UlFhXnPXB+7ZnmuawZ4dhDg3lo6Fy5GMuIpaFMTG
         Ym4yI/DL9y4kEbP3tm0UmnGGyxBsPyr7/80gIeHm1+iKqUYxEkuJOEkhiUGlDI3K1sBZ
         Za0xyA8Rj1YRmgD4/wOjoHeCL3q3LSkKR4TzWwM04lxkqKiGjGptncyP9i4xkmqh3TMf
         EaIDavMb1UR2w9LvMDvYiX8/phrTYu/cwPMiDSP+x0vUi/g48sr/zfGNY8AqOhle9R8A
         5V6dtII7wmUUTzSr4R3WMdVxAhy9NoN3yQIGd9gkxk1kJtu4B2ZhneyvwDlxo4A8ewU1
         b/9A==
X-Gm-Message-State: AOAM532tny4gH1U299fDhEd/jGelNNbtFQoE9K1gApJ/OSaRU4G+QfQu
        1Y05iLbWcg86r156xal3gNqNVNhag2I3ExSdFhk=
X-Google-Smtp-Source: ABdhPJxCZ+luUxaG3Uw4blEH1Uugs/2IQarkF7AV+BHji9VTWAALfFaRCxldTKpY+yzpya2/+u0t8g==
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr5314928lfo.504.1620369285788;
        Thu, 06 May 2021 23:34:45 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z11sm1716830ljc.121.2021.05.06.23.34.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 23:34:44 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e12so10175438ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:34:44 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr6262874lja.48.1620369284513;
 Thu, 06 May 2021 23:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210506180126.03e1baee7ca52bedb6cc6003@linux-foundation.org>
 <20210507010213.V8MhqooKS%akpm@linux-foundation.org> <CAHk-=wjKQZczi-J0rEUoPS+=Q6gCSpr3UmWzh-L8Qs9WGGUHuA@mail.gmail.com>
 <YJTPEXsvTs7QXIBx@localhost.localdomain>
In-Reply-To: <YJTPEXsvTs7QXIBx@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 23:34:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd4eiWFC=Lxi1cMyLNGPZUQsWSJfVyCf6h8gnFr-ekgQ@mail.gmail.com>
Message-ID: <CAHk-=wgd4eiWFC=Lxi1cMyLNGPZUQsWSJfVyCf6h8gnFr-ekgQ@mail.gmail.com>
Subject: Re: [patch 04/91] proc: save LOC in __xlate_proc_name()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 10:24 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Thu, May 06, 2021 at 07:24:36PM -0700, Linus Torvalds wrote:
> > ..
> > > +       while ((next = strchr(cp, '/'))) {
> >
> > Please don't do this.
>
> It is actually how it should be done.

No, Alexey, it really isn't.

> Kernel has such code in other places

.. and then you show that you do not understand the problem at all.

It's the unacceptable "double parentheses" disease I'm talking about.
The "other places" you bring up DO NOT DO THAT.

> "while" loop is no different.

This is not at all about the while loop. Comprende?

We don't do

   if ((a = b)) ..

or

   while ((a = b)) ..

or anything like that.

Why? Because that is pure and utter crazy garbage. The above syntax is
just insane.

> I never saw this warning. I just wrote double parenth knowing the
> warning will be emitted. It's an old warning.

Yes, and you picked the wrong solution for it. You picked the "write
bad code just to make the warning go away".

We don't make warnings go away by writing insane and bad code. We
write sane code.

So I repeat:

> > The proper way to write this is
> >
> >           while ((next = strchr(cp, '/')) != NULL) {

Notice the difference?

Because the "hide a warning by adding random parentheses" is not the
way we do things in the kernel.

So yes, we also write

    while (next) {..

and you are correct that this case doesn't need the " != NULL".

But notice how it also doesn't need the crazy extra parentheses?

           Linus

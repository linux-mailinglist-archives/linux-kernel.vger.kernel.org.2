Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393D33FE1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbhIASFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbhIASFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:05:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD17C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:04:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x19so464780pfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jT1FBNDJ8Khy+4TE63B+kK4MLXv82MCEzJzPE6StIGA=;
        b=or7AB9ZV4bVmEp4PVKukG70PMdtkEQxYh/YAe0wSDizgWal1xd4rZSzAdBjtBNWkA9
         ngIN0iV4SSX3qNm05mmTzS4VW/cXtLKC8p5emiUoY1ueLhAmLC+0w+KdFE5cLwda1+Zp
         w5w0wdVr0SJwWRX8SOrSEYyWu0YHLQc1NkWnSM/stYb9QdqEINRvfugVOp5wtnL5d4Lw
         tLnKVzQeLf0IhmiB71Q4+OM2uJFrNIvf1J46Zyw1fBf/h4wpqrv/DwSFVAjEIvgq3NhR
         iJwCcZ15OQERcEEoGVvtPOBhx7se70wUeOoXVKldG2Vx5GhUxYjHOj6FXYZbK/2dcjVS
         oNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jT1FBNDJ8Khy+4TE63B+kK4MLXv82MCEzJzPE6StIGA=;
        b=BjT9HcJJVfT6bfCV4JYUS2SRJkJj2IYhg+Ng7F6iVd5vnqxf1sUdtqFGbxW1VjQod6
         i2EwrIb/Tv61C1z8W1V8dd+Ok1mLTLRLTB8VMnV4fsakMHaq/NempHDfAum6D/We5q9L
         gIFBx1qoWPJvpNd1PyEYqHf2eGtUFg0tQFjrZCAOCkIve5JPaqWUuVq6GQBEqZ1YcGoP
         AoXu9nqZ42LWZEWhxKWLgpb+UDEQxc2hQNwXmmgJO4nIRS29enfIf7Q1Xs1kpFWs/S9L
         SSiZvHVqJqbm5q+K3LyGKVGRCq+T/uDyNnL1bQ4Mw6RvDQbGoG65d6zZN9syj8dcwUCE
         3YzA==
X-Gm-Message-State: AOAM530lkRsKsa1lFMBoETibtiakLdioTKCHf4zEK51nKAJs4g1E+MsT
        rYm7ovYQU4IkSHUqnJQVxP3c1cghItN4Y7xPTXhaB7MTAl1kig==
X-Google-Smtp-Source: ABdhPJy8K1Q75bsso7kyj+rHAgxfosvMbi5oINX7JEzYAdQYaPMgHfOVQ8YZGaxUhcW97rxmaF3b2Apn5sconoGEqWg=
X-Received: by 2002:a63:fc1d:: with SMTP id j29mr345547pgi.54.1630519486834;
 Wed, 01 Sep 2021 11:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
 <20210831133533.6aayzjghdakrhy56@h510> <13366651.n50aozgL3V@localhost.localdomain>
 <20210831230014.cp46vho2hnndacjp@h510> <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
 <YS+cexhuqldPaACs@kroah.com> <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com>
 <YS+vfVTV0fls6KuN@kroah.com> <20210901173357.2dfvw5xgpzjndesc@h510>
In-Reply-To: <20210901173357.2dfvw5xgpzjndesc@h510>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Wed, 1 Sep 2021 20:04:35 +0200
Message-ID: <CAPGkw+zhb=zC8fKyK8uUiNxNqCUR9Trg6N7fBjaAcBc9rmkmUg@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 7:34 PM Bryan Brattlof <hello@bryanbrattlof.com> wrote:
>
> On this day, September  1, 2021, thus sayeth Greg KH:
> > On Wed, Sep 01, 2021 at 05:34:36PM +0200, Krish Jain wrote:
> > >
> > > Can you tell me why this is the case?
> >
> > Again, it depends on your kernel configuration file as to what will, or
> > will not, be built.
> >
> > If you have some things set as modules, they can be built as a module,
> > but the ashmem code can not be built as a module, so you would never
> > build it if you did the above line.
> >
> > Here, look at this sequence, starting with a tree that does nothing if I
> > do a simple 'make' in it, as the whole kernel is already built, and
> > ashmem is enabled in the kernel configuration
> >
> > $ grep ASHMEM .config
> > CONFIG_ASHMEM=y
> > $ make
> > $
> >
> > So, let's change the time stamp on the ashmem.c file and see what gets
> > built if you use the M= option:
> >
> > $ touch drivers/staging/android/ashmem.c
> > $ make M=drivers/staging/android
> >   MODPOST drivers/staging/android/Module.symvers
> > $
> >
> > Nothing gets built as ashmem is NOT a module, and M= only builds any
> > modules in the directory you specified.
> >
> > But, if you tell make to just build the whole subdirectory, no matter
> > what the setting is, it will be built:
> >
> > $ make drivers/staging/android/
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND objtool
> >   CC      drivers/staging/android/ashmem.o
> >   AR      drivers/staging/android/built-in.a
> > $
> >
> > So that's the difference, "M=" builds modules in that directory, but if
> > you tell it to build the subdir, everything in there that needs to be
> > built, will be built.
> >
> > Be careful about your kernel configuration, that is the key for what
> > will, and will not, be built.
> >
>
> Ouch...
>
> I want to *really* apologize to you Krish for introducing so much
> confusion while you, and apparently I, am still learning. And for your
> persistence with seeking the correct answer here Krish.
>
> I did not notice that this could only be build as a built-in object.
> Thank you Greg for pointing out my mistake, and I apologize for dragging
> this out longer than it had to and the frustration this caused.
>
> It seems I will be reading the documentation again, along with Greg's
> book recommendation, "Linux Kernel in a Nutshell" over this merge
> window.
>
> Thank you again Krish and Greg
> ~Bryan
>

Yes, lots of reading to do :) . I had a look at the book and it seems
better than the documentation too, I don't know, maybe the writing
style? Love it, Greg. Lastly just out of curiosity, Bryan,  if this
can only be built as a built-in object then how come "As for your
patch, I built the driver using:

  $ make CCFLAGS=-Werror W=1 M=drivers/staging/android"

got you the errors that I desired? Aren't you building as a module here?


Warm Regards

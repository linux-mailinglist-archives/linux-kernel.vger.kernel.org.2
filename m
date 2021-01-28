Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BED307389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhA1KSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhA1KSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:18:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:17:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j21so3061497pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDnJWOkOFmVooLwW3iLEaR7P3zzZQ3ejRFAmfGsUQr4=;
        b=nm5BKmFVtD4KaRt5cIVds+MA9Jot7JyVBBQlKOiIydPan7p4oiIckxq+KyaLJB00Nb
         02R7FW7Nhwv0hq5iOD6LJ17h0XWvm06qIGYbm2WmtO/Tn09MR7c4tndTq442s5RDB+XL
         DnHE25BG6MFgiA/H3jKqZmu1WufG3BwQdn6/K29IdWiUv+DlMRPnNb4pTRQyPyMRbK2Y
         4moat9o9wHsLX58rBcoiAhwVAmQEK2ApkBRK57UX5tn8YgMAzkxXhrhGIxOP4Adxooog
         J1i1Htj7RYZdVMSvZem232qaUb8MU1QencicHcQRxb3ALwwy7I6WbB7G9VakU1HYxCHh
         wRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDnJWOkOFmVooLwW3iLEaR7P3zzZQ3ejRFAmfGsUQr4=;
        b=UG5tD8Dot5vXV1iJTjMVF+WZlPpckcYGHxohZyDK9D9LFxN9nscc31IrKzk399jh0z
         pdaQwKkp/hu/Ba9UsyHld4kiMfOkcS9ROo/uLEm1uz4myPx78/Rn7h9nIIfrd2eoOnPu
         2+8xIYZaCdST3T53Hcid6365vgPLvl7tuC9Q/zU8aY1mRZYWOeRjKl6yrPErgBBtv4fG
         SOzv0AC/gpNSBktETbxWWVbenLway/UXjWAl3zJ8KbguJa6138C0Fl88TK+B4BLEsy7d
         rcxZPSX85axBOgzg8NEuBBu3fsDHoriE2oPZAZjK7DF0TWTQeDm+3tn+rBmf0QSFi5Fe
         U2cQ==
X-Gm-Message-State: AOAM530tlhqlstqLDZDXygRzAN+9HNh6fWJeEk2URBoUlDixFj4n9/I5
        CRX8SwgimaO7PoJszSTag0PmbW4ZyKl2bsmhzZIIMZviJw8=
X-Google-Smtp-Source: ABdhPJwZttZrIE3JNDITk20YCw6r0SSowSi64TFkgJO4Bj4z6Sxlets3GP6LC967Csjl1E7M1uOThPS9zr5pI86h8uU=
X-Received: by 2002:a17:90a:644a:: with SMTP id y10mr10741619pjm.129.1611829078364;
 Thu, 28 Jan 2021 02:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-4-paul.gortmaker@windriver.com> <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
 <20210127080206.GE23530@windriver.com> <CAAH8bW-tWRJ4m3pP37YBVrferOa9CwMZGdZkSDC+GXvBfC=Uhw@mail.gmail.com>
In-Reply-To: <CAAH8bW-tWRJ4m3pP37YBVrferOa9CwMZGdZkSDC+GXvBfC=Uhw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jan 2021 12:17:42 +0200
Message-ID: <CAHp75VcZvZrF=YGjQ7Jt2nHguo+kOLNuvrDUV9vHoLom4q+d6Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 2:52 AM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Jan 27, 2021 at 12:02 AM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:

...

> > So, this change was added because Yury suggested that I "..store
> > nmaskbits in the struct region, and avoid passing nmaskbits as a
> > parameter."
> >
> > To which I originally noted "I considered that and went with the param
> > so as to not open the door to someone possibly using an uninitialized
> > struct value later."
>
> struct region is purely internal structure. It's declared on stack and filled
> field-by-field using helpers. 'Someone' misusing the structure doesn't exist
> because the structure doesn't exist out of the scope.
>
> > https://lore.kernel.org/lkml/20210122044357.GS16838@windriver.com/
> >
> > Looking back, I had a similar thought as to yours, it seems...
> >
> > I am also thinking more and more that nbits doesn't belong in the
> > region anyway - yes, a region gets validated against a specific nbits
> > eventually, but it doesn't need an nbits field to be a complete
> > specification.  The region "0-3" is a complete specification for "the
> > 1st four cores" and is as valid on a 4 core machine as it is on a 64 core
> > machine -- a validation we do when we deploy the region on that machine.
> >
> > I will set this change aside and get the nbits value to getnum() another
> > way, and leave the region struct as it was -- without a nbits field.
> >
> > This will also resolve having the macro handling of region that you were
> > not really liking.

> Region is a convenient structure. Adding nbits into it helps to remove
> validation
> logic from bitmap_set_region(), so it's worth doing this.
>
> Can you please have it unchanged?

I have a compromise proposal here, i.e. why not to create a wrapper
structure like

struct bitmap_region {
  unsigned int nbits;
  struct region r;
};

?

At least it will solve my concern and still be a local structure on
the stack without adding new parameters to called functions.

-- 
With Best Regards,
Andy Shevchenko

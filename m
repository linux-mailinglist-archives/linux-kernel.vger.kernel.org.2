Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652B400617
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349690AbhICTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhICTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:50:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F67C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:49:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u1so168802plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgpxLjOF/QKA0B+p7tW54Ior4Pi9CIfJybRDtP2mPk8=;
        b=G7/ki6Av2eCe4jeL/T9yynH+cqXZpSo9ccACyStofz6CNFAWHE5EcyRg535Kqxy0lO
         uyY8297O5gC4f0HGtUkfgIXXCrRaMQgCBMW8UOlRWTuVBum6tVaF+W7/j1JCjEHqJWcD
         jAVYkmioMEFLKQ7eaIamIVdxmRWGkJlz/Hq262rpUMB4WWiSYzw2cFOEKv5bnKkWvqwq
         8MtIXfTGcj7SvQg27K1OlL6878t5RP6aXdQvlT4Z8yaYtNM/7/w+oOKzFvHQeX1R7+w/
         MUhTODwGwBZKyxOr/YQPV7X1toTBMOoBK9a59NVH6qc/a6AGtPIeX2dMBM513ZuPzr9V
         ChVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgpxLjOF/QKA0B+p7tW54Ior4Pi9CIfJybRDtP2mPk8=;
        b=YW8+Uzo0rz4MUbEswIHi8FUbPU2+HKp0CVq6HhdvtZHKPtFnwzAK4h4tSojwbHOk3Z
         i5Leg3xgID8viG3rxNm4+inrZ8BgdtQej5hVDLdvlZ5GJTW6Va2rpuYdbNV6gJ6nCeo1
         UpFvptrjoTRMQ11k0sgrKly68h8i2xAoMH3jHZXK4WGDfwvb4oRVq0uNYf9sd4k30Jhw
         t/efY0yTqqlxAzK+0hxvkbVEyKeJ/08BoN0s0DZX04IdvH/nom5yvjf0yyWMCnnTac0z
         2Eprg+ZNu19U8Ddl+mM+WJGq+D4iFog+GTLyzC3Bb9rmvfnq7kLLKiD8y3Q3OhY+fsJF
         OIOg==
X-Gm-Message-State: AOAM5323/yrEFYpMma50Ejd48OiOwV7SD3CIEl3abX+/k7f5LhrUB5lV
        ym+aGdHtVuY6L9+6nuSGUuqeVHyy4LdRmAUW4mg=
X-Google-Smtp-Source: ABdhPJwyj3RSpH6y/BfTPZ4qBH19siRogzTXnU/CR9U686smAlTzYozZ4hAh56Rec9T1JF6YSylaKda3fhlDoMzLEz8=
X-Received: by 2002:a17:90a:4805:: with SMTP id a5mr502473pjh.139.1630698544332;
 Fri, 03 Sep 2021 12:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210827171155.700434-1-yury.norov@gmail.com> <YSuNTVh17CxUNxtC@smile.fi.intel.com>
 <20210903105607.35af6674@gandalf.local.home> <YTJGyk65rv/026+p@yury-ThinkPad>
In-Reply-To: <YTJGyk65rv/026+p@yury-ThinkPad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Sep 2021 22:48:28 +0300
Message-ID: <CAHp75VfHg8RqdjF+5AQwOFvJqomeXe9DAZwMEJVZhkKcrJuvzA@mail.gmail.com>
Subject: Re: [PATCH] lib/vsprintf: add __putchar()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 7:02 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Sep 03, 2021 at 10:56:07AM -0400, Steven Rostedt wrote:
> > On Sun, 29 Aug 2021 16:36:13 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Aug 27, 2021 at 10:11:55AM -0700, Yury Norov wrote:

...

> > > > There are 26 occurrences of the code snippet like this in the file :
> > > >   if (buf < end)
> > > >           *buf = separator;
> > > >   ++buf;
> > > >
> > > > This patch adds a helper function __putchar() to replace opencoding.
> > > > It adds a lot to readability, and also saves 43 bytes of text on x86.
> > >
> > > Last time I tried similar it failed the compilation.
> > >
> > > Anyway, while you remove a lot of code I'm not sure it makes the code better
> > > to read and understand. Also, we use the same idiom outside of this file.
> > >
> > > I would ask Rasmus' opinion on this.
> > >
> >
> > I actually like the clean up, although I haven't reviewed the entire patch.
>
> Thanks.
>
> > If it is used outside this file, perhaps it should be in a header instead
> > and those other locations should be updated accordingly.
>
> I used 'grep "buf < end"' to find spots for cleanup.

You need a "smart" grep, i.e. coccinelle for that.

>  And except for
> lib/vsprintf.c, there is a few random drivers inappropriate for this
> cleanup. Andy, can you please share details?

https://elixir.bootlin.com/linux/latest/source/lib/string_helpers.c#L307

-- 
With Best Regards,
Andy Shevchenko

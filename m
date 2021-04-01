Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E496352084
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhDAUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhDAUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:19:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276DC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 13:19:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so3550359lju.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMacy08brvFfRUpYLeP+H4MOScmZa9E7wv4MmR/VBGg=;
        b=eXfFVEjjROP1Q+nQ3NkaYjzuM9Uy4rJLC3deMgud30BeozKDTSpL6nRamRM0PHVQfY
         Kpu+X9dwlQeGcGulc+bo8E/mzC/TYLCLXm68cUGY23E5PGb20HJJFdGYLzqi095Q3Wqs
         wCc6FcPf5f5nXZg9IZ+LgxYIhmVuTgHFeRli0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMacy08brvFfRUpYLeP+H4MOScmZa9E7wv4MmR/VBGg=;
        b=U6mbTHWKfUTuXvRz6wW8NadLc5NrR/kTpwKC5+4SvvWa2Iyi9KoojEDQ/3EhlNLxSQ
         bFxK7AdxRjz3QcCpQIgjhdNG2Y/lWLFcm6tGf2jv9VPjWgA/JryHoxZQ1/ZBoykbHDcj
         813UuiAqGpjgMXbhEf7JfQ5Ojy+jWARZbBWXUxqtTVP9BKyXof4BY/u0EVjOy4j6Nfst
         ZAZaVgp5tTEnqI0cWf3c07g/A+fNmL3cVfLUnRFVXHU44wgoS0KM/OtlowoVUz3HJ32D
         zxok6VxFqs8udAZ7c3Uftnz9I6dDTQkFjyaPdtH35RPbZpVtza8Bj0V9PG2igJH4WiNX
         1W0A==
X-Gm-Message-State: AOAM532Cp9BRtF60MXhdCgu1MyGxqutAmwVXQGvcv5pfbgC9cQZ4K371
        RAJfe+sR/xDHsmxmyDCbDtSk3CIhuqwX5A==
X-Google-Smtp-Source: ABdhPJxK0W8Y993c8qKUTjkSpfwoKEn/QRd48/yXsIpqkKordBowAUW+yHB3CnPbfax3YwLn/cZJfA==
X-Received: by 2002:a2e:b55a:: with SMTP id a26mr6271230ljn.297.1617308356974;
        Thu, 01 Apr 2021 13:19:16 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d22sm657966lfg.160.2021.04.01.13.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 13:19:16 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n138so4665935lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 13:19:16 -0700 (PDT)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr6332540lfy.377.1617308356006;
 Thu, 01 Apr 2021 13:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210331092711.2b23fcff@gandalf.local.home> <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
 <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com> <20210401160710.45a7a9b8@gandalf.local.home>
In-Reply-To: <20210401160710.45a7a9b8@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 13:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_6JBGSiKtQp7CT99kFt2L5b1sbvs6YBTXJAWdPc8Hig@mail.gmail.com>
Message-ID: <CAHk-=wg_6JBGSiKtQp7CT99kFt2L5b1sbvs6YBTXJAWdPc8Hig@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling free_pages()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 1:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 31 Mar 2021 11:03:21 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > @@ -6231,7 +6231,8 @@ static int ftrace_process_locs(struct module *mod,
> >               if (!addr)
> >                       continue;
> >
> > -             if (pg->index == pg->size) {
> > +             end_offset = (pg->index+1) * sizeof(pg->records[0]);
> > +             if (end_offset < PAGE_SIZE << pg->order) {
>
> I believe that needs to be:
>
>         if (end_offset >= PAGE_SIZE << pg->order) {

No, but the "<" should be ">". That was just a typo.

It's ok for end_offset to be at the edge. That's the "we filled the
pages completely".

I'm not sure that can actually happen (it depends on the size of the
structure, and whether the size of the allocation is divisible by it),
but it's not wrong if it does.

Think of it this way: imagine that we have one 4kB page, and the size
of the structure is 1kB in size. You can fit 4 structures in it, and
end_offset for the last one will be index=3, so that you'll have:

        end_offset = (pg->index+1) * sizeof(pg->records[0]);

which will be

        end_offset = (3+1) * 1024;

ie 4096. That just means that the struct fill fill things _up_to_ the
end of the page.

So only when the end_offset is strictly larger than the page would it
have overflowed the allocation.

             Linus

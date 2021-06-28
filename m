Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6753B6718
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhF1Q4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhF1Q4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:56:30 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:54:03 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c26so10401915vso.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXKnP1FQvnqQE4gLc2QyShns9So7MaxmMPDz9zDzkAg=;
        b=jJ+rYfu7MIS/keksiWbXbRhnWEhocL6wEArPfI+lZHasgLCHaVj6bEDerDfN2VoBCM
         jQ4UQbQehQkPlnf8JtisZ7x7v/h5vdGpxXk0sC7nSTgV9SCpVL05VtG8NTofFqxFhQAT
         CzPilAt/eIt6cx3bIfH+wQ3aIsbVRFBozY6F8dcxasP7p1bIMtYfmIaf3qwo71ttXwG8
         Nrpxfbx2b0mum7D/wNiUhpd5h6pTts9ojzR6NTPmDdBdhqeHL7/bmY0JNNHGKCkwp2s4
         LCNxd/7mDzHOCNpBI6fNPDw1aqdr5+3sxFKw61uVN5AQMTwhZSx5j2v/k/LJ1EgJ0jI/
         53MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXKnP1FQvnqQE4gLc2QyShns9So7MaxmMPDz9zDzkAg=;
        b=nFBB48IKzFcjDB7Q2YNRe5YhDjxYRrXc/jUf60L89pGF48FUsTP1qCTQZLEv7kvehI
         ImvYBAuvr20vN5vOjLC7L96mzdbkQ06t/EkRxz4xNwWqfDfFeh0bFUsXoItpaeNBH8C1
         XeF5RY3FJXXkTOnMKP8PsFIj1YAvO+R6o10cbJ449FwPkY0ZZTRrlERPXaoW7l80isVn
         xgyk3srCmRZZX6JaVVqNY386XGAK+dW6azpn3JC0Z6wPydKnpFaeUFb/TdYR285M2LhE
         9rD+RMQ9Ln/feGsN96Eb7YDHqDdj0iB2KF32qqwx5DwjmKfCpy1NK9nFcXg/+PK1wiYC
         H+wA==
X-Gm-Message-State: AOAM5326Ip9ckfsAT5hjyG/j1IhgtQHyjAX/uflnj8FcXQczomg5L13d
        QbpHwEH+KnPDAelK6NG8NjhsTHQDe6lFn/XKMmVdJnEcCrg=
X-Google-Smtp-Source: ABdhPJy1T9zLSZgLx9s6LceT/kfzxCQUURZvxZv4QvNVuMZ2EjAHcj9Ztb9w1gZGoIP4ELsY7Ldi/Rmi7Fp6zp7CN3g=
X-Received: by 2002:a05:6102:34c7:: with SMTP id a7mr2929660vst.26.1624899242546;
 Mon, 28 Jun 2021 09:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210626034016.170306-1-jim.cromie@gmail.com> <20210626034016.170306-2-jim.cromie@gmail.com>
 <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
In-Reply-To: <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Mon, 28 Jun 2021 10:53:35 -0600
Message-ID: <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree.

On Sun, Jun 27, 2021 at 9:17 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2021-06-25 at 21:40 -0600, Jim Cromie wrote:
> > Before issuing a WARNING on spacing, exclude reports on linker
> > scripts, which don't comport to C style rules.  skip_on_filename()
> > skips on *.lds.h files, I think covering all cases.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2546,6 +2546,11 @@ sub get_raw_comment {
> >       return $comment;
> >  }
> >
> > +sub skip_on_filename {
> > +     my $fname = shift;
> > +     return $fname =~ m@\.lds\.h$@;
> > +}
>
> nak.  This is poor naming for what is not a generic function.

indeed.



>
> > @@ -5134,7 +5139,8 @@ sub process {
> >                                                       }
> >                                               }
> >                                       } elsif ($ctx =~ /Wx[^WCE]|[^WCE]xW/) {
> > -                                             if (ERROR("SPACING",
> > +                                             if (!skip_on_filename($realfile) &&
> > +                                                 ERROR("SPACING",
> >                                                         "need consistent spacing around '$op' $at\n" . $hereptr)) {
> >                                                       $good = rtrim($fix_elements[$n]) . " " . trim($fix_elements[$n + 1]) . " ";
> >                                                       if (defined $fix_elements[$n + 2]) {
>
> This .lds.h test is also used in one other place.
>
> It might be better to avoid all tests in .lds.h files by using a
> "next if" much earlier.

YES.  I see the code uses  'next if' syntax. so this would work.

   next if ($filename =~ m@\.lds\.h$@)

I will find a good spot for this line.

thanks
Jim

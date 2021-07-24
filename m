Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE53D4A03
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGXUWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:22:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD2C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:03:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so14117671pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEcCULqEhyKo2SpGJ7Bqqo2I7j0KMhnjJxCcjjRShVM=;
        b=O08+G8oEvcc5wa+k03WpMAiABwmJGk/2QcKYkhhhXIIjEYujrBrqnmHOmGl0MVE2Ys
         X7nboEc6mVsLFFqpQTQgdl3zFQlkwEd1/0Tqe0dBjkkcoL1JgUtCo4jobmr14KhzXmZP
         VnsJlJyHlFGR9+axQGRoEkupOGlgJKqnV/ke56sf/g9/4cgkCh5AFnSkLD3h4xFAJHzT
         SJoNzT3fcIS9blGStoxhEtYlJ232UwZ9hxwsEbjzDsrBi9D4AGdA/JCsd/ytImTGHRDq
         URzGArLt4HvJh1lovFFHG2F8GJkl92y58LN7/8/goLuYz4aUJn+f3UyRMwNBDz/ajE24
         ZsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEcCULqEhyKo2SpGJ7Bqqo2I7j0KMhnjJxCcjjRShVM=;
        b=k2Z7X5FGfCr4GIS1gXmDJgKk29RDXljM82pEio1RXVZPY6oDTLqWggoE608xtTJtTk
         z5pYQIf1AIunHo23zWRH8PJeQ18gc+w467ZEsWQ9fH69MpAuPFm8LZcmsE3yylYcQnaA
         UYuj1ls+ddiE8afZpwA2Bb6DRmUkiH1txtki651SqP9DVxF0SvPP8qS0nXajlH7B6kjC
         R/3pCqQWFFD3BRwYqPQRhW+tVMOxvRW8a/6Xji7WyvhTWMc+nR+yEg7FoLX92Lrx9CQm
         c4v63vSbQaDzxrT1i5grqq89dj/ZTYjt7tBIfHByH7oZmOZj4czqtWiiHdJWKlD5EUOO
         MYog==
X-Gm-Message-State: AOAM53298IHqARUJf1XAy3+ZPb/mOfmhwi6pib/gbqGezXTCm1PiRJkD
        YpzGXljH9fI1c80N4CFBt4MmxMaxOSG0qyHBEj8=
X-Google-Smtp-Source: ABdhPJwtzob59wiKP2UdJSzMit3B6pc7qSsZfnlE6rn42x4zn/OiL5xUloOLwq3ckcRAsS5A+9udDhdAFWlJ8hPfDNE=
X-Received: by 2002:aa7:8a04:0:b029:332:950e:d976 with SMTP id
 m4-20020aa78a040000b0290332950ed976mr10721501pfa.40.1627160589201; Sat, 24
 Jul 2021 14:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk> <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
 <CAHk-=wggE0PF4fAi8cFEpi=ryyV=WyYupddcHHbE3nggQJgYig@mail.gmail.com>
In-Reply-To: <CAHk-=wggE0PF4fAi8cFEpi=ryyV=WyYupddcHHbE3nggQJgYig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Jul 2021 00:02:32 +0300
Message-ID: <CAHp75VdXMB7EaBVpvMY=sjbnoUrYY1RC7zzsh3ZsMoNgJo7TRA@mail.gmail.com>
Subject: Re: 5.14-rc failure to resume
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jul 24, 2021 at 12:44 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > This does appear to be the culprit. With it reverted on top of current
> > master (and with the block and io_uring changes pulled in too), the
> > kernel survives many resumes without issue.
>
> That commit seems fundamentally buggy.
>
> It makes "acpi_dev_get_next_match_dev()" always do
>
>         acpi_dev_put(adev);
>
> to put the previous device, but "adev" is perfectly valid as NULL, and
> acpi_dev_get_next_match_dev() even tests for it:
>
>         struct device *start = adev ? &adev->dev : NULL;
>
> so it can - and will - do
>
>         acpi_dev_put(NULL);
>
> which does
>
>         put_device(&adev->dev);
>
> and passes in an invalid pointer to put_device().
>
> And yes, that adev very much can be NULL, with drivers/acpi/utils.c
> even passing it in explicitly:
>
>   struct acpi_device *
>   acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>   {
>         return acpi_dev_get_next_match_dev(NULL, hid, uid, hrv);
>   }
>   EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>
> Am I missing something? How does that code work at all for anybody?
>
> I probably _am_ missing something.

Yeah, the two changes (acpi_dev_put() and this fix) were in separate
submissions during different times. So, what we have here:
1) this fix misses that one line to be changed and after adding it
2) reveals UAF, or i.o.w. NULL dereference which is a bug in acpi_dev_put().

acpi_dev_put() has to be

if (adev)
  put_device(&adev->dev);


-- 
With Best Regards,
Andy Shevchenko

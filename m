Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A073E2C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhHFO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhHFO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:28:06 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC910C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 07:27:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p145so15473671ybg.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aE4oqvzCumQErrCzIDeCtJXvE6QYjywVC8g2m4kmOyA=;
        b=WqRLh1NKpyrfhDetHJ+MW/iNZ+m8oxDvO69RthRWrsJ6E6UncbU3Oapy7958Z6/HWr
         CMo1x50Ok8newbw5nofoDhqaxVHmZC7I4Rp0H9RYgNAEBVgkVRHIUmuAZOz6OnCz0KDi
         hgxbPcsHykCc+hwM97QDOKgnAtnyh3CzQCg+xQ1KDvLdVlxnCqmlbZN2ChJYbMuCm7h2
         nWRQ6q+OFU1SlMsqkUDb1c0fKIJvkj44xzE5jcnpPDKrQ7bWK+VSD6wSYYd9/42vqueh
         YVqN7fq562a+IDFtWzog/pBR0+tpqRfNK84vfIXM1kaNx1WLU2uAqvbgAL0b1iLP2lZJ
         0+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aE4oqvzCumQErrCzIDeCtJXvE6QYjywVC8g2m4kmOyA=;
        b=AERcOQxivdZNbvhzi9qDB7O9wvmxVIGhFtqoP2gQshVbaOvCipfCbhCMnRWdJMYfBP
         aw8H0eVb18W7EybFDJU3j7yAr9TzgOqPFMyafp0cn287IE/6tFS+ObsoJIhVDqrXbsCO
         +vFw7P/3esHGs8xVx378zbk5vUawiIIiO0yPV/QsjTk7RP+Gl4dHqTqut/6M/3Ubfkah
         wtbmU1YhtJJhdT+5+rVTTRiTCXrt+ijwpb1OSbK3jTOdKTvu94GgP6PCCLgFK+NTiBSJ
         lBifBx4ijMmgU3Qt7f0DBfxznazKdjfgwy1PrZp31eFfHxt7wl6rGWNJfnBfrFCO6My7
         Ky0g==
X-Gm-Message-State: AOAM533e/8Son1Zntwe07kJYdp/J1qFNZEvuQWl3wXOt6yFUXLGPI0ls
        JA/yjDklJRS8l6AG2RV5KDLsc44ECiOkLLb/hDHhbZEzp/8=
X-Google-Smtp-Source: ABdhPJyR1k9vj33SlcNE7XlOPVwJGDBSRaaHyuW5b7WYDJpd7yHTJYTzF6D3qkSH8PYyZ/mLGAS9DnGiegfkZp1HYVM=
X-Received: by 2002:a25:d290:: with SMTP id j138mr14083025ybg.151.1628260069813;
 Fri, 06 Aug 2021 07:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210806114049.649909-1-jun.miao@windriver.com>
In-Reply-To: <20210806114049.649909-1-jun.miao@windriver.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 6 Aug 2021 16:27:38 +0200
Message-ID: <CAKXUXMxrE=OO3K6fafU38GDp3cvEtRYrqo-w2-hDO6OrvHe26Q@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: Fix a typo in check_hung_task() comment
To:     Jun Miao <jun.miao@windriver.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        deller@gmx.de, wei.liu@kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 1:41 PM Jun Miao <jun.miao@windriver.com> wrote:
>
> It's "mustn't", not "musn't". Let's fix that.
>
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
>  kernel/hung_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 9888e2bc8c76..ea5ba912db06 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -99,7 +99,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>         /*
>          * When a freshly created task is scheduled once, changes its state to
>          * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> -        * musn't be checked.
> +        * mustn't be checked.

I cannot even parse this comment.

Does "When a freshly created task is scheduled once, changes its state
to TASK_UNINTERRUPTIBLE" mean "When a freshly created task is
scheduled once and it changes its state to TASK_UNINTERRUPTIBLE"?

Does this "it must not be checked" read as "it shall not be checked"
(as in "because if you check it, something goes wrong") or "it is not
required to be checked" (as in "usually, you need to check it
(otherwise something goes wrong), but here in this case, you do not
need to check it, because it cannot go wrong in this case")?

Fixing spelling mistakes is okay, but it is even better to check the
sentence you are correcting and try to comprehend it.

Lukas

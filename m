Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAE31D17C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBPUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBPUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:21:59 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:21:19 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m188so11602448yba.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqItVs551xarAqTOXx3vKqdvAq2kdgOmNogAihMa454=;
        b=ThYcsxbl9GGOgIWSjQA4X5VpumK7laL0Rao1M1r3y1Lx9Yvfr6MNq4BGXWI+mcFCF9
         +kyoAGdKTSRVCTouUEIoBPqLPQn3aDG94hQYVjXse/6iIPv84W9bjGn300ONZdQ2UGmR
         KXmjzWYsgawWoC7z8vGVLZ1C1uJxcFZw/7dkrfSlcUpDJG272tYAayf1hEHR2poniUyk
         etcwONHg/tyRXjC3qwC+9uP2pDloBZXqoBGqWEb89MAIUWxMI6I+ev9irgksZjJvjx3t
         bQ56D8OvyJkbH2T/ogz9JEVCc/kxYTVmKiTpmE7rB8PQ7e6FSj/YuPoBAiI9s+DVwY+d
         +Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqItVs551xarAqTOXx3vKqdvAq2kdgOmNogAihMa454=;
        b=hstuYuUG8C+JIig7bMqK/tMjepKNDT2lVC/3Z83zGRa3BWiDZoySK9LqcgdWABvd2R
         a8l1prsVb0zXc0IUBphls/l7CX+POlTfleW+VygAlQ23mru/fa6HlRi6eZRrTJe8rGw8
         8+0FTm4OUUe1gd7qDjTE+fSyGj9FWMPq7kiXLfTfCo5IQcnki5ElfhgWefkNz/BYOXJB
         44LbkaWrXd8JfH+MUqdnGDnbm5+4oPQDEoejd95v7mAc1a9aBywbYIk0YIHYik+8xSVQ
         DRtKydnw1BTOc6jZh6h0LAZR7qtgl20fKOoI6lzy+x59z9hE2ZGxeIiyWycwDYtdEXZf
         b9nA==
X-Gm-Message-State: AOAM532/jPoo4ilcGjaVd7wm0QUdpBpZOxSAn1MzJR2m66T8YTcfcvbz
        CmwLWvebKjZ0yI+OGwdmw6kCXIAbpNY9XEbUv7s8Qn9dEU4Q2w==
X-Google-Smtp-Source: ABdhPJwrr5Qgyjz10IJQE+TRaOGEkPRLIH9sUGO0RnNDVutUIe8LZmt3uLu/CSNxarRM958wc39ULdAq3XK5gZygGNU=
X-Received: by 2002:a25:d6d5:: with SMTP id n204mr1770723ybg.22.1613506878819;
 Tue, 16 Feb 2021 12:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de> <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de> <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de> <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de> <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
 <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
In-Reply-To: <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 16 Feb 2021 21:21:07 +0100
Message-ID: <CANiq72np-G3whePohyYazx3KpP6A+DsRwq-bjd7E7qKb1JG62w@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 7:26 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> That should be part of the commit message. You can always rewind to the
> commit message that introduce something and check if the commit message
> made sense or ignored a detail which made it wrong (or so).

No, it shouldn't. Commit messages are used to justify changes in the
past, but they shouldn't be used as a replacement for documenting the
present. The reason `in_interrupt()` is removed should be in the
commit message; while the reason the precondition for `cond_resched()`
is fulfilled should be in the code (assuming one finds the comment
necessary, see below).

> So it was needed once, it is not needed anymore. That was my arguing in
> v1 about. No word about general removing in_interrupt() from drivers.

Not sure what you mean by this.

> This is not a fix. It just removes not needed code. Also I don't think

It isn't a *bug* fix, yes, but it is a fix because the removal should
have happened when the code was refactored. We can call it a cleanup,
if you will.

> that this is a good idea to add a comment to avoid someone to backtrack
> / double check something. If you rely on a comment instead of double
> checking that you do is indeed correct you will rely one day on a stale
> comment and commit to a bug.

Sure, comments and documentation may contain bugs like anything else.
That does not mean comments and documentation are useless and we
should remove all of them. In fact, the kernel lacks quite a lot of
documentation.

On the stale point: one-liner comments contiguous to the line they
talk about and function docs are not as prone to get outdated as
out-of-line docs like `Documentation/`.

> To give you another example: If I would have come along and replaced
> GFP_ATOMIC with GFP_KERNEL would you ask for a comment?

Yes, I would, because if someone thought `GFP_ATOMIC` was needed at
some point, then it is likely there is something non-obvious going on.

Of course, it depends on the case. For instance, in the case of our
patch, having a comment is not a big deal because it is fairly clear,
specially for `charlcd_write()`. And `cond_resched()` has a
`might_sleep()` annotation which helps catching future bugs. So if you
don't add a comment, I will still take the patch since it is good
patch.

> Anyway, I'm posting a patch with changes as ordered in a jiffy.

It is not an order :-) i.e. don't feel pressured that you need to sign
off on the comment change -- I can submit the comment on my own later
on.

Cheers,
Miguel

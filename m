Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC53D49AF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhGXTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGXTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:09:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FFC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:49:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so8521623pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2sy7LjL+SckusgG1R9XWRMwLDyYfPc8ogRTmbKo0J0=;
        b=KHQjCxL7o5GiJ+1ZgXtjLDn8pCLcyqCwsqIHGM+p9f+xlh6urEzM8AXiK3rujXJnHa
         lCcqlJ1o1dXHj+CfUfsqzj+5rHwNlyHFOYcTkUFKVQd9JYNjpc/B0zKUx4Ti0saZQjEp
         XfrzAGdSXJbyA76aJq0CgnBBHcxcMIxhB/yKnxwLqh5l+DvnmaHNNlDXBrg6eHVG8oIL
         YxJ3wZ7WDb1nfKEXu8H0pHDMrYc92EusqOelcbmbcGTRYE9WhwBWB3x6ghUd3nl2HQBF
         5Scxcb5TUZ1I3XvK1L7IJD/JF5aVK/ElaeX607T90md8384kQngxsSk9Aq0947qVSeWA
         Om2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2sy7LjL+SckusgG1R9XWRMwLDyYfPc8ogRTmbKo0J0=;
        b=UmvtrSwY6tGA4C3UUwGNAwqvmZhpCdwB6RAbOwzsMQC4TwInZeeyDSwimvgsIf5Pnj
         jFnfc9jrttnJyxqrKh3O/mvpHRyauc43jfzGLlYDUTZH5yKfsJved2omq7vFUyBXst/S
         mtH7AgSW7nTRD8aIbf0RjKyK6W6U/jkyaouNH/Rt/w4Aj1MMi4P0QF4ciEb2hzu/mKlT
         mEYkoqrH+hVlFwsdU8MCw6kIhkdj1u25W4DI1p0KcQVap7tn/iQ2AXY8k4Ab5eMcFnW2
         o3LMldWPzxqcjGn+VAAqUoFipYKQsvN1f8PzeYi0WFgs3Gb0RWnPf1OWH56t2dSIJyFy
         2R1g==
X-Gm-Message-State: AOAM533eM70jwC8peKBuu8KndxbIelaCeAv07s7ibNfRQ9VidO2B8u/X
        gw1AqyLWSEopcidKfW2qbywHBx8UDHmU6BOUToA=
X-Google-Smtp-Source: ABdhPJyOMLCN+4wxr0k0WHJiBZ1RizG0DeJt1VzMPJbHTe8n2GdqaV+AopgBSPyE4oRtiXhBZm3AFhwEN4JU2zr67zo=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr19582128pjq.129.1627156199033;
 Sat, 24 Jul 2021 12:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk> <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
In-Reply-To: <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 24 Jul 2021 22:49:22 +0300
Message-ID: <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
Subject: Re: 5.14-rc failure to resume
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 8:56 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 7/24/21 9:57 AM, Jens Axboe wrote:

> > I ran into this when doing the last bit of testing on pending changes
> > for this release on the laptop. Outside of running testing on these
> > changes, I always build and boot current -git and my changes on my
> > laptop as well.
> >
> > 5.14-rc1 + changes works fine, current -git and changes fail to resume
> > every single time. I just get a black screen. Tip of tree before merging
> > fixes is:
> >
> > commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
> > Merge: 05daae0fb033 0077a5008272
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Fri Jul 23 11:30:12 2021 -0700
> >
> >     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
> >
> > Since bisection takes forever on the laptop (gen7 x1 carbon), I
> > opportunistically reverted some of the most recent git pulls:
> >
> > - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
> > - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
> > - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
> > - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
> > - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
> >
> > as they could potentially be involved, but even with all of those
> > reverted it still won't resume.
> >
> > Sending this out in case someone has already reported this and I just
> > couldn't find it. If this is a new/unknown issues, I'll go ahead and
> > bisect it.
>
> Ran a bisect, and it pinpoints:

Thanks for the report!

> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
> Date:   Mon Jul 12 21:21:21 2021 +0300
>
>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>
> which seems odd, as it worked for me with the acpi changes reverted. It
> could be that it _sometimes_ works with that commit, not sure. Adding
> relevant folks to the CC.
>
> I'm going to revert this on top of current master and run with that
> and see if it does 10 successful resumes.

This commit touches two parts (and API) EFI for Apple devices (seems
not your case) and CIO2 bridge (Camera device on Intel Sky Lake and
Kaby Lake machines). The EFI code runs at boot time AFAIU and CIO2
code runs at device's ->probe() time. I'm a bit puzzled as to why it
affects resume parts... Daniel, any ideas?

-- 
With Best Regards,
Andy Shevchenko

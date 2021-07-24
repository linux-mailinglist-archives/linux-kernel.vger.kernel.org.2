Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E23D49BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXTZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGXTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:25:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CDC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:06:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso5517256pjq.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+DLiIgxlVyMwhIVC6JdMSpMktU0RR1rKGEkwvA300o=;
        b=Hso5NyOvb9YiyulKEW8N7RVWwcm5LvuidYxTUL6ckhYNkFAzO7h5KgP8Al3EU5qG4o
         cHeZtaYUco2M4lwr6QWYis7aHStr8w4G3+Zk2g+W4xsbnngteZOCDTGIcAgjy9jBGGp2
         KJpuRd58EkT9hLw0rbZoKZeovReuitUUCuGb53ganYGEzaYU+m9yRRb71Z4cfhPhGgGl
         LFoGoWoaQ1qGPzyhkG/v3zYTRQDK2Dh0+Vck5zoCuqkbLmPm+B0zl2YqdXAtkuI/vfvf
         ctheLSXWDNQfKJ/hqsuMAjUt4MQ07UlbyPyQa6fB+GDcUGPzRt+7y0Vs2Th6OrQWy5tk
         2Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+DLiIgxlVyMwhIVC6JdMSpMktU0RR1rKGEkwvA300o=;
        b=hhCRCSjH1QfT9WEFoSpbOYb4pwWM6JjiARubHB3tl4DJa1tBUtqco2J6SWDBv68WsY
         HTEMgm/R4ugtE/MfcCAJRTwQj7+KA2EIQrZWQLfMtivtwb5Juzueu4XwKrFRlZx4/14Z
         zLWZrc/V1Ig9Phxj06Ysl92MYCUGbzRv6E+vxeAVD1kyr5IJQZNvc5KBNw4KDs+QiGNj
         tQJgOBR7TaoMF1OSvKzWms+3AqBBlKCnrDFAfZWYv8l7zqTx6rT2hBVgWLJC9s//CAJz
         /hfv8E3toTMp3vzDZJRiS5GiwwvEqkw2oq6/YS+UuyTrOmyOUEzwC/2NL2ZjFPi5RTan
         6olw==
X-Gm-Message-State: AOAM533UvmeoNNMrh8hXY/7AmK9oWIVsT3lE2/R7n4XikOU5Syu29n7l
        FHcuRqua+j6WDvsr4EflrZTAHBdeYweC0NMfl0A=
X-Google-Smtp-Source: ABdhPJwSinnOMvX1ZXXvAkjUweFOCW6VxLvvX1xX/PcjEUJarRyVGD4+p0k+FhUfy+bCLm9exPEKsPfkqUPji3+4A4o=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr10307368pfi.7.1627157181165; Sat, 24
 Jul 2021 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk> <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
In-Reply-To: <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 24 Jul 2021 23:05:44 +0300
Message-ID: <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com>
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

On Sat, Jul 24, 2021 at 10:43 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 7/24/21 11:56 AM, Jens Axboe wrote:
> > On 7/24/21 9:57 AM, Jens Axboe wrote:
> >> Hi,
> >>
> >> I ran into this when doing the last bit of testing on pending changes
> >> for this release on the laptop. Outside of running testing on these
> >> changes, I always build and boot current -git and my changes on my
> >> laptop as well.
> >>
> >> 5.14-rc1 + changes works fine, current -git and changes fail to resume
> >> every single time. I just get a black screen. Tip of tree before merging
> >> fixes is:
> >>
> >> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
> >> Merge: 05daae0fb033 0077a5008272
> >> Author: Linus Torvalds <torvalds@linux-foundation.org>
> >> Date:   Fri Jul 23 11:30:12 2021 -0700
> >>
> >>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
> >>
> >> Since bisection takes forever on the laptop (gen7 x1 carbon), I
> >> opportunistically reverted some of the most recent git pulls:
> >>
> >> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
> >> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
> >> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
> >> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
> >> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
> >>
> >> as they could potentially be involved, but even with all of those
> >> reverted it still won't resume.
> >>
> >> Sending this out in case someone has already reported this and I just
> >> couldn't find it. If this is a new/unknown issues, I'll go ahead and
> >> bisect it.
> >
> > Ran a bisect, and it pinpoints:
> >
> > 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
> > commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
> > Author: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Date:   Mon Jul 12 21:21:21 2021 +0300
> >
> >     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
> >
> > which seems odd, as it worked for me with the acpi changes reverted. It
> > could be that it _sometimes_ works with that commit, not sure. Adding
> > relevant folks to the CC.
> >
> > I'm going to revert this on top of current master and run with that
> > and see if it does 10 successful resumes.
>
> This does appear to be the culprit. With it reverted on top of current
> master (and with the block and io_uring changes pulled in too), the
> kernel survives many resumes without issue.

If I read correctly it seems at one of the local rebase I might have
missed something.

Can you replace sensor->adev with adev here

https://elixir.bootlin.com/linux/v5.14-rc2/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L231

and retest?

-- 
With Best Regards,
Andy Shevchenko

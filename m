Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754F03D4A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXUfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:35:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5777C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:15:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so8746459pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOgxaIETY1ggJrYn1XAT1q6dkvMSOza8mqs3cwib2dI=;
        b=Np/2XHWLVNoSlqoNeZpeKXPF/SZAlRCLg4bxHs2taD5XJ65AFz1KAxUzRu7C5wtRmU
         4HfbJTbhw7vN6w/FRd8l8V/yIfpK5r952SF4ayq7XaHR7GCY1+QCO1QGE2e2B7JyIhFk
         R5nrTwxa58qXd/Xeg6ultmKGUAVvbZO5lZ1d+exkfyGj9GazZjN3gxRrEEVo7NWK347S
         eWXIUunWQUzVLhfy2uvionltMLB9BjZjxQqbPFoP4sODGNhOV4VrNsjUAjHhcmmRKohP
         4JBBEP9nNSm02ZVY2fTUGus4QesuNwH5C48ae7U6dB/EUvTNLbNFGq950mVeoLRPYzYH
         4Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOgxaIETY1ggJrYn1XAT1q6dkvMSOza8mqs3cwib2dI=;
        b=PZ8YO1Xo+Za9cPwI6A0rF/pFx9miKW6ped63z0bKqShICzVVaQMIQdwcKYKEl6ezRm
         klKonuWryTgREmKAMhZ2WhiC9I4Dk7HqSHXXvRI0LGSA6TpVq1qRKijSQAvsMhxtdL8r
         pS75LzbdwMg+FKugFESpAqPwHkalSmTfeAcURPjX+QeRZtcLoSgryCPRfDJVtLd0nXVH
         tMeWddKhdCiPNaKiFPYCdm9lE3yrKCyne3G/Qgqr4/qArXUSAhK3gpIxAxyxmkC6KPsK
         2sbUcmKq0QCDSEPSWhw7MVzLGOaBx6Ucwlv8pHkWJFrrZtRvz4phVY9CsS7f60AYYNJx
         ZJhw==
X-Gm-Message-State: AOAM531Q8MNiwJvEzpSTmDWVJiED9zK9UDbk7lsWVH0UHziZ8hhhro0r
        LIeMMDp67ydiDYTOz+huP540wY4MxjwL8eqeUro=
X-Google-Smtp-Source: ABdhPJwl//82GdaS6o+Fra15J9DjuxEbRXuuUB/7XBsbkdzz2bLkbLW/NTop4BN0/1y8JI9WmSxHDM06tTLMtuecfjA=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr11152766pgm.74.1627161348416;
 Sat, 24 Jul 2021 14:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk> <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
 <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com> <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk>
In-Reply-To: <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Jul 2021 00:15:12 +0300
Message-ID: <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
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

On Sat, Jul 24, 2021 at 11:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/24/21 2:05 PM, Andy Shevchenko wrote:
> > On Sat, Jul 24, 2021 at 10:43 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 7/24/21 11:56 AM, Jens Axboe wrote:
> >>> On 7/24/21 9:57 AM, Jens Axboe wrote:
> >>>> Hi,
> >>>>
> >>>> I ran into this when doing the last bit of testing on pending changes
> >>>> for this release on the laptop. Outside of running testing on these
> >>>> changes, I always build and boot current -git and my changes on my
> >>>> laptop as well.
> >>>>
> >>>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
> >>>> every single time. I just get a black screen. Tip of tree before merging
> >>>> fixes is:
> >>>>
> >>>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
> >>>> Merge: 05daae0fb033 0077a5008272
> >>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Date:   Fri Jul 23 11:30:12 2021 -0700
> >>>>
> >>>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
> >>>>
> >>>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
> >>>> opportunistically reverted some of the most recent git pulls:
> >>>>
> >>>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
> >>>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
> >>>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
> >>>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
> >>>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
> >>>>
> >>>> as they could potentially be involved, but even with all of those
> >>>> reverted it still won't resume.
> >>>>
> >>>> Sending this out in case someone has already reported this and I just
> >>>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
> >>>> bisect it.
> >>>
> >>> Ran a bisect, and it pinpoints:
> >>>
> >>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
> >>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
> >>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>> Date:   Mon Jul 12 21:21:21 2021 +0300
> >>>
> >>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
> >>>
> >>> which seems odd, as it worked for me with the acpi changes reverted. It
> >>> could be that it _sometimes_ works with that commit, not sure. Adding
> >>> relevant folks to the CC.
> >>>
> >>> I'm going to revert this on top of current master and run with that
> >>> and see if it does 10 successful resumes.
> >>
> >> This does appear to be the culprit. With it reverted on top of current
> >> master (and with the block and io_uring changes pulled in too), the
> >> kernel survives many resumes without issue.
> >
> > If I read correctly it seems at one of the local rebase I might have
> > missed something.
> >
> > Can you replace sensor->adev with adev here
> >
> > https://elixir.bootlin.com/linux/v5.14-rc2/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L231
> >
> > and retest?
>
> Tried that, doesn't work unfortunately. Hung on first resume, just like
> current -git with that single line edit.

So, does it work along with the acpi_dev_put() converted to be

  if (adev)
    put_device(&adev->dev);

?

-- 
With Best Regards,
Andy Shevchenko

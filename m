Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B1402F06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhIGTh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhIGThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:37:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E9C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:36:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y34so126614lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtmNVK91Dz4uRn64k8Jqo2/KLRn/RHocVGbJgMvz35I=;
        b=DdNToKjzYX6aTUJcmZeUvsnKx9VFeFpfsFCogv/O5LJQHyQ7OM9180pJBu9CoJKiS2
         4Ie6GK0oDHhClWEQRcPZmR5Ktzs0nx1G5l6jF90SJ6uRuecrfsVbVK1T70hQzUESwTUt
         nYUfBE+62Kz8texug1GfNsHLcSdbE4SbCTRro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtmNVK91Dz4uRn64k8Jqo2/KLRn/RHocVGbJgMvz35I=;
        b=GFanarZkxM1pqkbqmjatV/NHrwF2wavxV3xOMaudpxEGTyrHe0XKsI4vdXBv3rH2Ir
         eWw/eh1YdyYjsEgIM8MBhSdHjaxmtQVvTU0ywh8sEJqTHjtoVQCYr6xUXnYEPCzk/xpq
         2wJYOiTDDdGzBCt4eVcXZcV0qh1aPao90WvqEuss0wou4IYAO1SZJ9n2Q16bsYnQ4Wkc
         /jWStXZx/1JLK231BSbUTFL3Yjq+ePQwuBhgnLJX6/a+ZjGpoYTIL0CZWA6vjZalamhf
         PNnqCVSTOaErviqEEF5zK+R9tLYkP3qWGmp3j25Bfia8yaKNi02ErHD3mcgh1300N2Fi
         LaNA==
X-Gm-Message-State: AOAM530Ix6ljZm3r3CWMOGsMhbJkpXflQOI5f+P2IMVUr9RKjieZONQZ
        XC/pO4Pi2+FjWFSXqxiL6XE+9UmSfpT3HVOyRDo=
X-Google-Smtp-Source: ABdhPJw60Aqn2GTgmaVeWi+7zcXlTjHW482ug/aADsz6MrfyqGWlWVGENvoXgUxWh3DA3GS8JCmdmw==
X-Received: by 2002:a05:6512:3f88:: with SMTP id x8mr20386lfa.233.1631043402419;
        Tue, 07 Sep 2021 12:36:42 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a6sm1171149lfs.160.2021.09.07.12.36.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:36:41 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id f2so388028ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:36:41 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr15590122ljn.56.1631043401603;
 Tue, 07 Sep 2021 12:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083613.31268-1-brgl@bgdev.pl>
In-Reply-To: <20210907083613.31268-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 12:36:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
Message-ID: <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.15
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:36 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>  We also have a new/old GPIO driver for rockchip - this
> one has been split out of the pinctrl driver, hence the pull from the
> pinctrl tree you can see in my branch. Another merge in the tree is from Andy
> for the intel drivers.

I appreciate the heads-up, but just *look* at those merges.

The intel GPIO merge at least talks about what it does, and looks
sane. I'm not convinced that automated shortlogs are great, but
whatever. The merge isn't bad.

The rockchip one?

All I can say is "WTF?"

This is the complete and full commit message:

    Merge branch 'ib-rockchip' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
into gpio/for-next

what part of that screams "that's an acceptable commit message" to you?

If the reason for that merge was that you want to have the current
state so that you can split it up, then SAY SO, for chrissake!

Not that useless commit message.

Why do I have to tell this to people SEVERAL TIMES EVERY SINGLE MERGE WINDOW?

Merge commits need explanations. They need explanations for why the
merge is done, and what the merge pulls in. Not this "single line that
doesn't explain anything".

Dammit.

I've pulled this, but I'm upset. I'm upset because I've told people
literally hundreds of times by now. Merge commits are not some trivial
thing that should be ignored. Quite the reverse. Merge commits are
generally worth *more* explanation than normal commits, and should
take *more* effort and thought than some random code commit that is
obvious from just the code.

Exactly because merges are *not* obvious from just looking at the
code. It's not some one-liner that is self-explanatory.

If you cannot be bothered to make proper merge messages, then don't do
the merge. If y ou don't have a good reason for the merge that you can
articulate, then don't do the merge. If you can't explain what you are
merging, then don't do the merge.

It really is that simple.

I've pulled this, but I'm really fed up.

            Linus

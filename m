Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA232AA02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380989AbhCBSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbhCBQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:08:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1BDC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:07:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h10so25813157edl.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIfeSEfmL8wAyn5TADy2HISNOXLZvpkt9t432wxDvWY=;
        b=vyZbsxwrlYxjFHO7Cc7mMvqFh/M7mu7PpuET7PCvtmDP+W6Pv+1+rgFEO8TybiCyJy
         9Yp4qA1gQZKIOM1b0ubIdVbOZdkXiwSnFfKWMlJKpnimsInqzhxXlCsA2lBsUWgM6eYX
         /+XjZB2k7crAsVNBDYRJiOr1sVSuT7a/hS7vYq8K16p4/nexvblVwrqHINLPERKhbxr4
         rJt8O8BOsN8acrKZgulVsP/wbz0w2+lkOk1i6H2ujGil7vAQS28r7UI8b92LGMpyl2jK
         HJgTq1hX8BNTHmathm0HmsPyAjuhdfZ4CE7bPy4ogkzmuv7gIHFnvRPmzc+bpdTjH9ub
         Z4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIfeSEfmL8wAyn5TADy2HISNOXLZvpkt9t432wxDvWY=;
        b=Lo4p0AForbJ923Iz+5gstyNW7RtX3Rdrfd4GE14Pbwm7GoSnYW9JoQwsOfHzz20EwS
         Kx+v2EpjmuMrnGlUmEVffwe3FDCNgLGtKSWzGBRFKtYlgC9O5FUVfnUqggNYDxsYz17y
         KpyiIvrC/C0tWbo34sPg/PZ2gfG3/WmOZOLGav1D6TyqWSPbio+me5gzzEHEIVgBKQ/i
         s0NmuYNOs0fqrJgLdubGaqyPcHIeEr//KHTMItvZxyCrD7lRHA7fA13u1BQfl1pYvMTc
         5VJtJAjGmEQQxVNUuVI9ojVk8f72t0LC3vqGwSZicY+g8AROWZLUTtUZT8HO3Y9Wb3Bn
         1vlQ==
X-Gm-Message-State: AOAM530Y+woqgCI6ZqE+AUliRjLLFibd8ngs5toJAumpbjHeU8MNi/Ux
        0EYN799B91Y+bIVmL8MCOdtXhgsRQ8Wn8cWrPHhDHA==
X-Google-Smtp-Source: ABdhPJwHuw1y3Y/v8jdMtjN1ZkyeSqxulDA1RDfV0AnDqqIe93CMsVo0jEsYKuMl36cJANkKqZoyE2G7jIaraKzXkGU=
X-Received: by 2002:aa7:d588:: with SMTP id r8mr21122916edq.88.1614701233853;
 Tue, 02 Mar 2021 08:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20210224185316.17942-1-brgl@bgdev.pl> <CACRpkdZ915TABrSt0A_1tM3Jt_op4gcCY1b-d2ocM7wjKJFoPA@mail.gmail.com>
 <b188690a-31e5-fca9-1226-9dbf7c9f9448@linuxfoundation.org>
In-Reply-To: <b188690a-31e5-fca9-1226-9dbf7c9f9448@linuxfoundation.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Mar 2021 17:07:02 +0100
Message-ID: <CAMpxmJUu3x7iCT=Zsung1TFU-f2qY-oTujoDNkF+sMG4SXJXgw@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: update .gitignore
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 4:27 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 3/2/21 7:44 AM, Linus Walleij wrote:
> > On Wed, Feb 24, 2021 at 7:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> The executable that we build for GPIO selftests was renamed to
> >> gpio-mockup-cdev. Let's update .gitignore so that we don't show it
> >> as an untracked file.
> >>
> >> Fixes: 8bc395a6a2e2 ("selftests: gpio: rework and simplify test implementation")
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Yours,
> > Linus Walleij
> >
>
>
> Thank you. I will queue this up.
>
> thanks,
> -- Shuah

Hi Shuah,

Please let me queue this through the GPIO tree as I have some more
development coming up this cycle that will require this. This will be
a new driver + selftests so it will all have to go through the GPIO
tree anyway.

Bart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25A6338E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhCLNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCLNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:16:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B8DC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:16:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h10so7878242edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neZ9V+cHHaOLaO/LQJ3v+VwMZ3+9mlPm1xPT4fXngAQ=;
        b=ZFEkO0tVH3wllnWFMhwQDJUcDBOY4/28BriU2RhZ3+Q5ZIGxNg1b2QaTwYCI7lr/Ce
         Z1ll8s2y3zgQsB5O1ZKpODLeh9AcHobATZSVo4EouwBk9ANUxNvRqCUnaUCjPUzVkzlW
         P6S9InY/9wESuvhpqE6KlDeC9o7BN3i9k7oWQxdq9035NaTQa8KGRTFPISPgVzwVhq2o
         WWHm9LRsZwg+njI4pTtAKwbeXvjcT9mX31UmXyhnmJ0a9K2D/NzZKGU90kE6FIHm09+W
         AEqV0CUhm/hmxCD28XI8gzmSrieF5jwDP2r+m64YuM526E7SQamFH/cqSpSODk57Q63K
         lyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neZ9V+cHHaOLaO/LQJ3v+VwMZ3+9mlPm1xPT4fXngAQ=;
        b=nIdkT6QEcXONuVhvoMexs/QJlwkUDcfxRivww5lOEQ0KbF3e0eiNA/XlR/E/aWmBCf
         hQ0piL6r/rfV4czbCC9DMEQVoQ9ePnlDC+tc8b5vA8Ewbl3jTB98xwUASrnxPquWFtOn
         h/gbILYPqMOu5RTUrEr16BF9bH/60NW57NmqMdK7cAFSIY66fF9//2pEs6c0HzV+3JOf
         Vmu1vn95PBgmowMwuBzJ9tbY+61MGMK4eafVQ8hJOB/ScY/s0jRqQYeDUVf6iefDCgYr
         XNd50q1P5tCgJETNKSvenpQ8ODgdqQ8cHEsh3petyJkrHGEOz8Wv4k4X/DDN9XGbXxnk
         2xxw==
X-Gm-Message-State: AOAM531vG4j7oMOxLrhHIDnQPmZKcTv3IaXL0PFc6bSaCQic/L/i57ZV
        grqxM31LTi3I9PoDjMnqRBD+suF+8epes6XsTvNaUA==
X-Google-Smtp-Source: ABdhPJwSNw8JNi+UKnMe99Qf0naPkixWkL2XPqedMsVuKvmkfKkzrdX38EVXWnCItjQXyDYYop5DuKx3MmFhtu4lBB0=
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr14555462edc.25.1615554973282;
 Fri, 12 Mar 2021 05:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20210312095700.16277-1-brgl@bgdev.pl> <20210312095700.16277-8-brgl@bgdev.pl>
 <YEtTKJliHBep7bL4@smile.fi.intel.com>
In-Reply-To: <YEtTKJliHBep7bL4@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Mar 2021 14:16:02 +0100
Message-ID: <CAMRc=Mc4DCDryO2VuC_2=ZkwT2XLPtUbe1HE47i0rfft=tb4oA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] lib: bitmap: provide devm_bitmap_alloc() and devm_bitmap_zalloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 12, 2021 at 10:56:56AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Provide managed variants of bitmap_alloc() and bitmap_zalloc().
>
> Perhaps I missed your answer to Greg's comment...
> So, what do you think about adding _GPL to the export?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Nah, I missed Greg's comment. :(

Will fix in v5.

Bart

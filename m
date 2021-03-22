Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67A3445D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCVNe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:34:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67761C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:33:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u20so21016114lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WPnh+9BruSzYQXPNbQjjx8XWnL6ZcqnHNniGVHI2ic=;
        b=zVfozITby6X5m9cVgVI4NHg5AGR4Yo8qfxBadC5vuclSxXdMiAnlP8/q6gcc671q6M
         yoDHGQPlbQQbAPghxNLjwU32gH0oFgO4TE9mFrkbcUhq17oA4SI8FJhejv7q+DDBNBmL
         vObdz/8gDuN+3y8LqnOWSgZjxLgNPg8e4yn1e/3StGUsLWcd3Qq6ylFIoxFEhIyHeGhf
         FYm2Gl2MqwbCf41PqRcGMWZkLam4KKDt86jlJBewNZGxf0qd2KHTH7X3g9UxMJl8aaYL
         FZmOd+e675px7yqiZ6HcGMOElUtSA+J4U4KZ0BXSl6Gqz5n6jZFHThyr9/dD4FeO/Y+p
         kG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WPnh+9BruSzYQXPNbQjjx8XWnL6ZcqnHNniGVHI2ic=;
        b=dcjMjpTpshxMABP47j1EC8Uc7Hmt2SXG9nLOje3MVKpanTYt5sv1MqWSxVtHJEs3ia
         H+m/nq6FeB4Jk+RC/aR/308+YPRyH8ly1eWJjUe/faFypk/NTEolFWNkjBY/LtFBDnxe
         uO25yOa2o2MPtFPFlKwm8AXgYg0eSvBP7mYYM9Nw4RcmgqqK0Irj6jD8EYOL1xmbR7bu
         00xVLrRua/rCRTeHk8iircnjHWfro/lmSNNM6FaF1E9yq6p2r9q9M8NS67OtugY3Q9/O
         Vd72Yj0UHCTRWtPODjkRmrvfE2QZf6ZNjJL2zRl8l6bnN/Xt4NKt3X8SnSsFRkAL9v6m
         65ng==
X-Gm-Message-State: AOAM532dhumctKK/7sxQcHO7Zlhgrnn0eAUQh5EsUIpzayJ9QYQ/1dZh
        T9zf6wa5BE7+8nHqNfJlcYEVa002L2CG1t9pRia0SQ==
X-Google-Smtp-Source: ABdhPJz0oc64Kx9cMP677X5vUFdOcCeCOUsWcX+1Bc1alVrv+fsS4ITQzDOa0UVfYhR9B41iluJDnEVhOWCLRUDi0tE=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr9253577ljj.467.1616420037816;
 Mon, 22 Mar 2021 06:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <202103191536.9cD1TuQQ-lkp@intel.com> <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
In-Reply-To: <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 14:33:46 +0100
Message-ID: <CACRpkda5ofCs=nkpZXVyekw2LoeYZUNrFTu1iGPt47ZSMa-6eg@mail.gmail.com>
Subject: Re: include/linux/unaligned/be_byteshift.h:46:19: error: redefinition
 of 'get_unaligned_be32'
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:57 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 19, 2021 at 9:05 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Linus,
> >
> > FYI, the error/warning still remains.
(...)
> >    In file included from include/linux/build_bug.h:5,
> >                     from include/linux/bitfield.h:10,
> >                     from drivers/iio/magnetometer/yamaha-yas530.c:22:
>
> Isn't it fixed already somewhere?

It is, I think Jonathan already applied the fix, it is just waiting to
percolate up
to Greg and then to Torvals:
https://lore.kernel.org/linux-iio/20210221154511.75b3d8a6@archlinux/

>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>>    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
>>    Selected by
>>    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
>>    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
>
> This one though is interesting.

This looks like nothing to me :/
As confused as ever about Kconfig.

Yours,
Linus Walleij

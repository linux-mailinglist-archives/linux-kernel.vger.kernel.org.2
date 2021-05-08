Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACED377395
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhEHSWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 14:22:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 11:21:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a36so15663793ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpLZHnBATYASHX2qyiYXjM99nZsADzAJuHz545iDnMw=;
        b=mO2WlNzoRrtDS3eRiZFmbBIjJyWzwqejoHEMnZi79SbFMnr2JnZlY/c0Qoa5dv2XAa
         rCqqL771Im0TYp8v8wom22qna9AviEv5GvP2xEN3HPrm4OirjqN/6a2+qo2xjLfRCdGS
         o6VjV+OsbreQ5X/On0x2vINCoRmDEQJXps/e0eWqOQxzd6K+xS4bVvqIEGkEfpHaMDoN
         U2a/GNhxpYXZmNStIu9c8uecnLb/XrhnvypOWIgCSiauXyjfDsmm757GhDphaPVapoGX
         GNgDiFliI2KVvv2dNk7v6quVqcNjXwP6d+vUpHr6/uA3TsgxezqthST2NFx3bYwTfJ94
         Ttng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpLZHnBATYASHX2qyiYXjM99nZsADzAJuHz545iDnMw=;
        b=VMJv8PzHDdk1rkgJyNqBt7Ig2mWbxEL4mk+4E8BFG9YCwN7r7nM/9Uy8+1veuanxfD
         Ky4azUF5U3lphbZJQUfmcdHLCDMxiYNBAfJat+pDMueqXY/gASvtiyC8cRgCaql/xQpP
         jKYF3bqU9jKcwZNLdFj+ztPTntted+Ep1V/T0HnImjFRXJ8mFhnqFg7f+wYGD1UHknvY
         GDbB7quGM2KoaM0gdBN1fJijTjbjMVNE6DrpteZ6FKxTn5FDM8XBtzz+ZyUU9RFr0OKy
         aHFjsCeiODgbM5PEHwkImGWBFCJo2aFCWVOnJUPF4+nhvhkJkhAbQ9iQPJ7Tvviq/tVh
         DPBg==
X-Gm-Message-State: AOAM530e13xSsWwP+93YYkNyiJVfxEK+Z+mSsjsm0chfofNpc09GUUzo
        vfkS3FS4q+LjMu+KRxte9PBoS7SlveYLCD+Ehla0gp/gTPM=
X-Google-Smtp-Source: ABdhPJy9paLVPUwnbFLwB+T8DxKC5dCGEYLRFZ1EvriEcPhw9kKSXHzsqwSSsevyxFuDqZjnAxwAkqVYVAnoBEoQ1ms=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr12755146lju.200.1620498079364;
 Sat, 08 May 2021 11:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com> <20210508161643.5990ec15@jic23-huawei>
In-Reply-To: <20210508161643.5990ec15@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 May 2021 20:21:08 +0200
Message-ID: <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Jonathan Cameron <jic23@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon,  3 May 2021 17:43:50 +0300 Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > When the ioctl() mechanism was introduced in IIO core to centralize the
> > registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> > core: centralize ioctl() calls to the main chardev"), the return code was
> > changed from ENODEV to EINVAL, when the ioctl code isn't known.
> >
> > This was done by accident.
> >
> > This change reverts back to the old behavior, where if the ioctl() code
> > isn't known, ENODEV is returned (vs EINVAL).
> >
> > This was brought into perspective by this patch:
> >   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
> >
> > Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> This is going to be a little messy to apply as lots of churn in that file.
> What I've done for now is pulled the fixes-togreg branch forwards onto
> current staging/staging-linus but I'll do that again after
> staging/staging-linus moves onto an rc1 or similar base.

This is starting to become a recurring problem is it not?

Have you considered the option to start to send your pull
requests to Linus (Torvalds) directly?

I suppose the current scheme is used because IIO changes
can affect drivers/staging/ but at this point that thing is
so much smaller than the stuff in drivers/iio proper that
I start to question if it's worth it.

Unless you really like to base your work on Gregs tree for
some reason or other, that is.

Yours,
Linus Walleij

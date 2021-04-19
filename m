Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB45363F52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhDSKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhDSKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:08:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:08:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a1so38680171ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4Ge4/OLRJ/QZEOtOI7jH3j6NMP0dgPEYr8cn2cVZdA=;
        b=Z5QIwT2CkNBKAhSpoqk55bCneVZpjmu4swI4eBVN9EkcGmktWGlFGXKTXiNVvu/WQt
         uyC9SblpJSM3EYE+9Sjwvta345bGjkLiM3zw/TQQJhbrN63RrhdSJx1+56l+1D2hPdpG
         USihPdD3gjbiR/z8wBB5vYmmQZZz34ShTa0mlb+QeBdsfskPceVzHWceaPYGjsXyMunm
         AsnGJDenTzRzGEqiiwStNnp+vXj246DjKxTLG6USZiREgmNqpAznsKJsp5MNhd3Q6bag
         AG/iZm7T7EalvmBGJHgL3GmMXYir+umXlADYmONnk0XUHNMcpJSsNamzvm8noKDx2n5L
         vDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4Ge4/OLRJ/QZEOtOI7jH3j6NMP0dgPEYr8cn2cVZdA=;
        b=N9hnbhmtqBcN6IevMJ/+la0D7fCfSSm9T7xQRIfgQQkRX0+W613jspHcuy1Zn2hfrW
         5j0K5kp5VhL4vHPppUsWe8CeDtcUEfTOjK51mjEDVFTaIWTC5sZAB0EcypFoq1Dr5fKm
         kCNtDM9VFnsZRiObGtiJvyQr3m7fh8rHIBfCINLlLqrkJ6dfm3M+nhC9/jCfMDLpPUn4
         6bVt5iKkU5Cqg8N+nmTtRt5vlme4fJgVY/aSUJuiiwE9FN6/N6iVQ05U6UZ2IXhY026h
         1YJtpr2fphskp2pycuBz+862ZmHmDU573qIIFqPbdb6DrIhcrzF8kGtAh2FRKvhrtYmj
         1shg==
X-Gm-Message-State: AOAM532/YUZr97NjdDEQj49v3/YylbrszJoIF2Oi1aztqHIj7LsgVhUu
        qFFojqSQbBr/K3vYDaBCA+SvHFTMo1g3VeLySPOcaQ==
X-Google-Smtp-Source: ABdhPJwstFUJyFsJF3O59qzplzSCx37u2qJMHf9wCIFo89KRCfj2WprbxTCJIwQf62k+aJyOaLHd2lz2Mv/JtqVJ3mU=
X-Received: by 2002:a2e:555:: with SMTP id 82mr10616897ljf.200.1618826879285;
 Mon, 19 Apr 2021 03:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
In-Reply-To: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Apr 2021 12:07:48 +0200
Message-ID: <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 8:06 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> The driver uses
> (x+23000)/280 formula for the conversion of raw temperature value, which
> gives 82C for x=0, thus apparently formula is wrong because x=50000
> should give us ~25C.
>
> I tried to search for the datasheet with the formula, but couldn't find it.

There is no public datasheet. I have never seen a non-public datasheet
either.

As the initial submission of the driver says:

"This driver is based on information from the rough input driver
 in drivers/input/misc/mpu3050.c and the scratch misc driver
 posted by Nathan Royer in 2011. Some years have passed but this
 is finally a fully-fledged driver for this gyroscope. It was
 developed and tested on the Qualcomm APQ8060 Dragonboard."

Nathans submission:
https://lore.kernel.org/lkml/1309486707-1658-1-git-send-email-nroyer@invensense.com/
(you find the threads at the bottom)

This submission came from inside Invensense so it is the closest
authoritative source we have.

> Linus, will you be able to check whether the formula used by the driver
> is correct? Thanks in advance.

Sadly the code is the documentation when it comes to Invensense stuff,
I am CC:ing Nathans Invensense address in the vain hope he is still
working there and could help, also CC to Jean-Baptiste who was
there last year and maybe can help out.

I don't anymore remember exactly how I found this equation,
but it wasn't from any datasheet. I vaguely remember browsing
through some Android userspace sensor code.

What I tend to do is dig around in old mobile
phone Android trees, and there you sometimes find this information
in different GPL code drops. I bet I got it from browsing some of
those.

Here is an example (Tegra):
https://android.googlesource.com/kernel/tegra/+/dba2740d025c8e7e7e3c61d84a4f964d2c1c0ac9/drivers/misc/inv_mpu

Worst case what one *can* do is to calibrate the scale, like put
the device in a controlled environment of some two reasonably
far apart temperatures and measure, assuming it is at least
linear. Some professionals use controlled environment
chambers for this. But I hope there is a better way.

Yours,
Linus Walleij

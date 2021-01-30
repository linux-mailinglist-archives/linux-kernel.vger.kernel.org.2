Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B87309834
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhA3U0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhA3U0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:26:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D699C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 12:25:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so14509940edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 12:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cboqjUpWYxdjttiZGLwmlnoPZCjqGtngb0ntKbK+K54=;
        b=BaFGJPfHtwGuZ1DlBNvrzZbX0Z9tIoMLa+eX2MqXqyRFSPFaGfiyQr+qPnkxhAXXDz
         PeqNM18x+Vc8gMklmVELOyuz9zHXuF2wVVn5CMc/Ys+6lcu8z455zNko/t+SPfWQ93BT
         PXZSBu+eY5pB1EYaCC/nHLc2qsNy340nttCG+VdUXkya060fe0TfTtYQ4DFOQVwafUFF
         fsu3Ugh3SyENNe+n+gqZ96V0Nq7AgBj+anNRfnqN1YOgsd8QcmJeHb8mJL+ecXTe8EcP
         EleXUYM0p5VGKgxo7xaAnKCL/AcfNuNuePS4ru7iZ4I8zBybZNCrfBF2y6cLCgOK0m99
         +gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cboqjUpWYxdjttiZGLwmlnoPZCjqGtngb0ntKbK+K54=;
        b=Ei6a35u81lVFkTddYRoKl+7E28rWb9tKJafwa/rn/iW+hTnu9wNBq2KduYIGXTiR3T
         E2vv4XzevNqlUb1ESaqYg98e0xxmHQ5JIrGpousHKE9TnA677a2Rb1YSPjwQJaOvzgX5
         x1cU+lHg7l/xPMTjpHbTuipHov9FJs6dQk3Fsc8TRfAPyNVJzpqY72Su8Qe8Posnoxl+
         PYsDxWgtLxsNPJ4LZh84kroXbCMBV8y7SXt/k5BfFGTWZcTPK8fJeyTAIlVpRCCVRNf6
         sK4Hj24UtMbQsc0IU21qBeblsjkvKGG5EMmsRgMDfVZQf6JihjZ+IZdrIAvE70huqrZT
         egsA==
X-Gm-Message-State: AOAM531a9xvH9ITP13rvTODZN60v1z++wDE2jbFGKyClYY5IO5p2jfcq
        3dgyx99BAGK+r/KN4/zlFf1qSSBYFYzFc9WXQJ+oZw==
X-Google-Smtp-Source: ABdhPJwbCgWn6jjiuRBpz8BjwrOkiWUTtmpqFld9Akl/0tgmwBLwYBJ0/FUm5m5yj3Boeir+RMkQcczAvD0mOn4W2jU=
X-Received: by 2002:aa7:ca51:: with SMTP id j17mr11712474edt.124.1612038319574;
 Sat, 30 Jan 2021 12:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20210129134624.9247-1-brgl@bgdev.pl> <20210129134624.9247-6-brgl@bgdev.pl>
 <YBQw3+K/6GDPK5xa@smile.fi.intel.com>
In-Reply-To: <YBQw3+K/6GDPK5xa@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 30 Jan 2021 21:25:08 +0100
Message-ID: <CAMRc=Md74KunuEvVsofn9cqcoKEqprepKadPdZA+JV_GMH7X7g@mail.gmail.com>
Subject: Re: [PATCH 5/8] lib: bitmap: remove the 'extern' keyword from
 function declarations
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 4:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:46:21PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The 'extern' keyword doesn't have any benefits in header files. Remove it.
>
> > +int __bitmap_equal(const unsigned long *bitmap1,
> > +                const unsigned long *bitmap2, unsigned int nbits);
>
> Why not
>
> int __bitmap_equal(const unsigned long *bitmap1, const unsigned long *bitmap2,
>                    unsigned int nbits);
>
> and so on?
>
> It's even in 80 limit.
>

I feel like this is purely a matter of taste. No rules define exactly
how the lines should be broken. I prefer the longer part to be below,
it just looks better to my eyes.

Bart

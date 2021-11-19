Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D59457713
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhKSTit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhKSTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:38:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A15C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:35:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so10032946edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ETuyJWwJFmb5zyOlM+RsYMtsddGkivK7tN9v32DkWw=;
        b=r45mWu3jbzyMOsyawFAmUd0DoVaBZmAGSij/fcdkDpxUYcmGtCnI85pdPVfwJXZeBc
         5VKPU1g8A3e6Uyl4awBjZSwRtXEihIsAzZp+6UjktP5n9cwjSSkUCcD+T3cYidlhl2F1
         ONdXmqhFuOsFlGKPhxvepAPFOpCdy6gsWLiKn2q3DiS9w+V6Toz3vf5rxN4k0MMa1TdR
         mRD6aCVmgF1/bGGzJe5FkGfEIjIVfAJWfwT2eoUhKlvEGjMOuD0kkTUWYg7XWGWppSVF
         ZzfKFkSpMXBDza8Wcb948X4Qizd/TahsQSGw1SjB59OBiwJglBTspdFdYNE9V+Yyfuor
         06Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ETuyJWwJFmb5zyOlM+RsYMtsddGkivK7tN9v32DkWw=;
        b=A9WU2ncWVwWQQ+oLEeg3XoQxLEmdIpsuj7DcXi7CWLZrNBmloR5+TqyyKBYqNjJcxD
         d/RR7/9sKRGXJN8cUrygr+Qc0bCMg2htyMSSXfG9pzvvFH1OcLsXjMEJbsNQ4gUyPEAq
         Ypw5k9ay1E07cfRO0hjQbDVxT184VF3h+QY9BtGMjQ3z85rFeDzi7dNK4kD9f+yaFwhu
         2lxlciM47YYj3C617jWl1hsNpPm3WBWX7eUXmlREtK2lekj9acb2pZfKFhvCN+Qiz7oa
         he23A+Cn6sGqb+DCHF+LJB2dOLZecNp2I0j6224zeXWct0BoqS/iQodZ8ikvw7+LMU3n
         r4WA==
X-Gm-Message-State: AOAM530OOHfe7hG+IL4En92BoLwu+zZwqCuRRcIIzg1KhGwSOQDcbL9F
        yf60u1yv8ZOAWhCS4NNp5CY7zCDCfzFCoDSeNTU47w==
X-Google-Smtp-Source: ABdhPJyS1KV7hzfkCD78KVd/SZZPMK74U7/2L/WTnHYSHnLy6FDG3ByJouNr9GQAX+XOGGUl01G4Sa5t0tsFbKIknpw=
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr28524459edb.52.1637350543916;
 Fri, 19 Nov 2021 11:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20211118132317.15898-1-brgl@bgdev.pl> <20211118132317.15898-2-brgl@bgdev.pl>
 <YZaH8rsMyUztOX/r@smile.fi.intel.com> <CAMRc=MdR_RGLLPJ5Hqetj5_7ZQfUXOijEoVp3uR7cgEDHKnchA@mail.gmail.com>
 <YZbCq5Xcohm/t/FP@smile.fi.intel.com>
In-Reply-To: <YZbCq5Xcohm/t/FP@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 19 Nov 2021 20:35:33 +0100
Message-ID: <CAMRc=MdBhm-+oDiBdYQJZXYEko8rGhZtHQfu6p3DFy_a3aJOZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 18, 2021 at 09:12:59PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 18, 2021 at 6:06 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Nov 18, 2021 at 02:23:17PM +0100, Bartosz Golaszewski wrote:
> > > > Several drivers read the 'ngpios' device property on their own, but
> > > > since it's defined as a standard GPIO property in the device tree bindings
> > > > anyway, it's a good candidate for generalization. If the driver didn't
> > > > set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> > > > device's firmware node before bailing out.
> > >
> > > ...
> > >
> > > >       if (gc->ngpio == 0) {
> > > > -             chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > > > -             ret = -EINVAL;
> > > > -             goto err_free_descs;
> > > > +             ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> > > > +             if (ret) {
> > > > +                     chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > > > +                     ret = -EINVAL;
> > > > +                     goto err_free_descs;
> > > > +             }
> > > > +
> > > > +             gc->ngpio = ngpios;
> > > >       }
> > >
> > > This should be
> > >
> > >         if (gc->ngpio == 0) {
> > >                 ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> > >                 if (ret)
> > >                         return ret;
> >
> > But device_property_read_u32() returning -ENODATA means there's no
> > such property, which should actually be converted to -EINVAL as the
> > caller wanting to create the chip provided invalid configuration - in
> > this case: a chip with 0 lines. In case of the non-array variant of
> > read_u32 that's also the only error that can be returned so this bit
> > looks right to me.
>
> So, what is so special about -EINVAL? Why -ENODATA is not good enough which
> will exactly explain to the caller what's going on, no?
>

Let's imagine the user sets gc->ngpio = 0 incorrectly thinking it'll
make gpiolib set it to some sane default. Then gpiochip_add_data()
returns -ENODATA (No data available). This is confusing IMO. But if we
convert it to -EINVAL, it now says "Invalid value" which points to the
wrong configuration.

ENODATA means "device tree property is not present" in this case but
the problem is that user supplies the gpiolib with invalid
configuration. EINVAL is the right error here.

Bart

> > >                 gc->ngpio = ngpios;
> > >         }
> > >
> > >         if (gc->ngpio == 0) {
> > >                 chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > >                 ret = -EINVAL;
> > >                 goto err_free_descs;
>
> When the caller intended to create a chip with 0 GPIOs they will get an error
> as you wish with an error message.
>

Yes, as it was before.

Bart

> > >         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6255339C35C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFDWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:16:21 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39526 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:16:19 -0400
Received: by mail-lj1-f182.google.com with SMTP id c11so13438765ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHwV5VmedMjo0fB2YIP5vfg5xQVpg3dB69VmPS6NB6w=;
        b=MnVZxFbAveBu4SxAm6rnwMcfKbtBeKCjcevhXTmXa4rOuP9GiqtaziNuotSsoxvwM7
         DXftDG0skvQrVaCe0j+L+NSy/INIx7jB6FBWMppgVd4y3jKx4sdyBJWUz/dhab18DgmW
         9IitniMtnsgtDoGB26sstadfh70MjYIrU7XponIOL3slBzmKEzcCM99vNdMAzKoYYVqK
         eQeiB4wCcGXLk5PnJnyxuKpZE3aGpvNcnS5caZuss1JCm3x3mXdK72DmUqzpx1G8mhC2
         xg/8oYU5sK4Sn+BzJgEhvatE9M05PNnXwsdgPAwBsTr+ONkPbECP1hA5gd6lWhQZHLU0
         Lcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHwV5VmedMjo0fB2YIP5vfg5xQVpg3dB69VmPS6NB6w=;
        b=JHBDAKYM9rdofDjbTNcplpkCzoX9T2s6JJaOWV/eLBpM8qx7g+Miy8vXsls28MTlGH
         NgZ3vzV2QUMr9E7EQmVtg1IR/+pWOajqCcJFtBoqDEt88nafes035cXjKRGFbqutp8dC
         6fu4/DyyWB3B3gRjvXL3jnpmUrOC42Hn5N9nrxIsalthn3pB9iRlD8U1Hfr1o2RGV4LC
         dg68aZ62u4ul3ls95c5m0cIJV5JW/FNf258KyQljQN+hQISNsjZxSmFYvTCje1PbknN6
         NUo3g0IL+1O4bl78p7wL6BbkTIEIDV/9t1pW5QiOFI8hYQo6zHJnMPjPlZKhJVnhsUl+
         Msrg==
X-Gm-Message-State: AOAM5321CSAxtd39c+3N3uRcf96tDFv1V0NE8fjhjD+kQIHk8pFBgW+x
        QZI6X6I83xOE8lvBCUonvJdp6nA8Aj0xadfbPtD4Ag==
X-Google-Smtp-Source: ABdhPJzYZy+CPX4nMzDIh1hrv+mRFW4eXSwoqi6rFl1IsAzTElzai5va+d9sj7JTSpmJFNS00UuTCZ6Wsuh39dD9LCk=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr5041191ljg.368.1622844811472;
 Fri, 04 Jun 2021 15:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210604110406.11006-1-michael@walle.cc> <CACRpkdZEytf1WJa4JNJy6o3CBqOJAZLb-D=_rGQb+naH=TKmZA@mail.gmail.com>
 <62d131e0c2f16d647c36406ae8f9efba@walle.cc>
In-Reply-To: <62d131e0c2f16d647c36406ae8f9efba@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 00:13:20 +0200
Message-ID: <CACRpkdYsh7=9KCHW8G8_qKoGy-f40rdTLUiE2dkzFGHc6KzLYQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: regmap: move drvdata to config data
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 12:03 AM Michael Walle <michael@walle.cc> wrote:
> Am 2021-06-05 00:00, schrieb Linus Walleij:
>
> >> Btw, I'm not sure how to handle this "was part of another patch by
> >> another
> >> author" thing. Should I leave the Sob and just add mine?
> >
> > Ideally just stack Sign-offs it is called the "delivery path".
>
> Even if it is just a subset of the original patch?

Yeah it's just an indication of whose hands typed thes characters.
Something with copyright law actually, nothing to do with actual
attribution. See (11) here:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Author: should reflect the person who wrote the majority of the
code however.

Yours,
Linus Walleij

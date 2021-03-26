Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6DC34A930
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCZOA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCZOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:00:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE6C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:00:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id e14so8515188ejz.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4E2S5nAzj1ksZmJVDyih97Im5qf9hgz2vlqV5+knSG8=;
        b=LdngGkFFOArwKJ8UJ104P+y+oqKrHDtcVxy/eFtCTkGjXnpY5/2uD3orjojnZK/Vf7
         0/AI7LiO7lUTJCK1SJPyBYybdo0fUsvwNmcYpD2S+zTjfA76kEx5FVJ+FafcqiKuAfEj
         wfsFI/wItAOUL6sRiVTNKQThgZx3E6/MRhJmCg7EgZIoR/nKXamUrCiWTt0wnWq7Ubyc
         81v0fx9JbcRoK8SiL34nhLM+7QfM771UwcCbbEUgqQ5f0Wr5JfGtWbpJYF6bNQLfeJdb
         ydCNNh/ZyKmiAs647P/wn10/7FITOsmEx62R5s5/xDCoXh8QA6xtPIDCqIMjT9s60VMg
         J0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4E2S5nAzj1ksZmJVDyih97Im5qf9hgz2vlqV5+knSG8=;
        b=oByvqAQpwUkcceInYc/PVDq0nvS4IGXGsB6TaxaUx6m/P+WKHzBqDP/IotrQjLM+wq
         giPmW8EkdwQsTaVS41u6x0pDpaAGGodjGdkvXqBMV5ADqgSa/r5EIO5EyYdmUfIykVd4
         jFpi9czOOei2J2wthp/Frv8vMouw6y4jyYu2Jg6Yjp1S4GTSI9Yc9jEwvq+vupI17jrx
         osDbNERbGQjX2eeccsmyTMCKD61pgorBg8W00n2Ulf/WWRmCptIFMD8mtmAZiw0NndXL
         Jye1R09jInfx9M54JfNMxgGV3v3raTg71d739jiuc4YZMbkWT9OyXkLm54yAaCU6j+zw
         RUMQ==
X-Gm-Message-State: AOAM530tjrR4m2F76bMmxpsC7RRZB3PqiveDG7ozSZF6yHK0WlwBzZ9g
        43c4CiMHSORCNpdvoWgi3uhoqkTs7tqAPr1A9+e+Eg==
X-Google-Smtp-Source: ABdhPJwCIK6bEQ+wusvSDhVviUDIcN+68kuVwxqzCeJsIZn9JiWkLZiMbDYndaUSskLApbRkVzmHH20b/0WPNk42s0o=
X-Received: by 2002:a17:906:398a:: with SMTP id h10mr15832832eje.155.1616767231611;
 Fri, 26 Mar 2021 07:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210315091400.13772-1-brgl@bgdev.pl> <CAMRc=MfQnofWQKz9tbnTA_1M8BkN37FcxbJpK4hs0RoRebWWkw@mail.gmail.com>
 <CACRpkdZbGDjAJarJJN91gGfHqXEG3puj=OwsQu=OZ5L+tpWt6A@mail.gmail.com>
In-Reply-To: <CACRpkdZbGDjAJarJJN91gGfHqXEG3puj=OwsQu=OZ5L+tpWt6A@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 26 Mar 2021 15:00:20 +0100
Message-ID: <CAMpxmJWdwpPBBcg_QrZzDmvvm6ZUPD1QtPCjhj+yz_=Pk2q3=A@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] gpio: implement the configfs testing module
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Mar 22, 2021 at 3:32 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > FYI The configfs patches from this series have been on the mailing
> > list for months (long before the GPIO part) and have been re-sent
> > several times. You have neither acked or opposed these changes. I
> > don't want to delay the new testing driver anymore so I intend to
> > apply the entire series and take it upstream through the GPIO tree by
> > the end of this week.
>
> I say go ahead.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Series applied, thanks for the reviews!

Bartosz

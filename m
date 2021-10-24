Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7B438C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJXWUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJXWUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:20:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243AC061767
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:17:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 65so4289923ljf.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJaQllcwUzGd4qxnMR+A86sauTQSNS36fTnnI/uULQM=;
        b=GQ+zacEvuIRSW8rKG/z7bNab0DMU6w/J4LIs6RCDHju9nVo1ufu9qJ9aDN0QJNxejY
         0FL926egcpBAegVGFn999GDpXrzXuR0g4jSjEjkqinSx9UutX/P7KOiiUeMk2It6MaEo
         rRHzucaXtlYVjA3ligXrHAhCQn+VAnngnZworLl41Rcs1XgMfoUs0XE9+ywYpBqjif0Y
         145L74F8X6SKmrGpzzZ0a0SX87Stx23qWWYI1iu7U2e4F91knBiglw4EpyuTZiSSocg3
         7WqpX796Rj1dGzcnbqfcuMw01bWvOI4Fx9g4xGw+3ubQMZKk1c22FSXIVbj+xJg2o29T
         UZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJaQllcwUzGd4qxnMR+A86sauTQSNS36fTnnI/uULQM=;
        b=W37Uq3HJTx5fxksgDLWHy08ayvvq8272WZFLc6D81NRT2kgOFNtHW/mfeyETzmg5RF
         cye1OXa9Of1xHCE0o36Fpo37RtBCR/3+LJ97nN/CpuBwP+6ONmeVNbRdkRYy41jP9aB6
         pcWtqRhJRJ60jgrkrATd/nJJ2pvARoRIcoIsfXvqY8LqwQnKJmSXEoZj46So2602LJ3m
         A1F7n3SDvIppIhVadlTr9n7aI4+RlSuvOXFOGQkOscO7lJzeWYrSaVYTKjwzeOsjm3MS
         ZuHZW91SZUBmuOmgB6b01xmhjZdfR1ZgAHU+hcUG9AHdDiGxO769cDjKydQDtfk7hQ67
         TwKg==
X-Gm-Message-State: AOAM531q6YIkzk3yt248P/bo69TujsPeha2yr0EB3M3ZGWXSy7MK6966
        NMOXkLSRfcEFV/muV5WkamBHfXjVr94gd04kASbq2A==
X-Google-Smtp-Source: ABdhPJzoqTpYQ5TpW5Izs9igH8k5pOJrErUUiisSDzyj8MrLgy4z8bzWFA9jSxPgHlJRRbjcka6RCXHo8VBMTWnTrq4=
X-Received: by 2002:a2e:b748:: with SMTP id k8mr15148284ljo.358.1635113875297;
 Sun, 24 Oct 2021 15:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20211019200831.3817-1-maukka@ext.kapsi.fi> <20211019200831.3817-3-maukka@ext.kapsi.fi>
In-Reply-To: <20211019200831.3817-3-maukka@ext.kapsi.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 00:17:44 +0200
Message-ID: <CACRpkdYvhM53GVLpDp6mHmy+U0kTz2t-yDz5afeXeWTgp=bsXw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] gpio: gpio-cascade: add generic GPIO cascade
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     Mauri Sandberg <sandberg@mailfence.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:10 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:

> Adds support for building cascades of GPIO lines. That is, it allows
> setups when there is one upstream line and multiple cascaded lines, out
> of which one can be chosen at a time. The status of the upstream line
> can be conveyed to the selected cascaded line or, vice versa, the status
> of the cascaded line can be conveyed to the upstream line.
>
> A multiplexer is being used to select, which cascaded GPIO line is being
> used at any given time.
>
> At the moment only input direction is supported. In future it should be
> possible to add support for output direction, too.
>
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> ---
> v6 -> v7:

This v7 looks like clean and nice merge material to me,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

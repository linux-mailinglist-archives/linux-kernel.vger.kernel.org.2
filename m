Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE209458BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhKVKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbhKVKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:04:49 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F50C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:01:43 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id y5so35286917ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9cKZ85V/kOofYO4Xn9D9NxUA7pbG6Ev+c+SBRxE64k=;
        b=LLOALxzuISMVAodihUK25Q4JlSFsywz0o35JoodfcsNHuAi/YcxhnuLoSsikDHA2q8
         vuvKJm33Fg53FYgXZ0l3oHxqvC1c07qRN1bN+VVgNNPu27GWwUaKJrdBN0Pvg0YTC/51
         oeAuc4FU+XotgfcEOlt3tWq89P5fA05cQrzPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9cKZ85V/kOofYO4Xn9D9NxUA7pbG6Ev+c+SBRxE64k=;
        b=cQCgnMGmn/s1H/VdeH7nNh4ER1xQlBPb5pQgGXAWRZ9MJngE2f3JbSC6wZarm2zWSf
         cuiC2bMeJ2IfeVqO8HSsZJAUtmUdM3h+qawOfJumUC7oE3pxTypJ3UoXdq2u4+HfMaEZ
         KJV60t49JX4ibz+cZ8v1PK6w36gwZH/cXT2YEISRpjsI/DbOo2Mr1mDHxkuW9aEwQ527
         MOIA9/FPq1BK7FUdC7NYbkbQEaJ62+4sdbCaxg6SRk6G9QTsh6SY5qrlwW/b0o7+6J/R
         4qFA5MmvQNkpcRZY8b9NNMYBB1ps9qgFHl+uLDFdaVd+9p1NRTNwsDUHvZzA7fP/Dq+X
         t13g==
X-Gm-Message-State: AOAM531dCpF6tOkyfD+Ibqau0yctZ1HDAjb33qqHYU9OjM7Oj9v1FjF0
        to/r7pOtFG/lOVTqUVv8KLi8Is3EPMX5NmkAs6VWpQ==
X-Google-Smtp-Source: ABdhPJy5AkNAerk25bDE+1X3yRxbzD4HZeiarqaFa2ZdpKEHGA0y9mw2lAcPsMW/rzogSnFGyjA5KtHtgZ/ypDezrsk=
X-Received: by 2002:a05:6102:38c7:: with SMTP id k7mr122446860vst.45.1637575302665;
 Mon, 22 Nov 2021 02:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20210923065500.2284347-1-daniel@0x0f.com> <CAFr9PXmPE_vRcHgPkJp3o=d5HnAV52TFuBe-2hf=hKY8y2=BhA@mail.gmail.com>
 <CACRpkda9j=dQKp+W0iE0xhbuBWAibXHovgdEVkyXHevRnnRtsg@mail.gmail.com>
In-Reply-To: <CACRpkda9j=dQKp+W0iE0xhbuBWAibXHovgdEVkyXHevRnnRtsg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 22 Nov 2021 19:01:32 +0900
Message-ID: <CAFr9PXm7YotmZFFuvqGwfromRGY3YdRkoH4ZC0kvOxqxujy7AA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] gpio: msc313: Add gpio support for ssd20xd
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        pavel@ucw.cz, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 22 Nov 2021 at 09:05, Linus Walleij <linus.walleij@linaro.org> wrote:
> I think it is usually easier for the maintainers if you don't include
> the DTS changes in the series.

Ok, I was aiming for a series that added something and then showed how
it would be used hence adding the board DTS bits.
If needed I'll create a new series with just the relevant bits. The
listed commits all got reviewed from what I remember so I was hoping
they'd get picked up.

Thanks,

Daniel

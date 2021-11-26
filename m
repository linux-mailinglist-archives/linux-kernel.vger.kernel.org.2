Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA545F71D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbhKZXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbhKZXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:13:20 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1436C06175C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:09:40 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t23so21470726oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szAbCvEVc+U0OOZvhHgeQny7/tz8gsDalBmRPbcJ/3E=;
        b=mV0tiAY7f+lf5HK9nIVV9X/OvyN1pM8C2KJSKdd1lcEjADhYd5yL8qTkBU9Q52lB3E
         YA+VlfF/nmsFJeXepADpwf23ZJhfokExBGnW/z5xbfeWa/Y78Cz6X5PSx2ODsTgkxF2W
         tGn11zAzGQECYzhohbb+im891gNzbzQ2HN26s/A2ogLhpgb0sUS8dlMApsvJnxkssqxx
         JLw7dpmBdURgM+liRnwziFU8qHE7+l8z20saRyQhqHKgTCtYZrBUXYVw8ARDMr1uw6Yj
         /O2tIKO/k0ptH+0961uahxU8Kijcvimo1gMcW37LRFj1EvKbzKgLYKASrcESO8WHYTeG
         wdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szAbCvEVc+U0OOZvhHgeQny7/tz8gsDalBmRPbcJ/3E=;
        b=XE+75dJmwCLAaI/1foC5/iWX7Qe0JaiExpHWQrGzVtN4oRpWmRw3bke3mrV/rmLCR0
         8GgzRzeWQD2E0AZP+8d+ArUNSHfitKBG/w04C2u665eIw+a32Jigtr62fnEI4ciZl8nN
         I5zUmnMWDFcHBojVIS7HPuqgUZXka9Nfc+p161hzKyViurIUqWYvnpv3AHjzztcW0Q7v
         a7RP+cwGoiQqf+8sZItTpxQpmJmorWOjzl4gwPfLDqPJBTfKs34j875o7v24wFeLxjHN
         Oe/vhYzS/JbKj8eGaiwPbdIrmqXREwzel53gKICVrWT2+5oTAPTap5k2tnT2kTC56bZm
         sTvA==
X-Gm-Message-State: AOAM531zy5l5ArNABoSYmZ0tHbolaBA4iPSYZd72hYgkBGTBghUua78L
        XxDyxdJ6MVNcBySoku/0ef3ku1BQBURjlhgs73ltafBQ/SHoMQ==
X-Google-Smtp-Source: ABdhPJyYKrBx78YhCu+G0cfxdu4WZA4XHAmFbZbp6Tkv+G+i9KKeB4qSzgNhqgmOIe5YoMABQPZ9LmfZFVvtRC4zdKg=
X-Received: by 2002:a54:4791:: with SMTP id o17mr27032271oic.114.1637968180205;
 Fri, 26 Nov 2021 15:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20211126011039.32-1-tangbin@cmss.chinamobile.com>
 <CACRpkdayKYeizBt=dspQ2VdsQvpc8iq7XeaT7SnRiCyMVO2Bsw@mail.gmail.com> <53308403-a6b1-3af4-27ff-9e772e378bd2@cmss.chinamobile.com>
In-Reply-To: <53308403-a6b1-3af4-27ff-9e772e378bd2@cmss.chinamobile.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 27 Nov 2021 00:09:27 +0100
Message-ID: <CACRpkdZc-zqeWvk_YFfQq4bORgrtM4U6RmmH9n3QV0qO7-q6dA@mail.gmail.com>
Subject: Re: [PATCH] ptp: ixp46x: Fix error handling in ptp_ixp_probe()
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     davem@davemloft.net, kuba@kernel.org, arnd@arndb.de,
        wanjiabing@vivo.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:40 AM tangbin <tangbin@cmss.chinamobile.com> wrote:
> On 2021/11/26 9:26, Linus Walleij wrote:
> > On Fri, Nov 26, 2021 at 2:10 AM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
> >
> >> In the function ptp_ixp_probe(), when get irq failed
> >> after executing platform_get_irq(), the negative value
> >> returned will not be detected here. So fix error handling
> >> in this place.
> >>
> >> Fixes: 9055a2f591629 ("ixp4xx_eth: make ptp support a platform driver")
> >> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > OK the intention is right but:
> >
> >> -           !ixp_clock.master_irq || !ixp_clock.slave_irq)
> >> +           (ixp_clock.master_irq < 0) || (ixp_clock.slave_irq < 0))
> > Keep disallowing 0. Because that is not a valid IRQ.
> >
> > ... <= 0 ...
>
> Please look at the function platform_get_irq() in the file
> drivers/base/platform.c,
>
> the example is :
>
>      * int irq = platform_get_irq(pdev, 0);
>
>      * if (irq < 0)
>
>      *        return irq;

In this case, reading the code is a bad idea. IRQ 0 is not valid,
and the fact that platform_get_irq() can return 0 does not make
it valid.

See:
https://lwn.net/Articles/470820/

Yours,
Linus Walleij

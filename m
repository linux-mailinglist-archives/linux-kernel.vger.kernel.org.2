Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF7422D66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhJEQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhJEQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:10:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA14C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:08:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so88556309lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzfx3fsRo7F5xw3fHSg8nKJV024hLxYFAlzOMQp4+E4=;
        b=uFqA5Cc3evmiBrUl9z6ToXQIVBU296s5VunLco/GeXPzwXHxuPpMdOxZBBU7FsQwzb
         ohznDJht5Qkj9hI2kFgCESrzSMkuWoMc90R6zOxOlAA2xntHYdgt90DkQVT5LQ8qb588
         yeaPyQhKooeku/8QQQEEN67WGwghh7Y3uBzNWseOHcM4GkhJ7PxJERPwq8fjoQgRjhKu
         ektxYB62gxECriYpa30+gxG5IcaPhA8YZ6wowtlTqeamGaePiWoxBgyJjGgLIysYZXUa
         yUCFn8xxFpTQScVpxMRkJM2ZQ7x9YmbSz3Ut/7OJ3qYgAhFiQhHy8Zv0Z/J+7G8gKW2K
         wx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzfx3fsRo7F5xw3fHSg8nKJV024hLxYFAlzOMQp4+E4=;
        b=svMo8Itq6T2AFUsU4SNSspvZ6u00V1eSJiRLFNx64PsHUNntYFOajSfHvf5KDuehR2
         ZdhNuqzodvC3b1KORre63ByPq9W/2uLhZ/38B1f14FI5kua0uP3Q/hmikY10XlCFezAO
         FQ43DXi4s3F4/jOw+OuXObNqvNFtjukvA3h1fm2bfhUGl/sGZD7Bp1F0U34usd2oqPY5
         vArq52w0ja9szfdletqlrqd2mlOv6qibYfe2ZnYZ160ojjDiSQtsh5QjjY/wqkGDAWH7
         VgaA0pQ8hknJTNayX255ixi8Jn5uirnRD1955dh7cFE7B6b9GnMW/hR59JgOQWjPE17v
         NbyA==
X-Gm-Message-State: AOAM532j3Hws+ftB86F9ia13nBz3jPPjfRCFtDNQ37gbaBV+sBdoV/s2
        PFL1gIKxgwe0GFYAfAmhpm+v68RHBvrkDL0M3xcSPw==
X-Google-Smtp-Source: ABdhPJwnC31+Ik6u2dpcC0CWhMVXL1AHvSjtDIcmiq1/SWE794/6DgQfUSDzkEj3yIm9x+wD7DVu/FMKUe34DDg+Je4=
X-Received: by 2002:a05:6512:10cc:: with SMTP id k12mr4520941lfg.72.1633450099935;
 Tue, 05 Oct 2021 09:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-4-marcan@marcan.st>
In-Reply-To: <20211005155923.173399-4-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Oct 2021 18:08:08 +0200
Message-ID: <CACRpkdanbovvXXLAGGZEEiKXXrNnW+8p1sCONQYWmAjVi-m-9A@mail.gmail.com>
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state controls
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Tue, Oct 5, 2021 at 6:00 PM Hector Martin <marcan@marcan.st> wrote:

>  drivers/soc/apple/Kconfig               |  21 ++
>  drivers/soc/apple/Makefile              |   2 +
>  drivers/soc/apple/apple-pmgr-pwrstate.c | 281 ++++++++++++++++++++++++

This is traditionally where we put the ARM SoC drivers, but
Mac has traditionally used drivers/macintosh for their custom
board etc stuff. Or is that just for any off-chip stuff?

I suppose it doesn't matter much (unless there is code under
drivers/macintosh we want to reuse for M1), but it could be a bit
confusing?

Yours,
Linus Walleij

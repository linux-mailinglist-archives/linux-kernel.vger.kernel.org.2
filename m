Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB043D3841
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGWJTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhGWJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:19:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA0C061760
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:00:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r17so1202812lfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3A3wcg13DZEjlCLDewUoUp2VK6us3A/bBxLiSdBb/g=;
        b=ANJjpl7NzOK7kQfV2NofKZZL6aTJrGWvKTTPloBDHHVg3B6xAG714RqD03hWe6uq80
         PZNZOc/PjOZiuE9PetDORTDVnG3p8lN5vcySRm8QT4m7XaqVt59XbrpVvbjykfeeihcd
         tmd3chqjQbdHk91ZhJEWKqMhKpii+6mnHI+qbDM4dwA9zF/FuIzNg/Zhxdhg+Tc7UOI/
         46uWhyLPz2bH8AOCjs3QfgQe/+cFANBWXdSnHP5jd/fR9iIbaso43z5GHNvfo3ZtozNb
         vC0yTCteUH9OcxwnTQAASPULIljFvOkiPjQK6xTxu/o3ssRUOckAatfnSPggS+LVfQul
         ef9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3A3wcg13DZEjlCLDewUoUp2VK6us3A/bBxLiSdBb/g=;
        b=WJ3cJb/78Y0s14JT9JEvIfZGvpZdqFLIOuhhQTzQ393watBpchDtZvO35YJzm7c9R9
         ry0GkscGmUG7sg30aFTB2V5z9iRRiKSSia5vCW6LwRibI0sQJd/iVBUVPsBoBT5EF0+j
         b5HuYWXHwByYFrJkKSZVz1HpIeVxx7L8epIfU+3kns71YTDIZ/gsIPEpi4SeD6//2cS4
         wuMIWkD9BL9f/YkE2sE4gOHUqlp0M8nk3mam0Et74yNRb7I6c/SxTPFc6ykQdeS4oUzb
         8RpAtvhZWOJfiLcJKIAHm2umU8kw8PuMv1H9d9m5Qtz6vFeaCRzvuGayOjRzpNqDB30B
         X8/A==
X-Gm-Message-State: AOAM5338/7Ri2/b78k1SZXFvtHRm7mHGqp8dDNKHK+QwvFrtpjyS+jTe
        eYzlZhpGXBv7wdipo5053qus2jBDCOoQmcawDIA0rg==
X-Google-Smtp-Source: ABdhPJxcpwkaKCEEng7O+N0rUtzYgwgekwY+aOeUQQrJkKShW042z4cuNAEJbb1Pn6WghT80XUFEIu8S0GqeR9yEIfw=
X-Received: by 2002:a05:6512:169e:: with SMTP id bu30mr2459661lfb.291.1627034406022;
 Fri, 23 Jul 2021 03:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210712100317.23298-1-steven_lee@aspeedtech.com> <20210712100317.23298-9-steven_lee@aspeedtech.com>
In-Reply-To: <20210712100317.23298-9-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 11:59:55 +0200
Message-ID: <CACRpkdZa696HyQvOssrUK=KiiJGVfvCZZ_7zyOWGoEaB-R_BkA@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] gpio: gpio-aspeed-sgpio: Use generic device
 property APIs
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> Replace all of_property_read_u32() with device_property_read_u32().
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

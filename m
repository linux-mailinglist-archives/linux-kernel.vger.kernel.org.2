Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79538FEED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEYKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhEYKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:21:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:19:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p20so37401159ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcT2Jgtxlyo0CZMh0hHbgP3RE9+2ZLrBHr6m5cHYlYE=;
        b=dT4U465qyQm+NuGSEtvJrUaFPY2vNIxX+/RkTGzkDxESJGHX8xKyHdXwMpexc5OEf1
         4fqkzt5GLcpr0jHvk6eq7X+HOI8HJK8CubxMTNro4jId3u8LBGutZZr0+RIYAr+BTGy7
         wc5j2Ph6PHwSG75S7ZSzfn1/3GE/FBkMzeUsIfvzDTI6WqK82ic41IWaj5b8UFQeKV/8
         JrgtJNzVhU2raBMDea1uXzgGxeWKdrnFPJSOgnP+hmEZU3+MZppCpWCiktTuPAAY/WpV
         4T+YtWnKs3+E5SLsAgZhZcfwmeYKlTfQ+lW8ThX1QeUlCe2nFgi2zGv6g8vpwotpUPVq
         7+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcT2Jgtxlyo0CZMh0hHbgP3RE9+2ZLrBHr6m5cHYlYE=;
        b=XNuhM8jPlqO84B34d7tXcSq92xK+oKdINrWhkl0DimMeEGgBgY7rWQEJ477x5H+NYY
         NQbn8a1qrIT7PAC22Zy/yHWDuR0dcFSubss9uiSeV3LPdzd8UA87J9DoG7jEUUElJxPt
         855LuqHy+HnN8cQLdPW9wiPAfKbHLoXRNg7P84K3Ps3M6O08Sd0nTpt+kiOg3yprM6HA
         ZAA/8v2OlYzwBLp72qFUb6sej+4YumMgi0j/PB3GAJtxQcuSh+FyQ9FZ4UTytHxI5lGl
         sKsqsX/Aemh9K1rpTN3GV5zo+P3G379siBehY99ZfctYvjh104uNQOTNLapuoK/piTqs
         y8Cg==
X-Gm-Message-State: AOAM531xueTGJSac50n0Aab+1GZNotw7mk9TLxzpDxiR+FQOk6UGSc6D
        vsAWJl5WYkDrjGWt04b9OqZj7yb/v30QGr6hysatTQ==
X-Google-Smtp-Source: ABdhPJzT7tL/SPPXamyedELaJ6nAfh9lFihJxM6PQnzr/GwL0Jl3DrclF00hvfS6jymBWcYv/s5V58iB3at8IMyuM/E=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr20322030ljg.368.1621937979403;
 Tue, 25 May 2021 03:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210525083340.27722-1-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 May 2021 12:19:27 +0200
Message-ID: <CACRpkdYkb+-y366esEDZBDMNQ7s6zOfHEPotNaTUi3m95QrBFw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/1] ep93xx: clock: convert in-place
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:36 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

>    text    data     bss     dec     hex filename
> 4491689  920748   92840 5505277  5400fd vmlinux
(...)
>    text    data     bss     dec     hex filename
> 4534485  927424   90304 5552213  54b855 vmlinux

So IIUC that is 49472 bytes more text & data? ~48KB.

I think what really matters is the 2MB limit on compressed
kernel size, which I guess can be pushed a bit by
compressing the kernel with something violent like ZST but
ultimately what EP93xx might want to do is to do what
the other SoCs are doing for accommodating Android: move
out as many drivers as possible to be modules and
not compiled into the static kernel. Do we have candidates
for that? Are people normally using modules on EP93xx?

I am  modernizing XScale IXP4xx and it doesn't suffer
from this as much: even the really ancient NSLU2 has
32MB of RAM.

Yours,
Linus Walleij

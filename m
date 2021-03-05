Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EBA32E5AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCEKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:04:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:04:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so2588289lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8J+w0fgwa1sUpfMBZyADbuEDaCsE3m6al0EfMW9eHc=;
        b=jRkpbGiDkQKNnW0MtmXLS+rYnxU/89mVsIl1jrF1GI6PL3iuSBynM7JspMRmf7UlQh
         y87uDyKk8PVvsmib6OfNxExG0e9Ox58GHRIn0l8Wk9sdDAJv/+122eVMvf9E8TaM1Vmz
         L9sR1U2USGzwXiHPs3sBZJ27tmXtntGwyA6G/nvCqVZBxFev1vJ7Od56JD7gF9H72Lhy
         FSeAuSDxQxpOgl3PpSRFV3Po+Lm+6x5RK9CoEsioXtxPI7L7rYHBvO5n2zfO7CzX7KK1
         DdbA2YBwI/GT6n+OwYhnx3phpm6hGPc/fhWJVsRiZItIFSdr9rLw0aqj+ViQGY1MiP8J
         YuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8J+w0fgwa1sUpfMBZyADbuEDaCsE3m6al0EfMW9eHc=;
        b=olgn3GCqR5g+ty4s9XiNkQj5mDnEjYofDDrRMQ/hGpTopOA5Y71Rc39WkMZM5i0sjT
         h6Ch2b4LG98r7Ua34vsn5Y3xE8iIyINNQNSYu4aBloL00nY4ezXhKI6T/pDpBB65hwKq
         Gg50/5W9bAwxwyF6tIHUGfPRna9qMNrKpLiLEB/uXT1HuraTIWyKte1XEzrR4/biOfq+
         B+ImETjzGlmEXg4IaRdQBhvM95wL+jxddkpinZydue0XmwwkO/NSwlE1HNyn3XkSaxWy
         K/2M9h/gsB8oNOFZbS2hyewijUUmAe11IojnSHfGEYHB73z5T1p/cWS4l/JYRrULAFTZ
         N/kw==
X-Gm-Message-State: AOAM532Tx+i5VG2dwCyyAugNU9VqO83NqXzeEsmyrHokHfLS8xZD81EZ
        8pEVBinVTBTSodlXKeLn2pschvV3c1fXbPeKUumk3w==
X-Google-Smtp-Source: ABdhPJxqh9yrK++QTKMKKbhStbC2MKJkUlZCZFJblRpzoAU+KHfUpZSpw/evQeR73PgLX4p8Ssace65AiYUWgqtq9sU=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr5256407lfe.29.1614938661355;
 Fri, 05 Mar 2021 02:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20210301142834.345062-1-masahiroy@kernel.org>
In-Reply-To: <20210301142834.345062-1-masahiroy@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:04:10 +0100
Message-ID: <CACRpkdZ8niLC8+LFs3+Wa79HCzYGSmKN4uLbkHsY_zk881nPQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: syscalls: switch to generic syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     patches@arm.linux.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:

> Many architectures duplicate similar shell scripts.
>
> This commit converts ARM to use scripts/syscalltbl.sh.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This looks good to me to FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'd like the arch maintainer Arnd Bergmann to take a look at it
though, he's the authority of cross-arch code sharing.

Yours,
Linus Walleij

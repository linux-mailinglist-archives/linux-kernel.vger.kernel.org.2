Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B6D3DF892
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhHCXiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhHCXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:38:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8136C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:37:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m9so510537ljp.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgcU07P8d98LR001HIP6m4+/OqdYkIdGGA3CcX8rXNU=;
        b=rKdwokq955nH4grtwUQdwUcWLmx/qiIuS8oPGDwfyMTgvVntboPQ/ZU+cvIInSMLLy
         xNpFAqRH+piza3H5pFzlNsVQcFFIASiVyreCmHIRJQ1/wpA56oTBmDhE9RoOwu/c2AzU
         CrXPeTYO1O9B4fLMUAlLYXhiUvKHzCyhp34kxYXQ09JZzXpiY5uV91NqOF53LsBj7DTa
         UcpU0SQuygBKw/0tAJx5qvvEIIQ0d2L6UXYPhBiHY94ifzhnjmDbqJrr8sBDX8V/uGyX
         nDl3rovtNqPQFEJ5fvInCcYfERei5QdO3vtm57afEdDiCtYFPqcPaZcmtEEazQ/J71DK
         aOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgcU07P8d98LR001HIP6m4+/OqdYkIdGGA3CcX8rXNU=;
        b=ApVzd1Ap7HdzNS0G6cr59bY8hysDoLrO6+o1A/e8wS/ywvbJSVd0joY5dQhq5VaB5Z
         vG3U1xj9JCuRpBtIShNnC5CFg5txHe1hGAdpaFOIIAcCH7/7fAvz9fWOcCZsUKXp2o/2
         Q+alx2TIYWCBWGv1a4YMajA0vh9/2rngc1M/vU247cUv3O5F9IQ1n42xhfnINZv9c5bP
         g+yyWaaFgHp0RuJzkuBJBH9bZZb4KDHaOWThJ6buxU+M/D2sed1QotfEmiVQoDV1iFb8
         AksuMSSKx0hWuyEI4bJ+l+Hu6WkviToQMdufyMwzZLY4RxsTewc7eCm7YUvtPQ0xJJMD
         zJLw==
X-Gm-Message-State: AOAM532lINuXmojUpq6SuFt0aXxYh2QFdvdpPTiBDd/hHKuYMbhzYqC/
        n8YvzYfNE/GRIAIfxwlol33Rp2ZfQx7TxCAaLzmBCw==
X-Google-Smtp-Source: ABdhPJwzckOkwBUeYQMWYEIsex+AHjlvavF2W82n9ctLhzOVO7QJq4N3oQEEp6wdBNNH0DVeYDGzgCxQx5YZqjLZRE4=
X-Received: by 2002:a2e:b615:: with SMTP id r21mr4207328ljn.368.1628033873263;
 Tue, 03 Aug 2021 16:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210803082034.2085618-1-arnd@kernel.org>
In-Reply-To: <20210803082034.2085618-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 01:37:42 +0200
Message-ID: <CACRpkdZOzCPKMiCaB3McYAmXZ1oC=L6jKER9a7g2oM6EHE55Fg@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx: fix printing resources
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:20 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When compile-testing with 64-bit resource_size_t, gcc reports an invalid
> printk format string:
>
> In file included from include/linux/dma-mapping.h:7,
>                  from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
> drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'ixp4xx_npe_probe':
> drivers/soc/ixp4xx/ixp4xx-npe.c:694:18: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>     dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
>
> Use the special %pR format string to print the resources.
>
> Fixes: 0b458d7b10f8 ("soc: ixp4xx: npe: Pass addresses as resources")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34F2418A98
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhIZS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIZS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 14:57:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE5C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 11:56:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so59622427edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euhjRyQ0dvhOzaWisAQrBRgkNaU3wGFLRW2qXQGz1q8=;
        b=IxZPnAMq/V0yqSjNHnrnmPO58IzCuok1uPDSKG7Gqv7WODWcY1/mqLEBY8qhWMVLoj
         20PkSsmW5mt0Zq1gjPxWRAnR55SQtyq5/b6NU1W7RSqqU94NjHQhpyJruyKgN7Hg1KI6
         V3E/kDJ31FJNtTvyyAvQpC0d+dwPO5fa1MTE7cIL+ML0LsKZdYQtvnLame7E+GK360Eo
         4NK8AAH59aDI9ZpWZFNEaDplCStGbvxRyy/Yg39dAmLbQbscLt7VSlnCtTBfTCGbLR9G
         Vx6S34wa+krhh3zIvJm3PhdnuoAp6GO0D6RY5wIRAwTHondg4rtHTzF2I2O0Qf9WT9+1
         5hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euhjRyQ0dvhOzaWisAQrBRgkNaU3wGFLRW2qXQGz1q8=;
        b=vUBlC/M5vQkRpMpBITZdBtcwMuRNT8SXkX0MleUp0gtJH/LIgXg2KEoJwPNrP9rh3t
         3y1Ou+Ao+K5mAG89BY9E7KtpD4Eg2+UielIHYMME8KzENdhdhGIRQe66P0LA7uUwfNy1
         Vv8dC9jo4uxdXL+89reth3x9vtM5enCr0XwByKE47P1Vsz3JQqZ7lVMaCIrVdzXPa60V
         WsBTGnIwoNDIPOVT3T0CtYgP4bgrWAhCbJkYE3s36M+Xw8S02MyYvQLKxwaSH2Aob7E1
         fvEGgsr38W2R7edJl0KVQzu1geZBJoIkKRTLGlXITIFtGxx7EsSwS3dCwJTjgROjSlJD
         8qCg==
X-Gm-Message-State: AOAM5332GEGONrBDuwYIq/UyCMU8GNx7Umwkx1jWBuikyuJHoyJXkFMa
        smVO0uUx2ttyQu+BiqUQfaueGFr81QR1q7jZsxg=
X-Google-Smtp-Source: ABdhPJxDX5PpX9LV+llk+yPx86d6jhgF+t80r4FXedvPh9uMo8q8Oa+H7Fz+NT7mJ+ExOflwi23D2D3oooYsnQ2EjmY=
X-Received: by 2002:a17:906:7208:: with SMTP id m8mr22939415ejk.82.1632682568970;
 Sun, 26 Sep 2021 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210925032951.6767-1-rdunlap@infradead.org>
In-Reply-To: <20210925032951.6767-1-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 26 Sep 2021 11:55:57 -0700
Message-ID: <CAMo8Bf+TE4PX5PBD8bSsF6Cx+LGunExjuB3xXyyRvwzC0iHMDA@mail.gmail.com>
Subject: Re: [RFC PATCH] xtensa: setup: use CONFIG_USE_OF instead of CONFIG_OF
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Sep 24, 2021 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> CONFIG_OF can be set by a randconfig or by a user -- without setting the
> early flattree option (OF_EARLY_FLATTREE).  This causes build errors.
> However, if randconfig or a user sets USE_OF in the Xtensa config,
> the right kconfig symbols are set to enable xtensa/kernel/setup.c to
> build.
>
> Fixes these build errors:
>
> ../arch/xtensa/kernel/setup.c: In function 'xtensa_dt_io_area':
> ../arch/xtensa/kernel/setup.c:201:14: error: implicit declaration of function 'of_flat_dt_is_compatible'; did you mean 'of_machine_is_compatible'? [-Werror=implicit-function-declaration]
>   201 |         if (!of_flat_dt_is_compatible(node, "simple-bus"))
> ../arch/xtensa/kernel/setup.c:204:18: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]
>   204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
> ../arch/xtensa/kernel/setup.c:204:16: error: assignment to 'const __be32 *' {aka 'const unsigned int *'} from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>   204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
>       |                ^
> ../arch/xtensa/kernel/setup.c: In function 'early_init_devtree':
> ../arch/xtensa/kernel/setup.c:228:9: error: implicit declaration of function 'early_init_dt_scan'; did you mean 'early_init_devtree'? [-Werror=implicit-function-declaration]
>   228 |         early_init_dt_scan(params);
> ../arch/xtensa/kernel/setup.c:229:9: error: implicit declaration of function 'of_scan_flat_dt' [-Werror=implicit-function-declaration]
>   229 |         of_scan_flat_dt(xtensa_dt_io_area, NULL);
>
> Fixes: da844a81779e ("xtensa: add device trees support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/kernel/setup.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks for your RFC. I've tested it and found a couple more places
where CONFIG_USE_OF should be used instead of CONFIG_OF.
I'll post the revised version.

-- 
Thanks.
-- Max

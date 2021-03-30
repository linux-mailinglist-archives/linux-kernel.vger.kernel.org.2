Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC134E596
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhC3Kjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhC3Kjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:39:33 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:39:32 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id d2so3451575vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx+qunAgeaKNzL/3vPJGFvdOm7PGo9OLfJ6hKlJPmiE=;
        b=kI5FFf3THdLIjOHzOjtIhhe00n2B3q6Tr0GaFLMTyppf+VBJ57i/smGoRVF+UFkdAX
         Wo0iXNy6Afvc+PPUqmzTLbO6FvNqEbb231rlN1GKiotRSwA2zNkNazyilIcVKiKSvy+N
         KR9k5fycIyRtmjdD6OU29//Ta4JOLoLOeHlZ7Sr4UDaF2dm+X+Ars7TgLaqDanRu2qMm
         DKnIMuNXvMMdowm9Vo3vc6/8YA1GRXhAliaTUKDoX1Za4NYWdhI9nWBHnk7bAztXsaRY
         0LK00BCHMbP9z0eBcwo5uyU//2AgP7AdBMqgWdx1QyY/pj1EBjewLx3NocixinBOauzA
         TGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx+qunAgeaKNzL/3vPJGFvdOm7PGo9OLfJ6hKlJPmiE=;
        b=aHqIU7VYC4wxq1pPNhSIvLbLkSn9U6eQq4oS1J049ISyVmg6siIR9A7qitT5ejaP9P
         38f0FFPScpA3wYtU0P3KiafPancmB79d0+yP5Og/mfHsiS2IE8ySjB9DCSZvm71mF/3z
         YURCFxCYqbSq/mQP0Ebx2F378oUv834GpyYRCi5O9OgtfqPWSzVR2JpMvmGczEK14GVn
         GNVBdCK8xyK0ubuMtpAsYE7rKkWdD/jFTOhVU0WA07gAFx/UAbcjm1dmAIJL3oa/+NSf
         xtiPhXaTGk0jPfM4qtJCgQVWWDVb3Iw/sMo5uZ7zGpOKMjjQnwmxnnR4F7Q6XtWRDvVf
         BaZw==
X-Gm-Message-State: AOAM533W4Ud2f6/0KeL7bs+brAXQ8hW4YU7xwMMs6qp/uqW3k8BAfZe2
        9xQHYI+mKWacq+9v1giYxuJZ47V9CBIdGZGZtYMovg==
X-Google-Smtp-Source: ABdhPJwp6Yp7RPHEVG9ZmngWfrWlYd1ALHAiwdqzhYpcPJDe2HYa5uuEsgtTfkkdE0xa/zFeWHhuvpX+9E1QgqiUxPs=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr17032947vkb.7.1617100771387;
 Tue, 30 Mar 2021 03:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 12:38:55 +0200
Message-ID: <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
>
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 29d2494..0311a37 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.

This change looks really silly to me, but I am not a lawyer - so I
can't tell if this makes sense or not.

In any case, "Hisilicon" is being used all over the kernel - do you
intend to patch all places with similar changes like this one? Perhaps
just send a big tree-wide-patch instead and see what people think?

>   */
>
>  #include <linux/bitops.h>

Kind regards
Uffe

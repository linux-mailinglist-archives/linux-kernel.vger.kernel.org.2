Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF3305F15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhA0PGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbhA0PAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:00:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:51:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bx12so2763295edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTb1qG9GkgwXMpUhNx1t/diaUHaqrqbu1GRsagpeLwM=;
        b=ILnM+OVztpAnYmVrO1FVr4Vx9kHcIQGC83QQvcgFKlG6GqybeWuPWtzo+hjn1g1+eY
         otRFOGVi5Xw/X21KkCGw7iVOnhZoDIlEvHU42/SsY+VJE20CEZNz9hM3uDT2VeOYTbfl
         f1nFs8LzId+9cfBGFgcSMNyN7j9p8L/e0JGeOpuJMFGO2GsJ/XcWkMQoP+oi5b8eSZSP
         exgSYYivVrn3jKxSmec7IINWa/r4+iQgGlDzkUq6Qo5kBsJarkVgsDIelg84AYqvGCof
         XTuIe4trKwoe0EfFdpZ9OaBNuagie1GmEaQrVQc/zE1FOctgq9cmVSg8cgds556LlKrE
         rs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTb1qG9GkgwXMpUhNx1t/diaUHaqrqbu1GRsagpeLwM=;
        b=afr2ejdPOlYV+ViyOIG4GjlJVyNhDpSfjACikumpKbTAKjrLjkGs9DUzc7C8fPHc0z
         0MyVr/w6bkrM5NGjgNA760LiccDc9Kgo/G60eJInk0coYoXpEZReHHtr1bw6YkY9MQj3
         jsfX1poyZAFwv5QA3XQIp8kEZ2bvtoUKmVfV3ujJFpRnCGX0GgkcaF7zx5dtZNlrQG56
         W9riET0Ey/hJMOLsDjajbi+vBrVzy58pEqTtSEX6TxuweG88U+RJjEitStqE37hOYtiA
         R4UolTuZ/i/sk1mAv7csWyOL/4/YhuZROoAgYignOgtZvCRrjo2cFlJGofLJaT2Iyn6L
         S+fw==
X-Gm-Message-State: AOAM532cLJFC8o4YheoHYKSrC1ZjOwGV1YxXnj9aGY3QULRAC2OG+P3O
        EdM62v7pDGtOhOuAleYT12DCTGEWFN4XMXbb6obt4A==
X-Google-Smtp-Source: ABdhPJxNdLjX1tXkgq0Mtqs/dnVrdJ1tF/Xdw5s4EqNQ/5sSx69L5xot49eIsuqwVjc83JQdSHoXkR2HRcAfXVMyzug=
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr9179966edr.232.1611759107579;
 Wed, 27 Jan 2021 06:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20210121141038.437564-1-warthog618@gmail.com>
In-Reply-To: <20210121141038.437564-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Jan 2021 15:51:36 +0100
Message-ID: <CAMpxmJWHzU7NM950gLx3dJB5ap07J8VRw1GCO-LfNnOOO1vevg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: clear debounce period if line set to output
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 3:11 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> When set_config changes a line from input to output debounce is
> implicitly disabled, as debounce makes no sense for outputs, but the
> debounce period is not being cleared and is still reported in the
> line info.
>
> So clear the debounce period when the debouncer is stopped in
> edge_detector_stop().
>
> Fixed: 65cff7047640 ("gpiolib: cdev: support setting debounce")

The actual hash for this commit is 65cff7046406 - I fixed that locally.

Patch applied for fixes, thanks!

Bartosz

> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 12b679ca552c..3551aaf5a361 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -776,6 +776,8 @@ static void edge_detector_stop(struct line *line)
>         cancel_delayed_work_sync(&line->work);
>         WRITE_ONCE(line->sw_debounced, 0);
>         WRITE_ONCE(line->eflags, 0);
> +       if (line->desc)
> +               WRITE_ONCE(line->desc->debounce_period_us, 0);
>         /* do not change line->level - see comment in debounced_value() */
>  }
>
> --
> 2.30.0
>

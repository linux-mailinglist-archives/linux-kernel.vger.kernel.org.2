Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBA3BFA48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhGHMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhGHMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:34:56 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8FC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 05:32:14 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id s13so2144228uao.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97vdrVmJKKi4NcxbUC3J7X79qp5WNrMcYTnOyAAgKjs=;
        b=WIVRaj1BSp54uJjE1kHVvg/EnfWbsrunUx2DNW8R0bu7vkb7moI4E81GVcBcKnkkPC
         2nucmpiQvSaliLnxpminobkKrgfbpZj6YX26xwON3BGZoVGizbc2FbBcf04URXOu9WnX
         D57y9c8aQy5bxugug//6QWP0op85FrHpJoNk6QbD+aXbFPOiFHQSET4EwOJiaDADkdzh
         3FsOSnuhzJPSezlvX3JK5eFo5b/zbW/NxDq0fvmqpvnjg1QnmywdxBJ76Srikk4aGFH9
         bbDP6cwRryrpdvOJnzkB18hp8nAY3/o2PRcYFOUmIBob3oVgDCw7oNPptg/qRXj5p/In
         ZC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97vdrVmJKKi4NcxbUC3J7X79qp5WNrMcYTnOyAAgKjs=;
        b=oSVlKmYNnB34MsxK2xPyol126coxuPPIxm4jcgRsOUWV/BXAA/nw2r/KnBc7RhRpJi
         GEZ2DLRzW4S5/GSB9iYWktnCUQTe/LkpJR+beX7UMXEXfPH+sLilLumn/RpMv52BmCI2
         NGwoWOc5EMYltHknIIM0Aq4e6V4ulXXQ3fEASa4xjZTl9p2cxzD0HuU+Qa0O5iwnOBYA
         TkrGGDwPaivDN851qxOt1nl+3U8tY5+NMBO0lv6cP7zKpo32BLTe5eBMv0OOV+MiGKTv
         zJmPIruroFneLW9Pv/fKSAfeHC0b5HZAQv+TJgffO+ii38SjacqZCxzqhUflNLyp+IbV
         xPNA==
X-Gm-Message-State: AOAM533jYKwTjFs9iRNA8P+kpHjBk3qSLHX4IwHJZ8DfDbWVbp7B2LjB
        u7AEHz97HVq/l0+IcU2XRJUsrGYE0mW+KJsqoOAKQb5GaoWTOzrg
X-Google-Smtp-Source: ABdhPJyaQV5Nz27FW0HR5+s3BUq9TkQ0MhLZj8IV0NX0V7i2yyvXQoJ/e1mgN5wOcTglek3w5xVsOBVxLh9XW9PcY4o=
X-Received: by 2002:ab0:42a6:: with SMTP id j35mr26712394uaj.129.1625747533895;
 Thu, 08 Jul 2021 05:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 14:31:37 +0200
Message-ID: <CAPDyKFoM-gkFPoFePbHS62r-HUpk6ipA5J-qPbQ8NWL9Mm_N2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 12:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Infinite loops are hard to read and understand because of
> hidden main loop condition. Simplify such one in mmc_spi_skip().
>
> Using schedule() to schedule (and be friendly to others)
> is discouraged and cond_resched() should be used instead.
> Hence, replace schedule() with cond_resched() at the same
> time.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/mmc_spi.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 65c65bb5737f..a1bcde3395a6 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -180,7 +180,7 @@ static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
>         u8 *cp = host->data->status;
>         unsigned long start = jiffies;
>
> -       while (1) {
> +       do {
>                 int             status;
>                 unsigned        i;
>
> @@ -193,16 +193,9 @@ static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
>                                 return cp[i];
>                 }
>
> -               if (time_is_before_jiffies(start + timeout))
> -                       break;
> -
> -               /* If we need long timeouts, we may release the CPU.
> -                * We use jiffies here because we want to have a relation
> -                * between elapsed time and the blocking of the scheduler.
> -                */
> -               if (time_is_before_jiffies(start + 1))
> -                       schedule();
> -       }
> +               /* If we need long timeouts, we may release the CPU */
> +               cond_resched();
> +       } while (time_is_after_jiffies(start + timeout));

This certainly is an improvement.

Although, what do you think of moving to readx_poll_timeout(), that
should allow even a better cleanup, don't you think?

>         return -ETIMEDOUT;
>  }
>

Kind regards
Uffe

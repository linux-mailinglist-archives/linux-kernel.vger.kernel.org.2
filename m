Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5307431323D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBHMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhBHMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:08:39 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A3C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:07:33 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id c44so2597032uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnWP5XVMnr/gaD9t7Bquau7AE4TzVEi+aJ7kL2wNzyE=;
        b=d87iCQfD/721FS7yUDY6GMFelkMdsrjVU3C1dvsQ7eL9rNN/Z+VtlXsbD5T6hjZZ95
         30svbw3VkZTHxg9fk7Vq2B4no41+UyYARuwV5pkPBn8qevxMND7Dj+IZFZcZyOOCX7Kr
         8I0/wbqhRz/pgd3IF/vg0MM868xPUNyV2uaH5MoXjxacOnhVUMeAK8BvmijrmVCsYpcF
         HlCLX3AuC6kIUnZMMh8Q4rRaS2kK+TyqNw+j4hAmhvIx6nLbWneklQu9BXuSUsBO1siV
         1KU336KL6TgAGczhyzaomH2zSgnQZzB45bqxK/OXhinQc+vTdLBx2604PzDDUGY4wFWG
         65yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnWP5XVMnr/gaD9t7Bquau7AE4TzVEi+aJ7kL2wNzyE=;
        b=LgN3G2Zkh08/Wk5w4+RvbkyOwajdeecWy65VmnSdD/WhJHrUV9xGaYmIUgpzZ5HH59
         WlMbLk+1OySodK78bzwW55ewnvKTynEqFYbFugAaCMpR+zUGkdzH71lEyIsmwy5cvaSp
         CT0RDn863Hxg9Dl+0RJHvCOUMwMX0m3fKJrFluV2+Lc7Iq5WoaHys1nJs2WYFixdY5Dp
         V7bc5WIn4g3hpnmTr4Y3XAH15bjGd6iDOQvFzpl0OUF8gPA7a8bTRRmd4WrHAfurgAMA
         KmkNt+eGl/HcMkw7Ln2hEXmHfFBtzNHA+qe3iD3XOv1xkBpHGea6BjKVu1zZ+5+9GElS
         0XCA==
X-Gm-Message-State: AOAM530DuC01PvXRkd3U79zNiq3dHJ9NsPxtcKEWzou2A73Zm9GkLqfY
        cWEaHjIaGTygvCpmJyAKD8Uu+w0gSN8Clhk6wQaltw==
X-Google-Smtp-Source: ABdhPJzUIgW4GliFuC/xzGpbGIv9yT3FBDhE3PrPHgTY5ajw6dmBq4oL6Y6tpVHfx6azRNRRclNqU7IqVevpWWzfu+E=
X-Received: by 2002:ab0:2e8d:: with SMTP id f13mr9564324uaa.15.1612786053154;
 Mon, 08 Feb 2021 04:07:33 -0800 (PST)
MIME-Version: 1.0
References: <1612422438-32525-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1612422438-32525-1-git-send-email-tanxiaofei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:06:57 +0100
Message-ID: <CAPDyKFpUSKJObVk49WSqDMkrcBp6s3bRpQR4kwntO0cFXue-Bw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Replace spin_lock_irqsave with spin_lock in
 hard IRQ
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     rric@kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 08:09, Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> It is redundant to do irqsave and irqrestore in hardIRQ context, where
> it has been in a irq-disabled context.
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index c5da3aa..4bb8f28 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -436,12 +436,11 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>  {
>         struct cvm_mmc_host *host = dev_id;
>         struct mmc_request *req;
> -       unsigned long flags = 0;
>         u64 emm_int, rsp_sts;
>         bool host_done;
>
>         if (host->need_irq_handler_lock)
> -               spin_lock_irqsave(&host->irq_handler_lock, flags);
> +               spin_lock(&host->irq_handler_lock);
>         else
>                 __acquire(&host->irq_handler_lock);
>
> @@ -504,7 +503,7 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>                 host->release_bus(host);
>  out:
>         if (host->need_irq_handler_lock)
> -               spin_unlock_irqrestore(&host->irq_handler_lock, flags);
> +               spin_unlock(&host->irq_handler_lock);
>         else
>                 __release(&host->irq_handler_lock);
>         return IRQ_RETVAL(emm_int != 0);
> --
> 2.8.1
>

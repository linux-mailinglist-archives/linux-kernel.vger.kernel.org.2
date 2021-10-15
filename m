Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DA42E867
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhJOFd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOFd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:33:28 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A765C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 22:31:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t2so7846571qtx.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWiGCC2rXcZBCVYZlH+a9kpFJzI+XvlV4CRW6eQGdVI=;
        b=FMwUtBh9Ij4KgMxfWHnTBZoUZhMXzE4SSWuqBNvdVxgD/bBnxHRRiGI1jWSBnRYdF2
         XZze2ckxog36jwieUK7itIYg58X0XDn8AF3sJcei/zPwL44npSBbWbbZdZEI7oO3Hj/7
         f0U6jghWYH+n/E1iuG8OpIBswbJQtLofxGvgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWiGCC2rXcZBCVYZlH+a9kpFJzI+XvlV4CRW6eQGdVI=;
        b=IKF8aFA5nI3IwtMH7+fhHp8s0UOycMhURSTovpHLgP4FZzXbRHAUydwZSwBIoSt7Ic
         fjqZkbl2MW/PD66EhQHz+KYbhhHDx4zHsT5sbOBNJXNMIpMJtWJvbv1zjjLJZcclJ7xc
         vnC5BaY8l66i8oVKniEjnyD8gM//9UQGJK+rayCl1PIG5XLeRaRzkqrzLBAhOcIs4WRr
         7AbsHhcaUR5cFmixlPL5I6VtptIBCd/as7x9i77Nj/d5Z46V0C9pJsSBrNYgVJzxQM2z
         8RA5HjE6zhqrJBkGYmvmXbS17hYdbwOVWKP8JaZ1wP8Qoe2ajp3GOI5pEfsiC6XUCmxz
         Gdew==
X-Gm-Message-State: AOAM531Vb0q9eUOHd7hQVzv0qI+qHBdRb7KdB+xKGAHoxA8jdzdaFK2/
        OWK5D66xIWcKwfLIQrU+6HUSB5SvYcYvq1kfItyincUJBQw=
X-Google-Smtp-Source: ABdhPJzaAQuvhue1L6Ab+QNvv/Ot048AV1Gb/UNpi/f8Fdoirb8f41n3Lkae0N3u23VXpYf0Z0eHyaxItCrwwkmRSrw=
X-Received: by 2002:ac8:5e49:: with SMTP id i9mr10730004qtx.145.1634275880706;
 Thu, 14 Oct 2021 22:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210803213016.44739-1-eajames@linux.ibm.com>
In-Reply-To: <20210803213016.44739-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 15 Oct 2021 05:31:08 +0000
Message-ID: <CACPK8XcVDAKxiPGmcrjsyHJ5LUt4xkCm3sJzb5d6xCXr_+dzrg@mail.gmail.com>
Subject: Re: [PATCH] fsi: sbefifo: Use interruptible mutex locking
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 at 21:30, Eddie James <eajames@linux.ibm.com> wrote:
>
> Some SBE operations have extremely large responses and can require
> several minutes to process the response. During this time, the device
> lock must be held. If another process attempts an operation, it will
> wait for the mutex for longer than the kernel hung task watchdog
> allows. Therefore, use the interruptible function to lock the mutex.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I think this is okay. I'm not familiar with the use of
mutex_lock_interruptible, so if anyone else wants to ask questions
please do.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/fsi/fsi-sbefifo.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 84cb965bfed5..a8d8e47e6fb2 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -740,7 +740,9 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
>          iov_iter_kvec(&resp_iter, WRITE, &resp_iov, 1, rbytes);
>
>         /* Perform the command */
> -       mutex_lock(&sbefifo->lock);
> +       rc = mutex_lock_interruptible(&sbefifo->lock);
> +       if (rc)
> +               return rc;
>         rc = __sbefifo_submit(sbefifo, command, cmd_len, &resp_iter);
>         mutex_unlock(&sbefifo->lock);
>
> @@ -820,7 +822,9 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>         iov_iter_init(&resp_iter, WRITE, &resp_iov, 1, len);
>
>         /* Perform the command */
> -       mutex_lock(&sbefifo->lock);
> +       rc = mutex_lock_interruptible(&sbefifo->lock);
> +       if (rc)
> +               goto bail;
>         rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
>         mutex_unlock(&sbefifo->lock);
>         if (rc < 0)
> @@ -875,7 +879,9 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>                 user->pending_len = 0;
>
>                 /* Trigger reset request */
> -               mutex_lock(&sbefifo->lock);
> +               rc = mutex_lock_interruptible(&sbefifo->lock);
> +               if (rc)
> +                       goto bail;
>                 rc = sbefifo_request_reset(user->sbefifo);
>                 mutex_unlock(&sbefifo->lock);
>                 if (rc == 0)
> --
> 2.27.0
>

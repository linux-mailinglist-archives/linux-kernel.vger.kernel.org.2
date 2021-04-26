Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635B36B0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhDZJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhDZJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:45:51 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2231C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:45:08 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id u22so16935837vsu.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jq6l+/zeiO0MmVuivxxJjucggcKTImzUuMZiYzS2/qU=;
        b=uFxMEaVU9TkO6pxkc1iLcaOb6Ih5f8NgBFT6HnB2JZGeDJlEE49k0fQZIfEVQB87Nl
         Y1Gtcu+HHXVxEgUr7ucvLNZ34WNK6jvx6rdPW+z+RGhoSJeIK5V4sqvWtSrbGjvGuhbS
         4mKqPOAXSvKEEWMEhmhpFdW46Zxu0Qn9vevaO/pbMTKqwvtjH1ycqHhMoz7qRpYoLGtf
         iKj2qWUeLCdDir3rAkNcnivBoz8NkiLac8xIaH2HoO4I0xUcKz7g6Rv7ZmZcMji/CXLW
         6m22bq7XztAydKZhJsAfLoveVqoihtqYAVVR2UyLoP1VCCJDFZ0VoPyYnwcK7BvzNN78
         z6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jq6l+/zeiO0MmVuivxxJjucggcKTImzUuMZiYzS2/qU=;
        b=CrajyiVV+lH2/EX5T/CnhVaDtGFQXJNiSyqFHYzOW8GMGSwBTgVz7lICpDOGjDwURC
         fy/XbsSEky7ZoIpCvSNjF/wKrSIcjPkzN9olUxDlxFzLPlFa/9kkkn2jV0bVItUepOAo
         /fHxVyVCmo3HIIOv1DYCpMJrG4VOH2Nig2L9OtXeA/sznTKWvLs7MjpxTlplmfwJm0tx
         sL6HG75iKU8jnD2HDYOtUzsZRFq059EyYsoNM3pOUB/cRRBiMF5i31Taev7y2hKHxBzh
         cRmfwgtIzOgpJzdA6oYnr3OQaER0FhOQaLonycnBXr9t+pINlhvZTqAE1SE/mcJzKGwO
         Hs3g==
X-Gm-Message-State: AOAM531JKCOVcNqq+U1JBHZC4qiKxdIdgZHsY7gDYP4i+R28NR5twGhA
        DWyM5879bCAH9l6+KV77f97Z2uzFKklYuDhPttur2g==
X-Google-Smtp-Source: ABdhPJw1ndt6VhCvCQjjRbfsHP9lGuTGdSe4tjtznSAIvSPMXZtSIKott5n3vwWPwG9OPuREVPYm9gDHmfTyT9ori9I=
X-Received: by 2002:a67:e902:: with SMTP id c2mr10830509vso.42.1619430307798;
 Mon, 26 Apr 2021 02:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135215.3414589-1-arnd@kernel.org>
In-Reply-To: <20210421135215.3414589-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Apr 2021 11:44:31 +0200
Message-ID: <CAPDyKFrUMaQM_aacYcKKnQeqeDz8cfabsFGrdNLYmotcFf3uew@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: ignore kfifo_out() return code again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 at 15:52, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A minor cleanup to address a clang warning removed an assigned
> but unused local variable, but this now caused a gcc warning as
> kfifo_out() is annotated to require checking its return code:
>
> In file included from drivers/memstick/host/r592.h:13,
>                  from drivers/memstick/host/r592.c:21:
> drivers/memstick/host/r592.c: In function 'r592_flush_fifo_write':
> include/linux/kfifo.h:588:1: error: ignoring return value of '__kfifo_uint_must_check_helper' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>   588 | __kfifo_uint_must_check_helper( \
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   589 | ({ \
>       | ~~~~
>   590 |         typeof((fifo) + 1) __tmp = (fifo); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   591 |         typeof(__tmp->ptr) __buf = (buf); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   592 |         unsigned long __n = (n); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~
>   593 |         const size_t __recsize = sizeof(*__tmp->rectype); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   594 |         struct __kfifo *__kfifo = &__tmp->kfifo; \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   595 |         (__recsize) ?\
>       |         ~~~~~~~~~~~~~~
>   596 |         __kfifo_out_r(__kfifo, __buf, __n, __recsize) : \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   597 |         __kfifo_out(__kfifo, __buf, __n); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   598 | }) \
>       | ~~~~
>   599 | )
>       | ~
> drivers/memstick/host/r592.c:367:9: note: in expansion of macro 'kfifo_out'
>   367 |         kfifo_out(&dev->pio_fifo, buffer, 4);
>       |         ^~~~~~~~~
>
> The value was never checked here, and the purpose of the function
> is only to flush the contents, so restore the old behavior but
> add a cast to void and a comment, which hopefully warns with neither
> gcc nor clang now.
>
> If anyone has an idea for how to fix it without ignoring the return
> code, that is probably better.
>
> Fixes: 4b00ed3c5072 ("memstick: r592: remove unused variable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/host/r592.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 026fadaa1d5d..615a83782e55 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -359,12 +359,15 @@ static void r592_write_fifo_pio(struct r592_device *dev,
>  /* Flushes the temporary FIFO used to make aligned DWORD writes */
>  static void r592_flush_fifo_write(struct r592_device *dev)
>  {
> +       int ret;
>         u8 buffer[4] = { 0 };
>
>         if (kfifo_is_empty(&dev->pio_fifo))
>                 return;
>
> -       kfifo_out(&dev->pio_fifo, buffer, 4);
> +       ret = kfifo_out(&dev->pio_fifo, buffer, 4);
> +       /* intentionally ignore __must_check return code */
> +       (void)ret;
>         r592_write_reg_raw_be(dev, R592_FIFO_PIO, *(u32 *)buffer);
>  }
>
> --
> 2.29.2
>

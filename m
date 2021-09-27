Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18E4191D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhI0JxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhI0JxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:53:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA2C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:51:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so11407926plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRePW3/TNCc7XAOvX2Kj8B2CrMxOQEcmgec1IIbW5Bc=;
        b=Kv0CFzwqmrmNCeq5ie36LnoFoefO3upoJO65nED9HFSLpOR8RWZrEybbVYO7On51L+
         yDr5vWV5JZQBK6y3B+w9GeG8IYVc4uzKBgVSguCCkzT3hUli/9zvA9HXvMzYD9YSwuB+
         Ed9zJmWD4L6tMMshbGjdANvnABU4nNzy3YaG9twfYmOKTHpbOq5XVOQFouj30mAUlZTi
         H3oFHfOM+UR1UEd4iPmH7cyAmNzYhkNgma7rk9envMghYIk6IYIK/UFa+wcf+L51zh/9
         gKntTZE8Te8MSY2DqGPODRBkP7dg8699MLXvo+eU1rfvJ38sNCJ5Bs9rSHwMJHQjaO73
         BLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRePW3/TNCc7XAOvX2Kj8B2CrMxOQEcmgec1IIbW5Bc=;
        b=bK3gKLNfNegGXHOV7eHMdWHX/V35xScMYxCS08nHNTcjeCoL9ML7omP7HpbR4oqISV
         YfcY7QFUREI9lejmupToRD3ybU1tj4oZgMa6R+sSyuY7PIivHR4FmUP+vBk0m6BCtqzv
         p4WeoCnvrrJgzNUFCXJl4+UTAaHCJlZlR9YDlUvrGttItovWHEBaFTXlEHmSB9cDxkyt
         wZNxz6rBNOzQrnIYPt/8ltcy8k1WQN4yBcoK7N0huXGpAWXL+n2K23S989XcSzYNl1x4
         Zl9frNloPAZeXh1A0EjlgC7RnH6+wklkp3uwA+NqL3HNXhN4wBY+OR492GdQyD+KMtiB
         Pjcw==
X-Gm-Message-State: AOAM530zcbewB1gZMhXY/tu5k8xFd1kM+MDtM3VN8CicOc+mlNEW8BNc
        HMlG75SkyDmBtcqlAhaucisKXqJ7frk3wzUzm8Iktg==
X-Google-Smtp-Source: ABdhPJy8qcfslrU6xWthqnTohHRpxrn9aUuU1mGA/gd6Rw6vxMIxAEKfecnkKiSEsHRjsb3BAljBhVwwKX2poMkSz6U=
X-Received: by 2002:a17:90a:f293:: with SMTP id fs19mr6467832pjb.137.1632736287919;
 Mon, 27 Sep 2021 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210927094327.644665-1-arnd@kernel.org>
In-Reply-To: <20210927094327.644665-1-arnd@kernel.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 27 Sep 2021 11:51:17 +0200
Message-ID: <CAB0TPYGWXAs5t_bG8BMs_9xvOmfsJiy1ejM0WoJC3Ts3yC6E1Q@mail.gmail.com>
Subject: Re: [PATCH] loop: avoid out-of-range warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Mon, Sep 27, 2021 at 11:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns that the sanity check for page size always succeeds
> when building with 64KB pages:
>
> drivers/block/loop.c:282:27: error: result of comparison of constant 65536 with expression of type 'unsigned short' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
>                            ~~~~~ ^ ~~~~~~~~~
>
> There is nothing wrong here, so just shut up the check by changing
> the type of the bsize argument.
>
> Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Martijkn Coenen <maco@android.com>

> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 7bf4686af774..51315a93b399 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -277,7 +277,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>   * @bsize: size to validate
>   */
>  static int
> -loop_validate_block_size(unsigned short bsize)
> +loop_validate_block_size(unsigned int bsize)
>  {
>         if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
>                 return -EINVAL;
> --
> 2.29.2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4A3C7124
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhGMNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhGMNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:24:00 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FBC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:21:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso22402347otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdpFilVG5TXmh38Qx9BIPBfF1X+JzE5ROTCr6BlXwgA=;
        b=Fwg2SHr2yp+pkT/nR3CsSwV0aVO1sH7RaLMxJ+2G0tYtseOkHQtTzkbotRYz/drs/D
         5DiBLZ9LnMkNK3nOfKZUQmhxqw4BttJSf88b08Bi+bKSsYf8WHNgkkgf71hs5Ksqt3t3
         HXQ15TMQgdauzfhnZbVo8rVgSwGTYxMpi5/D9jr7s6e5O2D3FMbPgaMoUu2E9xxnlkKu
         F5U0P+bjz/mttGkYC5yEAByea626fA5W+07zeALUr0T630X6t1SzO4kLFv5DQsXqqF5u
         OxZ/zw7rSJXcpUgrKHhyOTEvRmu2wkrK4wVZ147rjS0crHZQRYpix6aGTx9S7IzxUd2a
         3jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdpFilVG5TXmh38Qx9BIPBfF1X+JzE5ROTCr6BlXwgA=;
        b=rgftc4ypi1JmRjz0m8jPWUUj0eEZydZ10vylJ9XvZljp3k7s6fsmdEAhWOViRRs71c
         TktcMkFmffnwj8PZ87Ns7rH7wS31NgpuXmS7zBEGVeH9eY487aXZMQVLXxZfb3OLaMlt
         4XpjWZ0aDcc/K9MdJyB+8HRXqLBFb1/4Mq8xzx6tfuotoh+oP2JkLY4aBSuNtsrkXp/j
         hgolfNqKFU24Z6dtLavhCSWeSCpQdKtUcrbmQEW5XVdmt3C8Bv38klgVgrD1a0setsEo
         nWNAmP5wp9f+9b+gN13+K+Vtgj8+ko2wBjiJteKqIs0MRc875B3TDBH6pKi0L8J2BasG
         FpKA==
X-Gm-Message-State: AOAM532cWPiStPcn02ZDDaQCVR8Fz41N7sUzo6dqc2o1gqR37eZQ5BDi
        Uc2lOuf34uwhsaDz3a2FH6gRV56cFUEXvN041JY=
X-Google-Smtp-Source: ABdhPJzdUywi6Zcn01BcK81PlNUigJdVIW+LyVOJf2f8AlJplFa9ZxozIuTRgXLkYNGYTM2g5mWhgplR5D7L7hyy8Pg=
X-Received: by 2002:a05:6830:1f3b:: with SMTP id e27mr3555174oth.311.1626182470396;
 Tue, 13 Jul 2021 06:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210712224440.GA1830070@pc>
In-Reply-To: <20210712224440.GA1830070@pc>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Jul 2021 09:20:59 -0400
Message-ID: <CADnq5_PKSPAPXxBjAw39fMXsDsvyd4sHWByAzmA4mb71=rnPcw@mail.gmail.com>
Subject: Re: [PATCH] use swap()
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 3:09 AM Salah Triki <salah.triki@gmail.com> wrote:
>
> Use swap() instead of implementing it since it makes code more clean.
>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Patches for this driver generally have the following prefix in the subject:
gpu: ipu-v3:

Alex

> ---
>  drivers/gpu/ipu-v3/ipu-image-convert.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
> index aa1d4b6d278f..5f730cd6009d 100644
> --- a/drivers/gpu/ipu-v3/ipu-image-convert.c
> +++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
> @@ -1021,11 +1021,8 @@ static int calc_tile_offsets_planar(struct ipu_image_convert_ctx *ctx,
>
>                         u_off = y_size - y_off + uv_off;
>                         v_off = (fmt->uv_packed) ? 0 : u_off + uv_size;
> -                       if (fmt->uv_swapped) {
> -                               tmp = u_off;
> -                               u_off = v_off;
> -                               v_off = tmp;
> -                       }
> +                       if (fmt->uv_swapped)
> +                               swap(u_off, v_off);
>
>                         image->tile[tile].offset = y_off;
>                         image->tile[tile].u_off = u_off;
> --
> 2.25.1
>

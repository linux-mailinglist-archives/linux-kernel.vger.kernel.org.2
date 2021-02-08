Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11A312AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhBHHCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhBHHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:01:46 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABDFC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 23:01:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x19so3203268ooj.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGWZhw5FD17JgQu/vypm5kA3S3RNt2GOM+1bM/iHts8=;
        b=luPuRfruVI3C9Z4Bz6nnFNZ8XtpUHKXi2PydPjgRMvjXKetMiZ15BTduD1Wkcwwm80
         4bF2IvptIODZWGctNU8CJmAlbI0C2tUV4nGlNmWs5U9KkIUmoxxgXSeCXMov/JEMXOsz
         ypa4dlVOKj37nWoIMr9UShY6ZzoJ5BAZ5SJRqyoJ+XGCuRCQyTtx1fYbJ9h3nGf794Ec
         ExKcjquCK1cft66zu+e23xiDKKL9XvNdjpsnBjp9ZaFtWPnewFFuwSVGg3NuUjEWEoR1
         ZubRJ+3rBRxKZeLAR7U0E68HYdeTI9HkwcetxHTBspqWQk+N2QWNhAKEHKoiQ/AGg8SL
         ui/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGWZhw5FD17JgQu/vypm5kA3S3RNt2GOM+1bM/iHts8=;
        b=Tg2N4f91UVuMe419xr9tJN/t4g/UV94Uex/0iZU1ycxEewt4abqNEsQu6HUENLrFbJ
         G13ava/ByLc5cYUklbx4CDp2lTg32MAOkBrzx9wK8zijrwBuxktHItLYRlltecrgybn/
         /hIJUJqD88Ase1CFiu/lI5KZuSgKTMTcMV6fa6Abxs4LbiDz9ugEzAcXynvWEhi1VeK3
         aiq0Qm62Tpo45jwaerygJ3CcwzcCYiFrkpizqxargwBozaA96d+bSoLrcpiHwN7kpx4D
         CHNLew/Rjw2OS8l5H0pAsYg8m/nslDr4wcLs3LfHK0wQchpHNa8auKQK/Ts9Nt4rC3XW
         9jog==
X-Gm-Message-State: AOAM533grev6Ubip7dgvoI1fM0HBK72wZEVZvxhqOwPYdKfpVzDRJ18o
        NihYf7w9PokAP8Ka6+2I1CgUGXI0xIRHL/sS2Y2n2uXb6DA=
X-Google-Smtp-Source: ABdhPJzVvAsjSodZ+hxzYRjjNGj9meL9m1U5pZyKpSeqlD7X4IlCg6JC+XpvrS8SzpAATfOqm1+44ASRI/xlK34CTis=
X-Received: by 2002:a4a:c489:: with SMTP id f9mr11552941ooq.49.1612767665936;
 Sun, 07 Feb 2021 23:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20210125113758.2430680-1-arnd@kernel.org> <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
In-Reply-To: <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 8 Feb 2021 08:00:55 +0100
Message-ID: <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
Subject: Re: [PATCH] optee: simplify i2c access
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi Arnd,
>
> On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Storing a bogus i2c_client structure on the stack adds overhead and
> > causes a compile-time warning:
> >
> > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> >
> > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > open-code the i2c_transfer() call, which makes it easier to read
> > and avoids the warning.
> >
> > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
>
> Looks good to me.
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Would you mind testing this?

Thanks,
Jens

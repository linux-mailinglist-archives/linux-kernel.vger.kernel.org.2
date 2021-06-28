Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5810F3B5A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhF1HwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhF1HwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:52:10 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:49:45 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id r9so6633486ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpDL1yFtnBlqCZuK3CHLVZzWipOCqhkoV76MfrS+XPw=;
        b=A5/4xK8X5ZR9E6P0cb6x18jpF/MTNKiIOalvBQM5I6HhZXFVSz2dSXs0cAiVXGV0aA
         sJJACsN13TmWPg8rDJl4YEJZne/raXh78ys4/AQLdqRaWpdK0t8jr1RJLd1cvu8DjxiQ
         g9M8adyqxjEqoYCD7CKDM8jhlwgpri6pDL1JP4nhOGGuzG5dY/ylyD6Co/yJGl1eIlow
         fnlKTZoOUSHMzON7o4f61g7JQJfTZdINfFKd8Ic7FY0KFoxeBgmmqZ7ZQv7bQhA2ahA5
         81IsTLQ30fVZkW2Z4RwWJjmv0y40jADbq08AkUwX1hBCZ1h++xpmXsPn5hWaCKqr+PaJ
         SIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpDL1yFtnBlqCZuK3CHLVZzWipOCqhkoV76MfrS+XPw=;
        b=ILB6RVYuDAW3I6B2jngY9AHMfqALjHdwZ4re8c/OGHwbPSqoEtcaCjv6sUOpZeXs8N
         rpjf+j7xvvjr8U/Ddp4RZ/OQL78G2B0lnKyxp9NPF92ho48+HsITQ6UUzalMGIDXK5y6
         PE9fPz1INWBpmRwLlfOp/sYRV+EcGzZJVdiwOa9/PIn6gXytNWfXbuXxY1Lqpc0V0oTt
         gVQN3TaToqmq4IriKoUvTSeZlddEPwP882bWW9jwFzMNMY97LNK1Qe+R9TOOlQx4Z1Jg
         315QGxate+/Hk2OjYx/wYciCHIUecN2sx41oUZ17Dj+0XKz4hH4UkrNRCDQkTrK/GD1p
         YvVw==
X-Gm-Message-State: AOAM530z5+nrwtyifOx8m7Q7f6fG1851VJhUe1vDyBtRfi66nii9k5/0
        AUes+vle2l79JssbN/Atjqm4UitPKW+wr51oVss3qDR+L6mg3aPR
X-Google-Smtp-Source: ABdhPJwUdpg7JYcrOq4EEhy5BIfAtqS1t34Bu6KnY7BMgxcOojDtQELRD0HYCUiNtgyLQ6rB4dvjQDmC00Zf/FXrgBM=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr19690937uad.100.1624866583711;
 Mon, 28 Jun 2021 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123251.191299-1-ulf.hansson@linaro.org> <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
In-Reply-To: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jun 2021 09:49:07 +0200
Message-ID: <CAPDyKFrLSMpPJOgd5e4B1x3Vwfg4q23zgy4ESc8EmFL2MnyK7g@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Neil, Robin

On Thu, 24 Jun 2021 at 20:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 24, 2021 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Neil Armstrong (1):
> >       mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
>
> Ugh. How horribly ugly.
>
> Why is that 'host->dram_access_quirk' test _inside_ the loop, rather
> than be something like
>
>         if (host->dram_access_quirk)
>                 return sg_copy_to_buffer(data->sg, data->sg_len,
>                                 host->bounce_buf, xfer_bytes);
>
> at the top of the function, with meson_mmc_copy_buffer() then only
> handling the mmio case?
>
> No, I don't know this code, I'm just looking at the patch and going
> "that looks really ugly".
>
> Anyway, I've pulled it, but I thought I'd voice my reaction to it..

Thanks, good point!

Robin and Neil did discuss some cleanup that could be made on top [1],
but it looks like that was targeting a different part.

In any case, Neil, would you mind sending a cleanup according to the
comment from Linus?

Kind regards
Uffe

[1]
https://www.spinics.net/lists/arm-kernel/msg901045.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2D3BED6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGGRxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhGGRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:53:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:50:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id he13so4588825ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIkLwkBAX13D9qppUWtPCZH/Qq7ZqIfNxEiM6945sQ8=;
        b=tnlVHHbZs+0/Sb6fnbPDT9W/lEfr/Np1DpsPYVeiAgTYSuSutd8nvY7KCtHiRSOqGM
         RMuWP3mPFcEbSNQ92cZ6oq21YU73uL+catc/NKYxa3CNyPx+qlgzd+m9eQicVRNXcqY3
         nmcsoHPJoDqlVnBNuZG06jqIzFMXpzQ3hXp7FJ5B2b/w2g3fg95v+ELFnMVy5VFCAdCK
         WRvmVi/XjkFInkn8CVTcFtxcTf7EzodIGVAcvEGPgRdN+B+BC8BvR4B9yGe45wpCsetn
         SkH+QD81NQBcHIX6EQmSDa9QIkg/eKJjqfbpxoiDFxow3pu/3YPy1jQdpOXcfAEvWFlL
         tIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIkLwkBAX13D9qppUWtPCZH/Qq7ZqIfNxEiM6945sQ8=;
        b=cVLJXKG6fOmm6namzuGBIeYGmo8MQ6mAD+dIrSDTaPONlf7ZQUn+AbxkAAyQwKbHfM
         cpNNLDPAfYdlpm84NEG/UeRe2mb5rZATJ3YcqSPalYAXZDD5vOmpqofohP4U1tUbOs0l
         CKx8EMYnMHoUKA5U2AagVCgSqvsN7ff6rVqSXcg7B0qJAKPnqfAuxk4vrXNjLfqfoXQa
         MiYY0+MEk9QOWrGUc1ckjrZn4Dcl423JSgflsCSFykTt/hQXUhP5dwsha+MvO5vGbTzZ
         DH/O6AxZvuzmtQLZryEcD6VX3Q+2sgVtDTzbiCGY/9cI0Vn6JzeQVCNbJG/DjGk4fd7G
         e90Q==
X-Gm-Message-State: AOAM532QNandRkICF8IM/Hr+R/5cUnrYXsqaKmnLNOE2Pka/e2EcIf7T
        Q1KZnUdVHceu3yrfoS6fWBKLAuSBPcorVoq58yM=
X-Google-Smtp-Source: ABdhPJyXV09RM9rSxNu2QjCrzq76TegWSfCyvqMEqREhJbRgLyikdNeaa07eF8Yf807ykK8SOJBa0WxKUmVpIfSi4bE=
X-Received: by 2002:a17:906:e088:: with SMTP id gh8mr3389574ejb.125.1625680219108;
 Wed, 07 Jul 2021 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com> <s5ho8be8v3z.wl-tiwai@suse.de>
In-Reply-To: <s5ho8be8v3z.wl-tiwai@suse.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 7 Jul 2021 10:50:07 -0700
Message-ID: <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 12:02 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 06 Jul 2021 19:50:08 +0200, Max Filippov wrote:
> > linux v5.13 booting on qemu-system-xtensa virt board gets stuck inside
> > snd_intel8x0_probe -> intel8x0_measure_ac97_clock with this patch.
> > Prior to it it boots successfully for me.
> > I'm curious if this issue has been reported yet.
> >
> > What I see is an IRQ flood, at some point snd_intel8x0_interrupt
> > and timer ISR  are called in loop and execution never returns to
> > the interrupted function intel8x0_measure_ac97_clock.
> >
> > Any idea what it could be?
>
> That's something odd with the VM.  As the chip itself has never shown
> such a problem on real systems, maybe the best action would be to just
> skip the clock measurement on VM.  The measurement itself is
> unreliable on VM, so it makes more sense.
>
> That said, something like below would work?

It didn't change anything in my case. My further observation is that
the snd_intel8x0_update is called before the ichdev->prepared
is set to one and as a result IRQ is apparently never cleared.
Perhaps because intel8x0_measure_ac97_clock is called from the
snd_intel8x0_probe, well before the snd_intel8x0_pcm_prepare
that sets ichdev->prepared is called.

> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
> index 2d1bfbcba933..b75f832d7777 100644
> --- a/sound/pci/intel8x0.c
> +++ b/sound/pci/intel8x0.c
> @@ -2199,6 +2199,9 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
>         pbus->private_free = snd_intel8x0_mixer_free_ac97_bus;
>         if (ac97_clock >= 8000 && ac97_clock <= 48000)
>                 pbus->clock = ac97_clock;
> +       else if (chip->inside_vm)
> +               pbus->clock = 48000;
> +
>         /* FIXME: my test board doesn't work well with VRA... */
>         if (chip->device_type == DEVICE_ALI)
>                 pbus->no_vra = 1;

-- 
Thanks.
-- Max

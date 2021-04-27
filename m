Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87236C4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhD0LNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0LN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:13:28 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:12:44 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i12so27950104qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hP9KV+QzDMi9Ee3A915nGBhou5oqVpoVswUzp1mehQ=;
        b=bg8BRGZeDyUMhxijqaqZ2uEmaDmSiY82LeYiRIRNuBPn3Tyod3SucxVqlvtzvkcc4g
         43fRU7nmDwN5gZ8Rt5ZPQZYHJWDdDa2UOSX9heML9Q73tAUEww046ugWvUJ4Ai+NpBOj
         /pL/ibGJ654F8rgriYQxq+87LoRSaAmio77R2XzGN1G4KBohpX6Ct65Oiz3OGkOsUXzK
         GpX9eCa9eU1hBRdsto7u8rKTfvh/YbpCRqfina9A7LQBjIAVl55ArmGThHQvOSy7cdOz
         YNQHW070OAaqsZTb+pndAVPl3739f9egFm+JyjYXYBoRVAcDbpr38vkYPcc8igCpVlCy
         z3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hP9KV+QzDMi9Ee3A915nGBhou5oqVpoVswUzp1mehQ=;
        b=lVKhA8RN1aR4Hvr0RtvqJ+WORxk4mkpPUl0apb7ZE2urvNge5H5IcfSvq2DIIvlmMb
         fTjvCAJweUuH17kk+nd6AEg9PwRuFI7Rqz0zBOXjjf1mY6VKZUkNyeMJzb/BqZjykQ2p
         F3BQvBVHVOW+6dabyxZ7Y7E28ta5+xm2OLA4NMGfIJY5M2zqAi3YbOnEPa9Z3RE3fK/y
         rKjU3NyaneRhIYoKUvVQ1TkjMqbFU/MuxGnHDPJUchrerdmFe3N8mSrxJC55dXb1PcfK
         1c/oPF8wq0uhw07zSZtkwVYGL3gxIa+RHtfXLJ7j0AA4lKRa+scaeJpOgjj0kxz8rrC7
         0l9g==
X-Gm-Message-State: AOAM5332JZ9YakyzZiRSZPlwDTXm9NeXQjwOEko32lGhn8j4KerdunzR
        r1BMH6n77n2BzPRliyg1Ep9aHE5zCwSR+nlpIwk=
X-Google-Smtp-Source: ABdhPJxbs9d47JINdGB66ElNk6J0qHjHBi2Nw+rqEbRhR/7qc+uJbqNSiGD2C//W9pmtLQdJy/4eEHKA9sB2WaDZHzM=
X-Received: by 2002:a05:620a:2903:: with SMTP id m3mr10050569qkp.37.1619521964090;
 Tue, 27 Apr 2021 04:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com> <s5hpmygyp2x.wl-tiwai@suse.de>
In-Reply-To: <s5hpmygyp2x.wl-tiwai@suse.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 27 Apr 2021 19:12:33 +0800
Message-ID: <CAA+D8ANB1CZ41Qz6HK2uxT6QjHV3zfL0ayT59oYExX8h5ccW6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: pcm: Add support for 705.6KHz and 768KHz sample rate
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:56 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 27 Apr 2021 12:34:22 +0200,
> Shengjiu Wang wrote:
> >
> > Some high resolution codecs support 705.6KHz and 768KHz rates.
> > So extend supported sample rate to 768kHz in pcm.h.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> How many devices require it for now?

I have two devices, AK4458, AK5558.

>
> I don't want to extend the core definitions blindly unless those rates
> are really commonly used.  You can add those specific rates in the
> codec driver instead.

Ok, this is an option.

>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/sound/pcm.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index 2e1200d17d0c..88056824ffec 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -121,6 +121,8 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_RATE_192000                (1<<12)         /* 192000Hz */
> >  #define SNDRV_PCM_RATE_352800                (1<<13)         /* 352800Hz */
> >  #define SNDRV_PCM_RATE_384000                (1<<14)         /* 384000Hz */
> > +#define SNDRV_PCM_RATE_705600                (1<<15)         /* 705600Hz */
> > +#define SNDRV_PCM_RATE_768000                (1<<16)         /* 768000Hz */
> >
> >  #define SNDRV_PCM_RATE_CONTINUOUS    (1<<30)         /* continuous range */
> >  #define SNDRV_PCM_RATE_KNOT          (1<<31)         /* supports more non-continuos rates */
> > @@ -136,6 +138,9 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_RATE_8000_384000   (SNDRV_PCM_RATE_8000_192000|\
> >                                        SNDRV_PCM_RATE_352800|\
> >                                        SNDRV_PCM_RATE_384000)
> > +#define SNDRV_PCM_RATE_8000_768000   (SNDRV_PCM_RATE_8000_768000|\
> > +                                      SNDRV_PCM_RATE_705600|\
> > +                                      SNDRV_PCM_RATE_768000)
> >  #define _SNDRV_PCM_FMTBIT(fmt)               (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
> >  #define SNDRV_PCM_FMTBIT_S8          _SNDRV_PCM_FMTBIT(S8)
> >  #define SNDRV_PCM_FMTBIT_U8          _SNDRV_PCM_FMTBIT(U8)
> > --
> > 2.27.0
> >

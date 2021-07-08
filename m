Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7063BF3F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGHCZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhGHCZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:25:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26458C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 19:23:05 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v17so2101809qvw.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lST2GatSsqwk3Z8FCgmMrt0ILXDDrNipd0HQcGxijfg=;
        b=FAlLOPyJ4H7IU5p4eQxNVLd+Rt3wbUfxsZhaqIJKkrpRxeFe6vIiJ/xlTa0AlGa1XB
         9KRxcAvIhtvdWrHpY+Ldv7aP3Iv/P+5I14p2f5bfFTGgMzGc7GhOfb+WyldJPOIjXA0u
         u1xeW8BFARWocufzyI/+0E1gWlFlN4iDilER/unfMN7E+/I8ddaHnYUDpBQN0IbnhHNa
         N97Y9m4H/4F7/S7u84Htw4YsrweJICinmoPNrc9QRxZXW6uCvFqX+fsAjwPyibwiubYW
         qRml9wQdmjc7e8LjveU0mFk3wMcB3J6zXN02qiICqF2acuprTPIw4GGyYZNsO23Baom2
         YAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lST2GatSsqwk3Z8FCgmMrt0ILXDDrNipd0HQcGxijfg=;
        b=TbUEkPOJkftxKePNR663E4IkR/kttH2gNpuBdv/oNaqzieqr8mujO4c4wdaHiU+1ry
         EG+71lMYEICN1zv2OIq/6v2QnvT7bbi0DwnaUuzoDY9Fy+V0N9hICkQF5lfSc0CdSoo+
         iYqvQMl9U7d9vIk6wks/bfza3c6ERiK5G0w0IKFmo0HegRbCviemV5RMgFqEpmUouTZ8
         t779S/u/mgrSWb+AqsePo0pVyJIPb3ABZBIBWMvRxNrqQuW44GE890huAu8cz56j13bo
         88zjkPWITXiQ3E3SgsPGdjzlmiKmgkxVokaucf6SxYHVTVEUvMrRrNJS3uHbtjB1Cos1
         3fVw==
X-Gm-Message-State: AOAM531kFG/WyV7TXhgXkIwtzAs38X0fZQZ3qjliPiFPtRJYyFCi9S+w
        UxJfupf4bLlESVGBi6JzYfEq8ptXhGZKEw6cxgLQ
X-Google-Smtp-Source: ABdhPJy9HTVKpGucbawiqf7KNb+G9oMYcH6YLEKujjy13G56omVCNN8DzjnFWfdTDwgGfkVbxQGFwY3zZDjxWqqk7GM=
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr5425980qvb.55.1625710983970;
 Wed, 07 Jul 2021 19:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210706124440.3247283-1-lerobert@google.com> <s5hbl7e8ib1.wl-tiwai@suse.de>
In-Reply-To: <s5hbl7e8ib1.wl-tiwai@suse.de>
From:   Robert Lee <lerobert@google.com>
Date:   Thu, 8 Jul 2021 10:22:46 +0800
Message-ID: <CAOM6g_B2s7Dqt3srp3U+8s0QLEogjkT=q-nmmRyDXPPs+Tdt8Q@mail.gmail.com>
Subject: Re: [PATCH] ALSA: compress: allow to leave draining state when
 pausing in draining
To:     Takashi Iwai <tiwai@suse.de>
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        carterhsu@google.com, zxinhui@google.com, bubblefang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,
Nice catch. I make a change and mail patch v2 for reviewing.

thanks,
Robert.


Takashi Iwai <tiwai@suse.de> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 06 Jul 2021 14:44:40 +0200,
> Robert Lee wrote:
> >
> > When compress offload pauses in draining state, not all platforms
> > need to keep in draining state. Some platforms may call drain or
> > partial drain again when resume from pause in draining, so it needs
> > to wake up from snd_compress_wait_for_drain() in this case.
> >
> > Call API snd_compr_leave_draining_in_pause(), if the platform
> > doesn't need to keep in draining state when pause in draining
> > state.
> >
> > Signed-off-by: Robert Lee <lerobert@google.com>
>
> Well, the logic is a bit confusing (hard to understand what really
> "leave-draining-in-pause" actually means) but also error-prone;
> e.g. you left pause_in_draining flag set while changing the state to
> SNDRV_PCM_STATE_PAUSED.  This will keep the pause_in_draining flag
> even after snd_compr_resume() call.
>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/sound/compress_driver.h | 14 ++++++++++++++
> >  sound/core/compress_offload.c   |  7 ++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/sound/compress_driver.h b/include/sound/compress_d=
river.h
> > index 277087f635f3..e16524a93a14 100644
> > --- a/include/sound/compress_driver.h
> > +++ b/include/sound/compress_driver.h
> > @@ -145,6 +145,7 @@ struct snd_compr_ops {
> >   * @lock: device lock
> >   * @device: device id
> >   * @use_pause_in_draining: allow pause in draining, true when set
> > + * @leave_draining_in_pause: leave draining state when pausing in drai=
ning
> >   */
> >  struct snd_compr {
> >       const char *name;
> > @@ -156,6 +157,7 @@ struct snd_compr {
> >       struct mutex lock;
> >       int device;
> >       bool use_pause_in_draining;
> > +     bool leave_draining_in_pause;
> >  #ifdef CONFIG_SND_VERBOSE_PROCFS
> >       /* private: */
> >       char id[64];
> > @@ -182,6 +184,18 @@ static inline void snd_compr_use_pause_in_draining=
(struct snd_compr_stream *subs
> >       substream->device->use_pause_in_draining =3D true;
> >  }
> >
> > +/**
> > + * snd_compr_leave_draining_in_pause - Leave draining state when pause=
 in draining
> > + * @substream: compress substream to set
> > + *
> > + * In some platform, we need to leave draining state when we use pause=
 in draining.
> > + * Add API to allow leave draining state.
> > + */
> > +static inline void snd_compr_leave_draining_in_pause(struct snd_compr_=
stream *substream)
> > +{
> > +     substream->device->leave_draining_in_pause =3D true;
> > +}
> > +
> >  /* dsp driver callback apis
> >   * For playback: driver should call snd_compress_fragment_elapsed() to=
 let the
> >   * framework know that a fragment has been consumed from the ring buff=
er
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offloa=
d.c
> > index 21ce4c056a92..9c7bd4db6ecd 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -719,8 +719,13 @@ static int snd_compr_pause(struct snd_compr_stream=
 *stream)
> >               if (!stream->device->use_pause_in_draining)
> >                       return -EPERM;
> >               retval =3D stream->ops->trigger(stream, SNDRV_PCM_TRIGGER=
_PAUSE_PUSH);
> > -             if (!retval)
> > +             if (!retval) {
> >                       stream->pause_in_draining =3D true;
> > +                     if (stream->device->leave_draining_in_pause) {
> > +                             stream->runtime->state =3D SNDRV_PCM_STAT=
E_PAUSED;
> > +                             wake_up(&stream->runtime->sleep);
> > +                     }
> > +             }
> >               break;
> >       default:
> >               return -EPERM;
> > --
> > 2.32.0.93.g670b81a890-goog
> >

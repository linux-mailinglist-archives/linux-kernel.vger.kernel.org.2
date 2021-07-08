Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF073C14A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGHNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGHNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:50:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA621C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:47:36 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s4so5634913qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dcoeEcEIjqF8z6oBeMSQO0+nsBtqHQ+RSAADgarXULk=;
        b=FEUtm6k7pOULwc1g2GuWwg9ec+OFT9nFXNHy0FQUg5yslsXl/zWIK27+1NTJbM/7DI
         MTvLfSYX+y9XUO/NN87bJfhcDj+YbAo0FTEV5jcfj9T6S39PcvCcIocusy3/AENHY20a
         +Va2YDR++bDDHnSJvNiAmDjwQI0064Eo+5uZfLyfqX9l6L3PcldrewWMOTwauECAgAfK
         BzVxphbpYg2bpsDp7mwiGgzX+geREXzeIsA/Xkfnul+Ycy/fniIXCEj2xchrYDxLIEX/
         Vxnzj4dMSw+elFVSfF8P/mBFzWEq37Gy3DsDtBRNy7dOUbteahYkHCK6oiaq/pACSUDq
         /1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dcoeEcEIjqF8z6oBeMSQO0+nsBtqHQ+RSAADgarXULk=;
        b=WujYtxKPvyh4NeYwi3K3lK+13//wle9LUxpIpQXlDiOmwpxR6Vp/S5wvpnUNPqdoFm
         ruuKSDmXIHaEakGTXddjVlpWqZJfThOFXhU7EolH7i6ngro8DxrCLydb9aVKCVOyqY89
         GHtlJZL23IVtNKA++uXsQXzDL5OSoy9PlviD5ovnd7KxSRJsfg5PUOs4yts0EdSOZZKi
         a2CfpKoqODJI6PzRTVgZ0JwDYw8s809tL62vcmFGnJS/WUc3mesH2s+89/bPfqrbEuvU
         ezVZPxp8qz/25YeS962Kenf6FXGmNDRZskzj17dIz8P++Y9IHmtQFkurmT4PXkrytxAY
         +n1g==
X-Gm-Message-State: AOAM531h+QTJdqrVEaipiEtrOZoDLEaiEXrStf/3Kd9Y2UXVk2yEK+kt
        yo7wb/PQniXosEy9poLl3MqRwsXS8gdeS3V7+wGA
X-Google-Smtp-Source: ABdhPJyUsMtjO8wnhwRZut4p82VJ4jqmBsd5Llz44/hnsTOYseyp3t05psKtKvRnSTVa4QEwvKkRMweTnM1Cp/js6dY=
X-Received: by 2002:a37:8345:: with SMTP id f66mr31099925qkd.396.1625752055653;
 Thu, 08 Jul 2021 06:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210708020815.3489365-1-lerobert@google.com> <s5ho8bd59q4.wl-tiwai@suse.de>
In-Reply-To: <s5ho8bd59q4.wl-tiwai@suse.de>
From:   Robert Lee <lerobert@google.com>
Date:   Thu, 8 Jul 2021 21:47:24 +0800
Message-ID: <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com>
Subject: Re: [Patch v2] ALSA: compress: allow to leave draining state when
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

It is a little complex to describe the design in detail, but try to
explain simply
what issue we meet.

If w/o the change,  after user resumes from the pause, our system would cal=
l
snd_compr_drain() or snd_compr_partial_drain() again after it returns from
previous drain (when EOF reaches). Then it will block in this drain and no =
one
wake it up because EOF has already reached. I add this change to return fro=
m
the previous drain.

And yes, after user resumes it, it will change state to RUNNING. Then it wi=
ll
call snd_compr_drain() or snd_compr_partial_drain() very soon and change
state to DRAINING again.

Actually, I am wondering how the pause-during-drain can keep the state in
DRAINING. It should have a different design. :)

I also checked the snd_compr_open() comment, and it doesn't mention that
we cannot pause in DRAINING state. Looks like it needs to be updated accord=
ing
to these changes. Maybe it can be updated in another commit?

* SNDRV_PCM_STATE_DRAINING: When stream is draining current data. This is d=
one
 *      by calling SNDRV_COMPRESS_DRAIN.
 * SNDRV_PCM_STATE_PAUSED: When stream is paused. This is done by calling
 *      SNDRV_COMPRESS_PAUSE. It can be stopped or resumed by calling
 *      SNDRV_COMPRESS_STOP or SNDRV_COMPRESS_RESUME respectively.

thanks,
Robert.

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2021=E5=B9=B47=E6=9C=888=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:24=E5=AF=AB=E9=81=93=EF=BC=9A


Takashi Iwai <tiwai@suse.de> =E6=96=BC 2021=E5=B9=B47=E6=9C=888=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 08 Jul 2021 04:08:15 +0200,
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
> > ---
> >  include/sound/compress_driver.h | 14 ++++++++++++++
> >  sound/core/compress_offload.c   |  8 +++++++-
> >  2 files changed, 21 insertions(+), 1 deletion(-)
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
> > index 21ce4c056a92..c6e5c8f072d7 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -719,8 +719,14 @@ static int snd_compr_pause(struct snd_compr_stream=
 *stream)
> >               if (!stream->device->use_pause_in_draining)
> >                       return -EPERM;
> >               retval =3D stream->ops->trigger(stream, SNDRV_PCM_TRIGGER=
_PAUSE_PUSH);
> > -             if (!retval)
> > +             if (!retval) {
> > +                     if (stream->device->leave_draining_in_pause) {
> > +                             stream->runtime->state =3D SNDRV_PCM_STAT=
E_PAUSED;
> > +                             wake_up(&stream->runtime->sleep);
> > +                             break;
> > +                     }
> >                       stream->pause_in_draining =3D true;
> > +             }
>
> Hrm, what actually happens with this new flag?  It changes the state
> to PAUSED even if it's done during the draining.  Then user resumes
> the pause via snd_compr_resume(), and now the state changes to
> RUNNING.  OTOH, if the draining runs normally, it'll end up with
> SETUP.
>
> Even if the above is even designed behavior, it must be described
> properly somewhere.  The state change is described in snd_compr_open()
> comment, and the new behavior should be mentioned there as well.
> (Admittedly, the previous hack for the pause-during-drain is also
> missing and should have been mentioned there; but an excuse is that
> the pause-during-drain doesn't change the state itself :)
>
>
> thanks,
>
> Takashi

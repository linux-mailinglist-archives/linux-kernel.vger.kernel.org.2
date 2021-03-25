Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8B349367
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCYNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57584 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCYNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:55:19 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lPQSE-0007cB-5o
        for linux-kernel@vger.kernel.org; Thu, 25 Mar 2021 13:55:18 +0000
Received: by mail-lj1-f197.google.com with SMTP id d16so3082107lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ffsbwo16qlRWJVZeTtad+oHHzzSDUJ5bntqjE6nzNA=;
        b=ncvtizwZCDiWDGO0XuuQXZ9E+iohD2dmqqGj/kv6Qx202n9Vcwi4QK+Ko1nr7QD2VZ
         XYBX8L7eDCA8Nw1F2QpEE0Z429KmEP8MIMJH+yfG+v4RwSY9tHt6qRIynJIE+PXp36iI
         6RTcbEqRyo8MY2xQ6p2YZJPxbgRWY8mgDLxWPAfh/EXpOf8M29q6bYaXkTz/BI+vc0+7
         KJ2vWSafE1WV7tXvkUpRT6APCw/9HGaZ894q6BiGhFB5LiQGJ7tyl0Nju3ngxBDrjU2y
         c3BPfXpBsLDghQwdWfMoCpK1/E66oGrMVM4CUi8GswpDs0wXG3TWM1+yHoL7KBQL9wGy
         z5zw==
X-Gm-Message-State: AOAM530fjV+O6adPiXKy6jpNVUz5IxKavMiXweB+B1XtPfhdzc6Vlf0G
        Q/NjKg8l7aA4IuQB/5jwP1rDZIBJWZtVJZq8YBy99hNsDWzVke+2X8Klqin6lwjtKkyCV8136w/
        3ETRmowO16m0Nde+UmeAhXL4Di4z1qwv/A2+vk+tt8vfOJRM8TfBICsatOg==
X-Received: by 2002:a19:ee16:: with SMTP id g22mr5089504lfb.513.1616680517557;
        Thu, 25 Mar 2021 06:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw94famgyJI0St0cjSn+Ge9wfeQQ75F6q36rk/xgF1AqvrBMX5mZOrZ+0oDkwfVW6coMicgAN/SK+fyxqI0TEU=
X-Received: by 2002:a19:ee16:: with SMTP id g22mr5089489lfb.513.1616680517267;
 Thu, 25 Mar 2021 06:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210325121250.133009-1-kai.heng.feng@canonical.com>
 <20210325121250.133009-2-kai.heng.feng@canonical.com> <s5hczvnmju0.wl-tiwai@suse.de>
In-Reply-To: <s5hczvnmju0.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 25 Mar 2021 21:55:06 +0800
Message-ID: <CAAd53p79HSpNKu69ZM7vRGWQT+9ydf59hGH-yNMT=Ymbg2NebA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: usb-audio: Check connector value on resume
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Chris Chiu <chiu@endlessm.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tom Yan <tom.ty89@gmail.com>, Joe Perches <joe@perches.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:41 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 25 Mar 2021 13:12:48 +0100,
> Kai-Heng Feng wrote:
> >
> > Rear Mic on Lenovo P620 cannot record after S3, despite that there's no
> > error and the other two functions of the USB audio, Line In and Line
> > Out, work just fine.
> >
> > The mic starts to work again after running userspace app like "alsactl
> > store". Following the lead, the evidence shows that as soon as connector
> > status is queried, the mic can work again.
> >
> > So also check connector value on resume to "wake up" the USB audio to
> > make it functional.
> >
> > This can be device specific, however I think this generic approach may
> > benefit more than one device.
> >
> > While at it, also remove reset-resume path to consolidate mixer resume
> > path.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Remove reset-resume.
> >  - Fold the connector checking to the mixer resume callback.
>
> That's not what I meant exactly...  I meant to put both into the
> single resume callback, but handle each part conditionally depending
> on reset_resume argument.

OK, I get what you mean now.

>
> But this turned out to need more changes in mixer_quirks.c
> unnecessarily.  Maybe adding the two resume functions is a better
> approach in the end, but not for the specific connection thing but
> generically both resume and reset_resume callbacks.  Something like
> below.

This approach looks good. Let me send another one.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index b004b2e63a5d..1dab281bb269 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -3615,20 +3615,43 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
>         return 0;
>  }
>
> +static int default_mixer_resume(struct usb_mixer_elem_list *list)
> +{
> +       struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
> +
> +       /* get connector value to "wake up" the USB audio */
> +       if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
> +               get_connector_value(cval, NULL, NULL);
> +
> +       return 0;
> +}
> +
> +static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
> +{
> +       int err = default_mixer_resume(list);
> +
> +       if (err < 0)
> +               return err;
> +       return restore_mixer_value(list);
> +}
> +
>  int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
>  {
>         struct usb_mixer_elem_list *list;
> +       usb_mixer_elem_resume_func_t f;
>         int id, err;
>
> -       if (reset_resume) {
> -               /* restore cached mixer values */
> -               for (id = 0; id < MAX_ID_ELEMS; id++) {
> -                       for_each_mixer_elem(list, mixer, id) {
> -                               if (list->resume) {
> -                                       err = list->resume(list);
> -                                       if (err < 0)
> -                                               return err;
> -                               }
> +       /* restore cached mixer values */
> +       for (id = 0; id < MAX_ID_ELEMS; id++) {
> +               for_each_mixer_elem(list, mixer, id) {
> +                       if (reset_resume)
> +                               f = list->reset_resume;
> +                       else
> +                               f = list->resume;
> +                       if (f) {
> +                               err = list->resume(list);
> +                               if (err < 0)
> +                                       return err;
>                         }
>                 }
>         }
> @@ -3647,6 +3670,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
>         list->id = unitid;
>         list->dump = snd_usb_mixer_dump_cval;
>  #ifdef CONFIG_PM
> -       list->resume = restore_mixer_value;
> +       list->resume = default_mixer_resume;
> +       list->reset_resume = default_mixer_reset_resume;
>  #endif
>  }
> diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
> index c29e27ac43a7..e5a01f17bf3c 100644
> --- a/sound/usb/mixer.h
> +++ b/sound/usb/mixer.h
> @@ -69,6 +69,7 @@ struct usb_mixer_elem_list {
>         bool is_std_info;
>         usb_mixer_elem_dump_func_t dump;
>         usb_mixer_elem_resume_func_t resume;
> +       usb_mixer_elem_resume_func_t reset_resume;
>  };
>
>  /* iterate over mixer element list of the given unit id */
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index ffd922327ae4..b7f9c2fded05 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -151,7 +151,7 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
>                 *listp = list;
>         list->mixer = mixer;
>         list->id = id;
> -       list->resume = resume;
> +       list->reset_resume = resume;
>         kctl = snd_ctl_new1(knew, list);
>         if (!kctl) {
>                 kfree(list);

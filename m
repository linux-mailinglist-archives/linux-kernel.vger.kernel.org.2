Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B24348A26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCYH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:26:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45830 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCYH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:26:24 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lPKNp-0006HJ-FL
        for linux-kernel@vger.kernel.org; Thu, 25 Mar 2021 07:26:21 +0000
Received: by mail-lj1-f198.google.com with SMTP id j21so2572898ljg.18
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h65iB8fJxtr3WXADdRV0fzAhv+9Eb2KmvqOOMl04h9E=;
        b=Oc95dYjwYsOWxY00YPH7xzfBq/bTbxVL9b206uPxD50NdS/nXf8/YecfGCYWYe/5m6
         d58yBocMyZkYScSaMQEyt2jWWXqUh6n9+mOxbnsFpesHFm4PApOJWWRJfkEwLBIPehNG
         QLS4StiX56sIbRjtDp7GdqQ9LZVlVXpbjfnbUFh3VAnMkStX58q5S0hBzVIa5HqpWLHf
         CJrsBJTOXy6yxM5ktzgDbMwtgwdk10r9tamrG48twI34N0uvtf5yeLnpggGMW3X0AkXN
         pvXxrKqachK3KskG4Tznt6gL6enj6KviDGsLUK517lKREZYhzsvyeVr3ENoqH9CBii6/
         Inng==
X-Gm-Message-State: AOAM5332yHzaPpcRNoKM5IXyVi2QtCVAYoQ3BbyAIOqzWNM+XeyzVB03
        UuI8gEn7Tu+cnWLm+LGz+r9paZtQ8dnlj8GOsnd2Op6JPT9iPlNsUBaLkdb42ZVWqWHA8gHWl7/
        9cW2Y8kqVWiE1djGMkV+aUrYfeQzikjcGnxhVMXEFZI6/cew8FdD6av17fg==
X-Received: by 2002:a05:6512:3582:: with SMTP id m2mr4267452lfr.10.1616657180879;
        Thu, 25 Mar 2021 00:26:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWhSFaP7Ao1JcRgKv4+ndiMSYVHoI38U66PJbVh7i1QaGIDxdSdC/uz+tig0tTd5RsHT71ayOnRogMl8iDzOs=
X-Received: by 2002:a05:6512:3582:: with SMTP id m2mr4267441lfr.10.1616657180598;
 Thu, 25 Mar 2021 00:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210324171410.285848-1-kai.heng.feng@canonical.com>
 <20210324171410.285848-2-kai.heng.feng@canonical.com> <s5hzgyrn1id.wl-tiwai@suse.de>
In-Reply-To: <s5hzgyrn1id.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 25 Mar 2021 15:26:09 +0800
Message-ID: <CAAd53p7F=TWu5aYT00C03kDvtF-Wfw2YzeweGHecRHT87oNb+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: usb-audio: Check connector value on resume
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Chiu <chiu@endlessm.com>, Joe Perches <joe@perches.com>,
        Tom Yan <tom.ty89@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 3:19 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 24 Mar 2021 18:14:08 +0100,
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
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Just to be sure: this workaround is always needed no matter whether
> reset_resume is set or not?

Yes, reset_resume is irrelevant for this issue. Getting connector
status is the key.

> If so, it's better to change the resume
> callback to take reset_resume argument and call it always.  The
> resume_connector() can be folded into there.

OK, will send V2.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > ---
> >  sound/usb/mixer.c | 18 ++++++++++++++++++
> >  sound/usb/mixer.h |  1 +
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 98f5417a70e4..6a553d891b0f 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -3631,11 +3631,28 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
> >       return 0;
> >  }
> >
> > +static int resume_connector(struct usb_mixer_elem_list *list)
> > +{
> > +     struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
> > +
> > +     if (cval->val_type != USB_MIXER_BOOLEAN || cval->channels != 1)
> > +             return 0;
> > +
> > +     return get_connector_value(cval, NULL, NULL);
> > +}
> > +
> >  int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
> >  {
> >       struct usb_mixer_elem_list *list;
> >       int id, err;
> >
> > +     for (id = 0; id < MAX_ID_ELEMS; id++) {
> > +             for_each_mixer_elem(list, mixer, id) {
> > +                     if (list->resume_connector)
> > +                             list->resume_connector(list);
> > +             }
> > +     }
> > +
> >       if (reset_resume) {
> >               /* restore cached mixer values */
> >               for (id = 0; id < MAX_ID_ELEMS; id++) {
> > @@ -3664,5 +3681,6 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
> >       list->dump = snd_usb_mixer_dump_cval;
> >  #ifdef CONFIG_PM
> >       list->resume = restore_mixer_value;
> > +     list->resume_connector = resume_connector;
> >  #endif
> >  }
> > diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
> > index c29e27ac43a7..843ccff0eea3 100644
> > --- a/sound/usb/mixer.h
> > +++ b/sound/usb/mixer.h
> > @@ -69,6 +69,7 @@ struct usb_mixer_elem_list {
> >       bool is_std_info;
> >       usb_mixer_elem_dump_func_t dump;
> >       usb_mixer_elem_resume_func_t resume;
> > +     usb_mixer_elem_resume_func_t resume_connector;
> >  };
> >
> >  /* iterate over mixer element list of the given unit id */
> > --
> > 2.30.2
> >

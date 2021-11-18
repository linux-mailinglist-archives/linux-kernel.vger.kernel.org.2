Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6B455370
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhKRDgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbhKRDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:36:17 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E79C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:33:18 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id r15so10708825uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/jn/zgEzxQP9ZQwx0L5iwDA8SV1bEGJAnIDVoaBgXA=;
        b=JaF2etFbSKwaLKzECO7evTgrEGCIalvzi/L4AwWws/5MQ1RFdDBo7lk0Hk8D19TPOS
         5hBeTx2Go4PHeEnUOL5nZZkv5NQTN0Sk76gafNUap5rlb4d1pksHHXt6KUKliJIrZcZZ
         oaim98jEcrP/7lYYDjSjk5JY5dxuV3WF/novS95lwB+hbkmtKoXILpTiegKv3yF9/I7b
         Wx+WXy+6diat0CHIwnZZWpK4vQ/P9/aQLbldF0v7DLROD7mMsRZU3a6MtAQULarpMuDS
         MCPXPTeM6rIaPmTy0scKj3pSpYJj2K3a8LMzT4aZhBSETsB9B20fauaN16KmpbGG08y2
         2wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/jn/zgEzxQP9ZQwx0L5iwDA8SV1bEGJAnIDVoaBgXA=;
        b=6syZSgyvb/sRwUn0LosA43BUBixoV8H6OLG/mUX8r4k1EVC5Pw4NvKnQq6gYTs84EJ
         nYA9VvFpI/UUKEHmuzhTORAQ/M5a4NFBGiGi260sfiKPPXuIMjmv3wjdFZ0sVN6tOKBh
         95ZwGEhLOxahUhfXJwRXeRK0ApuaU0nKT//hMz3Xbit0oa0Kzt8ugTC6m9Th5w0QacAD
         O+RUsRRQndvgtA3/TXGIw74+I4nSTaBHeZ+0i9v5Ti8JFK4PCU/7NRxjBeQM2a7MEHMl
         ONPPyXa909juVKyHI7FUngG7K3CyrbtrsUpPzltO8wf7uTeK6ojGGy0NvspZCG40t9KA
         c48Q==
X-Gm-Message-State: AOAM530pEN5n4DSK8gCYDDTdkdDxuW8iBsTpo0gMAHQCzt+q+7OcX9SA
        ZkD0M6cRpnBRSC/PDhuAnFNckLxZjJd9fOdCMX4=
X-Google-Smtp-Source: ABdhPJx+SwE+lVngvA+ZZMvKi/vw2I5Xo7+pTY18CvYLu3GrjLvmCauC65r8hLMZ/7tTPQUQdMAU6W6EFB0SJ82r3ak=
X-Received: by 2002:a05:6102:32c9:: with SMTP id o9mr76054026vss.46.1637206397469;
 Wed, 17 Nov 2021 19:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20211116072027.18466-1-tiwai@suse.de> <07e228eb-676a-bdb1-c2ec-a96f691f5a18@linaro.org>
 <s5h5ysqlcm8.wl-tiwai@suse.de> <b0d2b643-214a-07c5-96b7-4845c54cba72@linaro.org>
In-Reply-To: <b0d2b643-214a-07c5-96b7-4845c54cba72@linaro.org>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Thu, 18 Nov 2021 09:02:40 +0530
Message-ID: <CAAs364-thiqACMRwT++JMxkMd7qa_stFApjK-4SmrEJetX6oyw@mail.gmail.com>
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Add missing rwsem around
 snd_ctl_remove() calls
To:     Alex Elder <elder@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>
> On 11/17/21 3:02 PM, Takashi Iwai wrote:
> > On Wed, 17 Nov 2021 20:56:14 +0100,
> > Alex Elder wrote:
> >>
> >> On 11/16/21 1:20 AM, Takashi Iwai wrote:
> >>> snd_ctl_remove() has to be called with card->controls_rwsem held (when
> >>> called after the card instantiation).  This patch adds the missing
> >>> rwsem calls around it.
> >>
> >> I see the comment above snd_ctl_remove() that says you must hold
> >> the write lock.  And given that, this seems correct to me.
> >>
> >> I understand why you want to take the lock just once, rather
> >> than each time snd_ctl_remove() is called.
> >>
> >> However I believe the acquisition and release of the lock
> >> belongs inside gbaudio_remove_controls(), not in its caller.
> >>
> >> If you disagree, can you please explain why?
> >
> > In general if the function returns an error and has a loop inside,
> > taking a lock in the caller side avoids the forgotten unlock.
>
> But taking the lock in the called function makes the
> caller not need to take the lock (which would be even
> more valuable if there were more than one caller).
>
> I prefer having the lock acquisition in the called
> function.  Please send version 2, as I suggested.


Hi Takashi,

Thanks for sharing this patch. In reference to the suggestion from Alex,
do you think replacing snd_ctl_find_id(), snd_ctl_remove() with
snd_ctl_remove_id() inside gbaudio_remove_controls() would be an even
better choice without worrying about locks?

--
vaibhav

 >
>
>                                         -Alex
>
> > Takashi
> >
> >
> >> Otherwise, will you please submit version two, taking the
> >> lock inside gbaudio_remove_controls()?
> >>
> >> Thanks.
> >>
> >>                                      -Alex
> >>
> >>> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")
> >>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >>> ---
> >>>    drivers/staging/greybus/audio_helper.c | 8 ++++++--
> >>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> >>> index 1ed4772d2771..843760675876 100644
> >>> --- a/drivers/staging/greybus/audio_helper.c
> >>> +++ b/drivers/staging/greybus/audio_helper.c
> >>> @@ -192,7 +192,11 @@ int gbaudio_remove_component_controls(struct snd_soc_component *component,
> >>>                                   unsigned int num_controls)
> >>>    {
> >>>     struct snd_card *card = component->card->snd_card;
> >>> +   int err;
> >>>    -        return gbaudio_remove_controls(card, component->dev, controls,
> >>> -                                  num_controls, component->name_prefix);
> >>> +   down_write(&card->controls_rwsem);
> >>> +   err = gbaudio_remove_controls(card, component->dev, controls,
> >>> +                                 num_controls, component->name_prefix);
> >>> +   up_write(&card->controls_rwsem);
> >>> +   return err;
> >>>    }
> >>>
> >>
>
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev

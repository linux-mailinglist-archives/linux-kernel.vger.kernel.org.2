Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5290E349151
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCYL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCYLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:55:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:55:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so2942381wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1h6GONbhgF2Yys7ho0AM9P0VvfqpLXnfjdbS9zycO8=;
        b=liEzoQJWZcRCyAUZGNG/ljaZ5tYWORY9q9YoaJmDs63lxfkaGFLfePnbCqlrFfeal/
         AjNCVFzB37coNtFS6UCerAo5nlRrUxr3lfBssgQzDxWNhMiIMlq5LBv0/Zb8xn2NW/xK
         olQSiPMwMtpa2DiTVw6AWnjacSCpeD+zfmTqMXEKLAY2ZaNzTuQMuIyeWVlDVx1CyoLS
         amdA7ZM+aBaEWhM35DhAfW0StzmC8cB+G5UYfMVW/lyWPrZq1IKGcmRtBwqR8mfFoNTa
         8HZ91X8U2xoXj8C3hAf/LMYGtwuXe1mQ0gsl35RPbxma+QXLAxzYIa7ysCeeXeyHwIBQ
         +tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1h6GONbhgF2Yys7ho0AM9P0VvfqpLXnfjdbS9zycO8=;
        b=fnSEca6FJ6xZ0A3qYRD3Htm3v5Iq5mrzDz4+6LZza9wyNan3fZgl50v6u5owRe2vDt
         JUMwDfYU/M+jgSqFVCsg8MqhLQYNjvbXBpT4m2zg+2UkFfTfPxwOv5zSulYvQO5Aqd2U
         LdXPn5puUEUEOCuk0S67tiA6ANjN+lc1+uA9ft3RlEX1rXi01emMAdAc1zQCmpM95efs
         +sU5dhKH/i7IcIBoWO+VUEY7R+4XB2IJCCizzhYeg25Y6ifgoh1ljHSH1e/o1536Zvh+
         cETrdsMTUBt4d7yCeZuQW8SJZKVViqmn06zXMrRGGFMasNB3cSd2EMpvDuE7fSUP5WxI
         1+sg==
X-Gm-Message-State: AOAM530iXe5FJDYTo21BLBCag38OnjUt7069Jhpvg9B6obHgO/lW6fGY
        cbc9aA/zM+UE5leD6kSf0dA=
X-Google-Smtp-Source: ABdhPJzQTKTtceUKIj0vScCdI4m3+AyGii4BnVfodiCidTnvVE4Ta+heOnzSzylierhrqKSfl0o9ZQ==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr7615480wma.148.1616673356553;
        Thu, 25 Mar 2021 04:55:56 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id i16sm8469770wmq.3.2021.03.25.04.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:55:56 -0700 (PDT)
Date:   Thu, 25 Mar 2021 08:55:50 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: fix misuse of WARN_ON
Message-ID: <20210325115550.t4w3eucgcctqoqeb@smtp.gmail.com>
References: <20210320132840.1315853-1-dvyukov@google.com>
 <20210324220008.nqwwwfugyfngbn3x@smtp.gmail.com>
 <CACT4Y+bDcd+hdgkQyEvPRM1eSWSoud4EDhq4tLKS8wxFjr1F6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bDcd+hdgkQyEvPRM1eSWSoud4EDhq4tLKS8wxFjr1F6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25, Dmitry Vyukov wrote:
> On Wed, Mar 24, 2021 at 11:00 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > On 03/20, Dmitry Vyukov wrote:
> > > vkms_vblank_simulate() uses WARN_ON for timing-dependent condition
> > > (timer overrun). This is a mis-use of WARN_ON, WARN_ON must be used
> > > to denote kernel bugs. Use pr_warn() instead.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Reported-by: syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com
> > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > Cc: Melissa Wen <melissa.srw@gmail.com>
> > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Change-Id: I7f01c288092bc7e472ec63af198f93ce3d8c49f7
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_crtc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > index 0443b7deeaef6..758d8a98d96b3 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -18,7 +18,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> > >
> > >       ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
> > >                                         output->period_ns);
> > > -     WARN_ON(ret_overrun != 1);
> > > +     if (ret_overrun != 1)
> > > +             pr_warn("%s: vblank timer overrun\n", __func__);
> >
> > Hi Dmitry,
> >
> > Thanks for your patch.
> >
> > Looks good to me.
> > The Change-Id tag just seems a little noisy to me, but can be
> > fixed while applying.
> 
> Yes, please drop Change-Id when applying if possible. Sorry for that.
> Thanks for the review, Melissa.

Applied to drm-misc-next.

Thanks,

Melissa
> 
> > Acked-by: Melissa Wen <melissa.srw@gmail.com>
> >
> > >
> > >       spin_lock(&output->lock);
> > >       ret = drm_crtc_handle_vblank(crtc);
> > >
> > > base-commit: e94c55b8e0a0bbe9a026250cf31e2fa45957d776
> > > --
> > > 2.31.0.291.g576ba9dcdaf-goog
> > >

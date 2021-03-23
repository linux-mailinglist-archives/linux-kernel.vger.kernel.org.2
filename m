Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC4346200
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhCWOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCWOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:54:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F51C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:54:15 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id k25so17254292oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqO+jSrm0OppF98WnNtbBizJ/AmSJJZtjDp1PeL64CQ=;
        b=lECKv0UrcLQRcL/CWnYZC5ZbC1utLv04pVQzf4q/FZG2ZP1Rz6xUiYT8yGZkjQUOuT
         H79ecVCh/8bZgVVZBPemIpYcaVgy7CgkXp6CI7c2Gr+4ZeCbQapBT+v8L8cfVEOwvmgF
         /LeNjeRmLy/JDaAcApWC2TZdob9oRuywIoAzarb++L6j8sY31t/0bzxJ6y290d7ZdKIG
         wafxS/6P79XsPXjGygQCRD5ZwGtzGLJIeq80Ajf3UNzL/ZUHZxUcKfrbHEuQQnDk7WFm
         4YgR/wGgyBPYSze++2RlsAb2Nc8UkERCIVr8QGrkRLPPFy1vfH6VHf401uwCNLB58ihz
         2kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqO+jSrm0OppF98WnNtbBizJ/AmSJJZtjDp1PeL64CQ=;
        b=hxn2n2zwQagv6EKh8FECuGFgDpSqG3JLWcry9Q98/Sd7vA9qj2M0Yxj4Dh7Vv9/vyY
         Ihur5/Ro8E2zY71voHfToPAzM68dA2wSCXK27j6cm40tg6K+nWyeNEHvm6IwVkF2klok
         9wxQEC2WWbK+ouLR+osDQOk1irqwj0P4vRWb+WIpSUnANL7iq6oUziUj+kBLzIGET1G4
         SclGiKOtUtl23XkAGK50zuK5MQ6xkagHK2pku9MhZsfbC3/luGlM1/dYot0TrvMb0aAE
         p3O3pb7aNQ1nx+AntDJYvVDApu7wopsRzaQwIrG/2VuPc3xhhclL1UY5h3v+6c4lvSGo
         PfRA==
X-Gm-Message-State: AOAM532iDblnfwXgb9MTONWdWE3cmjMhap+RQIO+9r6+XiD4aVhMPuYR
        0HuXm/ht/bMHIXp4/pT0mnlmw/n3i0YkjAkjQVbU0xeT
X-Google-Smtp-Source: ABdhPJzAHVGutNlnEG3vBoUnGvxbXvag8NZpLFKrCNCUli/nAQCNzsxC4UaxFPFRj7s/aXJsiEJLOdEO7hJ+ZZX3714=
X-Received: by 2002:aca:4284:: with SMTP id p126mr3637059oia.123.1616511255417;
 Tue, 23 Mar 2021 07:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210320183642.10886-1-unixbhaskar@gmail.com> <5cb1810-152-7ec3-ffd2-4a6fd1d6c01c@bombadil.infradead.org>
In-Reply-To: <5cb1810-152-7ec3-ffd2-4a6fd1d6c01c@bombadil.infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 10:54:04 -0400
Message-ID: <CADnq5_NOytHHjEt3FS3CoCgPzsoMVQJ1-Dord_=YzaTHWSY-KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: Couple of typo fixes
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Mar 20, 2021 at 3:10 PM Randy Dunlap
<rdunlap@bombadil.infradead.org> wrote:
>
>
>
> On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:
>
> >
> > s/seralization/serialization/
> > s/parallism/parallelism/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> > ---
> > drivers/gpu/drm/drm_atomic.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index dda60051854b..e1e4500aaca4 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -1148,7 +1148,7 @@ EXPORT_SYMBOL(drm_atomic_add_encoder_bridges);
> >  * This function walks the current configuration and adds all connectors
> >  * currently using @crtc to the atomic configuration @state. Note that this
> >  * function must acquire the connection mutex. This can potentially cause
> > - * unneeded seralization if the update is just for the planes on one CRTC. Hence
> > + * unneeded serialization if the update is just for the planes on one CRTC. Hence
> >  * drivers and helpers should only call this when really needed (e.g. when a
> >  * full modeset needs to happen due to some change).
> >  *
> > @@ -1213,7 +1213,7 @@ EXPORT_SYMBOL(drm_atomic_add_affected_connectors);
> >  *
> >  * Since acquiring a plane state will always also acquire the w/w mutex of the
> >  * current CRTC for that plane (if there is any) adding all the plane states for
> > - * a CRTC will not reduce parallism of atomic updates.
> > + * a CRTC will not reduce parallelism of atomic updates.
> >  *
> >  * Returns:
> >  * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
> > --
> > 2.26.2
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

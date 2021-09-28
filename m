Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D849E41AD93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhI1LIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240346AbhI1LIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632827227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR6VXnQsyOwoBA0NqYwQwAM8amF8J8DkhanQviHV1Bg=;
        b=Wz1ipQHn4MoRLzldiMuO5AwmuXTfmv8F/8nPl5w8qbvpdHAkpkDITgIC3GsxorDpM2pc+f
        rSg3Ifn8GhypYD2d2k5ZShFkOOJJsO+YgJXTFLxlledNAaJwfoAr5UthjxUaIC6S/Bax/S
        FKwhop1xJbEApqxpVSYw4oSwg13taRw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-R4Fo0HdNMuGcJNqByjFD7w-1; Tue, 28 Sep 2021 07:07:06 -0400
X-MC-Unique: R4Fo0HdNMuGcJNqByjFD7w-1
Received: by mail-wm1-f72.google.com with SMTP id p63-20020a1c2942000000b0030ccf0767baso954644wmp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WR6VXnQsyOwoBA0NqYwQwAM8amF8J8DkhanQviHV1Bg=;
        b=DorZSqLm1pZblE9h1s5GBZuAJDBJBsIS3QRc3r1TdijgU5PTCmsyByx1i+taYtFuGP
         wksyePog2sJnRXtisepHewV9cnxtYnLfMNYXgYRRDzWoDZ/d+QdpLxzk/yrGs+xnQobk
         5/RF/dm6KY3GwW3EJDHPqTdZLp/V7zl4uY/y2TSY1gu/EX8Dn8qU6aK0WNQoSTl2lanc
         HPz6zg+LIkwSAAGx6pN8kbUcVezcYCC292fFH1/+Q7k7SNDkp7M6kAmkX6HQokmTlOHJ
         J3IevBm8zyrseIOG3wwUFxw+UlZAsx0OPbVBOTN90y9ooG0uhPaOZd1XKZpGHrRsZOZc
         l0BA==
X-Gm-Message-State: AOAM530ijd8FFXol2/RK482DoObmUuHGX8s8LFU0Vs2w+NpuCPpVzVLo
        jXhPZ+THfGGC30qQFGa0yV0aCehDyJHwtcvDFnnivpWgTO7evyxMGAeRHrU70uifpd8d9XTOi7i
        /eyn62oRy/ky2bq7+7deAZK5qysrFZDsa629qHdsv
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr4036163wmk.141.1632827224641;
        Tue, 28 Sep 2021 04:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0TvRX1heajsLZFd4GGwP4vhnY328h7RyY16leHPFWlcyFhg8AWc8/US2AUGlQu71mjn+OzM8EFLIlyzTcL7Y=
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr4036143wmk.141.1632827224471;
 Tue, 28 Sep 2021 04:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201203000220.18238-1-jcline@redhat.com> <7f51dbe3dac85f692e01bb5cecdf4454a40b1893.camel@redhat.com>
In-Reply-To: <7f51dbe3dac85f692e01bb5cecdf4454a40b1893.camel@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 13:06:53 +0200
Message-ID: <CACO55ttDK4eCZ-RUOnPRLawZYUbX9xyXDnqwB=4z7vNrZkkvxg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: avoid a use-after-free when BO init fails
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Thierry Reding <treding@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

and queued

On Fri, Mar 26, 2021 at 10:41 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> On Wed, 2020-12-02 at 19:02 -0500, Jeremy Cline wrote:
> > nouveau_bo_init() is backed by ttm_bo_init() and ferries its return code
> > back to the caller. On failures, ttm_bo_init() invokes the provided
> > destructor which should de-initialize and free the memory.
> >
> > Thus, when nouveau_bo_init() returns an error the gem object has already
> > been released and the memory freed by nouveau_bo_del_ttm().
> >
> > Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
> > Cc: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > index 787d05eefd9c..d30157cc7169 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > @@ -211,10 +211,8 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int
> > align, uint32_t domain,
> >         }
> >
> >         ret = nouveau_bo_init(nvbo, size, align, domain, NULL, NULL);
> > -       if (ret) {
> > -               nouveau_bo_ref(NULL, &nvbo);
> > +       if (ret)
> >                 return ret;
> > -       }
> >
> >         /* we restrict allowed domains on nv50+ to only the types
> >          * that were requested at creation time.  not possibly on
>
> --
> Sincerely,
>    Lyude Paul (she/her)
>    Software Engineer at Red Hat
>
> Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
> asked me a question, are waiting for a review/merge on a patch, etc. and I
> haven't responded in a while, please feel free to send me another email to check
> on my status. I don't bite!
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A85443A50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 01:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhKCAPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhKCAPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:15:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D169C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 17:12:38 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w15so835565ill.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1hFdIa5+UMPz4ryPHs3ofaiooiYhjKx88rmchvIn5NY=;
        b=gLfoJHd6ZKlzlQhbePQy2aggmQknUF8BWz65ttk38CoFAqmVayRCvKORjOJCI2iCLA
         HlpNX5x1DH2gk4M0muenjcV9BlGiLmYKWAQIQRKddJSE4yGxk9jiEiTIOs/U9IVYDX6J
         K9JMyXZBoaR6gCjYikPXnz5PYkLuXE1ilj0RtejIyCndyCwqiU2divrDhP4xR2Dsfhq3
         9TNZINabHz+E/gvPNo1dNKIf92uVNzHMdVOLFHgjK4QU+PMkYZjVKGHS4x8Z9TnfbYiH
         H8741WpUobi3T8CFLP6PsQUNNMj+Y7HkO7MFVVfx4uQjUyIo1UqVmTzrmiRwrlHUduVv
         hd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1hFdIa5+UMPz4ryPHs3ofaiooiYhjKx88rmchvIn5NY=;
        b=A6icSGrG4g/OXESoW6uXlsm1jsbYXrsqBq+5670MY6O/LqVoMOYZsJo0rS98edFAhR
         eMU4kbxlIOxJxUg22Be5o9BfLrDvkp/d3BGQU+S0yLFqX6k1+PiYwXpi82a6DivGxfUh
         rzfwtHl7Jx2OBnEfXyOCGd5BOLLmQIszyioRN7B2pLn+sDZ3fURNFJVJzuYSfpC7mqbg
         6/nSJtrQsgVEoMuS1o5CIebbHdmV+6cL5cqPvYC9ZaiObtEp8c53fgjhLocK45IUDQ2Y
         /J7hPIFkoKgjVhBW3Scz8dTxKP6d8BLEoZz3ulUmD1RLSa0VPnx8/7hV4eY4+SinYWQg
         C5fg==
X-Gm-Message-State: AOAM532XbKSof//mYcrR9gg5r5eTj0Eg+KB6UYpje9I/VY9qHBUYuJn2
        LsJnp2fG5MUDbymrfk2niyeJQHDk8gPzY9XHpc5dJQ==
X-Google-Smtp-Source: ABdhPJyWD/JegcYFIIcy6BVOaSs6qyyeXkZkN5Cqniw7bm4x87PzruFAJR2UPC6iPqTJYKGsDlgM11UKmwiqgW0e39Q=
X-Received: by 2002:a92:7f0e:: with SMTP id a14mr26683165ild.215.1635898357612;
 Tue, 02 Nov 2021 17:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210930085932.1.I8043d61cc238e0168e2f4ca5f4783223434aa587@changeid>
 <17d63b06-d1bd-85ab-92d3-71fa236b9493@suse.de>
In-Reply-To: <17d63b06-d1bd-85ab-92d3-71fa236b9493@suse.de>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Wed, 3 Nov 2021 11:12:25 +1100
Message-ID: <CAATStaMSFu=27LdxNOabtARGaRq7rm_k2BHSsZ9+M-fF+nnk7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Fix use after free in mmap with drm_gem_ttm_mmap
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, nartemiev@google.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any movement on merging this patch? Not urgent on my end (we have this
patch in our tree), but I think other amd users might run into this
UAF.

On Thu, 30 Sept 2021 at 17:21, Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 30.09.21 um 01:00 schrieb Anand K Mistry:
> > drm_gem_ttm_mmap() drops a reference to the gem object on success. If
> > the gem object's refcount =3D=3D 1 on entry to drm_gem_prime_mmap(), th=
at
> > drop will free the gem object, and the subsequent drm_gem_object_get()
> > will be a UAF. Fix by grabbing a reference before calling the mmap
> > helper.
> >
> > This issue was forseen when the reference dropping was adding in
> > commit 9786b65bc61ac ("drm/ttm: fix mmap refcounting"):
> >    "For that to work properly the drm_gem_object_get() call in
> >    drm_gem_ttm_mmap() must be moved so it happens before calling
> >    obj->funcs->mmap(), otherwise the gem refcount would go down
> >    to zero."
> >
> > Signed-off-by: Anand K Mistry <amistry@google.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> This looks fine to me, but it affects many drivers. Let's maybe wait a
> bit if more reviews come it.
>
> Best regards
> Thomas
>
> > ---
> >
> >   drivers/gpu/drm/drm_prime.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index 2a54f86856af..e1854fd24bb0 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -719,11 +719,13 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj=
, struct vm_area_struct *vma)
> >       if (obj->funcs && obj->funcs->mmap) {
> >               vma->vm_ops =3D obj->funcs->vm_ops;
> >
> > +             drm_gem_object_get(obj);
> >               ret =3D obj->funcs->mmap(obj, vma);
> > -             if (ret)
> > +             if (ret) {
> > +                     drm_gem_object_put(obj);
> >                       return ret;
> > +             }
> >               vma->vm_private_data =3D obj;
> > -             drm_gem_object_get(obj);
> >               return 0;
> >       }
> >
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

--=20
Anand K. Mistry
Software Engineer
Google Australia

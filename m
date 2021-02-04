Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49830F60A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhBDPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhBDPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:18:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDEC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:18:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so3955075wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpfJPe/1tU+7DzTf4KYc1pV9RSxza5H3pS4oizaxjuc=;
        b=HcCeGBGJsMKx9yLKPrbfI+qpmPRZoIkJQeDpi0L9B/qg48Sp9HqgwH4gNJpK0bECyq
         zk+eFwNrB0sB4xpAcFmrm++/3Fk1dfCl0mOyOPMG4vdT1nynBruqqtQCIzsMGQP14+aN
         fpa6ojnGDSvQaNthY/dZXaE3//+3Ry3GIwJpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lpfJPe/1tU+7DzTf4KYc1pV9RSxza5H3pS4oizaxjuc=;
        b=ijgviGkeyDM5O/w+KUFNI8y2o7Bdjbog1/dH9+BT4AbqTWDZ7PELhtRqQGNeci/9g1
         CrC2vkh97bf8gwtapn+Csg+8LV+7OdpWokYUGntKF8FuRMtsGyIEMnR3xzSG1aw3Qa19
         eAizRG/OZrSCjUItLY5nA9psAtfbC2j4IAWawcNGF3WtxqJVI4BmEiAmZOHZ65ft8El6
         iOJwfN/fE3dsO9o8apijVQeEHXCZtH1BeAcJ2/VO9/AGghXRovgYBFfky/NV20MWMGH6
         TPb+YZMMcIOdf/FC6lZ0xFsMAHqTvjRiln/obsV1l12fCYJUzMNUuT5p2UJm08wdsKme
         M5Tg==
X-Gm-Message-State: AOAM530ZA/PaLS0f2h8yDX7ysoJysR2WMU9vuztC9myKMqizHi/IS4/H
        gtT8mnSQR/XOabz4nZdJYwMJPA==
X-Google-Smtp-Source: ABdhPJyBIQIVsMcklYb+yXnw0qimDfJH83/YxKcR6iv94o3WNC66b1hbf14zmpSAbgwo++Gvnf8wLA==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr9836389wrm.392.1612451879310;
        Thu, 04 Feb 2021 07:17:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w15sm8097023wrp.15.2021.02.04.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:17:58 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:17:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/kms: Make a lock_class_key for each crtc mutex
Message-ID: <YBwQJPepkIS39Grc@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20210125234901.2730699-1-swboyd@chromium.org>
 <YBlz8Go2DseRWuOa@phenom.ffwll.local>
 <CAF6AEGuWhGuzxsBquj-WLSwa83r+zO7jAQ9ten2m+2KtoGpYSw@mail.gmail.com>
 <YBp2h2cVXrF6lBno@phenom.ffwll.local>
 <CAF6AEGvTrfYYTfReGbAm9zcBNhjZvX0tko4kZUeQcyNZv4cM6w@mail.gmail.com>
 <161238950899.76967.16385691346035591773@swboyd.mtv.corp.google.com>
 <CAF6AEGtFpjpYoY_iu8F2z-RMJ=0+tBYo-akKJ1JbgKagBuQWtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGtFpjpYoY_iu8F2z-RMJ=0+tBYo-akKJ1JbgKagBuQWtA@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:11:09PM -0800, Rob Clark wrote:
> On Wed, Feb 3, 2021 at 1:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rob Clark (2021-02-03 09:29:09)
> > > On Wed, Feb 3, 2021 at 2:10 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Tue, Feb 02, 2021 at 08:51:25AM -0800, Rob Clark wrote:
> > > > > On Tue, Feb 2, 2021 at 7:46 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > >
> > > > > > On Mon, Jan 25, 2021 at 03:49:01PM -0800, Stephen Boyd wrote:
> > > > > > > This is because lockdep thinks all the locks taken in lock_crtcs() are
> > > > > > > the same lock, when they actually aren't. That's because we call
> > > > > > > mutex_init() in msm_kms_init() and that assigns on static key for every
> > > > > > > lock initialized in this loop. Let's allocate a dynamic number of
> > > > > > > lock_class_keys and assign them to each lock so that lockdep can figure
> > > > > > > out an AA deadlock isn't possible here.
> > > > > > >
> > > > > > > Fixes: b3d91800d9ac ("drm/msm: Fix race condition in msm driver with async layer updates")
> > > > > > > Cc: Krishna Manikandan <mkrishn@codeaurora.org>
> > > > > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > > >
> > > > > > This smells like throwing more bad after initial bad code ...
> > > > > >
> > > > > > First a rant: https://blog.ffwll.ch/2020/08/lockdep-false-positives.html
> > > >
> > > > Some technical on the patch itself: I think you want
> > > > mutex_lock_nested(crtc->lock, drm_crtc_index(crtc)), not your own locking
> > > > classes hand-rolled. It's defacto the same, but much more obviously
> > > > correct since self-documenting.
> > >
> > > hmm, yeah, that is a bit cleaner.. but this patch is already on
> > > msm-next, maybe I'll add a patch on top to change it
> >
> > How many CRTCs are there? The subclass number tops out at 8, per
> > MAX_LOCKDEP_SUBCLASSES so if we have more than that many bits possible
> > then it will fail.

Hm good point, tbh the mutex_lock_nested annotations isn't super awesome
either, it would be kinda neat if we could put that annotation into
mutex_lock_init fairly statically (and at that point we could allos resize
the array fairly easily I think at runtime).

The nice thing with the nesting index is just that it makes it a bit more
obvious that there's a static nesting going on and why it's ok.
-Daniel

> conveniently MAX_CRTCS is 8.. realistically I don't *think* you'd ever
> see more than 2 or 3
> 
> BR,
> -R
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

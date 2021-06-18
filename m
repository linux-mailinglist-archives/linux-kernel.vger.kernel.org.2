Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA83AC728
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhFRJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhFRJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:15:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8262C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:13:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id k10-20020a056830168ab029044d922f6a45so672322otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naLHEsuCCs4Fcb1r5mYO3/AVmqvBmoebiHpV20smRWA=;
        b=GHd7IR2qJU3StSL8QB47NRhFSsRGnHy4mieFnZDwqtAklNf7YBRKDvm/IGy9KBjnS1
         eWpMhv4Sg51xeG4ZfRuiPbZXWh2KWgD/LetEgJ0ZwB8NBngmTRHyiGkntSfaHEZAMRwe
         sqzEQ6yR0Zn4RU38m44TBbeJhAdr2ERNYV3BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naLHEsuCCs4Fcb1r5mYO3/AVmqvBmoebiHpV20smRWA=;
        b=ekHrWUqCHjEueYAWHkeVMZ0deF9kpwAuHN1W+rSz9HCDpF8VPpkIG8jkWfmp8NwEaU
         Mr7oujmR1t/ierUEd4Ks8VrVUacEETK/Yo4so2dLs1JORPSQPy3+mbIaA5LHT/T1/swi
         BloDl1eB0lp8Oq9D9sTXgWLRSKG/CLW422U769paH5eYqMxMREp1HZSmhEUXRuHVK1Ek
         OdtpEUMewlR5njKdHm1M7qzS0m4otJLW3ItS61uKMK+3nt0Hv/2zl/NAKu/wT/M9Rk+D
         V4jBqy7PCn3Zn5c/Wkbns3yNTvVPdZySYzKcs63Cy0hw5uaC437JDjxZ4GVTkcUVJ91S
         U1ow==
X-Gm-Message-State: AOAM5335+eOrz7AN6MH4lXE/rVsXZzAIp5YTv1vZ+VgCnqphnRSA92vN
        cQC5rqyHkos4VMXfTWbTG3HO7qMy7GVAZdlQcgYzzQ==
X-Google-Smtp-Source: ABdhPJxgpitxyVtOLxsFHGCQMUCu/rZqASW5/KbUvmThXsKPZTwp9fwtH9L3/bRNWE5tLQeLoP0eBWfvljngPPaBFEo=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr8438414otb.281.1624007588286;
 Fri, 18 Jun 2021 02:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023645.6535-1-desmondcheongzx@gmail.com>
 <20210615023645.6535-3-desmondcheongzx@gmail.com> <YMuCYqLafn5sGcFo@phenom.ffwll.local>
 <c384d835-d910-5b04-e88c-a7878ce6d37d@gmail.com>
In-Reply-To: <c384d835-d910-5b04-e88c-a7878ce6d37d@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 18 Jun 2021 11:12:57 +0200
Message-ID: <CAKMK7uE-3S_vOm7DsqFyvHngSTwoc5ibzt46-9FcC550Qd9+jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: Protect drm_master pointers in drm_lease.c
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 5:05 AM Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
> On 18/6/21 1:12 am, Daniel Vetter wrote:
> > On Tue, Jun 15, 2021 at 10:36:45AM +0800, Desmond Cheong Zhi Xi wrote:
> >> This patch ensures that the device's master mutex is acquired before
> >> accessing pointers to struct drm_master that are subsequently
> >> dereferenced. Without the mutex, the struct drm_master may be freed
> >> concurrently by another process calling drm_setmaster_ioctl(). This
> >> could then lead to use-after-free errors.
> >>
> >> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> >> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> >> ---
> >>   drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
> >>   1 file changed, 43 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> >> index da4f085fc09e..3e6f689236e5 100644
> >> --- a/drivers/gpu/drm/drm_lease.c
> >> +++ b/drivers/gpu/drm/drm_lease.c
> >> @@ -107,10 +107,16 @@ static bool _drm_has_leased(struct drm_master *master, int id)
> >>    */
> >>   bool _drm_lease_held(struct drm_file *file_priv, int id)
> >>   {
> >> +    bool ret;
> >> +
> >>      if (!file_priv || !file_priv->master)
> >>              return true;
> >>
> >> -    return _drm_lease_held_master(file_priv->master, id);
> >> +    mutex_lock(&file_priv->master->dev->master_mutex);
> >
> > So maybe we have a bug somewhere, and the kerneldoc isn't 100% clear, but
> > I thought file_priv->master is invariant over the lifetime of file_priv.
> > So we don't need a lock to check anything here.
> >
> > It's the drm_device->master derefence that gets us into trouble. Well also
> > file_priv->is_owner is protected by dev->master_mutex.
> >
> > So I think with your previous patch all the access here in drm_lease.c is
> > ok and already protected? Or am I missing something?
> >
> > Thanks, Daniel
> >
>
> My thinking was that file_priv->master is invariant only if it is the
> creator of master. If file_priv->is_master is false, then a call to
> drm_setmaster_ioctl will invoke drm_new_set_master, which then allocates
> a new master for file_priv, and puts the old master.
>
> This could be an issue in _drm_lease_held_master, because we dereference
> master to get master->dev, master->lessor, and master->leases.
>
> With the same reasoning, in other parts of drm_lease.c, if there's an
> access to drm_file->master that's subsequently dereferenced, I added a
> lock around them.
>
> I could definitely be mistaken on this, so apologies if this scenario
> doesn't arise.

You're right, I totally missed that setmaster can create a new master
instance. And the kerneldoc for drm_file->master doesn't explain this
and mention that we must hold drm_device.master_mutex while looking at
that pointer. Can you pls do a patch which improves the documentation
for that?

Now for the patch itself I'm not entirely sure what we should do.
Leaking the dev->master_mutex into drm_lease.c just because of the
setmaster ioctl is kinda unsightly. And we don't really care about the
fpriv->master changing under us, we only need to make sure it doesn't
get freed. And drm_master is refcounted already.

So alternative solution: We add a drm_file_get_master() function which
calls drm_master_get under the lock, and we use that instead of
directly derefencing drm_file->master? Ofc then needs drm_master_put
instead of mutex_unlock. Kerneldoc should then also point at this new
function as the correct way to look at drm_file->master state.

This way it's 100% clear we're dealing with a lifetime issue and not a
consistency issues.

What do you think?
-Daniel


>
> Best wishes,
> Desmond
>
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

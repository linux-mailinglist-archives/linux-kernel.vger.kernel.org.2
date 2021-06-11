Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311573A3D15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhFKH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFKH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:29:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B224C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:27:04 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso2255582oto.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef52vRx74fc5UCfQHCig8+5esV/3pCK5+NiUbiLHnvQ=;
        b=Y8ThRrG17JeXYR82682Is0eVQuuGT56zmi/UILuLbklbnOVQnRJ1XIFjtxrdreVOaF
         GKaqSSnp7EA3r+zs6//WcDeAM/4EyuYJhcPtU5c8VEUluGgfIZNKeJJQBqWrcKIRyRXr
         OM0MezCo/yFyiRRiG1Zkhf1jxbtS+PdNwVLn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef52vRx74fc5UCfQHCig8+5esV/3pCK5+NiUbiLHnvQ=;
        b=DkYkRUavDa+7R1FM/cH3kXOsvhvqVFJs9mWVxz1K9i3A8vWiABXFFS1j/17b3YQO4x
         HSGLh+YxBRRD9lq8E6LFxhPLfMA4WeRShGy7bfIcboktJokW7abIBwMqwJaW6ol2O8Jx
         rq7mxjy+ElXGS/gVbFd3d9rdKsEPUbF5Hx7YLVQBMMck5xJPtySrbre+o3rGtklKX4CI
         DhU5I1ay3XDzOvA76H16TqHmLW/NSuGQQCvkVABwN53VISerDD6cERBcOTKMmfXSVVPK
         AA3yAViYef5f9VQj9Yi2MtPB7ipMv3fZr/XJK45ud631wCVW1EPP55dhjdoHLqLT8fyz
         jnEw==
X-Gm-Message-State: AOAM530CEoqMFoi9PwDSoXR7Fre4W0d6h3ePkzCYapwc1wHqP2mK288D
        JfAYKRRAFaje7Vg4FmMzHUF44Y1XHc8QTle3S1tOuw==
X-Google-Smtp-Source: ABdhPJz3IOQqQF+lRvx53nYLgYJH0he5j+6eXuQM7b70P1oLbyxSfT5qUOpvpqgUteIugcKijfjghWgWanPrcPLy+6E=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr1933399otb.281.1623396423931;
 Fri, 11 Jun 2021 00:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210609092119.173590-1-desmondcheongzx@gmail.com>
 <YMHlLQHRLWgWlXTs@phenom.ffwll.local> <f16f4123-bd0b-f09c-ddf1-7197c841b588@gmail.com>
 <YMJCdG7k5sNaiHen@phenom.ffwll.local> <d8150fdb-3a59-e491-f148-1c528fe3c824@gmail.com>
In-Reply-To: <d8150fdb-3a59-e491-f148-1c528fe3c824@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 11 Jun 2021 09:26:52 +0200
Message-ID: <CAKMK7uEAs0ZJiN_x0Od03yiLuh38=x8vNqv=b3Zr7BMy+Fbr1w@mail.gmail.com>
Subject: Re: [PATCH] drm: Lock pointer access in drm_master_release()
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
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 4:18 AM Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
 On 11/6/21 12:48 am, Daniel Vetter wrote:
> > On Thu, Jun 10, 2021 at 11:21:39PM +0800, Desmond Cheong Zhi Xi wrote:
> >> On 10/6/21 6:10 pm, Daniel Vetter wrote:
> >>> On Wed, Jun 09, 2021 at 05:21:19PM +0800, Desmond Cheong Zhi Xi wrote:
> >>>> This patch eliminates the following smatch warning:
> >>>> drivers/gpu/drm/drm_auth.c:320 drm_master_release() warn: unlocked access 'master' (line 318) expected lock '&dev->master_mutex'
> >>>>
> >>>> The 'file_priv->master' field should be protected by the mutex lock to
> >>>> '&dev->master_mutex'. This is because other processes can concurrently
> >>>> modify this field and free the current 'file_priv->master'
> >>>> pointer. This could result in a use-after-free error when 'master' is
> >>>> dereferenced in subsequent function calls to
> >>>> 'drm_legacy_lock_master_cleanup()' or to 'drm_lease_revoke()'.
> >>>>
> >>>> An example of a scenario that would produce this error can be seen
> >>>> from a similar bug in 'drm_getunique()' that was reported by Syzbot:
> >>>> https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803
> >>>>
> >>>> In the Syzbot report, another process concurrently acquired the
> >>>> device's master mutex in 'drm_setmaster_ioctl()', then overwrote
> >>>> 'fpriv->master' in 'drm_new_set_master()'. The old value of
> >>>> 'fpriv->master' was subsequently freed before the mutex was unlocked.
> >>>>
> >>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> >>>
> >>> Thanks a lot. I've done an audit of this code, and I found another
> >>> potential problem in drm_is_current_master. The callers from drm_auth.c
> >>> hold the dev->master_mutex, but all the external ones dont. I think we
> >>> need to split this into a _locked function for use within drm_auth.c, and
> >>> the exported one needs to grab the dev->master_mutex while it's checking
> >>> master status. Ofc there will still be races, those are ok, but right now
> >>> we run the risk of use-after free problems in drm_lease_owner.
> >>>
> >>> Are you up to do that fix too?
> >>>
> >>
> >> Hi Daniel,
> >>
> >> Thanks for the pointer, I'm definitely up for it!
> >>
> >>> I think the drm_lease.c code also needs an audit, there we'd need to make
> >>> sure that we hold hold either the lock or a full master reference to avoid
> >>> the use-after-free issues here.
> >>>
> >>
> >> I'd be happy to look into drm_lease.c as well.
> >>
> >>> Patch merged to drm-misc-fixes with cc: stable.
> >>> -Daniel
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/drm_auth.c | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> >>>> index f00e5abdbbf4..b59b26a71ad5 100644
> >>>> --- a/drivers/gpu/drm/drm_auth.c
> >>>> +++ b/drivers/gpu/drm/drm_auth.c
> >>>> @@ -315,9 +315,10 @@ int drm_master_open(struct drm_file *file_priv)
> >>>>    void drm_master_release(struct drm_file *file_priv)
> >>>>    {
> >>>>            struct drm_device *dev = file_priv->minor->dev;
> >>>> -  struct drm_master *master = file_priv->master;
> >>>> +  struct drm_master *master;
> >>>>
> >>>>            mutex_lock(&dev->master_mutex);
> >>>> +  master = file_priv->master;
> >>>>            if (file_priv->magic)
> >>>>                    idr_remove(&file_priv->master->magic_map, file_priv->magic);
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>
> >>
> >>  From what I can see, there are other places in the kernel that could use the
> >> _locked version of drm_is_current_master as well, such as drm_mode_getfb in
> >> drm_framebuffer.c. I'll take a closer look, and if the changes make sense
> >> I'll prepare a patch series for them.
> >
> > Oh maybe we have a naming confusion: the _locked is the one where the
> > caller must grab the lock already, whereas drm_is_current_master would
> > grab the master_mutex internally to do the check. The one in
> > drm_framebuffer.c looks like it'd need the internal one since there's no
> > other need to grab the master_mutex.
> > -Daniel
> >
>
> Ah ok got it, I think I confused myself earlier.
>
> Just to check, may I include you in a Reported-by: tag?

Sure.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

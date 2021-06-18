Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4F3AD496
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhFRVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:52:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCAEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:49:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d19so12101593oic.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HftXY5HZKwK0KDmrBsoMx+gpdQ5siROESOKP5dy/F8=;
        b=E5olw9SNmfZevEbrfodkTk+8lQ8FK9yhuIepr6RmTNMNS7E/5JPaqHsWjJwljb/7co
         wjYovRqsciFEBTwBolV2xyNw5YM4FDKM8ubtqaGgcfizb7PcKO3xu4CrXDvMhJVW2hCw
         T7rR7MbxN2++yz8pOf+/WOx1KgNeQIEW0F/bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HftXY5HZKwK0KDmrBsoMx+gpdQ5siROESOKP5dy/F8=;
        b=KOXL4pPr38vgGnvJKooeVMIde3lVtGMrk6XCfHWwE9sb6v0BnDjVwSNlGhUmnh+n5w
         fKTWURH1jglCm23mQ8k23LB1AbB9sY8OevCDQ/cCeoMN5McpATdNivspFFz828xscalQ
         ajwbaJ1bqPziK6kIZrQtWIyR+03AU9J9OYmBPNkmkEnIDr8701keB5GLOu8V+4s05Xao
         pA2wQg6IpETXt0WUtims+HGYQyW2UY0EIs/CGGSjMbJxBBIpSA0aDJukAjkLwYEyKojG
         BECpB8Gr+KUThv0ZWjKPrj6PMooxJwagRFct6SLFM6d6MFW8UbXwtKkzsMvCjjN8rzm7
         v80g==
X-Gm-Message-State: AOAM530FGK0poU76bxs2o5gN3HnT/6riG+yBRZyeymITQbiM1kIf4y+a
        00Zsf/SVpNffJOJvxt3+NRs3Wp50MF8VKJhy3pvODw==
X-Google-Smtp-Source: ABdhPJwKO5vg9+uabQtIu/70bMMPgrZlz4a83uLAcEPA/chF0LOMNhAfoDdvjtPr7xyUaHQEQ4CfnCCKrYrBx3IsfHU=
X-Received: by 2002:aca:530f:: with SMTP id h15mr9047358oib.128.1624052994077;
 Fri, 18 Jun 2021 14:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023645.6535-1-desmondcheongzx@gmail.com>
 <20210615023645.6535-3-desmondcheongzx@gmail.com> <YMuCYqLafn5sGcFo@phenom.ffwll.local>
 <c384d835-d910-5b04-e88c-a7878ce6d37d@gmail.com> <CAKMK7uE-3S_vOm7DsqFyvHngSTwoc5ibzt46-9FcC550Qd9+jw@mail.gmail.com>
 <a43b752e-e823-01ea-9902-1c5e173aa6bf@gmail.com>
In-Reply-To: <a43b752e-e823-01ea-9902-1c5e173aa6bf@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 18 Jun 2021 23:49:43 +0200
Message-ID: <CAKMK7uEdoLUc5HAXR3Bvdj1yp=ooEr-0cEuHrBX6uKXJXjPcxw@mail.gmail.com>
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

On Fri, Jun 18, 2021 at 6:54 PM Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
>
> On 18/6/21 5:12 pm, Daniel Vetter wrote:
> > On Fri, Jun 18, 2021 at 5:05 AM Desmond Cheong Zhi Xi
> > <desmondcheongzx@gmail.com> wrote:
> >> On 18/6/21 1:12 am, Daniel Vetter wrote:
> >>> On Tue, Jun 15, 2021 at 10:36:45AM +0800, Desmond Cheong Zhi Xi wrote:
> >>>> This patch ensures that the device's master mutex is acquired before
> >>>> accessing pointers to struct drm_master that are subsequently
> >>>> dereferenced. Without the mutex, the struct drm_master may be freed
> >>>> concurrently by another process calling drm_setmaster_ioctl(). This
> >>>> could then lead to use-after-free errors.
> >>>>
> >>>> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >>>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> >>>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> >>>> ---
> >>>>    drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
> >>>>    1 file changed, 43 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> >>>> index da4f085fc09e..3e6f689236e5 100644
> >>>> --- a/drivers/gpu/drm/drm_lease.c
> >>>> +++ b/drivers/gpu/drm/drm_lease.c
> >>>> @@ -107,10 +107,16 @@ static bool _drm_has_leased(struct drm_master *master, int id)
> >>>>     */
> >>>>    bool _drm_lease_held(struct drm_file *file_priv, int id)
> >>>>    {
> >>>> +    bool ret;
> >>>> +
> >>>>       if (!file_priv || !file_priv->master)
> >>>>               return true;
> >>>>
> >>>> -    return _drm_lease_held_master(file_priv->master, id);
> >>>> +    mutex_lock(&file_priv->master->dev->master_mutex);
> >>>
> >>> So maybe we have a bug somewhere, and the kerneldoc isn't 100% clear, but
> >>> I thought file_priv->master is invariant over the lifetime of file_priv.
> >>> So we don't need a lock to check anything here.
> >>>
> >>> It's the drm_device->master derefence that gets us into trouble. Well also
> >>> file_priv->is_owner is protected by dev->master_mutex.
> >>>
> >>> So I think with your previous patch all the access here in drm_lease.c is
> >>> ok and already protected? Or am I missing something?
> >>>
> >>> Thanks, Daniel
> >>>
> >>
> >> My thinking was that file_priv->master is invariant only if it is the
> >> creator of master. If file_priv->is_master is false, then a call to
> >> drm_setmaster_ioctl will invoke drm_new_set_master, which then allocates
> >> a new master for file_priv, and puts the old master.
> >>
> >> This could be an issue in _drm_lease_held_master, because we dereference
> >> master to get master->dev, master->lessor, and master->leases.
> >>
> >> With the same reasoning, in other parts of drm_lease.c, if there's an
> >> access to drm_file->master that's subsequently dereferenced, I added a
> >> lock around them.
> >>
> >> I could definitely be mistaken on this, so apologies if this scenario
> >> doesn't arise.
> >
> > You're right, I totally missed that setmaster can create a new master
> > instance. And the kerneldoc for drm_file->master doesn't explain this
> > and mention that we must hold drm_device.master_mutex while looking at
> > that pointer. Can you pls do a patch which improves the documentation
> > for that?
> >
>
> Sounds good, I'll add it to the patch series.
>
> > Now for the patch itself I'm not entirely sure what we should do.
> > Leaking the dev->master_mutex into drm_lease.c just because of the
> > setmaster ioctl is kinda unsightly. And we don't really care about the
> > fpriv->master changing under us, we only need to make sure it doesn't
> > get freed. And drm_master is refcounted already.
> >
> > So alternative solution: We add a drm_file_get_master() function which
> > calls drm_master_get under the lock, and we use that instead of
> > directly derefencing drm_file->master? Ofc then needs drm_master_put
> > instead of mutex_unlock. Kerneldoc should then also point at this new
> > function as the correct way to look at drm_file->master state.
> >
> > This way it's 100% clear we're dealing with a lifetime issue and not a
> > consistency issues.
> >
> > What do you think?
> > -Daniel
> >
>
> Makes sense to me, since the drm master itself holds the lease, as long
> as it isn't freed while we're using it, there's no need to prevent the
> value of fpriv->master from changing after we access it in drm_lease.c.
>
> I was going to say that it may be unclear when to use the
>
>         master = drm_file_get_master(file_priv);
>         ...
>         drm_master_put(&master);
>
> pattern, versus when to use
>
>         mutex_lock(&dev->master_mutex);
>         master = file_priv->master;
>         ...
>         mutex_unlock(&dev->master_mutex);
>
> . The second pattern, for example, is used in drm_getunique, and also in
> drm_setversion which calls drm_set_busid.
>
> But on closer inspection, it's clearer to me now that those functions
> need the master_mutex because they access protected fields such as
> unique and unique_len.
>
> Would it then be correct to state in the kerneldoc that
> drm_file_get_master() should be used to look at drm_file->master only if
> we aren't already holding master_mutex + have no other need to grab
> master_mutex?

Yeah that's sounds like a good decider for which variant to pick.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

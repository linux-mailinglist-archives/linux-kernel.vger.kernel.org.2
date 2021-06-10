Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB783A3159
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFJQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:51:54 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46642 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhFJQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:51:52 -0400
Received: by mail-wr1-f45.google.com with SMTP id a11so3070716wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Va0amXVpbOJYAdcXM2qj5nU9Tu9UczfM1jakTq/wmdg=;
        b=FyfMFTyYNn6kzp1mOKyvxeIHW7+zNDTMt9LT+2mQjekJebzJvlPSU1rhnFEIcvuZxx
         qtOqbwl8ew2XrQQUnPjEBcEwKGuqSEjeCxk9niJH5oO3IgynvvkpsDES13fSJo4zgnC7
         YK8a0hzM5M/sRRzXENNS36PWnn0WzFtfTRi9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Va0amXVpbOJYAdcXM2qj5nU9Tu9UczfM1jakTq/wmdg=;
        b=VWFFwWPH2wExSGr815Po95h6uKpj4yPE8rfe6hOff4U7BWeh2csNwyVACQeMKDrTXJ
         qvdQI8avbvc6xtCU2YDjFbOQNw9o2ko6uxSaby3oPNblMunuRyvfAOn6s9/P7xT7Ei3c
         1lFENkwToEwOgq97kN+J6iD38X/lvoqcHybKjDJTriznWm0tKK1JB+8qwaomOsOchs+V
         sVpGXyr/ON1Bc039L+rKqzhioi5Olvyw/3Ek7kBwcVfxgbRqvWxUeBfbLgj3GRmfo/GT
         Px7LyA1U1vyQtFZRliel+mXCZFpkj2MmNYNaH/L1sS78Asdukv9jC8VyyfFA2B+CGakt
         nFeA==
X-Gm-Message-State: AOAM532SZKFyPjM+WOPErQZIFFRM2DPTkcjQ6AO6mH0jyUfgjcecSA/2
        rVypdQYg7ILm8XX2WSRv3EXs2Q==
X-Google-Smtp-Source: ABdhPJwKUd+3xHMQQumAoTuOuRiDExJUPLezgyBaaYn3NvQs12ckjvG7Xo578Rk9Mrz+3+WPv44Yfg==
X-Received: by 2002:a5d:4538:: with SMTP id j24mr6513899wra.391.1623343735014;
        Thu, 10 Jun 2021 09:48:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a10sm2313774wrr.48.2021.06.10.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:48:54 -0700 (PDT)
Date:   Thu, 10 Jun 2021 18:48:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm: Lock pointer access in drm_master_release()
Message-ID: <YMJCdG7k5sNaiHen@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210609092119.173590-1-desmondcheongzx@gmail.com>
 <YMHlLQHRLWgWlXTs@phenom.ffwll.local>
 <f16f4123-bd0b-f09c-ddf1-7197c841b588@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16f4123-bd0b-f09c-ddf1-7197c841b588@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:21:39PM +0800, Desmond Cheong Zhi Xi wrote:
> On 10/6/21 6:10 pm, Daniel Vetter wrote:
> > On Wed, Jun 09, 2021 at 05:21:19PM +0800, Desmond Cheong Zhi Xi wrote:
> > > This patch eliminates the following smatch warning:
> > > drivers/gpu/drm/drm_auth.c:320 drm_master_release() warn: unlocked access 'master' (line 318) expected lock '&dev->master_mutex'
> > > 
> > > The 'file_priv->master' field should be protected by the mutex lock to
> > > '&dev->master_mutex'. This is because other processes can concurrently
> > > modify this field and free the current 'file_priv->master'
> > > pointer. This could result in a use-after-free error when 'master' is
> > > dereferenced in subsequent function calls to
> > > 'drm_legacy_lock_master_cleanup()' or to 'drm_lease_revoke()'.
> > > 
> > > An example of a scenario that would produce this error can be seen
> > > from a similar bug in 'drm_getunique()' that was reported by Syzbot:
> > > https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803
> > > 
> > > In the Syzbot report, another process concurrently acquired the
> > > device's master mutex in 'drm_setmaster_ioctl()', then overwrote
> > > 'fpriv->master' in 'drm_new_set_master()'. The old value of
> > > 'fpriv->master' was subsequently freed before the mutex was unlocked.
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > 
> > Thanks a lot. I've done an audit of this code, and I found another
> > potential problem in drm_is_current_master. The callers from drm_auth.c
> > hold the dev->master_mutex, but all the external ones dont. I think we
> > need to split this into a _locked function for use within drm_auth.c, and
> > the exported one needs to grab the dev->master_mutex while it's checking
> > master status. Ofc there will still be races, those are ok, but right now
> > we run the risk of use-after free problems in drm_lease_owner.
> > 
> > Are you up to do that fix too?
> > 
> 
> Hi Daniel,
> 
> Thanks for the pointer, I'm definitely up for it!
> 
> > I think the drm_lease.c code also needs an audit, there we'd need to make
> > sure that we hold hold either the lock or a full master reference to avoid
> > the use-after-free issues here.
> > 
> 
> I'd be happy to look into drm_lease.c as well.
> 
> > Patch merged to drm-misc-fixes with cc: stable.
> > -Daniel
> > 
> > > ---
> > >   drivers/gpu/drm/drm_auth.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> > > index f00e5abdbbf4..b59b26a71ad5 100644
> > > --- a/drivers/gpu/drm/drm_auth.c
> > > +++ b/drivers/gpu/drm/drm_auth.c
> > > @@ -315,9 +315,10 @@ int drm_master_open(struct drm_file *file_priv)
> > >   void drm_master_release(struct drm_file *file_priv)
> > >   {
> > >   	struct drm_device *dev = file_priv->minor->dev;
> > > -	struct drm_master *master = file_priv->master;
> > > +	struct drm_master *master;
> > > 
> > >   	mutex_lock(&dev->master_mutex);
> > > +	master = file_priv->master;
> > >   	if (file_priv->magic)
> > >   		idr_remove(&file_priv->master->magic_map, file_priv->magic);
> > > -- 
> > > 2.25.1
> > > 
> > 
> 
> From what I can see, there are other places in the kernel that could use the
> _locked version of drm_is_current_master as well, such as drm_mode_getfb in
> drm_framebuffer.c. I'll take a closer look, and if the changes make sense
> I'll prepare a patch series for them.

Oh maybe we have a naming confusion: the _locked is the one where the
caller must grab the lock already, whereas drm_is_current_master would
grab the master_mutex internally to do the check. The one in
drm_framebuffer.c looks like it'd need the internal one since there's no
other need to grab the master_mutex.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

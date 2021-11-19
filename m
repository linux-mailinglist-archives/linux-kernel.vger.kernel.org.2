Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB3456D57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhKSKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbhKSKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:33:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C94C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:30:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so40726072edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=carminywHVkfCA+4NFBY21DE5JrCWEMoTBTfqat9eKo=;
        b=JqTXLWoxo1pt0SAgax4z8lSGfacM06j1bbOo6BXYZWxREyW4PtseemiDrziHWIYDLW
         n+8QuoaNkc7kMmxv9iXIr04af3CgxEX4JuYVT5UyEhA4Sia9127m2bRpxUeMU/XXWFgf
         QsfGhDRetZT5zOt/8sjx1a6wPXY7DyI+MUQoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=carminywHVkfCA+4NFBY21DE5JrCWEMoTBTfqat9eKo=;
        b=O9FgdeloJNMIw0RTAc5oqhpQrQBHtr+dWyYSPuAdXQK07G8jAVsqDMra4BXXgOVYwP
         7rNqMJaSQAeWbq0hFzaka9XPmQfFwBbx+PMP2Uh5eT+8Akkn8b1hStSQztC4RomgWndj
         Am1ONA+rR6FlDZgESwy4yrtDcvRdMsmEPWZtV5ej7ZbEen1klzztsqbiyr+Xi0snLt0T
         NoFTYEImeZ3XujQaKJrE0fn2Z+Vmf3jyVoMoY0w6gGNR1NMW2EEe6m/dPIXlU8ExkELO
         z+3SvUKD8mwu2jZ88/pBD4SOJoxtRMQGJw48io8gH/BjFEKy1VluPAaxENDtE2WHEgrA
         FtGQ==
X-Gm-Message-State: AOAM5331o/tRJn6GGOkS8ESEdPSy0/IDsT+ZiBpP2mBee8G/EUcbh4S3
        16EyCtsY+csvlG4yJCl2g14ncQ==
X-Google-Smtp-Source: ABdhPJxW3RqitM6BIFpy4p8RffcLsHT+hwVTb5ABQGC5XemUNLnMWWDLgyhFpXWCLoZreYYGO99w0w==
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr6309596ejc.270.1637317817093;
        Fri, 19 Nov 2021 02:30:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f22sm617738edf.93.2021.11.19.02.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:30:16 -0800 (PST)
Date:   Fri, 19 Nov 2021 11:30:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: check drm_format_info hsub and vsub to avoid divide
 by zero
Message-ID: <YZd8tpDN9lsq0ZbZ@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1635429437-21718-1-git-send-email-george.kennedy@oracle.com>
 <YXqt46TPL9tUZCL1@intel.com>
 <YZdxFvGkBPXrtoQ7@phenom.ffwll.local>
 <YZd2VI820CUGrMjv@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZd2VI820CUGrMjv@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 12:03:00PM +0200, Ville Syrjälä wrote:
> On Fri, Nov 19, 2021 at 10:40:38AM +0100, Daniel Vetter wrote:
> > On Thu, Oct 28, 2021 at 05:04:19PM +0300, Ville Syrjälä wrote:
> > > On Thu, Oct 28, 2021 at 08:57:17AM -0500, George Kennedy wrote:
> > > > Do a sanity check on struct drm_format_info hsub and vsub values to
> > > > avoid divide by zero.
> > > > 
> > > > Syzkaller reported a divide error in framebuffer_check() when the
> > > > DRM_FORMAT_Q410 or DRM_FORMAT_Q401 pixel_format is passed in via
> > > > the DRM_IOCTL_MODE_ADDFB2 ioctl. The drm_format_info struct for
> > > > the DRM_FORMAT_Q410 pixel_pattern has ".hsub = 0" and ".vsub = 0".
> > > > fb_plane_width() uses hsub as a divisor and fb_plane_height() uses
> > > > vsub as a divisor. These divisors need to be sanity checked for
> > > > zero before use.
> > > > 
> > > > divide error: 0000 [#1] SMP KASAN NOPTI
> > > > CPU: 0 PID: 14995 Comm: syz-executor709 Not tainted 5.15.0-rc6-syzk #1
> > > > Hardware name: Red Hat KVM, BIOS 1.13.0-2
> > > > RIP: 0010:framebuffer_check drivers/gpu/drm/drm_framebuffer.c:199 [inline]
> > > > RIP: 0010:drm_internal_framebuffer_create+0x604/0xf90
> > > > drivers/gpu/drm/drm_framebuffer.c:317
> > > > 
> > > > Call Trace:
> > > >  drm_mode_addfb2+0xdc/0x320 drivers/gpu/drm/drm_framebuffer.c:355
> > > >  drm_mode_addfb2_ioctl+0x2a/0x40 drivers/gpu/drm/drm_framebuffer.c:391
> > > >  drm_ioctl_kernel+0x23a/0x2e0 drivers/gpu/drm/drm_ioctl.c:795
> > > >  drm_ioctl+0x589/0xac0 drivers/gpu/drm/drm_ioctl.c:898
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> > > >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> > > >  __x64_sys_ioctl+0x19d/0x220 fs/ioctl.c:860
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > 
> > > > Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_framebuffer.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> > > > index 07f5abc..a146e4b 100644
> > > > --- a/drivers/gpu/drm/drm_framebuffer.c
> > > > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > > > @@ -195,6 +195,16 @@ static int framebuffer_check(struct drm_device *dev,
> > > >  	/* now let the driver pick its own format info */
> > > >  	info = drm_get_format_info(dev, r);
> > > >  
> > > > +	if (info->hsub == 0) {
> > > > +		DRM_DEBUG_KMS("bad horizontal chroma subsampling factor %u\n", info->hsub);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (info->vsub == 0) {
> > > > +		DRM_DEBUG_KMS("bad vertical chroma subsampling factor %u\n", info->vsub);
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > Looks like duct tape to me. I think we need to either fix those formats
> > > to have valid format info, or just revert the whole patch that added such
> > > broken things.
> > 
> > Yeah maybe even a compile-time check of the format table(s) to validate
> > them properly and scream ... Or at least a selftest.
> 
> I really wish C had (even very limited) compile time evaluation
> so one could actually loop over arrays like at compile time to 
> check each element. As it stands you either have to check each
> array element by hand, or you do some cpp macro horrors to 
> pretend you're iterating the array.

Python preprocess or so seems to be the usual answer, and that then just
generates the C table after it's all checked.

Or a post-processor which fishes the table out from the .o (or just links
against it).

But yeah doing this in cpp isn't going to work, aside from it'd be really
ugly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A29456CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhKSKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:06:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:51011 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234088AbhKSKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:06:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221608161"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="221608161"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 02:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="647109761"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2021 02:03:01 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 19 Nov 2021 12:03:00 +0200
Date:   Fri, 19 Nov 2021 12:03:00 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: check drm_format_info hsub and vsub to avoid divide
 by zero
Message-ID: <YZd2VI820CUGrMjv@intel.com>
References: <1635429437-21718-1-git-send-email-george.kennedy@oracle.com>
 <YXqt46TPL9tUZCL1@intel.com>
 <YZdxFvGkBPXrtoQ7@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZdxFvGkBPXrtoQ7@phenom.ffwll.local>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:40:38AM +0100, Daniel Vetter wrote:
> On Thu, Oct 28, 2021 at 05:04:19PM +0300, Ville Syrjälä wrote:
> > On Thu, Oct 28, 2021 at 08:57:17AM -0500, George Kennedy wrote:
> > > Do a sanity check on struct drm_format_info hsub and vsub values to
> > > avoid divide by zero.
> > > 
> > > Syzkaller reported a divide error in framebuffer_check() when the
> > > DRM_FORMAT_Q410 or DRM_FORMAT_Q401 pixel_format is passed in via
> > > the DRM_IOCTL_MODE_ADDFB2 ioctl. The drm_format_info struct for
> > > the DRM_FORMAT_Q410 pixel_pattern has ".hsub = 0" and ".vsub = 0".
> > > fb_plane_width() uses hsub as a divisor and fb_plane_height() uses
> > > vsub as a divisor. These divisors need to be sanity checked for
> > > zero before use.
> > > 
> > > divide error: 0000 [#1] SMP KASAN NOPTI
> > > CPU: 0 PID: 14995 Comm: syz-executor709 Not tainted 5.15.0-rc6-syzk #1
> > > Hardware name: Red Hat KVM, BIOS 1.13.0-2
> > > RIP: 0010:framebuffer_check drivers/gpu/drm/drm_framebuffer.c:199 [inline]
> > > RIP: 0010:drm_internal_framebuffer_create+0x604/0xf90
> > > drivers/gpu/drm/drm_framebuffer.c:317
> > > 
> > > Call Trace:
> > >  drm_mode_addfb2+0xdc/0x320 drivers/gpu/drm/drm_framebuffer.c:355
> > >  drm_mode_addfb2_ioctl+0x2a/0x40 drivers/gpu/drm/drm_framebuffer.c:391
> > >  drm_ioctl_kernel+0x23a/0x2e0 drivers/gpu/drm/drm_ioctl.c:795
> > >  drm_ioctl+0x589/0xac0 drivers/gpu/drm/drm_ioctl.c:898
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> > >  __x64_sys_ioctl+0x19d/0x220 fs/ioctl.c:860
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> > > ---
> > >  drivers/gpu/drm/drm_framebuffer.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> > > index 07f5abc..a146e4b 100644
> > > --- a/drivers/gpu/drm/drm_framebuffer.c
> > > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > > @@ -195,6 +195,16 @@ static int framebuffer_check(struct drm_device *dev,
> > >  	/* now let the driver pick its own format info */
> > >  	info = drm_get_format_info(dev, r);
> > >  
> > > +	if (info->hsub == 0) {
> > > +		DRM_DEBUG_KMS("bad horizontal chroma subsampling factor %u\n", info->hsub);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (info->vsub == 0) {
> > > +		DRM_DEBUG_KMS("bad vertical chroma subsampling factor %u\n", info->vsub);
> > > +		return -EINVAL;
> > > +	}
> > 
> > Looks like duct tape to me. I think we need to either fix those formats
> > to have valid format info, or just revert the whole patch that added such
> > broken things.
> 
> Yeah maybe even a compile-time check of the format table(s) to validate
> them properly and scream ... Or at least a selftest.

I really wish C had (even very limited) compile time evaluation
so one could actually loop over arrays like at compile time to 
check each element. As it stands you either have to check each
array element by hand, or you do some cpp macro horrors to 
pretend you're iterating the array.

-- 
Ville Syrjälä
Intel

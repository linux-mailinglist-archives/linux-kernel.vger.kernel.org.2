Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824E42686C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhJHLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:04:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:48667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239954AbhJHLEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:04:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213432329"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="213432329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 04:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="489419871"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga008.jf.intel.com with SMTP; 08 Oct 2021 04:02:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 08 Oct 2021 14:02:40 +0300
Date:   Fri, 8 Oct 2021 14:02:40 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/fb-helper: improve DRM fbdev emulation
 device names"
Message-ID: <YWAlUBoMlerOGJEV@intel.com>
References: <20211008071708.1954041-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008071708.1954041-1-javierm@redhat.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:17:08AM +0200, Javier Martinez Canillas wrote:
> This reverts commit b3484d2b03e4c940a9598aa841a52d69729c582a.
> 
> That change attempted to improve the DRM drivers fbdev emulation device
> names to avoid having confusing names like "simpledrmdrmfb" in /proc/fb.
> 
> But unfortunately there are user-space programs, such as pm-utils that
> query that information and so broke after the mentioned commit. Since
> the names in /proc/fb are used programs that consider it an ABI, let's
> restore the old names even when this lead to silly naming like the one
> mentioned above as an example.

The usage Johannes listed was this specificially:
 using_kms() { grep -q -E '(nouveau|drm)fb' /proc/fb; }                                                        

So it actually looks like  Daniel's
commit f243dd06180a ("drm/nouveau: Use drm_fb_helper_fill_info")
also broke the abi. But for the pm-utils use case at least
just having the "drmfb" in there should cover even nouveau.

Cc: stable@vger.kernel.org
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> Reported-by: Johannes Stezenbach <js@sig21.net>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 3ab07832104..8993b02e783 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
>  			       sizes->fb_width, sizes->fb_height);
>  
>  	info->par = fb_helper;
> -	snprintf(info->fix.id, sizeof(info->fix.id), "%s",
> +	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
>  		 fb_helper->dev->driver->name);
>  
>  }
> -- 
> 2.31.1

-- 
Ville Syrjälä
Intel

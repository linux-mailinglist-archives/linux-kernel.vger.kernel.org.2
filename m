Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FE42BFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhJMM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJMM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:29:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885AEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:27:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so7670923wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z4fOeWoNGe7oIdEUiKQM52q9RkPtgbU73XW1me6uvfI=;
        b=cFlFkDQVisrjJ0gmIjial9F8G9xdYVR6VW7z23cXGkeQaIRZ7DDJCUozWDnHhwTgdq
         VaoSyyj+mBWC1vX1pq2dpOK57tJuyKAv4pECsQh2WDNu+KOxVjM/B4KL47tg+yIkME+S
         vX79oyE/SpY15pAPmYiHT3nvGZhTuPB+dMvq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Z4fOeWoNGe7oIdEUiKQM52q9RkPtgbU73XW1me6uvfI=;
        b=cE+h/mEkyfg89CaYJFtjxw6Xu8hpw6nm2FmTiHzuJspMbQcgZBI59KYJofk+J5o7An
         JQw4cK0KU+geY6oP0qz4kh1xsgC0/RKhYnIaQBjB/7x/J5//dSbfiV10TUMdp8eqQ6l3
         vjDV0ws8ozAaw3+gaB31FJO99YhGGhgZXtb9TmgvGj6Ly8lEByiysi/3in3G7qPdJdxe
         PKDNWXfOVOYiZJmc83+RfG6pvPlwt27+9lcJPepBDdDAJB2wCv+tyT0bWDVdB9HL0F2V
         stRBLuYBKuDzwkMipRcxkR3iCxhtSj8yZ0sb7PRJ9ZQCi0W79IYGlkPjNV5cA122mUuZ
         9ybw==
X-Gm-Message-State: AOAM532/qaOq8Ej9HR3E9WWD4Df5PQKsDwzyZXZx+De9nRbOEXjE9D25
        /lwUFV+x4+k3c4tlPpBaUPrmeg==
X-Google-Smtp-Source: ABdhPJxLUAeVYVXqPDEDTDBfMn5AXMi7rqYAet0Wff3glrqg6tTfr+eDMzXKMGLBamxjUg3QJ4nQhQ==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr38590051wrc.30.1634128046809;
        Wed, 13 Oct 2021 05:27:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e9sm5223682wme.37.2021.10.13.05.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:27:26 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:27:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/fb-helper: improve DRM fbdev emulation
 device names"
Message-ID: <YWbQrP9blDndQV2F@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org
References: <20211008071708.1954041-1-javierm@redhat.com>
 <YWAlUBoMlerOGJEV@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWAlUBoMlerOGJEV@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 02:02:40PM +0300, Ville Syrjälä wrote:
> On Fri, Oct 08, 2021 at 09:17:08AM +0200, Javier Martinez Canillas wrote:
> > This reverts commit b3484d2b03e4c940a9598aa841a52d69729c582a.
> > 
> > That change attempted to improve the DRM drivers fbdev emulation device
> > names to avoid having confusing names like "simpledrmdrmfb" in /proc/fb.
> > 
> > But unfortunately there are user-space programs, such as pm-utils that
> > query that information and so broke after the mentioned commit. Since
> > the names in /proc/fb are used programs that consider it an ABI, let's
> > restore the old names even when this lead to silly naming like the one
> > mentioned above as an example.
> 
> The usage Johannes listed was this specificially:
>  using_kms() { grep -q -E '(nouveau|drm)fb' /proc/fb; }                                                        
> 
> So it actually looks like  Daniel's
> commit f243dd06180a ("drm/nouveau: Use drm_fb_helper_fill_info")
> also broke the abi. But for the pm-utils use case at least
> just having the "drmfb" in there should cover even nouveau.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> > 
> > Reported-by: Johannes Stezenbach <js@sig21.net>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> >  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 3ab07832104..8993b02e783 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
> >  			       sizes->fb_width, sizes->fb_height);
> >  
> >  	info->par = fb_helper;
> > -	snprintf(info->fix.id, sizeof(info->fix.id), "%s",

Please add a comment here that drmfb is uapi because pm-utils matches
against it ...

Otherwise this will be lost in time again :-(
-Daniel
> > +	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
> >  		 fb_helper->dev->driver->name);
> >  
> >  }
> > -- 
> > 2.31.1
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

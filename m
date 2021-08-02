Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2B3DD203
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhHBIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhHBIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:31:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 01:31:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yk17so21918441ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2KQi/PpUB7Y3JmHg1rJxCNCGs8vvEPZaQqU4vBqqxj0=;
        b=HgHrrIbB878oj98KI0co1g6r02tGSh9g7VKDedPS39+9jjWZi3bKmqEcp8zzSZzf8l
         CUIHisZ21o1fOMQj4SMZXwh2N3t32A4U9UWUcRJwVyN5wkDb9r3t86E6Z9tO9F1/gRZv
         /Grst0h8i/kmjiopPhS0osukh5NAaw1iQR0RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2KQi/PpUB7Y3JmHg1rJxCNCGs8vvEPZaQqU4vBqqxj0=;
        b=m5YvNpTHvtW7WlGPzPfwjSh4SlkLqq35XPhHi6DdD9kaoqlss2ZB9CocuRTdeQwKpp
         Y+6PJmPe5pnplc+7nsgGRFxL51XYLCR9laFsIyeU+2bWl2834c329FUxGjXbnaxDWBpe
         nxUCEW3JQpJzHzpZl3k//eWGubITg3cO0zE0R3eW66hmXgp+396rTGslrGRdH25eXf1l
         jF1xmEYqSQ0eC/BbL2pDEtR41AZemknn7ee3ky9v0qsuq4/SdoGJxM5PlSLOLnXBYsux
         5Dm7eYPrwP1nZQ5QiuzDfwhUCcgxjA8vHKLklQK9iUdhB/FyosUFfM5E6+cXn5e8j65H
         yvYw==
X-Gm-Message-State: AOAM5300r18w/oMWsd2BTgNy9fX1qk+TRn4Hwk940az/9cpoRQgQQYzO
        khQCTgiNFnZlqQSI283zgW2DSw==
X-Google-Smtp-Source: ABdhPJxQFaOHuhoAlTk/8r4Zhkzk4Wm3gRp+HcSLY10IzWI3V+1UMipvcAfeq6ZIhAqRFodwmjs63A==
X-Received: by 2002:a17:906:32d6:: with SMTP id k22mr14107178ejk.228.1627893087250;
        Mon, 02 Aug 2021 01:31:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v8sm3078590ejy.79.2021.08.02.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:31:26 -0700 (PDT)
Date:   Mon, 2 Aug 2021 10:31:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
Message-ID: <YQetXMaASz/F2EyS@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian König wrote:
> Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> > When primary bo is updated, crtc's pitch may
> > have not been updated, this will lead to show
> > disorder content when user changes display mode,
> > we update crtc's pitch in page flip to avoid
> > this bug.
> > This refers to amdgpu's pageflip.
> 
> Alex is the expert to ask about that code, but I'm not sure if that is
> really correct for the old hardware.
> 
> As far as I know the crtc's pitch should not change during a page flip, but
> only during a full mode set.
> 
> So could you elaborate a bit more how you trigger this?

legacy page_flip ioctl only verifies that the fb->format stays the same.
It doesn't check anything else (afair never has), this is all up to
drivers to verify.

Personally I'd say add a check to reject this, since testing this and
making sure it really works everywhere is probably a bit much on this old
hw.
-Daniel

> 
> Thanks,
> Christian.
> 
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> > ---
> >   drivers/gpu/drm/radeon/evergreen.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
> > index 36a888e1b179..eeb590d2dec2 100644
> > --- a/drivers/gpu/drm/radeon/evergreen.c
> > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > @@ -28,6 +28,7 @@
> >   #include <drm/drm_vblank.h>
> >   #include <drm/radeon_drm.h>
> > +#include <drm/drm_fourcc.h>
> >   #include "atom.h"
> >   #include "avivod.h"
> > @@ -1414,10 +1415,15 @@ void evergreen_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base,
> >   			 bool async)
> >   {
> >   	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
> > +	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
> > -	/* update the scanout addresses */
> > +	/* flip at hsync for async, default is vsync */
> >   	WREG32(EVERGREEN_GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
> >   	       async ? EVERGREEN_GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
> > +	/* update pitch */
> > +	WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset,
> > +	       fb->pitches[0] / fb->format->cpp[0]);
> > +	/* update the scanout addresses */
> >   	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH + radeon_crtc->crtc_offset,
> >   	       upper_32_bits(crtc_base));
> >   	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
> > 
> > No virus found
> > 		Checked by Hillstone Network AntiVirus
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E74408AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJ3MIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhJ3MIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 08:08:15 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E9C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=ZIAjfyluv6n+7SWUoRXNUVKzRvp5Ka/4JBN91H8gIjw=; b=UlL6C
        y7KWJxvsH0KyRc8dqvUy1qBoz5CKHAOy+he56H/eaRcatnfBl2ntbvYbtPxRjeh1mvkt6QZfvQWgZ
        lvxGl1NzmJPU3R3V/Ayaxn7V6zZlemg/ZwrKAfTrQuYqToF++CMOgPfuvmpYZVmMTuzdg7jVOcdNV
        xJ29zirhfWqEb7d308lMuiX+5wHBw85PPBFrbO2NXc9i95Yr++yyLAD8hqqO3H7jqt+nn/k1bt+On
        wOS4YOogsomdox3as6PPEgk8Hjwu3iPjXux3tqDlfaUQSnGFjrsl6sUriYQLpxrVKcYoS1xCu8bRz
        2cH0rea8KUuHR8Yd7CPfe9wbdt+Yg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mgn76-0003Ms-BU; Sat, 30 Oct 2021 13:05:32 +0100
Date:   Sat, 30 Oct 2021 13:05:31 +0100
From:   John Keeping <john@metanate.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: use generic fbdev setup
Message-ID: <YX01C6l93I2YPgku@donbot>
References: <20211029115014.264084-1-john@metanate.com>
 <ab7ace79-0148-1efa-ec17-6994bb35fd2f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7ace79-0148-1efa-ec17-6994bb35fd2f@suse.de>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Oct 29, 2021 at 09:00:08PM +0200, Thomas Zimmermann wrote:
> Am 29.10.21 um 13:50 schrieb John Keeping:
> > The Rockchip fbdev code does not add anything compared to
> > drm_fbdev_generic_setup(); the one custom function for .fb_mmap does the
> > same thing as gem_prime_mmap which is called by the helper.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >   drivers/gpu/drm/rockchip/Makefile             |   1 -
> >   drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  10 +-
> >   drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   2 -
> >   drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 164 ------------------
> >   drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h |  24 ---
> >   5 files changed, 2 insertions(+), 199 deletions(-)
> >   delete mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> >   delete mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h
> > 
> > diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> > index 17a9e7eb2130..1a56f696558c 100644
> > --- a/drivers/gpu/drm/rockchip/Makefile
> > +++ b/drivers/gpu/drm/rockchip/Makefile
> > @@ -5,7 +5,6 @@
> >   rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
> >   		rockchip_drm_gem.o rockchip_drm_vop.o rockchip_vop_reg.o
> > -rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > index 69c699459dce..20d81ae69828 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > @@ -26,7 +26,6 @@
> >   #include "rockchip_drm_drv.h"
> >   #include "rockchip_drm_fb.h"
> > -#include "rockchip_drm_fbdev.h"
> >   #include "rockchip_drm_gem.h"
> >   #define DRIVER_NAME	"rockchip"
> > @@ -159,10 +158,6 @@ static int rockchip_drm_bind(struct device *dev)
> >   	drm_mode_config_reset(drm_dev);
> > -	ret = rockchip_drm_fbdev_init(drm_dev);
> > -	if (ret)
> > -		goto err_unbind_all;
> > -
> >   	/* init kms poll for handling hpd */
> >   	drm_kms_helper_poll_init(drm_dev);
> > @@ -170,10 +165,11 @@ static int rockchip_drm_bind(struct device *dev)
> >   	if (ret)
> >   		goto err_kms_helper_poll_fini;
> > +	drm_fbdev_generic_setup(drm_dev, 32);
> 
> Please pass 0 for the final argument. The fbdev helpers pick 32 by default.
> Maybe leave a comment if you require 32 here.

I wanted to minimise the changes introduced here - passing 32 matches
the value passed to drm_fb_helper_initial_config() in the deleted code
from rockchip_drm_fbdev.c.

What do you think about changing this to 0 in a follow-up patch?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2A43A9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhJZBbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJZBbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:31:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558AC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:28:53 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n2so12092637qta.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh45oPDn94gNypIm1FQKgEgGeN239lum/jZyUe6g9nY=;
        b=U2dYK2PV3BxgyM+7d822+Ew8Y5DSy6+gsGjm/wl0fPr+ZF2fi3mJ0IGMLrSZXSuxNn
         qqBGh9pVxQ6I7KBKWXtlf+3sGcm9y4iSx8uLS5V5/oah9ex0fpysu4UGghJCAM4SYXGJ
         FM62r0guNt1biyKMGwfkAUDqX9Rw4xGPLTRDnsnSbjv1Oc2Sin0YLjoSptdYRK+xY7JJ
         Fk7MkGG6yDX9WVesysklP7VAyMb9RG98TFoYnBER2IJElQSEnSwFHiAcxJGIqefMX9AC
         +Z6JUwys1RyJg30ReZKj0RBpc8k1XZfW8esNdah9WY73zuLQpGoqqbHm8WPXl0SZviKp
         jzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh45oPDn94gNypIm1FQKgEgGeN239lum/jZyUe6g9nY=;
        b=h2Yfd/sOE+Cn1F9QsYGS/OZ9zLKLqoTO+0rneYeuvnvqs2Fqkh2eQaVnL9LA1rVRqd
         e4wLDvIS2Y125BLyD9pNfbYtfucMEX3Rjzp5MYRvXK/oG9RJv+7xPcTHaQwk/Mjjifur
         60Tbp5D6+T+SkwXg9qGzZOtvby2xkJlPxHJ2rC6FXYIQh2sarV9qA0BQeRjy7LN5hoxW
         TFvAE+HkJ+SMSJqEUWVXJL22EmPUNdFVXD+GfcmaN1MZsmGHAMfpCuPIM+X/8nAFCa2V
         epHlsTahqqFR/4qL84FtiXDH4DpbEGfMvhW4cYo0JmdkAT4Q85X3cCGW9T7foXZF830T
         Sw2w==
X-Gm-Message-State: AOAM530ahcsoCRixb4HQ6XCfSLJ2NVXYiyBL6l0mWEghXyjYcDTzKsiB
        6iM1BjMSGssy0qoltqZXbcN72Q==
X-Google-Smtp-Source: ABdhPJw79deyD9lBHGmREWUAqpL3YQFMBNdQygVadCb4kqmWCWsyXxVF3unQOWHfWut9doYx00CuoQ==
X-Received: by 2002:a05:622a:199c:: with SMTP id u28mr21723399qtc.153.1635211733222;
        Mon, 25 Oct 2021 18:28:53 -0700 (PDT)
Received: from localhost ([167.100.64.199])
        by smtp.gmail.com with ESMTPSA id b8sm9463851qtr.82.2021.10.25.18.28.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Oct 2021 18:28:52 -0700 (PDT)
Date:   Mon, 25 Oct 2021 21:28:51 -0400
From:   Sean Paul <sean@poorly.run>
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, seanpaul@chromium.org,
        Mark Yacoub <markyacoub@google.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mediatek: Set Rotation default value to 1.
Message-ID: <20211026012851.GH2515@art_vandelay>
References: <20211022165409.178281-1-markyacoub@chromium.org>
 <20211026011154.GE2515@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026011154.GE2515@art_vandelay>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 09:11:54PM -0400, Sean Paul wrote:
> On Fri, Oct 22, 2021 at 12:54:02PM -0400, Mark Yacoub wrote:
> > From: Mark Yacoub <markyacoub@google.com>
> > 
> > [Why]
> > The Rotation prob is a bitmask value. It must always have a valid value.
> 
> nit: s/prob/prop/
> 
> > A default NO rotation is equal to 1 not 0.
> > 
> > [How]
> > 1. At the reset hook, call __drm_atomic_helper_plane_reset which is
> > called at the initialization of the plane and sets the default value of
> > all planes to DRM_MODE_ROTATE_0 which is equal to 1.
> > 2. At the ovl layer check, do no overwrite the state->rotation value 0
> > if DRM_MODE_ROTATE_0 is set. We should not change the value that the
> > userspace has set, especially if it's an unsupported value.
> 
> nit: I would probably split these into 2 patches since they're related but
> different

Did you decide not to remove the default value from the plane rotation value? I
still think we should do that.

Sean

> 
> Sean
> 
> > 
> > Tested on Jacuzzi(MTK).
> > Fixes IGT@kms_properties@plane-properties-{legacy,atomic} and
> > IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}
> > 
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 20 +++++++-------------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  5 ++---
> >  drivers/gpu/drm/mediatek/mtk_drm_plane.c    |  3 ++-
> >  4 files changed, 12 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > index 86c3068894b11..2fc566964f68e 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > @@ -64,7 +64,7 @@ void mtk_ovl_config(struct device *dev, unsigned int w,
> >  		    unsigned int h, unsigned int vrefresh,
> >  		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> >  int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
> > -			struct mtk_plane_state *mtk_state);
> > +			const struct mtk_plane_state *mtk_state);
> >  void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
> >  			  struct mtk_plane_state *state,
> >  			  struct cmdq_pkt *cmdq_pkt);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index ea5760f856ec6..13999564304bc 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -190,19 +190,15 @@ unsigned int mtk_ovl_supported_rotations(struct device *dev)
> >  }
> >  
> >  int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
> > -			struct mtk_plane_state *mtk_state)
> > +			const struct mtk_plane_state *mtk_state)
> >  {
> > -	struct drm_plane_state *state = &mtk_state->base;
> > -	unsigned int rotation = 0;
> > +	const struct drm_plane_state *state = &mtk_state->base;
> > +	unsigned int rotation = drm_rotation_simplify(
> > +		state->rotation,
> > +		DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y);
> >  
> > -	rotation = drm_rotation_simplify(state->rotation,
> > -					 DRM_MODE_ROTATE_0 |
> > -					 DRM_MODE_REFLECT_X |
> > -					 DRM_MODE_REFLECT_Y);
> > -	rotation &= ~DRM_MODE_ROTATE_0;
> > -
> > -	/* We can only do reflection, not rotation */
> > -	if ((rotation & DRM_MODE_ROTATE_MASK) != 0)
> > +	/* We can only do reflection, not non-zero rotation */
> > +	if (((rotation & ~DRM_MODE_ROTATE_0) & DRM_MODE_ROTATE_MASK) != 0)
> >  		return -EINVAL;
> >  
> >  	/*
> > @@ -212,8 +208,6 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
> >  	if (state->fb->format->is_yuv && rotation != 0)
> >  		return -EINVAL;
> >  
> > -	state->rotation = rotation;
> > -
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 1b582262b682b..530bdd031933f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -53,9 +53,8 @@ struct mtk_ddp_comp_funcs {
> >  	void (*disable_vblank)(struct device *dev);
> >  	unsigned int (*supported_rotations)(struct device *dev);
> >  	unsigned int (*layer_nr)(struct device *dev);
> > -	int (*layer_check)(struct device *dev,
> > -			   unsigned int idx,
> > -			   struct mtk_plane_state *state);
> > +	int (*layer_check)(struct device *dev, unsigned int idx,
> > +			   const struct mtk_plane_state *state);
> >  	void (*layer_config)(struct device *dev, unsigned int idx,
> >  			     struct mtk_plane_state *state,
> >  			     struct cmdq_pkt *cmdq_pkt);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > index e6dcb34d30522..accd26481b9fb 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > @@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
> >  		state = kzalloc(sizeof(*state), GFP_KERNEL);
> >  		if (!state)
> >  			return;
> > -		plane->state = &state->base;
> >  	}
> >  
> > +	__drm_atomic_helper_plane_reset(plane, &state->base);
> > +
> >  	state->base.plane = plane;
> >  	state->pending.format = DRM_FORMAT_RGB565;
> >  }
> > -- 
> > 2.33.0.1079.g6e70778dc9-goog
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS

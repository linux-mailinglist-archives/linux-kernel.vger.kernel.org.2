Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2773768DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhEGQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhEGQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:35:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4BC061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:34:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l14so9898959wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O99QLS/XuXmi5sOenN2CFxQz7Q5z0xeHfl0XAzi4THc=;
        b=U+IByuCcxULK3nxRVkk7JSImKY8trLGHWZcfLZTgiCNxRgComAbd5SB0Cfj6jYZ996
         9lS6uV6uHIiiE4JuSIZxyPiEFBQLgBWjXWWpjAxbl8UM05Asr4O0C2J4hfCVuPJJkeXk
         Lp1lfV5LSbB4AJ6q9iEoC6lTzRO2xg0DHZElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=O99QLS/XuXmi5sOenN2CFxQz7Q5z0xeHfl0XAzi4THc=;
        b=GST9S9Vlde1dXNS5sb84x2oWJ0KzeK11akHkU7eK3Ayay+CbFy/uJQ6NdumEVhdcoQ
         5VlMG7/hVYDd3tj+y8jfxH/7HMqwkWU3IdoIibtf6zzgFKkiEnJD84v6FkDh2hBUiWnD
         iMgsA/sCHfnWSf0YdfNznzcH6gvX+TWA9Pnr0ztUgFBxR2SjvaLflHeYRE9AmbRwx7sK
         PBnzWD0GvMRrQvDDn/rE+DOs8xGXOcBtpKko0AzFIaDAzMBzrBS0EXgkQIhJdwJ9iIv/
         SJuYITkX9swa7eAvfjRoBgs06/Y/cTnrfwPp6rhxnee/B4Qf/I2GKD8+DrQLs3F8oJqQ
         A5xA==
X-Gm-Message-State: AOAM5311LxWewe68SXTOGYjAgYm4oZkFN0GrgZ9zyDkJ7ucuAfl8G131
        rH36AgyDyCL9MGhPVpqI/n3+yA==
X-Google-Smtp-Source: ABdhPJz9eV+VjyShaXPfAx4WvqHMrnt9SIWVOMU/ZLtthyBfUy5zg6ri6iuFlihrahEEp1TfX0GW8g==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr13620583wru.16.1620405276947;
        Fri, 07 May 2021 09:34:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r2sm8702898wrt.79.2021.05.07.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:34:36 -0700 (PDT)
Date:   Fri, 7 May 2021 18:34:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
        krzysztof.h1@poczta.fm, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, j.beisert@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: fbdev: imxfb: Fix an error message
Message-ID: <YJVsGn4+rbh0+b+I@phenom.ffwll.local>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
        krzysztof.h1@poczta.fm, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, j.beisert@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <d7b25026f82659da3c6f7159eea480faa9d738be.1620327302.git.christophe.jaillet@wanadoo.fr>
 <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 07:05:03AM +0200, Uwe Kleine-König wrote:
> Hello Christophe,
> 
> On Thu, May 06, 2021 at 08:57:05PM +0200, Christophe JAILLET wrote:
> > 'ret' is known to be 0 here.
> > No error code is available, so just remove it from the error message.
> > 
> > Fixes: 72330b0eeefc ("i.MX Framebuffer: Use readl/writel instead of direct pointer deref")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/video/fbdev/imxfb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > index 7f8debd2da06..ad598257ab38 100644
> > --- a/drivers/video/fbdev/imxfb.c
> > +++ b/drivers/video/fbdev/imxfb.c
> > @@ -992,7 +992,7 @@ static int imxfb_probe(struct platform_device *pdev)
> >  	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
> >  					   &fbi->map_dma, GFP_KERNEL);
> >  	if (!info->screen_buffer) {
> > -		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
> > +		dev_err(&pdev->dev, "Failed to allocate video RAM\n");
> >  		ret = -ENOMEM;
> >  		goto failed_map;
> >  	}
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for patch& review, queued for 5.14 in drm-misc-next.
-Daniel

> 
> Are you using this driver, or did you find that problem using some
> static checker?
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

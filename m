Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA05E41434F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhIVINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhIVIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:13:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918FEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:11:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i23so4310453wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wxHTAEsI7Nk3iPURnvztUqIFLbdCaS8kxfRLaXFpIzk=;
        b=bfg6hrQ4CjFf3qWQZk05aiAU0SKwDjTnGVr5mmD58yypuw2lHFVQdfzHvRlnvwkmzX
         /FufyeEw+ShF3lBaIvdD61+iZomA9+EA1DtEdqrZThfFPlyIUvl8oJXkZH2vZH/Z7YmX
         8hBljxI7NZBefkCWG9+pAJgbTVXrXqBw70xC/eGdLlG1XQ3nFFKgBnnEsjv6W8GVfOIT
         fVHJ9K4G9BNc7b1q4jrPrAH9vbUjOm7rtDOLQLpgFjAjXzejkKQFJvJ0NGksttyXBOMZ
         UY+2LoTXk0snXiGB9Vk4TtZNlT5Pfhx6F4OhVWd7zw0I6qdDslAxs9qqCVAS9aLtOuNk
         EOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wxHTAEsI7Nk3iPURnvztUqIFLbdCaS8kxfRLaXFpIzk=;
        b=QcKEavRfuK6hGTkzs9XVL+YmKO1nCvGAEet9T6APjS+da1KMUMGns47iqi1oVQ0mZj
         CoG3IAZLMYuSIEIc8ySXfkmyvOnwRBtqaguyY9UZpwGEw5W3tHHY77OZwjN5JLLRGCR/
         NzRIoWZHSNYBGaX3/0XRnoAsCivIrJZTWsGbc0QO73tyh3cACW1HoEzXyKM/YCmsMWEl
         r5Fg7cOd9vQMy9KfFQw8hqg9AkEasKNPqJZF6upUsP7ysWgoAQzmQXm1uLDP4QQ3//sy
         6VPXfWPgweQuMOhdBKdFCW+MaxBokkvX8IibYffsooaEslTCTrY3Rygxle6+bF5RQJmC
         aiWw==
X-Gm-Message-State: AOAM5325s+UXFJwgFJIVCTVspn7fADHFVaJrRTClJWGh/wDlRHOpJEbe
        vSpbhF893etovrFsEMPJT6I=
X-Google-Smtp-Source: ABdhPJzzflJ6y5fsEmusSNKQISqiUc/JclUu6xfNP0IJZ06m+Vg1SrDTtpO577Ikb4qShOViKHDcrQ==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr41194518wrq.145.1632298292228;
        Wed, 22 Sep 2021 01:11:32 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id a25sm5072161wmj.34.2021.09.22.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 01:11:31 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:11:25 +0100
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Make use of the helper function
 devm_platform_ioremap_resource_byname()
Message-ID: <20210922081125.qc4eaaxyfi6rjunr@smtp.gmail.com>
References: <20210901112941.31320-1-caihuoqing@baidu.com>
 <20210920083134.hajvw6kpvfg3qitn@mail.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920083134.hajvw6kpvfg3qitn@mail.igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20, Melissa Wen wrote:
> On 09/01, Cai Huoqing wrote:
> > Use the devm_platform_ioremap_resource_byname() helper instead of
> > calling platform_get_resource_byname() and devm_ioremap_resource()
> > separately
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >  drivers/gpu/drm/v3d/v3d_drv.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> > index 9403c3b36aca..c1deab2cf38d 100644
> > --- a/drivers/gpu/drm/v3d/v3d_drv.c
> > +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> > @@ -206,10 +206,7 @@ MODULE_DEVICE_TABLE(of, v3d_of_match);
> >  static int
> >  map_regs(struct v3d_dev *v3d, void __iomem **regs, const char *name)
> >  {
> > -	struct resource *res =
> > -		platform_get_resource_byname(v3d_to_pdev(v3d), IORESOURCE_MEM, name);
> > -
> > -	*regs = devm_ioremap_resource(v3d->drm.dev, res);
> > +	*regs = devm_platform_ioremap_resource_byname(v3d_to_pdev(v3d), name);
> >  	return PTR_ERR_OR_ZERO(*regs);
> >  }
> lgtm.
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>

and applied to drm-misc-next.

Thanks,

Melissa
> >  
> > -- 
> > 2.25.1
> > 



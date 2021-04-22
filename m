Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A9368204
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhDVN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhDVN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:58:47 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70505C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:58:12 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j3so22014880qvs.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDNnkJPb2aQUATNCDosNiyczROSb5OwKI26xW7uSy28=;
        b=R4gYl8V9m76fiz5yMnlKUIbRJene//D0v8wbWVpqrHO13nHZEo37aC7E7PIRJDsGeq
         sfEgLFCT2klfSqwCXqz/IIT5X254leclwQZtLDrL5ONQafBUy+aPNsgEqJaO2mHBQd+o
         J6RM68h3qBw9hnHl99j17M1JzZwY8v7XBzy2Vqmjkfj5ZpIo5PXCfF2+jRZvl1eK0U0T
         dAGIPAH1bZDSJM82Et7l7ckY/uUPPqg4j3zspAHhT4ef2sCzxSwX6Eqvy8o0Slrchqoe
         lRX0E3VLVB0FKsqQ1xfL9ZlggAqn1sJTeHZ9Dee+xWmyAbNz1Tg07GG2m2Scla4qFYtg
         2JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDNnkJPb2aQUATNCDosNiyczROSb5OwKI26xW7uSy28=;
        b=B4QeV/Nop9iza2xnPuCzRPr3MQKny+7uXkkyYDa2pewd0NAmPBQS2new3bxDJD7eWK
         oMX6o6DsQv3P36S8VNYGVIfhxTWRdBqeNeJUhQStPIS9hXVIYmaen3g8VZED1pSU1cIA
         kGT0ZAmFYahOxIU/6TGZZvSc1vQhSLozJm2LJ0OZ/7pOZyrg02LsJvKyfO5QXJ3JdEdX
         bzKNF3EAUg4r7D7fGAZDZbkNzzR9xRqvpazbgD6iLr8i+BFfo0Sf/45pWjPiooTy/PJS
         l8xui0Ofvw4+GC8o/5PDH+sv8AIhTDO5pZwClWdc9GmxPCadYrMc+DONcgQAQIygQ0la
         DHVw==
X-Gm-Message-State: AOAM532/ZiiqdRcc9j+7K2CMq1vj/k1x3uJ9VM0RQdG4GD1K9e+iqUxb
        Bemnzf7RQjUvwZkbQLUz7c/ZjQ==
X-Google-Smtp-Source: ABdhPJyZJdGFuL+vpCjOqy7YRTYsaeQhy9BH3TnGMSu3vmr9Ghy8k0VdVdtgLaCfy2MyMPaAm45r2w==
X-Received: by 2002:a05:6214:2a9:: with SMTP id m9mr3807764qvv.39.1619099891662;
        Thu, 22 Apr 2021 06:58:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id r25sm2278007qtm.18.2021.04.22.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 06:58:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lZZqM-00A2d6-Nq; Thu, 22 Apr 2021 10:58:10 -0300
Date:   Thu, 22 Apr 2021 10:58:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/gvt: fix DRM_I915_GVT dependency on VFIO_MDEV
Message-ID: <20210422135810.GG2047089@ziepe.ca>
References: <20210422133547.1861063-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422133547.1861063-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:35:33PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Kconfig dependency is incomplete since DRM_I915_GVT is a 'bool'
> symbol that depends on the 'tristate' VFIO_MDEV. This allows a
> configuration with VFIO_MDEV=m, DRM_I915_GVT=y and DRM_I915=y that
> causes a link failure:
> 
> x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `available_instances_show':
> gvt.c:(.text+0x67a): undefined reference to `mtype_get_parent_dev'
> x86_64-linux-ld: gvt.c:(.text+0x6a5): undefined reference to `mtype_get_type_group_id'
> x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `description_show':
> gvt.c:(.text+0x76e): undefined reference to `mtype_get_parent_dev'
> x86_64-linux-ld: gvt.c:(.text+0x799): undefined reference to `mtype_get_type_group_id'
> 
> Clarify the dependency by specifically disallowing the broken
> configuration. If VFIO_MDEV is built-in, it will work, but if
> VFIO_MDEV=m, the i915 driver cannot be built-in here.
> 
> Fixes: 07e543f4f9d1 ("vfio/gvt: Make DRM_I915_GVT depend on VFIO_MDEV")
> Fixes: 9169cff168ff ("vfio/mdev: Correct the function signatures for the mdev_type_attributes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oh kconfig stuff like this makes my head hurt, thanks for finding it

I also can't see an alternative to this ugly thing, besides having the
i915 guys properly modularize this code someday

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

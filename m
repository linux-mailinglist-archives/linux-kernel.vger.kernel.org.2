Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051853691BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbhDWMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:07:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:07:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id er3so15086619qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oIrSmttZt8w8IYsvq2tZWFNRx5PYZRmzsHZiyS/kUBY=;
        b=Jc/ceFWZmat8S6sF1UODv7FrsjOU2LiF7hvKDA4IarmIqpq4khjIETCAcnVRm9o6p3
         9K/8o8GHp4GXlKPDZEsuc2v0dB2qXUrn/SUizyTjBPVKuZq2MCdYcl6Mv64DdFJGju4J
         KhbZouoic0IBGEhMaAPaEdG4cIrs2L2+a0rnT2QTZK/QT0amnGPCYeYYr1l5YUYOfpm2
         YwHkC5Q98b5kNae+amekx6g+7tk0AOES0yj7Q7753+pSmIyajCt1HO01ytB/OHAuOHct
         lBUG50r3nFSWvdkH3Nzd9KsK/ZLXw1FowoGqC1AjAv8rFvurbX/haeJctby9jVq9fX3d
         cd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oIrSmttZt8w8IYsvq2tZWFNRx5PYZRmzsHZiyS/kUBY=;
        b=BfH5x9auyXkv05FoinQK2vSy7ATZ9ykF/OEHTAJtCppY6NyT4fS5aweoYWYhUbIlsx
         lCU1Wd8X1KnPBpLRuW0T0irOv/DYd4RkdZsXZXKm6b6IBb2yMNnGGjar3BYrMqDUmEZ6
         a4PEW884wFB+weeiA0vF/KjZ6uQYOXTl++9t4fM3WLdIhA04XqGS+YLyvIMWcs+pVRXy
         B2xrMjYRMe9Vu6tfDv/0BQHJyGKMBmoWgsx3TevRCyZXxsFE8YtfiJQU7JU9/NsPROmO
         DY4K6gYWXRCXRv2vveGJvqSCBiQcEAAJBpHQretBjRMx6X/P+SQsSa1O5hI5u0esDv9u
         v9dA==
X-Gm-Message-State: AOAM5326uS0CviG2o57tZDDczntXZj2kmuwT6SpfufGZjqRSLy4DT+x3
        pAj2BTmpEYTcy6E9p3Oho6GoQw==
X-Google-Smtp-Source: ABdhPJx1yej2P8kFCD2IbM1FZf62rljfBdX3+a55H78bRF2KLbJS2Ts/crATqgvwfwYv0jRo/ofqXw==
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr3746904qve.27.1619179631869;
        Fri, 23 Apr 2021 05:07:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id z17sm4217230qtf.10.2021.04.23.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 05:07:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lZuaT-00AYW6-Gy; Fri, 23 Apr 2021 09:07:09 -0300
Date:   Fri, 23 Apr 2021 09:07:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/gvt: fix DRM_I915_GVT dependency on VFIO_MDEV
Message-ID: <20210423120709.GH2047089@ziepe.ca>
References: <20210422133547.1861063-1-arnd@kernel.org>
 <20210422135810.GG2047089@ziepe.ca>
 <20210423035426.GG1551@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423035426.GG1551@zhen-hp.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:54:26AM +0800, Zhenyu Wang wrote:
> On 2021.04.22 10:58:10 -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 22, 2021 at 03:35:33PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The Kconfig dependency is incomplete since DRM_I915_GVT is a 'bool'
> > > symbol that depends on the 'tristate' VFIO_MDEV. This allows a
> > > configuration with VFIO_MDEV=m, DRM_I915_GVT=y and DRM_I915=y that
> > > causes a link failure:
> > > 
> > > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `available_instances_show':
> > > gvt.c:(.text+0x67a): undefined reference to `mtype_get_parent_dev'
> > > x86_64-linux-ld: gvt.c:(.text+0x6a5): undefined reference to `mtype_get_type_group_id'
> > > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `description_show':
> > > gvt.c:(.text+0x76e): undefined reference to `mtype_get_parent_dev'
> > > x86_64-linux-ld: gvt.c:(.text+0x799): undefined reference to `mtype_get_type_group_id'
> > > 
> > > Clarify the dependency by specifically disallowing the broken
> > > configuration. If VFIO_MDEV is built-in, it will work, but if
> > > VFIO_MDEV=m, the i915 driver cannot be built-in here.
> > > 
> > > Fixes: 07e543f4f9d1 ("vfio/gvt: Make DRM_I915_GVT depend on VFIO_MDEV")
> > > Fixes: 9169cff168ff ("vfio/mdev: Correct the function signatures for the mdev_type_attributes")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >  drivers/gpu/drm/i915/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Oh kconfig stuff like this makes my head hurt, thanks for finding it
> > 
> > I also can't see an alternative to this ugly thing, besides having the
> > i915 guys properly modularize this code someday
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> 
> I don't really want this mess to propagate further. We should move
> mdev related stuff to kvmgt module instead, so not pretend any more to
> possibly use that for other hypervisor..
> 
> Sorry that I didn't realize this issue when Jason proposed this. Let
> me do the left cleanup.

It would be good, but Alex should still take this patch for the
upcoming merge window, you can revert it when you do all the cleanups

Jason

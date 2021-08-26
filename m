Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0533F8475
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbhHZJXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbhHZJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:23:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C63FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:22:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u9so3920662wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5nGZgvsyXA2v5RBRhfghmqhLLrwrK3N/HAosQKFTGU=;
        b=gPVYqvarTNOfAMXnLrOwhAZEMjPHA9JBmY7uaVY5mZDlUw6TWlUKedc1ZYtK0GBZ1f
         Mwo/R9M9Fk9Fa9LVqGsfUKkr5xcapuuftVZBe4bxEQqm7oug5gtIaPjOyrnS5nc/ylnm
         8TaYJ9AZ76dyPC/sNv1v2ua8pWaTrWYynyuNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Z5nGZgvsyXA2v5RBRhfghmqhLLrwrK3N/HAosQKFTGU=;
        b=ODvxfHD5c+ZvFbAi6gIJ18zzCzUQSu+lVIKqqggefRpkJsfzQf0nMKdfbHofRI1Hf2
         sWAxmdXqiZSYsA9RRH+PS0enEC5gN6OJxfIqH9LqjMKwwi2nIj7hO9bXqcwU6UHUiFko
         tUIY3OYBCNKAK7t8UfrieGcIuoyV7RRaga5PtY2RdECsoceC9oQ+B6jN/Gh9jrjDhFoN
         yAlgO35A3jpDI9vIPM2IT6pmi7BEyk4AyGJd4qyaO8ZyEFVkVvHcru5u7BAwiOWkAWuY
         M173dOWWQqeXLMe8A7Tym0BH1R6cXjSTGCyT+rEOhmPnCgOpp8jRNaFGmWfV5k0DE8cn
         EzXQ==
X-Gm-Message-State: AOAM533p1fP6Nc7CubrRocY/gg4b5RH2KodQWcDHFNQKe2xvrO3bXG3e
        HAlD6IBheRt/pF+hRQnr+GNdDQ==
X-Google-Smtp-Source: ABdhPJywIjK24u44KRC9Fyl/LBYQf/UtyuZhNV+15XNUicx6WL1eBmZ28GqU1x/tJY9ZhVWwQcJQoA==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr2650396wrq.285.1629969764058;
        Thu, 26 Aug 2021 02:22:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v21sm2697421wra.92.2021.08.26.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:22:43 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:22:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, tzimmermann@suse.de,
        Arnd Bergmann <arnd@arndb.de>, wanghaibin.wang@huawei.com,
        Jun Nie <jun.nie@linaro.org>, airlied@linux.ie,
        Shawn Guo <shawnguo@kernel.org>, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, mripard@kernel.org,
        devicetree@vger.kernel.org, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH] drm: remove zxdrm driver
Message-ID: <YSddYSKvGneVKNjW@phenom.ffwll.local>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, tzimmermann@suse.de,
        Arnd Bergmann <arnd@arndb.de>, wanghaibin.wang@huawei.com,
        Jun Nie <jun.nie@linaro.org>, airlied@linux.ie,
        Shawn Guo <shawnguo@kernel.org>, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, devicetree@vger.kernel.org,
        maarten.lankhorst@linux.intel.com
References: <20210821031357.289-1-yuzenghui@huawei.com>
 <YSPuMqd1QgnRIVCB@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPuMqd1QgnRIVCB@robh.at.kernel.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 01:51:30PM -0500, Rob Herring wrote:
> On Sat, 21 Aug 2021 11:13:57 +0800, Zenghui Yu wrote:
> > The zte zx platform had been removed in commit 89d4f98ae90d ("ARM: remove
> > zte zx platform"), so this driver is no longer needed.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jun Nie <jun.nie@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >  .../devicetree/bindings/display/zte,vou.txt   | 120 ---
> >  drivers/gpu/drm/Kconfig                       |   2 -
> >  drivers/gpu/drm/Makefile                      |   1 -
> >  drivers/gpu/drm/zte/Kconfig                   |  10 -
> >  drivers/gpu/drm/zte/Makefile                  |  10 -
> >  drivers/gpu/drm/zte/zx_common_regs.h          |  28 -
> >  drivers/gpu/drm/zte/zx_drm_drv.c              | 190 ----
> >  drivers/gpu/drm/zte/zx_drm_drv.h              |  34 -
> >  drivers/gpu/drm/zte/zx_hdmi.c                 | 760 ---------------
> >  drivers/gpu/drm/zte/zx_hdmi_regs.h            |  66 --
> >  drivers/gpu/drm/zte/zx_plane.c                | 537 ----------
> >  drivers/gpu/drm/zte/zx_plane.h                |  26 -
> >  drivers/gpu/drm/zte/zx_plane_regs.h           | 120 ---
> >  drivers/gpu/drm/zte/zx_tvenc.c                | 400 --------
> >  drivers/gpu/drm/zte/zx_tvenc_regs.h           |  27 -
> >  drivers/gpu/drm/zte/zx_vga.c                  | 527 ----------
> >  drivers/gpu/drm/zte/zx_vga_regs.h             |  33 -
> >  drivers/gpu/drm/zte/zx_vou.c                  | 921 ------------------
> >  drivers/gpu/drm/zte/zx_vou.h                  |  64 --
> >  drivers/gpu/drm/zte/zx_vou_regs.h             | 212 ----
> >  20 files changed, 4088 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
> >  delete mode 100644 drivers/gpu/drm/zte/Kconfig
> >  delete mode 100644 drivers/gpu/drm/zte/Makefile
> >  delete mode 100644 drivers/gpu/drm/zte/zx_common_regs.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi_regs.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_plane.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_plane.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_plane_regs.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc_regs.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_vga.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_vga_regs.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_vou.c
> >  delete mode 100644 drivers/gpu/drm/zte/zx_vou.h
> >  delete mode 100644 drivers/gpu/drm/zte/zx_vou_regs.h
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

I just merged another patch to delete the zte driver.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

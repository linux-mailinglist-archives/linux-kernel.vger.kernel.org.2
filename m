Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E907C3F50CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHWSwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:52:16 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45775 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhHWSwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:52:15 -0400
Received: by mail-ot1-f43.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso7279793otv.12;
        Mon, 23 Aug 2021 11:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wdgHBs4jqcab0Nca0Wa4pPNHM3gmB9i3TY5nzR3jzD0=;
        b=JHwPmJy2aiE3it45/tfx93+11VS8iIdmEo9xu21Rr1sIh9gS/f6jv6fibm2NWxtTaa
         XEMqFL5DUt/mvLpFBRGZTdTVxXnhXKObYNtmdYzH4eMspAznpwpt6GOV8m2iROwwn5F7
         82fDItVQjANsklDiFgfntVQlW8atQmdRFNFXk/t/KmQM7zFKVUCAzHpkYGjuK7mzbaUd
         576L+LtaipSoXnUAlZS9uNaifp88Ou55k5tewsmvHf1Es6XVorbNbhG3NX5PUmFPpS7h
         TNi/eIhITSYXThvDWc/4Zxxj1orvL93mio1MW444aOZfLX/YzBPCb3qQE4hHnjQAkD5k
         lCSA==
X-Gm-Message-State: AOAM532T+iVQlWo3wPeqLyGqSx3LuvFf7fPHpUrP0rm4N/zceQKL/+pX
        ftpByCUAnGeDMukUcjkmhQ==
X-Google-Smtp-Source: ABdhPJxvnG6wdrGM3ED6xV8CXtjfI+vHLk44/i9f1eGqIcHuh2RHVLuZtfJfpY7ClH4k6nOeWoUm+g==
X-Received: by 2002:a9d:730a:: with SMTP id e10mr3153668otk.120.1629744692283;
        Mon, 23 Aug 2021 11:51:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v5sm3560150oos.17.2021.08.23.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:51:31 -0700 (PDT)
Received: (nullmailer pid 2511997 invoked by uid 1000);
        Mon, 23 Aug 2021 18:51:30 -0000
Date:   Mon, 23 Aug 2021 13:51:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     tzimmermann@suse.de, Arnd Bergmann <arnd@arndb.de>,
        wanghaibin.wang@huawei.com, Jun Nie <jun.nie@linaro.org>,
        airlied@linux.ie, Shawn Guo <shawnguo@kernel.org>,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, mripard@kernel.org,
        devicetree@vger.kernel.org, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH] drm: remove zxdrm driver
Message-ID: <YSPuMqd1QgnRIVCB@robh.at.kernel.org>
References: <20210821031357.289-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821031357.289-1-yuzenghui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 11:13:57 +0800, Zenghui Yu wrote:
> The zte zx platform had been removed in commit 89d4f98ae90d ("ARM: remove
> zte zx platform"), so this driver is no longer needed.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  .../devicetree/bindings/display/zte,vou.txt   | 120 ---
>  drivers/gpu/drm/Kconfig                       |   2 -
>  drivers/gpu/drm/Makefile                      |   1 -
>  drivers/gpu/drm/zte/Kconfig                   |  10 -
>  drivers/gpu/drm/zte/Makefile                  |  10 -
>  drivers/gpu/drm/zte/zx_common_regs.h          |  28 -
>  drivers/gpu/drm/zte/zx_drm_drv.c              | 190 ----
>  drivers/gpu/drm/zte/zx_drm_drv.h              |  34 -
>  drivers/gpu/drm/zte/zx_hdmi.c                 | 760 ---------------
>  drivers/gpu/drm/zte/zx_hdmi_regs.h            |  66 --
>  drivers/gpu/drm/zte/zx_plane.c                | 537 ----------
>  drivers/gpu/drm/zte/zx_plane.h                |  26 -
>  drivers/gpu/drm/zte/zx_plane_regs.h           | 120 ---
>  drivers/gpu/drm/zte/zx_tvenc.c                | 400 --------
>  drivers/gpu/drm/zte/zx_tvenc_regs.h           |  27 -
>  drivers/gpu/drm/zte/zx_vga.c                  | 527 ----------
>  drivers/gpu/drm/zte/zx_vga_regs.h             |  33 -
>  drivers/gpu/drm/zte/zx_vou.c                  | 921 ------------------
>  drivers/gpu/drm/zte/zx_vou.h                  |  64 --
>  drivers/gpu/drm/zte/zx_vou_regs.h             | 212 ----
>  20 files changed, 4088 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
>  delete mode 100644 drivers/gpu/drm/zte/Kconfig
>  delete mode 100644 drivers/gpu/drm/zte/Makefile
>  delete mode 100644 drivers/gpu/drm/zte/zx_common_regs.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi_regs.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_plane.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_plane.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_plane_regs.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc_regs.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_vga.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_vga_regs.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_vou.c
>  delete mode 100644 drivers/gpu/drm/zte/zx_vou.h
>  delete mode 100644 drivers/gpu/drm/zte/zx_vou_regs.h
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F353FB9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbhH3QN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhH3QN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:13:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3949060F5E;
        Mon, 30 Aug 2021 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339982;
        bh=40inKDhWzSvdGsiJaHfcPhn4GTMQWygcBLFqeqAn4/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzTicYRYkcQru4sLkEttXtHEU1G2mK+qzPV//QJM+KiX9BKTip5JYE9M3m6jBzokj
         jWrfOGUKySmn7oe5uU5PXq1vfJpwSD2dL46K14+ZvUTwHhRid4W9JYILYeBgH66bUn
         7lCah/C3lQpIpxbNQRtB69JGMeAo0m+IwISOnPAP3Vmzafm1h2uyHbf+uIfiEpRrWR
         ldywnKXG8xILvroo+EMzAQ4RpMMKWlfAqYLHATbCg84KgFFekl598B4cTR65PXCBKs
         Lbte+tcrlHLINyZyLkCuvQDD18RkvV1lGwhG7FenBdKK1r79sl2PU5/Rygd+Dq8Dix
         rh6gS3yxsIgfA==
Received: by mail-ej1-f53.google.com with SMTP id e21so32220012ejz.12;
        Mon, 30 Aug 2021 09:13:02 -0700 (PDT)
X-Gm-Message-State: AOAM532xnnDsV47z/Eyo6VUFaALd8aO0rCTn3G22yn2r+Lsj7r8m8kWW
        li2vILMbWgchdVjLWReDaRstqi2rj+gsyS8vFw==
X-Google-Smtp-Source: ABdhPJzgx5cNjX+gTraGFHxZN+e1334aj9v6T19QNMRMy0fo5AFPAJt2/mH9BWnDA3HXjDRaNHV50rJYr6iuSxAiU4U=
X-Received: by 2002:a17:906:b4d:: with SMTP id v13mr26478063ejg.468.1630339980797;
 Mon, 30 Aug 2021 09:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210821031357.289-1-yuzenghui@huawei.com> <YSPuMqd1QgnRIVCB@robh.at.kernel.org>
 <YSddYSKvGneVKNjW@phenom.ffwll.local>
In-Reply-To: <YSddYSKvGneVKNjW@phenom.ffwll.local>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 11:12:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+gapHO79i1BY8AhCJX6H67FgLmZV7xXcjBn9yY4q=6iQ@mail.gmail.com>
Message-ID: <CAL_Jsq+gapHO79i1BY8AhCJX6H67FgLmZV7xXcjBn9yY4q=6iQ@mail.gmail.com>
Subject: Re: [PATCH] drm: remove zxdrm driver
To:     Zenghui Yu <yuzenghui@huawei.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, wanghaibin.wang@huawei.com,
        Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 4:22 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Aug 23, 2021 at 01:51:30PM -0500, Rob Herring wrote:
> > On Sat, 21 Aug 2021 11:13:57 +0800, Zenghui Yu wrote:
> > > The zte zx platform had been removed in commit 89d4f98ae90d ("ARM: remove
> > > zte zx platform"), so this driver is no longer needed.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Jun Nie <jun.nie@linaro.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > > ---
> > >  .../devicetree/bindings/display/zte,vou.txt   | 120 ---
> > >  drivers/gpu/drm/Kconfig                       |   2 -
> > >  drivers/gpu/drm/Makefile                      |   1 -
> > >  drivers/gpu/drm/zte/Kconfig                   |  10 -
> > >  drivers/gpu/drm/zte/Makefile                  |  10 -
> > >  drivers/gpu/drm/zte/zx_common_regs.h          |  28 -
> > >  drivers/gpu/drm/zte/zx_drm_drv.c              | 190 ----
> > >  drivers/gpu/drm/zte/zx_drm_drv.h              |  34 -
> > >  drivers/gpu/drm/zte/zx_hdmi.c                 | 760 ---------------
> > >  drivers/gpu/drm/zte/zx_hdmi_regs.h            |  66 --
> > >  drivers/gpu/drm/zte/zx_plane.c                | 537 ----------
> > >  drivers/gpu/drm/zte/zx_plane.h                |  26 -
> > >  drivers/gpu/drm/zte/zx_plane_regs.h           | 120 ---
> > >  drivers/gpu/drm/zte/zx_tvenc.c                | 400 --------
> > >  drivers/gpu/drm/zte/zx_tvenc_regs.h           |  27 -
> > >  drivers/gpu/drm/zte/zx_vga.c                  | 527 ----------
> > >  drivers/gpu/drm/zte/zx_vga_regs.h             |  33 -
> > >  drivers/gpu/drm/zte/zx_vou.c                  | 921 ------------------
> > >  drivers/gpu/drm/zte/zx_vou.h                  |  64 --
> > >  drivers/gpu/drm/zte/zx_vou_regs.h             | 212 ----
> > >  20 files changed, 4088 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
> > >  delete mode 100644 drivers/gpu/drm/zte/Kconfig
> > >  delete mode 100644 drivers/gpu/drm/zte/Makefile
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_common_regs.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_hdmi_regs.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_plane.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_plane.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_plane_regs.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_tvenc_regs.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_vga.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_vga_regs.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_vou.c
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_vou.h
> > >  delete mode 100644 drivers/gpu/drm/zte/zx_vou_regs.h
> > >
> >
> > Acked-by: Rob Herring <robh@kernel.org>
>
> I just merged another patch to delete the zte driver.

Unfortunately, that one missed the binding doc, so please send me a
patch removing the binding doc.

Rob

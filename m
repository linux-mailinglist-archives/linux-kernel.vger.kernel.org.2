Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4014191B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhI0JlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:41:18 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhI0JlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:41:17 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M890H-1mQeN71wLT-005Lhh for <linux-kernel@vger.kernel.org>; Mon, 27 Sep
 2021 11:39:38 +0200
Received: by mail-wr1-f48.google.com with SMTP id v17so7196767wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:39:38 -0700 (PDT)
X-Gm-Message-State: AOAM530jh/oPM/iK2reyItdKlI6qIuQYR7k26KMariDTLzsHtu7xj36F
        jF7FVisxvCjrnVib+rBM/UE7W1Ev/H4vi1bZPtA=
X-Google-Smtp-Source: ABdhPJzw8wp0ZsXSNDvP3gv334QGiK0yVNSZyzNIHpmCfkoIjZ41K7Vl7uVq2HYR9WzUuAX6tNcVwXjlGq+HfuyrMz0=
X-Received: by 2002:a1c:2357:: with SMTP id j84mr5135591wmj.1.1632735578051;
 Mon, 27 Sep 2021 02:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <YU8oVDFoeD5YYeDT@kroah.com> <CAK8P3a3pdVhjv4J4HSB1cvHU7U_P7TV7HCOYmrK==V_MAnT2BQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3pdVhjv4J4HSB1cvHU7U_P7TV7HCOYmrK==V_MAnT2BQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Sep 2021 11:39:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0gSJrR=rLtyLOH+D-grsoy_9_kOOS-AT3aX8R48p+zww@mail.gmail.com>
Message-ID: <CAK8P3a0gSJrR=rLtyLOH+D-grsoy_9_kOOS-AT3aX8R48p+zww@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move dma-buf symbols into the DMA_BUF module namespace
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wEWm+JUmaN2OkLrppac5ENU1FjQ8tEMfG1WCKExGsD4/sy1hgIA
 JFCJoVDHn5qpfESPR5LaUamnnOjekLbV4thSwXd1InZbcXZhwXriFV2icpDfDStJlyNppsR
 pFxfP3kn2RQgeru8DCyu287dY3gHhkrwRLOgZyNTI2vswxA/YoC+rNL2NwnKR6dQeMfT2YF
 Y2NQUc8YuAYNO9fgYrS7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kH81Fqhe5T8=:EyjyLy77fwA5M3a6B5e1Gw
 LCskmYpghlKRRjtYuETaDicumx3xrQuIkjyBqLOU3xeWeLWow/RI8aEwtB6B6aZ+Rc/NmIljK
 j9xpGfInRXnrpNQYJcsyErzJwrkKjASkvAkqCVoBGmwH0D+GqJHWpnG1eUSY3x+iXbcyYIPdK
 5OFvn3j8/+9jT6ywYkx6StyE0+Y8RcoGNJtMCKjVWpLsjPnHXQviWP8JzFYwneZLFttRkwV+p
 4NoAUV0EygA3i+GANUUdeWdID+MNIg+NeDzRcAf4TPLhRvUmw9Ma2UwA7jt1s2ZNqaJaruife
 kjKHZvy3LT+xQRpQh0qq20BVdxl7TfbHWRX74jN5fFzlwB06uL5xbmL4H96PhtvCVBfqMhg9c
 D4jEPXYBDTGXue+4dr4v+5TdDJIPG2QliI7xoqGWKjsp8lrC55L9P1l3qOGfcPelw99x09HFS
 AuW+tbowpYULMY4KRXpAxzpL9yDbxqlzX5zpGihAlCVOsGJfBT7p8JW2VLgpc56oq4CxEFP1W
 S5luEvhHMxVaAZi4vyvjqaYEWTYC9DhJaZdf09ihXx31bjpSd4q+svGQOTnR7ZYkgEmmOxvIe
 nVJk6+fqihK09+1Og+qjxI5ypkW2/pDkjd0/qtV/pyG0QWNlwY4ZfTV6MhPMD/6auCY4TH825
 0TvZupaGox0z30i0vxJKXNOv4wsCG8UeEv9M6bDC3wC2UWYUhcTYu4+uzLb/rzg1mjGqYTved
 mheA+DRM6WA6L5Ww8Fd3y5XP0QUmJOq5OYTZvDVaC1FMYSo29bWm7cZwS0dCycXMmfVuMzKlC
 QUp+DZxUB7Jbnwv8Mb1NSVz2Hp/umsFYPP4Z8tSQSkDsN1u24YnCXNyUCMuhSNWlfg5cayBKT
 zO7gKhOIVF+mOcVavWug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 7:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Sep 25, 2021 at 3:47 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Only test-built on x86 allmodconfig, don't know what other arches will
> > pick up, will let 0-day run on it for a bit...
>
> I've added it to my build box doing arm32/arm64/x86 randconfig tests,
> if it doesn't report anything by Monday, it's probably good in that regard.

It found these two, please fold into your patch:

diff --git a/drivers/gpu/drm/armada/armada_gem.c
b/drivers/gpu/drm/armada/armada_gem.c
index 21909642ee4c..711f0cca6f9c 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -15,6 +15,8 @@
 #include "armada_gem.h"
 #include "armada_ioctlP.h"

+MODULE_IMPORT_NS(DMA_BUF);
+
 static vm_fault_t armada_gem_vm_fault(struct vm_fault *vmf)
 {
        struct drm_gem_object *gobj = vmf->vma->vm_private_data;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
index f4cde3a169d8..809f86cfc540 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
@@ -11,6 +11,8 @@

 #include "omap_drv.h"

+MODULE_IMPORT_NS(DMA_BUF);
+
 /* -----------------------------------------------------------------------------
  * DMABUF Export
  */

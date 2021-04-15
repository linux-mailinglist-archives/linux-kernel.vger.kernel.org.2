Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A523615FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhDOXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhDOXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:17:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4895C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 16:17:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e186so25923692iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0ipiL9MSmifEz+wQcyijLIsT5i8r0XZoqk47MKHQX0=;
        b=Mvr0swQN0vMSA686ousRXdWsFDCK58MYUMZ0RH6CLbu/croY2Klo10xpZop4fmSjL7
         7onK0m1cohsP8fW7+2UoABnO02HXDN416uR1gtuNimQlElPblBOKs8TorQSfD6IORDKB
         cnBzw2byalExaMnPk6VV7OsqfCDRytqCPVjFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0ipiL9MSmifEz+wQcyijLIsT5i8r0XZoqk47MKHQX0=;
        b=JDZPrEx7/r/dfAy+2qyvD68H2qFsc5A1gXkV7OFP6467ANpMDjVtpjZvVqimxYSK7s
         NqH6pIS67pRDrm2hwzXfUEZLEywf3aPbn6JgpFph+pG8Q6PtSSztZMh5eyw4bQPkst/8
         NPAHRVPWHJ09CyUpYoVRy5Zcpt+kp3QhbXKnW30jnhim2D4CfPnIG8mEs8IfCiesnUWA
         B4BeWmEt2vQfGbWHHt05xm84l6LO+FPBEfPuJDH7v9io4xA9qPuCagcH3HEs9LZwHdAT
         oN1jdFjs+dj1KfH2n2bMBy4IfX0hM2CZuBbWChIvIOwmVuAPTlKHBe63qzitprA2lGu6
         YikQ==
X-Gm-Message-State: AOAM530Fpg7sVAjXzf9OGQPq3oBPYK0wBtacqSwoif6c67GyRF5oe19P
        oZsmwupaEl0MmZkJ72OOLVWsy0ARfSrK6qdlqAZAoo72lXM=
X-Google-Smtp-Source: ABdhPJz9ok+IhzVwAe8/5RL9/SG/dp0NT4iebVO8VyFBC41k4i1AM/fnTNCNxLheJMddJzJJSsbP2v0IaVHDtMwP65s=
X-Received: by 2002:a6b:148f:: with SMTP id 137mr1208273iou.0.1618528649030;
 Thu, 15 Apr 2021 16:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210409093738.GH6048@kadam> <d3cd5c0b-f30e-6130-582d-7b68d8320507@codeaurora.org>
In-Reply-To: <d3cd5c0b-f30e-6130-582d-7b68d8320507@codeaurora.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 15 Apr 2021 16:21:01 -0700
Message-ID: <CAJs_Fx7fgeURHzm2k-Bb8h_xy1=-5vrbt+jt5J=vEzr1rEd8Cw@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600
 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 9:52 AM Akhil P Oommen <akhilpo@codeaurora.org> wrote:
>
> On 4/9/2021 3:07 PM, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   2d743660786ec51f5c1fefd5782bbdee7b227db0
> > commit: 5785dd7a8ef0de8049f40a1a109de6a1bf17b479 drm/msm: Fix duplicate gpu node in icc summary
> > config: arm64-randconfig-m031-20210407 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
> > drivers/gpu/drm/msm/adreno/a4xx_gpu.c:727 a4xx_gpu_init() error: passing non negative 1 to ERR_PTR
> >
> > vim +600 drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> >
> > 7198e6b03155f6 Rob Clark      2013-07-19  515  struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
> > 7198e6b03155f6 Rob Clark      2013-07-19  516  {
> > 7198e6b03155f6 Rob Clark      2013-07-19  517         struct a3xx_gpu *a3xx_gpu = NULL;
> > 55459968176f13 Rob Clark      2013-12-05  518         struct adreno_gpu *adreno_gpu;
> > 7198e6b03155f6 Rob Clark      2013-07-19  519         struct msm_gpu *gpu;
> > 060530f1ea6740 Rob Clark      2014-03-03  520         struct msm_drm_private *priv = dev->dev_private;
> > 060530f1ea6740 Rob Clark      2014-03-03  521         struct platform_device *pdev = priv->gpu_pdev;
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  522         struct icc_path *ocmem_icc_path;
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  523         struct icc_path *icc_path;
> > 7198e6b03155f6 Rob Clark      2013-07-19  524         int ret;
> > 7198e6b03155f6 Rob Clark      2013-07-19  525
> > 7198e6b03155f6 Rob Clark      2013-07-19  526         if (!pdev) {
> > 6a41da17e87dee Mamta Shukla   2018-10-20  527                 DRM_DEV_ERROR(dev->dev, "no a3xx device\n");
> > 7198e6b03155f6 Rob Clark      2013-07-19  528                 ret = -ENXIO;
> > 7198e6b03155f6 Rob Clark      2013-07-19  529                 goto fail;
> > 7198e6b03155f6 Rob Clark      2013-07-19  530         }
> > 7198e6b03155f6 Rob Clark      2013-07-19  531
> > 7198e6b03155f6 Rob Clark      2013-07-19  532         a3xx_gpu = kzalloc(sizeof(*a3xx_gpu), GFP_KERNEL);
> > 7198e6b03155f6 Rob Clark      2013-07-19  533         if (!a3xx_gpu) {
> > 7198e6b03155f6 Rob Clark      2013-07-19  534                 ret = -ENOMEM;
> > 7198e6b03155f6 Rob Clark      2013-07-19  535                 goto fail;
> > 7198e6b03155f6 Rob Clark      2013-07-19  536         }
> > 7198e6b03155f6 Rob Clark      2013-07-19  537
> > 55459968176f13 Rob Clark      2013-12-05  538         adreno_gpu = &a3xx_gpu->base;
> > 55459968176f13 Rob Clark      2013-12-05  539         gpu = &adreno_gpu->base;
> > 7198e6b03155f6 Rob Clark      2013-07-19  540
> > 70c70f091b1ffd Rob Clark      2014-05-30  541         gpu->perfcntrs = perfcntrs;
> > 70c70f091b1ffd Rob Clark      2014-05-30  542         gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
> > 70c70f091b1ffd Rob Clark      2014-05-30  543
> > 3bcefb0497f9fc Rob Clark      2014-09-05  544         adreno_gpu->registers = a3xx_registers;
> > 3bcefb0497f9fc Rob Clark      2014-09-05  545
> > f97decac5f4c2d Jordan Crouse  2017-10-20  546         ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
> > 7198e6b03155f6 Rob Clark      2013-07-19  547         if (ret)
> > 7198e6b03155f6 Rob Clark      2013-07-19  548                 goto fail;
> > 7198e6b03155f6 Rob Clark      2013-07-19  549
> > 55459968176f13 Rob Clark      2013-12-05  550         /* if needed, allocate gmem: */
> > 55459968176f13 Rob Clark      2013-12-05  551         if (adreno_is_a330(adreno_gpu)) {
> > 26c0b26dcd005d Brian Masney   2019-08-23  552                 ret = adreno_gpu_ocmem_init(&adreno_gpu->base.pdev->dev,
> > 26c0b26dcd005d Brian Masney   2019-08-23  553                                             adreno_gpu, &a3xx_gpu->ocmem);
> > 26c0b26dcd005d Brian Masney   2019-08-23  554                 if (ret)
> > 26c0b26dcd005d Brian Masney   2019-08-23  555                         goto fail;
> > 55459968176f13 Rob Clark      2013-12-05  556         }
> > 55459968176f13 Rob Clark      2013-12-05  557
> > 667ce33e57d0de Rob Clark      2016-09-28  558         if (!gpu->aspace) {
> > 871d812aa43e63 Rob Clark      2013-11-16  559                 /* TODO we think it is possible to configure the GPU to
> > 871d812aa43e63 Rob Clark      2013-11-16  560                  * restrict access to VRAM carveout.  But the required
> > 871d812aa43e63 Rob Clark      2013-11-16  561                  * registers are unknown.  For now just bail out and
> > 871d812aa43e63 Rob Clark      2013-11-16  562                  * limp along with just modesetting.  If it turns out
> > 871d812aa43e63 Rob Clark      2013-11-16  563                  * to not be possible to restrict access, then we must
> > 871d812aa43e63 Rob Clark      2013-11-16  564                  * implement a cmdstream validator.
> > 871d812aa43e63 Rob Clark      2013-11-16  565                  */
> > 6a41da17e87dee Mamta Shukla   2018-10-20  566                 DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
> > 871d812aa43e63 Rob Clark      2013-11-16  567                 ret = -ENXIO;
> > 871d812aa43e63 Rob Clark      2013-11-16  568                 goto fail;
> > 871d812aa43e63 Rob Clark      2013-11-16  569         }
> > 871d812aa43e63 Rob Clark      2013-11-16  570
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  571         icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  572         ret = IS_ERR(icc_path);
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  573         if (ret)
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  574                 goto fail;
> >
> > IS_ERR() returns/true false so this will lead to an Oops in the caller.
> >
> >       icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> >       if (IS_ERR(icc_path)) {
> >               ret = PTR_ERR(icc_path);
> >               goto fail;
> >       }
> Agree.
>
> >
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  575
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  576         ocmem_icc_path = devm_of_icc_get(&pdev->dev, "ocmem");
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  577         ret = IS_ERR(ocmem_icc_path);
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  578         if (ret) {
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  579                 /* allow -ENODATA, ocmem icc is optional */
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  580                 if (ret != -ENODATA)
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  581                         goto fail;
> >
> > Same.  ret is true/false so it can't be equal to -ENODATA, plus the
> > caller will Oops.
> >
> > Btw, this patch removed the assignments:
> >
> >               gpu->icc_path = of_icc_get(dev, "gfx-mem");
> >               gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
> >
> > So I think "gpu->icc_path" and "gpu->ocmem_icc_path" are always
> > NULL/unused and they should be removed.
> >
> Agree. Will share a fix.
> Thanks, Dan.

gpu->ocmem_icc_path/icc_path is used on older devices.. it sounds like
we broke some older devices and no one has noticed yet?

BR,
-R

>
> -Akhil.
>
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  582                 ocmem_icc_path = NULL;
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  583         }
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  584
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  585
> > d163ba0b65f2e4 Brian Masney   2019-11-21  586         /*
> > d163ba0b65f2e4 Brian Masney   2019-11-21  587          * Set the ICC path to maximum speed for now by multiplying the fastest
> > d163ba0b65f2e4 Brian Masney   2019-11-21  588          * frequency by the bus width (8). We'll want to scale this later on to
> > d163ba0b65f2e4 Brian Masney   2019-11-21  589          * improve battery life.
> > d163ba0b65f2e4 Brian Masney   2019-11-21  590          */
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  591         icc_set_bw(icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
> > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  592         icc_set_bw(ocmem_icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
> > d163ba0b65f2e4 Brian Masney   2019-11-21  593
> > 871d812aa43e63 Rob Clark      2013-11-16  594         return gpu;
> > 7198e6b03155f6 Rob Clark      2013-07-19  595
> > 7198e6b03155f6 Rob Clark      2013-07-19  596  fail:
> > 7198e6b03155f6 Rob Clark      2013-07-19  597         if (a3xx_gpu)
> > 7198e6b03155f6 Rob Clark      2013-07-19  598                 a3xx_destroy(&a3xx_gpu->base.base);
> > 7198e6b03155f6 Rob Clark      2013-07-19  599
> > 7198e6b03155f6 Rob Clark      2013-07-19 @600         return ERR_PTR(ret);
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> > _______________________________________________
> > kbuild mailing list -- kbuild@lists.01.org
> > To unsubscribe send an email to kbuild-leave@lists.01.org
> >
>

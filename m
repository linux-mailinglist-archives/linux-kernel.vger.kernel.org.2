Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE636239A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbhDPPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbhDPPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:12:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:11:50 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s16so22740650iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ICI3BCnkNSFzXzic3cRkcOXWXJoyOOpaEJYmsxWhlw=;
        b=J3JDgMfCQ0l+9nfgPwWvLQNLBNBuizNWHopccHJySGViU0iTOo8HMqa3DIEAeH+al8
         8fHu4VIzVUNG3z6xw8b+B6pgZ5Lah/cxglpnhnrztHWlml3bVXYPd9ZcodOsyw4AzHa0
         6ROZrTFFFvpXGXqMg1YqGlaWCiy1ht2rxdM5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ICI3BCnkNSFzXzic3cRkcOXWXJoyOOpaEJYmsxWhlw=;
        b=WgTPCzjE6LjfAZf9SqDePYX/8fyLK0w8kSgBFcS+bMv5XY0xbkRT8lP9avuiSpOFVg
         V34bj3HpowSARB6+YGd6zDfCRgUNGSLVYJCZ6H25iZq/u/Ngf9DxyP0n3thHJt5EAYDk
         H70pZc9lbSurIhBt4afZc8swM/2LoT+QuHLyLYaGv8Wt6NI6mzRP/WQfVKU9ZUNx6iZr
         y942q3Ai3Hg0WNqB8jE8EKZWN/UtQtkzgar1E9FT4wT3/GcnjOy5HjmeR5bOQkmSesrE
         47mYgVZ+DEpIDkoyuxA7sXNWPsiltbL9zMlzlM7/k0YJWCU70U3DXP2VU2HBAAb2o9mo
         NGlA==
X-Gm-Message-State: AOAM531BSK+J2ctfW+FavRGse419o2cXPmYmj/H753h0x9hmh75UEtio
        Zg7Z8xHjhej+6X+wPNJ6EY5A7kynN94t2ebD9iTHQCwCyJk=
X-Google-Smtp-Source: ABdhPJz3Anr6taj83RjN2Oj9SkvDs2A4WXubu0aJ3eWvF2oI6huqSI625CIj2e3PFTZmn7IA4g209PU6m8mak3TOycQ=
X-Received: by 2002:a02:c85c:: with SMTP id r28mr4543871jao.80.1618585909875;
 Fri, 16 Apr 2021 08:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210409093738.GH6048@kadam> <d3cd5c0b-f30e-6130-582d-7b68d8320507@codeaurora.org>
 <CAJs_Fx7fgeURHzm2k-Bb8h_xy1=-5vrbt+jt5J=vEzr1rEd8Cw@mail.gmail.com> <20210416043336.GM6048@kadam>
In-Reply-To: <20210416043336.GM6048@kadam>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 16 Apr 2021 08:15:22 -0700
Message-ID: <CAJs_Fx4WY9B_FudZtSe1hOkLbqy5pFZ=O-dfNJWtWMkJ=8ySbg@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600
 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 9:33 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Apr 15, 2021 at 04:21:01PM -0700, Rob Clark wrote:
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  571         icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  572         ret = IS_ERR(icc_path);
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  573         if (ret)
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  574                 goto fail;
> > > >
> > > > IS_ERR() returns/true false so this will lead to an Oops in the caller.
> > > >
> > > >       icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> > > >       if (IS_ERR(icc_path)) {
> > > >               ret = PTR_ERR(icc_path);
> > > >               goto fail;
> > > >       }
> > > Agree.
> > >
> > > >
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  575
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  576         ocmem_icc_path = devm_of_icc_get(&pdev->dev, "ocmem");
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  577         ret = IS_ERR(ocmem_icc_path);
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  578         if (ret) {
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  579                 /* allow -ENODATA, ocmem icc is optional */
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  580                 if (ret != -ENODATA)
> > > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  581                         goto fail;
> > > >
> > > > Same.  ret is true/false so it can't be equal to -ENODATA, plus the
> > > > caller will Oops.
> > > >
> > > > Btw, this patch removed the assignments:
> > > >
> > > >               gpu->icc_path = of_icc_get(dev, "gfx-mem");
> > > >               gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
> > > >
> > > > So I think "gpu->icc_path" and "gpu->ocmem_icc_path" are always
> > > > NULL/unused and they should be removed.
> > > >
> > > Agree. Will share a fix.
> > > Thanks, Dan.
> >
> > gpu->ocmem_icc_path/icc_path is used on older devices.. it sounds like
> > we broke some older devices and no one has noticed yet?
>
> This is error paths and dead code.  Probably no one is affected in
> real life.
>

oh, right, we are using devm now, so we can drop the icc_put()s

BR,
-R

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90B332DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCISAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:59:59 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C31C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:59:59 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j8so13725052otc.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDPCYluFrdjMuzSEcawbKVQhqqsYOAVXybwEkOdxycU=;
        b=fQQzGb/jC1+8DjdcNxsptTS92WplKKRFklYa26EweJxZelK+27rO4Dk3Z+c0CcoG0i
         ex6lvP02F6oP23QRdP1abDLhXK+leEIvngG7dxSPifhRUVltVm0o/jlN4lgIbZQMSGfC
         +Q1rQe9M8OUTe+Jfi28FRJZ9Kro9wwNnlntZekOUY38dTsiRA1vPTiL5fXNkSVVyh8K+
         t3IJjkXzGkhvzgm40JVKnCLUJezdQUyyK7kR2BsDjle84ERuGhTM1b5v7WGGrcWhVLsv
         FJdeLG2DUkH9/8Iqp4xXALIgFo1/j5y+60UcIzb/pOS7MShzZtw17n3lj6Ue2wmRdsga
         4Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDPCYluFrdjMuzSEcawbKVQhqqsYOAVXybwEkOdxycU=;
        b=lzdd52c4IEMtXjsfQtcHigEoT5eHtR4+n1PQbfigA5V58A/2I5qAAXsrQk1fJK4UDm
         3pZXVlDIqAZ//KMYTN4HDvNN7rKUA7JferuEV5qwa5TuUUsiSiRd7t/0gwK8J3ZRpZzb
         Yc7qPWyolJpDFtqUdmFx6IrV5JUCYos8lQfsdG0xyA6Ld5M/GNh/l9DjZA6YiQHVgRBI
         bP0XBVk1qQVHgH6BA3WcqB3HodUkJFOOqPtw72oOGJJsypICpDPdz1Snq1a7/fouv69O
         yhK8m4TyMEKI/k85F7iE08QbrjUt6pw7tn3hCShCN+b33VgA0yWr8nCqv1T61B9dwft2
         SvbA==
X-Gm-Message-State: AOAM530dw/FTRnxsRrqN2HQ7bI0pDFj8WojAaBCvE1N6XMC/W9Y3QMuW
        R87lq/ac1fnZhdhDiM2KpkMA//sSpRc+/ympK8o=
X-Google-Smtp-Source: ABdhPJwEwsQ2caBdS22GuC0IAzNDOpvTy7t2RPblLIObbiLdaz9uhek4Vj9BBKsWFEIVLdwuEa4xRZ7j1/P0+lG9We8=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr25146289otl.23.1615312798691;
 Tue, 09 Mar 2021 09:59:58 -0800 (PST)
MIME-Version: 1.0
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com> <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com> <YEexf0/V/YF394bf@myrica>
In-Reply-To: <YEexf0/V/YF394bf@myrica>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Mar 2021 12:59:47 -0500
Message-ID: <CADnq5_OTeK7-nN57+F+WE+Hdg86uiuTN8c_n0bmCtx40N_wraQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 12:55 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Hi Felix,
>
> On Tue, Mar 09, 2021 at 11:30:19AM -0500, Felix Kuehling wrote:
> > > I think the proper fix would be to not rely on custom hooks into a particular
> > > IOMMU driver, but to instead ensure that the amdgpu driver can do everything
> > > it needs through the regular linux/iommu.h interfaces. I realize this
> > > is more work,
> > > but I wonder if you've tried that, and why it didn't work out.
> >
> > As far as I know this hasn't been tried. I see that intel-iommu has its
> > own SVM thing, which seems to be similar to what our IOMMUv2 does. I
> > guess we'd have to abstract that into a common API.
>
> The common API was added in 26b25a2b98e4 and implemented by the Intel
> driver in 064a57d7ddfc. To support it an IOMMU driver implements new IOMMU
> ops:
>         .dev_has_feat()
>         .dev_feat_enabled()
>         .dev_enable_feat()
>         .dev_disable_feat()
>         .sva_bind()
>         .sva_unbind()
>         .sva_get_pasid()
>
> And a device driver calls iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA)
> followed by iommu_sva_bind_device().
>
> If I remember correctly the biggest obstacle for KFD is the PASID
> allocation, done by the GPU driver instead of the IOMMU driver, but there
> may be others.

IIRC, we tried to make the original IOMMUv2 functionality generic but
other vendors were not interested at the time, so it ended up being
AMD specific and since nothing else was using the pasid allocations we
put them in the GPU driver.  I guess if this is generic now, it could
be moved to a common API and taken out of the driver.

Alex

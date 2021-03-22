Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDF344660
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCVN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhCVN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:59:00 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:58:59 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4121534ooe.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ycw4kh6uo5mWPlwHrkQbviI/KYMjUPq3rp+uHfdtBN8=;
        b=WaafIrkRt7VtbLiAqIvMQ7prtR+nbO+j3A/PsAroCb42gPmrFUj0dDALDmw1qiVf4r
         QZ0NZtKuEHyYU8j4D1oQ4EyDnGSwIY8B6E+FcEACoxi3oYTFnf4gJm+60NHNXcdz8Tuw
         TGXNA/HE78qtHiS4kXBXalgoxVHD73NaxNxsyfE5QjBGsuJB9E7o1txUYPYC/dCwb2ln
         FWnHO0cqAzYkjWL7dKD1/snl7HuhXmqqMgnocwz3B0zQ7qy3I8ABnUUb1VB4bfWLsScH
         e2AowhcZLFchuJ6vl7u6FXEF1vmvTHQ09AdIrv5S5VgJUU1OYCOnXbWgjZA/8pZAH2g+
         BREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ycw4kh6uo5mWPlwHrkQbviI/KYMjUPq3rp+uHfdtBN8=;
        b=Wyit0BkgG+jINZglbi50KA/O6Vz4ShVYJy/a6dhsrEK/zc9LYI0xFxQG3A0hPydpfr
         E0iYFWa7EIc/KkIVnyEoj75mvvIkaHrKDOqGhEniBlu8kNTox/COJHNDp2MoamKAfnlv
         BAObAY5GtQ5VLLJbc0zQahuiaXO2YS0Uhv7yu3It9p+8z8u6Q9HKuz54gCVvaJYjlLNU
         b3xJCkic2zkY1G6hT9V2Rjw0cYaGJ7CfDp29xvprhphyrhoFAuk92SFZDPyhMhGDxHeO
         nRE7diRHE3cnE2eWtcF6+YixGxMgTkX0hVpohwSNXZMaOOoQyBlFM1QIkoqgOTCu21gg
         Xf9A==
X-Gm-Message-State: AOAM53252NgXrVZM3wl7uSULhOfMLytSpdTg+++XIp5KqH2Rhau+J+4H
        AaqJcVMOnYxqzgCvX7UXe/BLO7Uxj1vOyDCbUZg=
X-Google-Smtp-Source: ABdhPJxDOzZh9ZxCV6hb/mMM8UpqW475cGLkyoKO6WoioK+ZUYE8oTQejvUEuqG3V1Cq8b3Lbb3PcktRVUC+7Y8yAPo=
X-Received: by 2002:a4a:8845:: with SMTP id e5mr11120361ooi.90.1616421539106;
 Mon, 22 Mar 2021 06:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210318202414.10547-1-unixbhaskar@gmail.com> <3cc678f2-36d1-1af1-5759-37aea82f41ea@bombadil.infradead.org>
In-Reply-To: <3cc678f2-36d1-1af1-5759-37aea82f41ea@bombadil.infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Mar 2021 09:58:48 -0400
Message-ID: <CADnq5_Muaa7MLsiUL+pyV16_HuhKJg=jwS8FwCSvgWgGH11LvQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: Fix a typo
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        John Clements <John.Clements@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 3:52 AM Randy Dunlap
<rdunlap@bombadil.infradead.org> wrote:
>
>
>
> On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:
>
> > s/traing/training/
> >
> > ...Plus the entire sentence construction for better readability.
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> > Changes from V1:
> >  Alex and Randy's suggestions incorporated.
> >
> > drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > index c325d6f53a71..bf3857867f51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > @@ -661,10 +661,10 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
> >
> >       if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> >               /*
> > -              * Long traing will encroach certain mount of bottom VRAM,
> > -              * saving the content of this bottom VRAM to system memory
> > -              * before training, and restoring it after training to avoid
> > -              * VRAM corruption.
> > +              * Long training will encroach a certain amount on the bottom of VRAM;
> > +                 * save the content from the bottom VRAM to system memory
> > +                 * before training, and restore it after training to avoid
> > +                 * VRAM corruption.
>
> These 3 new lines are indented with spaces instead of tabs. Oops.  :(
>
> (I may be too late with this comment -- sorry about that.)

I fixed that up when I applied it.

Thanks,

Alex


>
> >                */
> >               sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
> >
> > --
> > 2.26.2
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

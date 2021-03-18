Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439FA340C95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhCRSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhCRSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:12:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:12:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so6059805otr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Mp/bqm2YFp4NyDCzBjnGP7gif34FWuZnhrIj0q+jJI=;
        b=G1ah34xvIoECWz9i/TlzYs207EAkTumLJMTcgRZAZqEsFRP8j8vtS+i93OZj3Fwyh5
         xansT8QAg1v+0aj/4MNUhVTpxws8NOoOpiiflSJr5w4vTLn8pq1WMdIlo364jwNPSqui
         4xSvIr4Hc1qkThPAZ4IvN+DnKMv8YhW0MEIfn4pk+rhDViDvJ77t0P/LfM2E+nsWVGw/
         mfXolrgKVVJCeiUWRNPg2QqEDXRujI/F3HxEKKQAROAg/HwGXvLTkYW+gUb254UrZn+L
         4VmOyG2ITSZwEEUVjKFvDCArHXHADotUOZQNX+OdML050e5t+eWU9hL3jFyayQ32L4fH
         UwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Mp/bqm2YFp4NyDCzBjnGP7gif34FWuZnhrIj0q+jJI=;
        b=FhS8rcPYgZ57J2kGE+GWP2h51vCgv/M7tiThkLpLcnRLyb3yO9HpNVRj2Y2BVxdFRN
         tPQxBtnq3XpyXaDPw2PZbGS6a82JptASqjMeXRY0D+dpN1h1qQHOKF3kE6VQjXw7A/f0
         yoQ1AsHDnF5N7qb2pNtjB2mMJ+0QrpFgt2SQRilJqbXoCPAdK6f7ELJK2HE8O+lDEu1j
         yMyuTY/P7CS0zRzEyjhGyw3sfv/t7eoDm/7J7Upsw+8iMuNJQ1A8yFhb+5NPLC+N9O3c
         1yasZjtZqlzlibp7o9Aejh1H3v3Rmw82KBK76nxzqR17vmgTkN4i3JyXuum2yAMJFbTr
         WKVg==
X-Gm-Message-State: AOAM531MbPyzGpCdwNBp0JlPRL4F9jazTHmPEggcag8ZbeTUWNd4rZGE
        bar4/t75/K0W9acRUNeb5UXc/2rTnVqpIQYw69odXuZZzMU=
X-Google-Smtp-Source: ABdhPJwis+EdQ8GEL/sfDI7LNFt1XiDBiVCBHLPvZtHLfXfeeppuS/V3TIi6KXXkkyMkCPVpuaS2m8dXyFQ0/kRgwmo=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr6216093ots.23.1616091141211;
 Thu, 18 Mar 2021 11:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210318113308.1345-1-unixbhaskar@gmail.com> <b09b524c-1f3d-6231-29b9-f0eac3e77293@infradead.org>
In-Reply-To: <b09b524c-1f3d-6231-29b9-f0eac3e77293@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Mar 2021 14:12:10 -0400
Message-ID: <CADnq5_OsrHGxmXeuEiV06qas7jJ0pvExqdrw-PmqpKvWi=0jOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <John.Clements@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 2:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/18/21 4:33 AM, Bhaskar Chowdhury wrote:
> >
> > s/traing/training/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > index c325d6f53a71..db18e4f6cf5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > @@ -661,7 +661,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
> >
> >       if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> >               /*
> > -              * Long traing will encroach certain mount of bottom VRAM,
> > +              * Long training will encroach certain mount of bottom VRAM,
>
>                                                        amount
> I think.

Yeah, I think it should read something like:

Long training will encroach a certain amount on the bottom of VRAM;
save the content from the bottom VRAM to system memory
before training, and restore it after training to avoid
VRAM corruption.

Alex

>
> >                * saving the content of this bottom VRAM to system memory
> >                * before training, and restoring it after training to avoid
> >                * VRAM corruption.
> > --
> > 2.26.2
> >
>
>
> --
> ~Randy
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

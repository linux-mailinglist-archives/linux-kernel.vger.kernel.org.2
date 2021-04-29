Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122C36E326
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhD2CK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2CK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:10:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EEDC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 19:09:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u80so31452130oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 19:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpteW1PZJWutvArOWsFj/ZNWB/Fybylygdy+Uph5aBg=;
        b=DsAkVTofK/Xe5v6g4JN1wqggjo+FWBs2DbjZ1lhg84Xl3S8EHIL1qmsHGNf07k2hoH
         YRj8NOX69DxJjpBoQDTyKw3kNF3M/9izPVV/4xkcucp7HzOGwJdDm5QcBdlPNzsElUod
         mdd0jEOkPM67KTRS0AOtoqXDsakD8Dqnza6RhJBWy5BOvnFIJydZpsW7E8JS86P/4h7x
         wmPamGBgRfmg03zn/MhHdoetOcCThYMfskOg7CDftttxb69DmrE6avPSrdT0i9oRUoh5
         AiKcgJX8LKFbqKoXElWUIcQXiKTsRrwqn9sH2jAqY7gqB3ENVnHZVOYEBNGF799vSZ3l
         P41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpteW1PZJWutvArOWsFj/ZNWB/Fybylygdy+Uph5aBg=;
        b=PXT/sfK4h3J4WYybZTPq//hwz6C3htoIqGzJLtbfmjR/66WjMLu39+Eo7PNLuQP6tP
         QALTGcX41ScgrjiVDytv3cWA/OTXy9xzBQ2flPZ2l+S9pzEui0TFV+f3VkcmTUg8PsNJ
         sO5PeIGmhMSKqcvW0Xtvv4HgahAPUMATw/EA/h7MyjS/DQRfqzzrtGBQ7ig5v1jzRRfa
         y+7sPf8UVoj+mOgzzCSUSHUKX09QSN2jjY3NHYMI38NkzuGp0GJsI/SkFWp6tIJ3HLZg
         yQwx5Aoipdi73aP8rqR8EcKW85ZiFmtdK/7nPlsp4jgIm5w46cLfWma6Gm+pl3N/T7li
         nMJg==
X-Gm-Message-State: AOAM531K5QB2cXdl4F2SpKhjOvoBJobh2TMoMD/oNTxaHkb8+PAWlMi/
        /mkkfbZK3ZaV3mhQJHq/ZhpKhiyeZVsE816oFC8=
X-Google-Smtp-Source: ABdhPJyuYXVAOuFtIEN/9ZLKxDjiTfOQu7kcczQGclHdfUPsTiqficxHMdUkZazFrXKpKU36KATgpeiiM90eypHsB6s=
X-Received: by 2002:aca:4a4e:: with SMTP id x75mr14232021oia.123.1619662180056;
 Wed, 28 Apr 2021 19:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
 <CAHk-=wh3x4Q4pCkYe7__OAnvOyPqdZLN5ha0z4U035FwT5G57w@mail.gmail.com> <e6532806-ba36-d5d0-6d74-488182787a6c@amd.com>
In-Reply-To: <e6532806-ba36-d5d0-6d74-488182787a6c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Apr 2021 22:09:29 -0400
Message-ID: <CADnq5_Nd6Xo+dQ01Lvoe-e+21zp-gihPZ67ykxec6AG5W=j6CQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.13-rc1
To:     Mikita Lipski <mlipski@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:14 PM Mikita Lipski <mlipski@amd.com> wrote:
>
> Hi Linus,
>
> The patch to fix the warning is here
> (https://www.spinics.net/lists/amd-gfx/msg61614.html)
>
> I guess it just didn't propagate all the way to the release.
> Can it still be pulled into 5.13-rc1 release?

I'll include it in my -fixes pull next week.

Alex


>
>
> From: Mikita Lipski <mikita.lipski@xxxxxxx>
>
> [why]
> Previous statement would always evaluate to true
> making it meaningless
> [how]
> Just check if a connector is MST by checking if its port exists.
>
> Reported-by: kernel test robot <lkp@xxxxxxxxx>
> Signed-off-by: Mikita Lipski <mikita.lipski@xxxxxxx>
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@xxxxxxx>
> Acked-by: Wayne Lin <waynelin@xxxxxxx>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 656bc8f00a42..8bf0b566612b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3030,7 +3030,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
>                         if (!aconnector->dc_link)
>                                 continue;
>
> -                       if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
> +                       if (!aconnector->mst_port)
>                                 continue;
>
>                         link = aconnector->dc_link;
> --
> 2.17.1
>
>
>
> Thanks,
> Mikita
>
>
> On 2021-04-28 6:21 p.m., Linus Torvalds wrote:
> > On Tue, Apr 27, 2021 at 8:32 PM Dave Airlie <airlied@gmail.com> wrote:
> >>
> >> This is the main drm pull request for 5.13. The usual lots of work all
> >> over the place. [...]
> >>
> >> Mikita Lipski:
> >>        drm/amd/display: Add MST capability to trigger_hotplug interface
> >
> > Hmm. I've already merged this, but my clang build shows that this looks buggy:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_dm/amdgpu_dm_debugfs.c:3015:53:
> > warning: address of 'aconnector->mst_port->mst_mgr' will always
> > evaluate to 'true' [-Wpointer-bool-conversion]
> >                          if (!(aconnector->port &&
> > &aconnector->mst_port->mst_mgr))
> >                                                 ~~  ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >
> > and yeah, checking for the address of a member of a structure benign
> > NULL doesn't really work.
> >
> > I'm assuming the '&' is just a left-over cut-and-paste error or something.
> >
> > Please fix after reviewing (I'm not going to blindly just remove the
> > '&' just to silence the warning, since I don't know the code).
> >
> >                  Linus
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

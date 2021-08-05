Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74E93E1CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhHETlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhHETlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:41:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B81C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:41:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so6335830otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l686f0aR6AZETBlltd1qDZRfWjVmSO5B176n1yPkOvQ=;
        b=HAKSzogBjHaGz/MmRtknrIukzojUmgTt4Rr5s5HqZchtgPstM/lth+D8ZYpKQZpzqb
         4DRFfpTDTAngj62j2qfwJ8vRvzz7Lh7R9BV/thjDZCbx5OG8xv5Yel1EuESASdqBu+6+
         X/F5pTULZeUXAYAMvZckWnAHIDA+sC2HLyroo0uDuABk0KgJmNfweerBS+i2IaoYC3cz
         433cM+fONuHf+lkEEH4UQnHLorG5rK2v2EBl1SN2EIfx7pO3L+uQgN+7/sPe6t4z5pQx
         YX7qWjK6E0TTHwz6Ou6CtZCZj2cVm0zQ27l+fQFaW0c3WbLuXb+kzbynx89cuybJanK+
         SX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l686f0aR6AZETBlltd1qDZRfWjVmSO5B176n1yPkOvQ=;
        b=TUypCeOhWZl+o6F/gBwPYsM3IeCJdDIlz1xtfABMRj8sHsJtZ/N1OKusmv367E8uMl
         di88YAjRxsgbRL3bIAqbzWV6flrXzMXKgYVNTxs1fEVfE+yyxUSz/mZu4IvMYngwdguG
         KPi6tFI3tSfKn41jvXwHRtyG4HoRU8aWpX+DQPGW44KYN/WEz93u08HHFeZXxyVWo60m
         fQTP7PqvGo5hKqg6hXxFHPBnHLUlTQW9bF1K1tyirdDZy7nfTNUsighXYtaReYeDxobu
         HjZ9IlBenNB3vRpmpaGrqxufmIEHhgZ/Ww9JHUY0xtu+9l5MXg8dmjmARvs1fO/yTnaH
         iXvw==
X-Gm-Message-State: AOAM530j7FMs+yDO0tZEJG2PoAXD0ITRgVse1jUK9sAgBKB4PXhfbZJF
        35yeV6UmG0EW7KKr7dk+V8X2OSOA+J07GydSet4=
X-Google-Smtp-Source: ABdhPJxgepyRnrfglhFIU+E6xqYtRxIaivQRZddDs3Oo6UOwC+2+tZQLEO5/Z7A9OsUhNU3TRK9GM9vKDw7B7OZes6E=
X-Received: by 2002:a9d:70c3:: with SMTP id w3mr4873883otj.311.1628192461066;
 Thu, 05 Aug 2021 12:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210804112053.263887-1-sergio@lony.xyz> <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
In-Reply-To: <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Aug 2021 15:40:50 -0400
Message-ID: <CADnq5_PcfoQijtu86BKDjGNEE3JxmsrvigMaO_mBrWQrBtmR3Q@mail.gmail.com>
Subject: Re: [PATCH] DRM: gpu: radeon: Fixed coding style issues
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <lonyelon@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <sergio@lony.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 5, 2021 at 8:33 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 04.08.21 um 13:20 schrieb Sergio Migu=C3=A9ns Iglesias:
> > Fixed braces, an unnecessary if statement and added a missing space.
> >
> > Signed-off-by: Sergio Migu=C3=A9ns Iglesias <sergio@lony.xyz>
>
> Normally we see patches which just fixes coding style as unnecessary
> churn, but the "if (rbo) {}" is really ugly here.
>
> So Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeo=
n/radeon_fb.c
> > index 0b206b052972..6640b7c947fe 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fb.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> > @@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
> >       struct radeon_fbdev *rfbdev =3D info->par;
> >       struct radeon_device *rdev =3D rfbdev->rdev;
> >       int ret =3D pm_runtime_get_sync(rdev->ddev->dev);
> > +
> >       if (ret < 0 && ret !=3D -EACCES) {
> >               pm_runtime_mark_last_busy(rdev->ddev->dev);
> >               pm_runtime_put_autosuspend(rdev->ddev->dev);
> > @@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct rad=
eon_fbdev *rfbdev,
> >               radeon_bo_check_tiling(rbo, 0, 0);
> >       ret =3D radeon_bo_kmap(rbo, NULL);
> >       radeon_bo_unreserve(rbo);
> > -     if (ret) {
> > +     if (ret)
> >               goto out_unref;
> > -     }
> >
> >       *gobj_p =3D gobj;
> >       return 0;
> > @@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *he=
lper,
> >       return 0;
> >
> >   out:
> > -     if (rbo) {
> > -
> > -     }
> >       if (fb && ret) {
> >               drm_gem_object_put(gobj);
> >               drm_framebuffer_unregister_private(fb);
>

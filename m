Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124E63662B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhDUAAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhDUAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:00:18 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:59:46 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so8846110oop.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SxR++HmNMtsFaPjPoWGP3yCDilrISVYh6Idyrh/hrQc=;
        b=L+daVzwAV3O2jG3d8KotJCsora66UrQgGpdGHwBkaGI8yj52YKK0u07pbL9YvlIg+J
         oWG6Pk4ENP6bMkQhEFUpUgnxQ9bDe+B5v5fCJqTG4p98vUij6+7as8RZxPV595xQ4CcB
         VnVcAYnthE5I3eGeFy4cP9XpWgL5mvlBRwo9lfdIu3qLPs8Lcf5Tzvf5unZXwiDlR+QR
         9VLFLmvIcLdib3m9erqIheKWPA5NcEHyv8Oh5XU7toYOoCk5ji56oiiAwuLQZhI8o/24
         aG2PAe4cpE05aWfYAj3oVkxMFZpsC9ItAp/czFBmcTJBK9CKnShST28wqTY2SXj3NDrc
         ge9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SxR++HmNMtsFaPjPoWGP3yCDilrISVYh6Idyrh/hrQc=;
        b=BvpT9OKHp/jk+/EgoMCVfBUgDAcvj6gn4IbdKH5lVqVM76t4Gbsij+/sDI0WzSgplx
         4idxCEA/NkXIGbUzzFeQIqoQyoMCciFwrKCClA9eApAh9b9VsEB1NeBpn3SDEQ8ppxyN
         BpUkbMCOBkcgOM4MscNYei8yeeibI0kDCkPQHjOta8odao6qPhUJqWZI8PIcv4DoCdqm
         o627EzhhOYs/llZf+znjEy2Y2Kl1jQRRb9GCW1rTAyErJ/mO6X4M/IK3lHh+LMTzos4E
         BLMLxMMUyDKpi+jRLxvnKmjqD1bUYrYuyuB0g294CBCmK66ro/0Yvz3GlOj5iLd5S4yE
         e2jA==
X-Gm-Message-State: AOAM532+se1+R8p1o8TQ9sAAsftcnYMSU7K1cyoggUogVgpf4l0l4PIO
        Z5DtD+DKUEuKZPI2073wq/2Wg7jYfAMOOyi+54Y=
X-Google-Smtp-Source: ABdhPJzl+deAHpDoxg3MeSz0QbS8aVCVRzHVR2KPghP8gR1TmN2eLRRbC5EaE1urYpXG0jTZl3S325GT9aiaEjqcP/4=
X-Received: by 2002:a4a:800d:: with SMTP id x13mr18900158oof.61.1618963186047;
 Tue, 20 Apr 2021 16:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-32-lee.jones@linaro.org> <2029fbcf-8d2b-7a85-edd2-481a571ae43d@amd.com>
In-Reply-To: <2029fbcf-8d2b-7a85-edd2-481a571ae43d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 20 Apr 2021 19:59:35 -0400
Message-ID: <CADnq5_N5_poFcOpQzV+Ae22rwD0PG3kq0O3q10gmbb7=fNpEyA@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of
 function names in the docs
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Apr 16, 2021 at 11:53 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.04.21 um 16:37 schrieb Lee Jones:
> > Fixes the following W=3D1 kernel build warning(s):
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:73: warning: expecting proto=
type for amdgpu_dummy_page_init(). Prototype was for amdgpu_gart_dummy_page=
_init() instead
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:96: warning: expecting proto=
type for amdgpu_dummy_page_fini(). Prototype was for amdgpu_gart_dummy_page=
_fini() instead
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Nirmoy Das <nirmoy.das@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.c
> > index c5a9a4fb10d2b..5562b5c90c032 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > @@ -60,7 +60,7 @@
> >    */
> >
> >   /**
> > - * amdgpu_dummy_page_init - init dummy page used by the driver
> > + * amdgpu_gart_dummy_page_init - init dummy page used by the driver
> >    *
> >    * @adev: amdgpu_device pointer
> >    *
> > @@ -86,7 +86,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_=
device *adev)
> >   }
> >
> >   /**
> > - * amdgpu_dummy_page_fini - free dummy page used by the driver
> > + * amdgpu_gart_dummy_page_fini - free dummy page used by the driver
> >    *
> >    * @adev: amdgpu_device pointer
> >    *
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3E32BF44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577950AbhCCSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447549AbhCCPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:04:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C5C061760;
        Wed,  3 Mar 2021 07:03:33 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m25so13242783oie.12;
        Wed, 03 Mar 2021 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UFdmdGIL0QMCEr5PKkU9AQdIZLVV8WmqiWX3bdKwEO8=;
        b=QQauQWBbvUN9iU7ZIBR5QfpryPCDaxW5eGXds6qSe28kjr/VQDd1TFN796AY2l+wEf
         QzwToGQJPogy9LWjlpAnFUKI3DowbWVkql+8QFSwkamByG9wl/+NzjoEkIop+f7HjvNN
         EdYxpRj2DXXcwtdY1I2r00QeUix0enLHaYcsPwVpr830DEL8iruObLGMAc8fTJ4cTG/d
         //DaE22CAK8yoMZaA3yze89IAonfl7zg6EXf2cuWIIuVou7NQNcXQ2P736Mwc9JMqmkI
         Igep49NceowL4SLIWSHK/UiyPuf/d8SgmDJgZoRB/bkIaLOvAEyXhstbdRE3HdNji3p7
         DbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UFdmdGIL0QMCEr5PKkU9AQdIZLVV8WmqiWX3bdKwEO8=;
        b=pz3/Ry+HqN5Lwlc7Blc2aqACHWo/EHPVwwbNiwzNZxQxDpZMBrpAhX35820HYEnH3/
         sSxYUkpoDA+ycrocQNaji7pD37sWYxhuXZprVY/6UkrfkckXTbe9fO6gwuhu2AsAGExk
         b0yMSBz2JJR2fFEjU/1PR1Xo6uWiR0qeEyZrk2vZCk2cFCQ/lC2a32iv5Hm//4HahL2x
         uesrj8eBQpNR0KxRy7jhLyOmCqUFHpM398HR4WIG7xJ43pad0Clv7qk8INE/aGA26n2T
         //U4+7A6zxCC4nouFFHuiklhEqcNlcqZIh9D0JbFSVp34ZrwdSbvyVb8g7CNGyh/K72i
         iABQ==
X-Gm-Message-State: AOAM530nDX9xjAgd5FA1TW9IigCclD1OAq3PlaNH8tGuIL8upqkATIEa
        2Z8u7Lo7776CSzAMDopIImVbGjUa9w+Rw6eoaAc=
X-Google-Smtp-Source: ABdhPJy/Z9v1e0H8KZp7WiXlPIQST+M+l00Z0J29yDOyNADm4PL6rAXPb5X74je0lpVPYXZgHf57Nj4bXaIqH3IfYWw=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7604275oih.120.1614783812744;
 Wed, 03 Mar 2021 07:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20210303002759.28752-1-colin.king@canonical.com> <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
In-Reply-To: <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Mar 2021 10:03:21 -0500
Message-ID: <CADnq5_N9P5AHF3PFTyR-k_s23sofvATCGbER=Q9qbNzQFp66UA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix copy of uninitialized variable back to userspace
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Mar 3, 2021 at 2:42 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.03.21 um 01:27 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the ioctl command RADEON_INFO_SI_BACKEND_ENABLED_MASK can
> > copy back uninitialised data in value_tmp that pointer *value points
> > to. This can occur when rdev->family is less than CHIP_BONAIRE and
> > less than CHIP_TAHITI.  Fix this by adding in a missing -EINVAL
> > so that no invalid value is copied back to userspace.
> >
> > Addresses-Coverity: ("Uninitialized scalar variable)
> > Cc: stable@vger.kernel.org # 3.13+
> > Fixes: 439a1cfffe2c ("drm/radeon: expose render backend mask to the use=
rspace")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Let's hope that this doesn't break UAPI.
>
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_kms.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/rade=
on/radeon_kms.c
> > index 2479d6ab7a36..58876bb4ef2a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -518,6 +518,7 @@ int radeon_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >                       *value =3D rdev->config.si.backend_enable_mask;
> >               } else {
> >                       DRM_DEBUG_KMS("BACKEND_ENABLED_MASK is si+ only!\=
n");
> > +                     return -EINVAL;
> >               }
> >               break;
> >       case RADEON_INFO_MAX_SCLK:
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

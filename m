Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900EC3B92E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhGAOJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhGAOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:09:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4096C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 07:07:16 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t3so7415769oic.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LvpeMiTx+++tobKvgMd8tiu03gqF3LE74eGjSIVJmM=;
        b=cG4bqq9KDzrE+dj3GFUS1LQbZj0AdrOX1WfFneE90DHNbcdGVC6/hFFLG9qlWGzW40
         yukj07M/SLCeVwyBsRFJUIXUKd5+sC9SZjs7VIn+EUN+wOjVazmWEZxtGIgUlp+2Krqo
         dHXbmmE/Lbl3wfIzbqtFdRgC+IfWQ6GHL9y+q/0AL0yJXlwJJi1R//K6M0EZQP9rELmI
         peHS+l+ZsMSP92FpCw/NM5wq7kVBQYi8ooxbVWkIUKx7mzZzNGMMmW4rFXWQw7Y2tR7J
         NBC9z6/0O0Vvy5rarcNfWPW0CUn/rD308wAwfkM3tPJP74zlRYGpfi9FbJjvLtMmmczr
         Iziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LvpeMiTx+++tobKvgMd8tiu03gqF3LE74eGjSIVJmM=;
        b=WsouBBIC2zHtpyylsNonlOWlR+W0aFYvspreXIsIypFl1G//zKyIRQnfhPbSdJU9K3
         gJIlZgDj93n22WnBP+NPRbV6BSJPdGJEh7L5aG4U32hU7TOb2YWlxiuCDtM3eZRDhDBZ
         9PFZLxfoxPUCbCiiB909DaDowObbAdwlCszPUidqS3H0tqkkRWCKwXtAdAgqHzj6QbBN
         TkF89nMs86bAzVQNOm+Qnjs3yLOdZe+hji2OLOWT7veP8klOwwmVpWYaOW2enzCxW9dM
         Uzy2hx4dMLYBxiEqkA4+qDZG/gBGaMGWCUpBHbAMpSaXUGEH17obzFTZKtgprTp7TbP6
         XsVQ==
X-Gm-Message-State: AOAM53285xv5utbBrmnSSGhx8Ute5KJdNndfQjmprTXctuqOyxw9hxDN
        NOOtkaexXBUnEQADKpcjGM3zkUeU29ZdBNEq+ek=
X-Google-Smtp-Source: ABdhPJy/Bb2nAAYxH99GQ22ZYraHDbrq4Lv/WhfkE3YsXG7MGaxPKGpRgwHVefcnoe12zrB+8vhQEZsXjPcz7bZ5a/Q=
X-Received: by 2002:aca:3446:: with SMTP id b67mr19352551oia.120.1625148436388;
 Thu, 01 Jul 2021 07:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2106241319430.18969@cbobk.fhfr.pm> <nycvar.YFH.7.76.2107011030030.18969@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2107011030030.18969@cbobk.fhfr.pm>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Jul 2021 10:07:05 -0400
Message-ID: <CADnq5_N_v5YGxSE6szz5dAajbO0VV032Xp2YTrO6c-qr7ft62g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix resource leak on probe error path
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Vojtech Pavlik <vojtech@ucw.cz>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 1, 2021 at 4:32 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 24 Jun 2021, Jiri Kosina wrote:
>
> > From: Jiri Kosina <jkosina@suse.cz>
> >
> > This reverts commit 4192f7b5768912ceda82be2f83c87ea7181f9980.
> >
> > It is not true (as stated in the reverted commit changelog) that we never
> > unmap the BAR on failure; it actually does happen properly on
> > amdgpu_driver_load_kms() -> amdgpu_driver_unload_kms() ->
> > amdgpu_device_fini() error path.
> >
> > What's worse, this commit actually completely breaks resource freeing on
> > probe failure (like e.g. failure to load microcode), as
> > amdgpu_driver_unload_kms() notices adev->rmmio being NULL and bails too
> > early, leaving all the resources that'd normally be freed in
> > amdgpu_acpi_fini() and amdgpu_device_fini() still hanging around, leading
> > to all sorts of oopses when someone tries to, for example, access the
> > sysfs and procfs resources which are still around while the driver is
> > gone.
> >
> > Fixes: 4192f7b57689 ("drm/amdgpu: unmap register bar on device init failure")
> > Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>
> Friendly ping on this one (as it's easily triggerable in the wild by just
> missing proper firwmare).
>
> Thanks.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 57ec108b5972..0f1c0e17a587 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3414,13 +3414,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >       r = amdgpu_device_get_job_timeout_settings(adev);
> >       if (r) {
> >               dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
> > -             goto failed_unmap;
> > +             return r;
> >       }
> >
> >       /* early init functions */
> >       r = amdgpu_device_ip_early_init(adev);
> >       if (r)
> > -             goto failed_unmap;
> > +             return r;
> >
> >       /* doorbell bar mapping and doorbell index init*/
> >       amdgpu_device_doorbell_init(adev);
> > @@ -3646,10 +3646,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >  failed:
> >       amdgpu_vf_error_trans_all(adev);
> >
> > -failed_unmap:
> > -     iounmap(adev->rmmio);
> > -     adev->rmmio = NULL;
> > -
> >       return r;
> >  }
> >
> > --
> > 2.12.3
> >
> >
>
> --
> Jiri Kosina
> SUSE Labs
>

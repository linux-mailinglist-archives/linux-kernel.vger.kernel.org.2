Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80A44C521
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhKJQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:39:28 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B282C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:36:40 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so3894426otg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34q8TP/FdpNNcC4qaqVLk8YGFJoEHKKC5e9KJhJR34M=;
        b=EYeT0zn+F7PuJHoM4eY4rPwqvLJrhnfcezHwOLSWUF7gmmJPNHECFdbLaQKpTW8UEh
         UjH/FM+jMjWNQVjOu+Vx2gWNaOCaybIdbhwEqHJfepbzMQUQjzBHPRgbNr6GViImou53
         LxCm1yAFloZb7f7jH1oQaTh1VQ/1ASYA/thgJNp0U6Ygxp76CQJEHM418KtbtiN+bGIv
         fLIzZ8FFOtrP6usxKGFMzepI4umrRJCqIAHToZZxKm9uSv94ixxsZaD4Rzih/q+loZ9T
         /fb1jlP7E30RghmjKxuOvcOoM4mpdNeXge460RzxjvXtqr77q1kOSXfJEjy+9JG3pkdM
         qX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34q8TP/FdpNNcC4qaqVLk8YGFJoEHKKC5e9KJhJR34M=;
        b=aciNW8DkPR0JdC+xpkIJCTG1LmHc+IxBbrU1i2ErN0qDloekBUK13jJV3ptQoOdtyF
         A5Uv9a4kVQ3pfP+ea8MkU3gmEcM5vf2c/z+4O458t47io5sqGS+Y16EIY1zOziXqkMDo
         M2A6yrmDYIa68LnXaOilJVIRwIOmNxTA5DwMUUT1nH0IIYKPUO8s55PFRczykz6zjLy1
         aaKlSR2qqRH25sEIMMkXhorpPD4zmWpS0iaFIrCla249SrM26MfsURamUzf0rTB4mg/x
         6NG1m2SyqR3iueN4pouPkkqK6YcSiZ1DNX409iiDbNj954qpGdw+OUFZhM0IWXKj3sP5
         W/7g==
X-Gm-Message-State: AOAM531WraNRep3oIaqeJ5/jblRBOW5rVj1ceA7n+oKKUqsjBX7fcpBA
        Qyti8YmXZSRE0gctj6NwXETZlTzsvVhKU+Kc9nfQ5FVv
X-Google-Smtp-Source: ABdhPJwpD6xChUUgRNOjree36MS1YJc+NNz3RmjGufQp5s4j9TIsPda0h6FvC/5YL5SaGc6+w6OFhq0BGW9R16c49dM=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr432516otn.299.1636562199962;
 Wed, 10 Nov 2021 08:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20211110094242.67668-1-vulab@iscas.ac.cn>
In-Reply-To: <20211110094242.67668-1-vulab@iscas.ac.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Nov 2021 11:36:28 -0500
Message-ID: <CADnq5_PL7Y8y0Laf7yt-hpwgLHjFtQOZtX=m4iooBvxLuU0Ptg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: correct indentation
To:     vulab@iscas.ac.cn
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Nov 10, 2021 at 11:08 AM Xu Wang <vulab@iscas.ac.cn> wrote:
>
> Correct indentation in radeon_driver_load_kms.
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> index 482fb0ae6cb5..7afe28408085 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -168,7 +168,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
>         if (!r) {
>                 acpi_status = radeon_acpi_init(rdev);
>                 if (acpi_status)
> -               dev_dbg(dev->dev, "Error during ACPI methods call\n");
> +                       dev_dbg(dev->dev, "Error during ACPI methods call\n");
>         }
>
>         if (radeon_is_px(dev)) {
> --
> 2.25.1
>

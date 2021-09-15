Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5440C819
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhIOPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhIOPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:19:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E4C061574;
        Wed, 15 Sep 2021 08:18:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w19so4600632oik.10;
        Wed, 15 Sep 2021 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s47povPHC17mzUM43hPaNuCVlnjcb1YymD4IzB2Fw7Q=;
        b=H5F4SycB3G6lDTgS54F9rM3ChhQpYgNJ6rzJ/MlpVYRsFh4NNy5t+vxycNUk4J0bpq
         uBSSBADO+WczlshwtZ9iWPmfOFEaesG+uiSGFNXgrt7if6pt3y+UW4z0HmSkjepr/+f7
         Kth7/1V45EdcFF3f2QSrCBiiCjKYWskPav4ZPn0L2mmZkrO285uPXregr24jHwNOQuB9
         kSnBN0ykE54FkubHzqkmKCFgqkW7zIDKKyjTmqs07MQ+uLzfKs35ta6efet5njFOOm2Z
         kcpnBzuHIZQSNGenejWwO4/lSwy2G2Bp7z5SWsNUMdsCNGlBb732df9SwZWKKh+VyQ43
         mxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s47povPHC17mzUM43hPaNuCVlnjcb1YymD4IzB2Fw7Q=;
        b=6rUbMaeOZP52ly5tW1xr89yajO57HGwuGQ9xqD3Fr39bRkgZoQ+YJMCRZD45y0l2yG
         44tKJWKsybG8nfnEgcFLPYIJ42Uwy6OajnOnJkQa+4hAYZ0brH0CD16dPRdkb4D5W7iO
         XiAmiIs/YG60wu5VjTFvsE8Xr120U40aCEXB88Rm0Sg+KeYeAW3q6s3PboaW+MOjkdLn
         qsNT6eAhWb28z4Zgd8QlwZMfXC7HwxRJFYiYqVDtzXwP9nskRqFIKKp4gT1PCCDxWXdy
         IGc9TMutR0qUjrrN5Oe0tB6l01LXpJ3y06FIMyebhd3cxppGxBMrobdWzU0OPHZ1WZs1
         x0pw==
X-Gm-Message-State: AOAM533kK0agiEBScz4xxgyMa98VmSYbJ/ZLrzkydPFxJcrpdbi82Eh3
        nBC9BEVisfDHGPub9kDv97OM5swzSxCGnwjSKB8=
X-Google-Smtp-Source: ABdhPJxN8y+U7oRECmZ+npqb9JFoI4RVReJOjBfUtqj5GftKFCmqUXmsC34nY5tds3nkg43tIAEhcR6O12emBYoBCQs=
X-Received: by 2002:aca:706:: with SMTP id 6mr5449830oih.5.1631719101439; Wed,
 15 Sep 2021 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210915113611.13620-1-colin.king@canonical.com>
In-Reply-To: <20210915113611.13620-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Sep 2021 11:18:10 -0400
Message-ID: <CADnq5_NW11tad5-jVEEL4CDUcOm==2zsUMN+v594fKdSg5JErQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: make array encoded_lanes static
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 7:36 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the read-only array encoded_lanes on the stack but instead it
> static. Also makes the object code smaller by 97 bytes:
>
> Before:
>    text    data    bss     dec    hex filename
>   38899    8064      0   46963   b773 ./drivers/gpu/drm/radeon/r600_dpm.o
>
> After:
>    text    data    bss     dec    hex filename
>   38738    8128      0   46866   b712 ./drivers/gpu/drm/radeon/r600_dpm.o
>
> (gcc version 11.2.0)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/r600_dpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r600_dpm.c
> index fd4226b99862..9d2bcb9551e6 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c
> @@ -1361,7 +1361,9 @@ u16 r600_get_pcie_lane_support(struct radeon_device *rdev,
>
>  u8 r600_encode_pci_lane_width(u32 lanes)
>  {
> -       u8 encoded_lanes[] = { 0, 1, 2, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6 };
> +       static const u8 encoded_lanes[] = {
> +               0, 1, 2, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6
> +       };
>
>         if (lanes > 16)
>                 return 0;
> --
> 2.32.0
>

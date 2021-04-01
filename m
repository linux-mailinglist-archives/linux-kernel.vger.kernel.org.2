Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227B35215A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhDAVL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhDAVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:11:55 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8BC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:11:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n140so3098524oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3O3ezYK4tjrRScd1RwWw7v+Stoxl6m+PGnpI8CPjlE=;
        b=DofhZBNC+BMajMH6Ihx31LeKFM6jRi6/ZtImsQ18V1w4naw4NzgjchsOgXd+iXKMPP
         /xqGIbyuTAvepsfMXVubdEw9/p1OJOpfG+LbXwzbZs83Ocf2J6TOsBlvWEDgp15aKkN9
         ngoxoETJBUekW/VQp3Mf5i9RHwZWb0zlIbgeYIjXfybm8Ol2a9zEJo8MEaXrCLEbi5XM
         nGFB4YHqv/190W4JWrcovVhG64otW8yaWxx6IN/tzmOyJogNVwa6COUkujm3vofv0FUK
         16z/pJEM3Whl/sgk85e1F4eTSjEhzLQEX4QLxn1JTPg2GqosG9DbOxPtz+/fR6kpstyS
         rMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3O3ezYK4tjrRScd1RwWw7v+Stoxl6m+PGnpI8CPjlE=;
        b=Lf206OaLmv8g5nErjPdsXs5NopovHl0Dip1pkaTdH1G614SzbDiTKiZbeyepL5lDJN
         HBpeuf60T4eaqppBd8AtCnUym58x9MQWvsGW7oyjhloD+DFl9RgtGARaP4cYapYx8icq
         PuhsnZbFoDNSDz9oNUyFNzRHmP64Vv03YZYcfdNxHeI8w3kz9/Mv4gxySRO//r3e2qlT
         4PA5gAcfOrvU3HkJwKPbJ2dl7YY7eToL4MqIpv2DH/mYG8I8TVg2bZNjdjb0wj8rWbyN
         EQnAuusBfjSVA0kXT7i47I5Bm/79+zWoZv+TB2VWOojl/fKzfeXS7Gg41sYhzdkLqLlr
         AZpA==
X-Gm-Message-State: AOAM531FITJ9bxbp7D+a4YJFgjWJ1aPsakuA2cd/gVjYA4jynmtuL5wq
        R3slROL124nPm6bL6Cdg+zG2a/zEzAmxXO8R/48=
X-Google-Smtp-Source: ABdhPJxehEErIgFKLEhysJ3MRBbpDbe4PiVid4S27ndYhqpWgh7rnSg+6pua5YkQyIVVJ70BZun3GE+BkeGJgKYJi4Q=
X-Received: by 2002:aca:4748:: with SMTP id u69mr7133639oia.5.1617311514752;
 Thu, 01 Apr 2021 14:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210331131205.60710-1-bernard@vivo.com>
In-Reply-To: <20210331131205.60710-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Apr 2021 17:11:43 -0400
Message-ID: <CADnq5_NkSUcYYZQnobUDZS8+-a2D32-DwO3JqRDkSh37OCPsXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: cleanup coding style a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        John Clements <john.clements@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Mar 31, 2021 at 9:36 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Fix patch check warning:
> WARNING: suspect code indent for conditional statements (8, 17)
> +       if (obj && obj->use < 0) {
> +                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
>
> WARNING: braces {} are not necessary for single statement blocks
> +       if (obj && obj->use < 0) {
> +                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
> +       }
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1fb2a91ad30a..43d17b72c265 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -449,11 +449,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
>
>  static inline void put_obj(struct ras_manager *obj)
>  {
> -       if (obj && --obj->use == 0)
> +       if (obj && (--obj->use == 0))
>                 list_del(&obj->node);
> -       if (obj && obj->use < 0) {
> -                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
> -       }
> +       if (obj && (obj->use < 0))
> +               DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
>  }
>
>  /* make one obj and return it. */
> --
> 2.31.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

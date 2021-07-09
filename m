Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE33C29C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhGITit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:38:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4615C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 12:36:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q18so25422299lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2U2kQrbeK6yCldnVDRPJ/ZaHJkvPY10dBngYqOaMhEE=;
        b=crTk0AqLwsaVtFV2GfnN+DDPeOmc/ojaEnT4qFFD4AWPb9GmJ9rL5a94Z5h7cRuR+4
         SOYZN8KEQlZaNdmMzsXJFe88cpIJ4Ij+p7/QtQEQs8rjDbkw1PyrhqW2zfl5UQb062SK
         OBSTI8+QENSjwZh0FlW5IY42m4Dr5bVJ+OO9nBFGnOMqyWpSEWB6apudQ2HgS27LmHYG
         EU//f0AZkEpsf/CxQ23BkSRHDrCBrzhVI5c73I097mCwf6hkzU3i4GQ4EWnGf8a9WNPm
         Xbcih562NKcvdmKJ5xd6+c28r0auzLN3zDZu01T1j4UpToVhvW6g1N49nnXLKsZFaXyC
         ZnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2U2kQrbeK6yCldnVDRPJ/ZaHJkvPY10dBngYqOaMhEE=;
        b=RELE41eSA/4i22BikelzMifC214sw/952w8uBCIKpDPES32p2WUlu0bQ5C80imPODD
         pTcqSidZaDU4mWNzQ2SzFyLw/2xB6W/a/dwrruOHHj3QsJjjFP0mRAglslgzY/p9PbPe
         RTc3B+1EvVz6AHcpNltP/nSjU+0colo3PgYCXs0QJV4cShbFgFVQh3fvuq1m4g54U70v
         eq3ia06mGu+/bSYCB2RxMr8URvVP++LLdZQ3nQfXCOm2zMsdxAdFO20tG4VjPv8dqmT6
         685GwuAL5PI95jlF4AUWo1vzV5jl9I29MKyTDtYEFyu3Q16lRHfcBGZ0VIbnXwkdEbxX
         U52Q==
X-Gm-Message-State: AOAM5306jdxT0YGq9iVNQFXRH1DR0jHyHxzM3M+btq23Xw8LCrRJnHwE
        0w9RtViRH0HcjvgQjOsJOB58HI5/ovpY9gkiaPM=
X-Google-Smtp-Source: ABdhPJyBCbKwn9zzReCzdj/pgI5h6sZXdNuZEmNZedP1m7wL8YfBQK6HslDo62ouEZbfqBnzImCHVykj6ZEyfIezDk8=
X-Received: by 2002:a19:d609:: with SMTP id n9mr9949297lfg.198.1625859362002;
 Fri, 09 Jul 2021 12:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210629115956.15160-1-jingxiangfeng@huawei.com>
In-Reply-To: <20210629115956.15160-1-jingxiangfeng@huawei.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 9 Jul 2021 21:35:51 +0200
Message-ID: <CAMeQTsbgrTa09t+qBHzoSRmK=WU5K0uTuQ8xRN7zd6XRMYMQsw@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Add the missed drm_gem_object_put() in psb_user_framebuffer_create()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 1:52 PM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> psb_user_framebuffer_create() misses to call drm_gem_object_put() in an
> error path. Add the missed function call to fix it.
>

Sorry for the delay, I'm currently on vacation.
Looks good. Thanks for the patch.

Applied to drm-misc-next

-Patrik

> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/gpu/drm/gma500/framebuffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
> index ebe9dccf2d83..0b8648396fb2 100644
> --- a/drivers/gpu/drm/gma500/framebuffer.c
> +++ b/drivers/gpu/drm/gma500/framebuffer.c
> @@ -352,6 +352,7 @@ static struct drm_framebuffer *psb_user_framebuffer_create
>                          const struct drm_mode_fb_cmd2 *cmd)
>  {
>         struct drm_gem_object *obj;
> +       struct drm_framebuffer *fb;
>
>         /*
>          *      Find the GEM object and thus the gtt range object that is
> @@ -362,7 +363,11 @@ static struct drm_framebuffer *psb_user_framebuffer_create
>                 return ERR_PTR(-ENOENT);
>
>         /* Let the core code do all the work */
> -       return psb_framebuffer_create(dev, cmd, obj);
> +       fb = psb_framebuffer_create(dev, cmd, obj);
> +       if (IS_ERR(fb))
> +               drm_gem_object_put(obj);
> +
> +       return fb;
>  }
>
>  static int psbfb_probe(struct drm_fb_helper *fb_helper,
> --
> 2.26.0.106.g9fadedd
>

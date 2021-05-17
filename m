Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD9383B00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhEQRRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbhEQRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:17:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:16:07 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso6218346ote.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xBDaVEbXGRu9l052Wzwx34wSV2NVJtrXnPmwUuBm64=;
        b=XySfAYGTZ6DPQW0mCUYcdwG2BOfs4TTQzxXT7geirkcLqoNso8TymlO0DSxQ4EUra1
         evUNyjAjtQUR9YCCUaHUFShQpNAJuYQfOa1tfMO3HwMafowImonDBqEaxyp/wInH2qsp
         8ppNl3XUt1jqumyB3gCRIRwgonKojBIzBLdq7jdfiLFZi+VWVyZN7ijkA85ndt8iK+/H
         UKOicrMy/po61xxK7gmiacDC48JagET7k653aqzZ2ZQRtlreqB+TwLJGlA65LuyGfFrL
         UvKReqvupNRQZ9VsxPRCMY/Vk1QkrUP/TDVOtgM7RWu06YCNNwCYyBboQ0ahNymOyneT
         69cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xBDaVEbXGRu9l052Wzwx34wSV2NVJtrXnPmwUuBm64=;
        b=KbgJ5ZGivTtOxmLKtvUqN5uwh5TqbcYrolfvwg8j0xaUeI3K1gtBulrH+fIPenZtDw
         18SR1kX7QkhXaCogtcpSkSAGUp1F3yvJlAuTSaDeNY0G48TVaEps6YO5FwdnMO1DIUWY
         N/6XnNe4NR+ACuiiMFlEJ/JazTzrbcj1OO1BVOVRJ1eF3ZWlEjXiG+dPuDJJxwMUqXUU
         yg59jRcBs27OZL5JiOnPQ1cHpxQGzJMaK6VFQqsqIJhG+XmEvVxpO2O/MEtL+a8/IdP+
         MffDYa6PxWztugGyYe5hqFrI5rjWvmFLPwkdrXI1Pfr03ah5RVvDu1g9Xnq3FwOWKJfI
         1/jw==
X-Gm-Message-State: AOAM533rOfBl0OkhRYhbD/OKwjQftPeX0xE+lkeRJ8J9/1QIt0LPxhUr
        RachXbFV6ikThHFCP/vAH+qx27xaJBrcA+MlbwQ=
X-Google-Smtp-Source: ABdhPJyNkLmTwrVqlUZyWSMcpDD9a5UrsmvHIT/nk2h2CKZYzPsfx42ok1JoA9q3mzE6yfWvGXXd7jiPsNYb3o6AmkM=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr481703otl.311.1621271766808;
 Mon, 17 May 2021 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <e5f8613b96fe43bd8ab2ac304a2c9fb57a87a2ca.camel@perches.com>
In-Reply-To: <e5f8613b96fe43bd8ab2ac304a2c9fb57a87a2ca.camel@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 May 2021 13:15:55 -0400
Message-ID: <CADnq5_M98GPrHk6cdbieBtFDQYaauHzj1gm-OXn0bYTRjtgzAw@mail.gmail.com>
Subject: Re: [trivial PATCH] drm/amd/display: Fix typo of format termination newline
To:     Joe Perches <joe@perches.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 1:01 PM Joe Perches <joe@perches.com> wrote:
>
> /n should be \n
>
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 45f96221a094..b38fee783277 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1724,7 +1724,7 @@ static bool init_soc_bounding_box(struct dc *dc,
>         DC_LOGGER_INIT(dc->ctx->logger);
>
>         if (!is_soc_bounding_box_valid(dc)) {
> -               DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
> +               DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
>                 return false;
>         }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 5b54b7fc5105..3bf66c994dd5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1497,7 +1497,7 @@ static bool init_soc_bounding_box(struct dc *dc,
>         DC_LOGGER_INIT(dc->ctx->logger);
>
>         if (!is_soc_bounding_box_valid(dc)) {
> -               DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
> +               DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
>                 return false;
>         }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index fc2dea243d1b..84c61128423e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -1093,7 +1093,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
>         DC_LOGGER_INIT(dc->ctx->logger);
>
>         if (!is_soc_bounding_box_valid(dc)) {
> -               DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
> +               DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
>                 return false;
>         }
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631A3425B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbhJGSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbhJGSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:47:51 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F24C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:45:57 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o83so2854156oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rDadMTPT7yyY7zuLSmBvIb9W4n6qJgK6CHOiJKi6wrU=;
        b=dGQk+EoGS93Xn4qHMUWC9fqgM3FVdBsK9PkC29RD2iUQAxVVP7KAoVKjv54fxqJkzN
         KJ6XZoKXFqaMjVMMXW/jvz+J9W1IqQ5VApJlrWQkwHn6KQ7MsGCQAvRSpkg4qcWbAKMa
         rUz68kF/gjv8BKru2E0qaN98F2fgjgIEGBS7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rDadMTPT7yyY7zuLSmBvIb9W4n6qJgK6CHOiJKi6wrU=;
        b=l4jR+7VGT0+lvrpraHYIO6WRuhQ5O4JU1BjZ1DGxzgC+SlE+fnfB3QCpl+LAO0vfeZ
         VTFN5eomC7+kolNF3IFyCH/invmz9z09sLCZaMM2cifM7wqf/0TGM/6DRwipJNJVoIBp
         KK/unXqEqKrgkbBAQ+vIkbMuSQjuZoFQksAZqCgFhipF9+L+2IpERPweefOrpB9v6CzA
         7NIgN79m0GF/i+diDYpjmZgpomUUe3zR7zRpi0OukIalRQQoUl/dhD690PxjWOEUfJWX
         Ylry5ct4XZQZ0kjo0up/zwRxmsgYuhN7PKjpqB0FoWzDj41qPmievTo8QbJThV50hNo2
         XlUA==
X-Gm-Message-State: AOAM531O85v4au/6cggxALBNwSb8/ZyA7OtjOHGA4dHElcoNZnqnmxmy
        RkgKo6oiY0m2FXuk9QzxG9i4POZb5h42QP3XVumJEA==
X-Google-Smtp-Source: ABdhPJxBJsyd0RzB+el+45iuDcFtlkQElBx3yXG2b/lZ0Xu1oExh/Yl03jChEI82FDGbQZVvKT7JtH8AKdJBrny2ByM=
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr12980586oiw.164.1633632357140;
 Thu, 07 Oct 2021 11:45:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 14:45:56 -0400
MIME-Version: 1.0
In-Reply-To: <20211007183341.3140281-1-bjorn.andersson@linaro.org>
References: <20211007183341.3140281-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 14:45:56 -0400
Message-ID: <CAE-0n53LwqpTyxrRwwEiJQVpKgS4QVNuQFz8WD1VfR=s4eHWoA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Simplify the dp_debug debugfs show function
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-07 11:33:41)
> The "dp_debug" show function allocates a buffer and piecemeal appends
> line by line, checking for buffer overflows etc.
>
> Migrate the function to seq_file, to remove all the extra book keeping
> and simplify the function.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  drivers/gpu/drm/msm/dp/dp_debug.c | 161 +++++-------------------------
>  1 file changed, 24 insertions(+), 137 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> index 2f6247e80e9d..566037942343 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> -static ssize_t dp_debug_read_info(struct file *file, char __user *user_buff,
> -               size_t count, loff_t *ppos)
> -{
> -       struct dp_debug_private *debug = file->private_data;
> -       char *buf;
> -       u32 len = 0, rc = 0;
> +       struct dp_debug_private *debug = seq->private;

const?

>         u64 lclk = 0;

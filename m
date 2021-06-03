Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278D39AE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhFCWcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFCWcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:32:08 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D9C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 15:30:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso7282606otu.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9us/X29o3VT0A9yPJl6yvX/k+4UGGdwauIgNXt1rL50=;
        b=Ae4+I3or7ogynbEpsfQtXyErORg6YvYL19cfW+k2mIAWjUKF8FtNeKxN1JVYt+L/Cq
         swe/mwLSNf20XJihLEB2Gn2zeOVY20uCemPtSF4nI/rvPG46Nd3ArPzbp3b6z4OJK7dz
         DI9vOk+8E71HnUl41tmrEWe0HaVFmADnj7vwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9us/X29o3VT0A9yPJl6yvX/k+4UGGdwauIgNXt1rL50=;
        b=AdJ+PPLTgIcHyHmRIsdnh8/Kyl4ojZ2KtkTdIgv05Q6SZsFgIvxMcPwk+cT4vRdk/M
         YLlWJXYJYkT01n+vaRA56bc3/l8BgVin6ipBBGnhrG6G8yavF7ds4CZQ63TOi6VsUfir
         0hOB+yl0qfUHhBFkJen+A4obJZxcy7NFQg6AFT1to555pdXzafM/oH/qcW0dynsekwYR
         DG1Tq/pU6Bpz1e2OWjExvaYTqAUuyO6FPR7nhFF8af1vr5KXkOOtj0k6Zrs/XhvnUxlR
         ErNRpvDxhQD+3Kp4NdXXzru2IE/uk8B9Vf3lWo6tY47iWzIfjXfX1nUu6phuIogjgrvg
         b5Vw==
X-Gm-Message-State: AOAM532Z67lCCg6SIJij0pSsInittjU2NO376P+rSLzyKKhCIgBom1aK
        a3k/qxAjQpozFT/G7VXqyDijxYzSzcQVgobsOrt7EA==
X-Google-Smtp-Source: ABdhPJw9y4/jOJCkB2/176jBXW7Rl0wjqh/5ugEle6IRrPcBapG5B8JW+7gbN8S/7HIoRZVy5ZQiuqD1hEqLALTtt+A=
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr1249312otq.303.1622759411317;
 Thu, 03 Jun 2021 15:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210603215819.3904733-1-keescook@chromium.org>
In-Reply-To: <20210603215819.3904733-1-keescook@chromium.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 4 Jun 2021 00:30:00 +0200
Message-ID: <CAKMK7uG7tDVUV3cVmtYMFdwVx1SuEWh6i+VsQ3nLP0Rb=-f0aw@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
To:     Kees Cook <keescook@chromium.org>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[gmail is funny]

On Thu, Jun 3, 2021 at 11:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> pl111 is modular. Update the Kconfig to reflect the need.
>
> Cc: Emma Anholt <emma@anholt.net>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/pl111/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index c5210a5bef1b..b84879ca430d 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -2,7 +2,8 @@
>  config DRM_PL111
>         tristate "DRM Support for PL111 CLCD Controller"
>         depends on DRM
> -       depends on VEXPRESS_CONFIG
> +       depends on ARM || ARM64 || COMPILE_TEST
> +       depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM

I thought the canonical way to represent optional dependencies was
depends on FOO || FOO=n

Since we don't really care whether it's the same as DRM (that's
sufficient, but a bit too much), it needs to match DRM_PL111, or be
disabled. It's at least the pattern various drm drivers use for AGP.
If that still works in testing, can you pls respin?
-Daniel

>         depends on COMMON_CLK
>         select DRM_KMS_HELPER
>         select DRM_KMS_CMA_HELPER
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

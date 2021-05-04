Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6C372E07
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhEDQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhEDQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:28:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:27:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m13so9293783oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYF7uUe0NSSJCsH19h2K0ONCXMFGfdoSakxploOCV0I=;
        b=FfAikBWHjfuKkAeTPxwjl/w800FhqUT9u9QL2i2sOIzQ2uPv2fE9oUb/mDJSo6Ty+S
         oFL9pETzB/3ytHSJhV8ZcLDnRe5IUwtpTzOvPryHm4NzwxuebeQsBxxnvquIfA53MHqb
         9WeSY8YoyNqwsOZ6mpywqQOzm5RnM4Q704264=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYF7uUe0NSSJCsH19h2K0ONCXMFGfdoSakxploOCV0I=;
        b=pU4OinzrTxjRFNNTBKM9xqWKTjdMeDBuMGHvQKS8R6TZ9tMhqYq8WdBB+ttEwwMrCG
         B2DoHXAq3IMQQoxuDyx7H8IMp8GOsFx49pstLwr3pgDiupHqwxyhOn222T+V5F6pb0gz
         mdqna4zOsECiQxNwokpGpPScu55TaacSwL9EcfV1uLdnfNeNihOqkqI6Cr/q0BOpae/M
         c1gS7mlMqYFeRICcoJM2gB+GFXzlQlS9fAcMNibcO+zvK1rq6YWypmnKc77FVpKJtVjk
         oFDW8b3MVqh8Bdo2Ome8JhRm2A5HoDkc+RiLD2eYUP4h5ijHbNKv6x2CWMXJyGd+BsPe
         HUsg==
X-Gm-Message-State: AOAM533DA341UltNmD+IfcFWDrfmQ835KO7XMfXp4L/7KWfxJV4cYVFQ
        eixTSr/p0OHxisan3VLAlkli9nuyF+vT5RK7ygHq5A==
X-Google-Smtp-Source: ABdhPJzeyuzhzEF4gjzViZ7VOW+e0CqP6lg5U4itQk1v3xCNoIGcrH1flchbU+farzPUB+KtPOd05UmsfzRZLFXH+RI=
X-Received: by 2002:aca:2219:: with SMTP id b25mr3525216oic.14.1620145663881;
 Tue, 04 May 2021 09:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210504142910.2084722-1-linux@roeck-us.net>
In-Reply-To: <20210504142910.2084722-1-linux@roeck-us.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 4 May 2021 18:27:32 +0200
Message-ID: <CAKMK7uFNtE=hW75kn8tnSHpZveaUtavMwk6Libb9uUeonz853g@mail.gmail.com>
Subject: Re: [PATCH] fbmem: Mark proc_fb_seq_ops as __maybe_unused
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 4:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_PROC_FS=n and -Werror, 0-day reports:
>
> drivers/video/fbdev/core/fbmem.c:736:36: error:
>         'proc_fb_seq_ops' defined but not used
>
> Mark it as __maybe_unused.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Queued up for -rc1 in drm-misc-next-fixes, thanks for the patch.
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 372b52a2befa..52c606c0f8a2 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -733,7 +733,7 @@ static int fb_seq_show(struct seq_file *m, void *v)
>         return 0;
>  }
>
> -static const struct seq_operations proc_fb_seq_ops = {
> +static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
>         .start  = fb_seq_start,
>         .next   = fb_seq_next,
>         .stop   = fb_seq_stop,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

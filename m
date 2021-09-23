Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF0415EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhIWM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhIWM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:58:11 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:56:39 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id n4-20020a4aa7c4000000b002adb4997965so421271oom.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVXu7kjSXu+P/8oGmOO5Kp7VFy7hdCAFq/98GJCuVfU=;
        b=gNu2dzSvL+TfeLTj9hs9GpoKvriXkgOe2vM7Mq4Y/HBCJ5pWQxL5fr7L72Ldx2188w
         7J5iYp7gQGXBOZ7wkPQ2OZs9ItXBkJLc1aEWmsmxt0w9NzRjq1qNdgt6p+u1zEkQ8UPe
         nMjuluGGLMbjtUtl8a3Y2yC50cwpeZQSVQEf6eG96KAWm5TmGxgT4xJocX40XSBPVadp
         hoehV+YiPiKZ62wihEw7M4U6+m57nFpOwkJDK4xgHOQX6T4tBn4FJSCLfxHJtrUtAk7W
         Utj0Ao8MRe0YkU1+bdUZ9A+3wZLWDigymvsvav6IcU+cOaNJBWQpte+NyF3Fg6EvsZ9S
         F/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVXu7kjSXu+P/8oGmOO5Kp7VFy7hdCAFq/98GJCuVfU=;
        b=PGTcSsIiWycescmTZlqrmTpkMUXelTS3yKg8geyjhXPP47+nR2RejWwE9aHEERKy9J
         QuUWjdlYNPmqAss8lDPJdTEB/80tgqYm789nwG+89JgkRbZMW5JKQ66sYWL+q973tgpL
         8fhjFy/6DlQvty8LbyYPvy3zTht85iyb4BopFVKvRMdQbAi/mMaeZ4RkvY1ZKWY5y3jd
         WzNaRUT2sl35IpwwRKHVwBhrigX92CleLCagRKQywJhAs22iOj2eBY7LEOnZl3qekHzy
         nCTSiBSKhZv8X0RpDedRPQsgVjLjGnqf5yR9alc4bSp9DnyV9jF+4wIjbryD3g92aNQs
         9G9Q==
X-Gm-Message-State: AOAM530b0hRRGMMjLVmWYbNDlaV+UagYnBN+BTrXZCH9p/8BazrTJEaM
        gNgt6kLDkjTjN8FZkrxVH4gkanNqA7XPNQv14ok=
X-Google-Smtp-Source: ABdhPJw+itN2funATMJjYzrnvfLukCJ8KMynQKVWLKTfPY1S5tVJl6kJS4XE4j70X9EfHKNEdRDb3ebGSnBXHlVTSxc=
X-Received: by 2002:a4a:d794:: with SMTP id c20mr3562114oou.23.1632401798852;
 Thu, 23 Sep 2021 05:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210923090232.61559-1-yipeng.chen@amd.com>
In-Reply-To: <20210923090232.61559-1-yipeng.chen@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Sep 2021 08:56:27 -0400
Message-ID: <CADnq5_Put1U-X8MBS4Gpxo2zkkyNCS6yum+X3q+H-30xNn31_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix randomly flicking on overlay with
 enabled ABM
To:     yipeng.chen@amd.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Cyr, Aric" <Aric.Cyr@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Martin Tsai <martin.tsai@amd.com>, bing.guo@amd.com,
        roy.chan@amd.com, George Shen <george.shen@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>, Jing.Zhou@amd.com,
        dale.zhao@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 5:03 AM <yipeng.chen@amd.com> wrote:
>
> From: "Yipeng Chen (Jasber)" <yipeng.chen@amd.com>
>
> [Why]
> Enabled ABM (level != 0) would raise short pluse irq DC_IRQ_SOURCE_HPD1RX
> randomly with PSR error LINK_CRC_ERROR. Actually there is no hot plugging
> on EDP panel. After correcting CRC error, there is no need to send drm
> hotplug event.
>
> [How]
> Returning false would skip doing hot-plug when handle_hpd_irq_psr_sink()
> handled irq. Hot-plug process causes visible flicking on overlay.
>
> Signed-off-by: Yipeng Chen (Jasber) <yipeng.chen@amd.com>
> Reviewed-by: Roman Li <Roman.Li@amd.com>
>              Anthony Koo <Anthony.Koo@amd.com>

Each reviewer should be called out on a separate line E.g.,
Reviewed-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>



> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 1e4794e2825c..9b9fbe5e9bd4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -3007,7 +3007,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
>
>         if (handle_hpd_irq_psr_sink(link))
>                 /* PSR-related error was detected and handled */
> -               return true;
> +               return false;
>
>         /* If PSR-related error handled, Main link may be off,
>          * so do not handle as a normal sink status change interrupt.
> --
> 2.25.1
>

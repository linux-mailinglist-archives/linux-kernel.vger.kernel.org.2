Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A558830934F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhA3JYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhA3JVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:21:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49193C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 22:32:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s7so7963714wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 22:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Nm9IfnYPTwx6O0U9BdKLhxgG7rzF4f0DS/IBep8xNQ=;
        b=dAtNPsQdYjophNuTU8NT6epZcaDeSrQs/c8eei4DT1CWQBEjlxVGw5Goax1seBiwBQ
         jEnwGrlEFssBsfg7D4luNcaUa5QRab0GFZJrpVVACtHEneFndwwVlPeXQA0rEsIIGZfW
         Dz069gikwHnLrdL4SMMRsvl8air957bwcy5YWCPNcX9KC+PlI728BtkiW2Cz+8Zp7yDQ
         qLfwrjQDcZK9aD8sh6ZnTLa6NMb+6KW3I7eAmMz9X5NcdzPh74wtay+WBTZQBfd3eDmY
         qpsHgLNYAbq3Sx3lDXQWCVA5JYDNmVrB9SBbbOcVmzKl4LxbIDepT2dnMAlaMbZF/QgO
         YmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Nm9IfnYPTwx6O0U9BdKLhxgG7rzF4f0DS/IBep8xNQ=;
        b=NHHhSIGFUY41azFZNyWundWoQhDoBvr/oBdhC4/LAoPFQwIshduiTwbD48HbxJh/cl
         vZZHAUV/dXpeKtfJo0yyH80S1yo2PuUaRorXUiv7MdP+KcXDSkE+tSIWe15DqnwZgVCX
         UEYe4Zlezro8iPIP156dJmU9vrjoERk0VnRcHyVaZAvyTuxmuKvhae0l8h0afvJ+uew9
         KMIUyCRKboQ5kO0k5yOnHEwwmuVX3L/1fDF2RNyZ9T7k7zF6Wke8kW6IkSKlTHtIMKXR
         Fa1pPXz7mBl4ifeCJAQ07/l1G7uXkebFlCxfjNAozdhodf2+g32epAhn4CYQomqRCVJP
         8IAw==
X-Gm-Message-State: AOAM531HamyPv0zCAvjK7SHHNpuBhT5XZjEYhDmDT3WAhJ5aWeGLrtQy
        SGYPPLJXk3jX5cVzCoDtinDNERhIWiYZuDsDSM8=
X-Google-Smtp-Source: ABdhPJy5ra0GCZkItSzcz2upUZ3HQLq88/bhFgC5ykVBf87d+3YorQ3DFUHffmOzAOPNWuCENk9vsJ0QNM03cQUuawo=
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr7992929wrv.208.1611988321918;
 Fri, 29 Jan 2021 22:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20201127094438.121003-1-miaoqinglang@huawei.com>
In-Reply-To: <20201127094438.121003-1-miaoqinglang@huawei.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 30 Jan 2021 14:31:50 +0800
Message-ID: <CAKGbVbs=jUMJxvTbi1Pd3-fCb7R2dsqu_eNbhkAQMm2GZDjWCA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix reference leak in lima_pm_busy
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to drm-misc-next.

Regards,
Qiang

On Fri, Nov 27, 2020 at 5:42 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to putting operation will result in a
> reference leak here.
>
> A new function pm_runtime_resume_and_get is introduced in
> [0] to keep usage counter balanced. So We fix the reference
> leak by replacing it with new funtion.
>
> [0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")
>
> Fixes: 50de2e9ebbc0 ("drm/lima: enable runtime pm")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index dc6df9e9a..f6e7a88a5 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -200,7 +200,7 @@ static int lima_pm_busy(struct lima_device *ldev)
>         int ret;
>
>         /* resume GPU if it has been suspended by runtime PM */
> -       ret = pm_runtime_get_sync(ldev->dev);
> +       ret = pm_runtime_resume_and_get(ldev->dev);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.23.0
>

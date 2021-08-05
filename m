Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84F53E1CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhHETp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhHETpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:45:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E87C061765;
        Thu,  5 Aug 2021 12:45:39 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y18so8887126oiv.3;
        Thu, 05 Aug 2021 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqhS5sUxb+FPRaCHmEWlXq3OvfKWMu7XyfbVn+a5nZ0=;
        b=ofpTRUJcKmfmo43OyrJS4dZ5vMxWnnJ0cbyaTvQzR9uVGmEcyeB0XNSK/Xj+HZP1uQ
         iJZPQdwsWTRpdZ/yllLQhRQeUCaShZrke6Eu3N7VECTgzErEupVOCkWFIO/d5tN0FiWL
         JZ87mc5Y9d/gPNfVxe05qY84BGaAbtfO8tQ6SzaMzoGLKwN53MBFeuhTjX4KsE+OSv36
         X1Z0nHMsUdFyHWZ0UkC6SVY0kLa1lFz85NXBSp57KBgJse2ReaW6jVuRzkrQJcvC0yJk
         Rm65oqHcuWn8yy8MtXEANt+7U3hdIwM7kWvXa7AS2P7aninDFW1MyHZSqSZw4lvIGlRD
         tMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqhS5sUxb+FPRaCHmEWlXq3OvfKWMu7XyfbVn+a5nZ0=;
        b=H8KV1P0/qu6OcmimGIJb0EkQQGQCvJHSJYS1VWq0gz0SiaNHR3z1x3oLwM5DOrWpYv
         g+1V4rjB+DETFUbQvasIbKZ3eexNjGVw0yRbN7D+jFTf8M7kl9KqrRLNaDqvaBCmCw3p
         oDGK4CVrv4Q+dd/+ZkDKppOVRfdNNypHXK8tzCvDkKou9GP1mypR0hcOo40Aa0c2+3T4
         W/YW5bNrH59jpoJjChd2QIREQCmnpMffkwXyWVWDYlkxJ7DDGLnKo3S/5fH9PcfwvWaP
         Sppa9M8o0rn5PLd2Yuc3opNn96MoymPjuzuFdnXUCGKwfKNQreIRa/+qRXMcFIMu5cLu
         yeSA==
X-Gm-Message-State: AOAM530rcRM9seXBo5FGLke7Yj2h9LiaQ39uV+tdIJyZyi2dtKqxpeIi
        8DpimO1vQ7xe78n0Il3ZLjJTDe2XeloRpFYCSIo=
X-Google-Smtp-Source: ABdhPJxrEYt0szkcD/cfSYhFo1AC+UgnnsHdkrgRqo4gcN3MWQd6mMuRE94WTAiaWxNSQ9u9S4jqhgDoI1vNMkMuBcI=
X-Received: by 2002:a05:6808:6d2:: with SMTP id m18mr4805541oih.120.1628192738822;
 Thu, 05 Aug 2021 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <fd28a9cec24a8d32ebb26dd857c399d0a15acdd5.1628188477.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fd28a9cec24a8d32ebb26dd857c399d0a15acdd5.1628188477.git.christophe.jaillet@wanadoo.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Aug 2021 15:45:27 -0400
Message-ID: <CADnq5_Prm8D8z5TuH-iha8DvEX9oRqzaRNqdCyXjAVib1=qozg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a memory leak in an error handling path
 in 'vangogh_tables_init()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 5, 2021 at 2:44 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'watermarks_table' must be freed instead 'clocks_table', because
> 'clocks_table' is known to be NULL at this point and 'watermarks_table' is
> never freed if the last kzalloc fails.
>
> Fixes: c98ee89736b8 ("drm/amd/pm: add the fine grain tuning function for vangogh")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 335b3c70e1a7..06eea917284e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -256,7 +256,7 @@ static int vangogh_tables_init(struct smu_context *smu)
>         return 0;
>
>  err3_out:
> -       kfree(smu_table->clocks_table);
> +       kfree(smu_table->watermarks_table);
>  err2_out:
>         kfree(smu_table->gpu_metrics_table);
>  err1_out:
> --
> 2.30.2
>

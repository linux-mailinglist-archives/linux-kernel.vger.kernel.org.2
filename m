Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E017C376FFC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhEHGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEHGK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:10:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FDEC061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:09:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id m13so10790777oiw.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 23:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=+ehCmrhhM5OGDTE20S4py5cwY10k0xIadseOT++JVkU=;
        b=filaKRYCVqTgLrB7WYSzzG3Fi5HrJFb7fpcmY1plN+C7xJALT1EJeR+Yqm9YTg6/hP
         N3FPBwLjZaSQwbDlFOfRY/lRGwTqgshbIylR37I495etiV4LoY/JA2jzzGThnnzpq2Or
         +82ApXbQhbi2MA3dplRMFrTSqRg4ogvzrlWsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=+ehCmrhhM5OGDTE20S4py5cwY10k0xIadseOT++JVkU=;
        b=WanzEWM87ASnwQxuxLn7lXlMA5iJbHpJ10raupIUvBM9S7VVzTdZb2lrVeTwbeWyUL
         C10A2WzhLd+EnC9MVVd9zkKc17URmPGwpsc2wq9jTyo2VYgiaKsPfcJoVLR3jqmC6WqI
         aF1pkgAPbItU7DMfK2TEuxWPT2PCUe5U8fYzRaIshtALjT6VceCzHy8fEauobfC4R6bB
         VZI1/aeS8sodvgMWWeILqF4iJS8X7tmBtF2mER/B77Yh++SGvnC+mGstAcD7bVMiK7Wz
         ERgfntmm1yGzu5rksmuHmHIRZTKEaZXd4nU56YPnh8yZOD7k+BRdazQZlXQhyFxDTYAn
         +4Jw==
X-Gm-Message-State: AOAM531hXbCyXVU5K8eL2VIZdJlFjF3CnybLERBUxJN9vpI5MXpW0G+w
        tQZOtnnBOSCtAtk5MQuhempM3cfdCYtGgCAaHyznYQ==
X-Google-Smtp-Source: ABdhPJwCjdFMtu/woUmAWajk3S7zPVWlf7VcEkGyAgxE1bs3Mv227JjHZld7Ob9xYKO0lx4jgnp4g2qGCeSaEupXPEg=
X-Received: by 2002:aca:654d:: with SMTP id j13mr17682432oiw.125.1620454195844;
 Fri, 07 May 2021 23:09:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 8 May 2021 02:09:55 -0400
MIME-Version: 1.0
In-Reply-To: <20210508024254.1877-1-thunder.leizhen@huawei.com>
References: <20210508024254.1877-1-thunder.leizhen@huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 8 May 2021 02:09:55 -0400
Message-ID: <CAE-0n51owL8RGJyz_5BUCTjrUW5m0X-DTKUx=mqRL=-4i-tMDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/msm/dpu: Fix error return code in dpu_mdss_init()
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhen Lei (2021-05-07 19:42:54)
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
>
> Fixes: 070e64dc1bbc ("drm/msm/dpu: Convert to a chained irq chip")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index 06b56fec04e0..1b6c9fb500a1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -253,8 +253,10 @@ int dpu_mdss_init(struct drm_device *dev)
>                 goto irq_domain_error;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> +       if (irq < 0) {
> +               ret = irq;
>                 goto irq_error;
> +       }

It would be even better if ret wasn't assigned to 0 at the start of this
function.

>
>         irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
>                                          dpu_mdss);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A141341386
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCSDgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCSDgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:36:05 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:36:05 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id w1-20020a4adec10000b02901bc77feac3eso1973318oou.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5N2rEg9VhvQue8bVp0pO6l2JMPpHyJZDJ/KHUZ6Vc8=;
        b=gsF2SBGxPuldrPBxT5jwhewdWAlJbxr1L9dZBZUUcFwdgZx9Ms2OhyJXS2groCwCSv
         NGs1qwm/SvN9bBqhpLgNByrDc4kHjPn/+oKQX7xydlyomPlyJfaLfz+FeGWHAKJqxnRS
         bguiSo4SOkcgj5x4aatLQuvabk+r9ICB5Yn5uMCQXRKKdfpjUMeltXB/yvq0VKgRiPhj
         35qlxaR9w8n7jbDyKYbU383MwyxpV52t5yeymGHcjsdIk8SMlUDVM2mbnGlx9QSj2n96
         EK40qRsNSZ22qbw3kZ/M9aitqHhijPycjqZuwEEtwrQ9946SOrjwAyImgzwnxqXY09jW
         zaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5N2rEg9VhvQue8bVp0pO6l2JMPpHyJZDJ/KHUZ6Vc8=;
        b=DGzFEkjvvcKzthwXr+GfptWcUM2zcxgNCr9B4deQiDnT5oP3ZTZlomX6a0GwkfjgxH
         CMDJJcrwIb2P0sWVFxArjeoQ4r1zEFNkpsUBDrfvHb1OJvwAx3hazSZbfUvV7rb0bt9X
         VBqt6FNi0F398w4YHsarFa8gtBiTv4IdFaExTmQJGrBo9ZixuQS/QeS3dX7aaNLdUILc
         x/I6BI37Lh5TWYkKRL9BQrpddUuIzYhjUnQm7Gv01mO8c4UhrVFYlocLy/RZcnwPm3t9
         d70L+5x1oJuDupBVK3cm9MRMeBs0IDxJMGgGuFP7SbHWN09IpoBm5H/CV5axbX+C+E/1
         KE5Q==
X-Gm-Message-State: AOAM530itSXsQ42yxuZ64eUQ2CBau9X6Qaks+KjZqnxUkXaFTsAbxvci
        FQ0eh76nggyi0dE01YyCBmBgRXISiEjDiNwRjwA=
X-Google-Smtp-Source: ABdhPJyNOud3n18QxGzdZdz018WeLgmgfKwbaEPYrkO1ZJitepN9fMereYb0SpwZhay6NBxjkw/To45EBcK2OfWgoz4=
X-Received: by 2002:a4a:7615:: with SMTP id t21mr9986585ooc.72.1616124965033;
 Thu, 18 Mar 2021 20:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210318231815.19546-1-unixbhaskar@gmail.com>
In-Reply-To: <20210318231815.19546-1-unixbhaskar@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Mar 2021 23:35:53 -0400
Message-ID: <CADnq5_MC6f72e06xhWxQ_UKMYiw_=KfiESWxFm8s8rXBPPkMSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <John.Clements@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied both patches.  Thanks!

Alex

On Thu, Mar 18, 2021 at 7:20 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> s/proces/process/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index bf3857867f51..c1d5a3085bae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -598,7 +598,7 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
>  }
>
>  /*
> - * save and restore proces
> + * save and restore process
>   */
>  static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>  {
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

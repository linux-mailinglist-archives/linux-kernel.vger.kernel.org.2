Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5C32F38C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCETKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCETKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:10:02 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F692C061574;
        Fri,  5 Mar 2021 11:10:02 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j8so2862311otc.0;
        Fri, 05 Mar 2021 11:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXzxwkzjLPM7KiJlrDFoXaEopVztroSTDc/T8EMHkyA=;
        b=MHFhF1jy/arRNMe+nRyOQC57EQvTOsY6xXLgEOXZBFd9dqdRZIVlBWIC3S97NIQwtQ
         iDuxd2SYi6D5XyPg6ecwKwFK4V7+/3FnqrNOtHmvpAkgcbm3Tmeap4lZh4OLtlEFugHi
         Y8xiHkhEjmUq9D9igDgXhvovqcXUTS25i0s39z0sYCvqDJzfvHoiJlbs3Ag9RHvyh1s5
         RvidPRO0ZNshH3OQQ9y+t6prDNk4K7SWqtf5+UpJa91klgQIrIx45TZqHL8+KGNc9Tnt
         6J2EYeav9hkbRjCUmC0MQuq5T5MqzH6ELwBol9e12fXYY1/x42Can0cE348oscPRuDGw
         zdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXzxwkzjLPM7KiJlrDFoXaEopVztroSTDc/T8EMHkyA=;
        b=dBd5IRzcVF18KP8Yo/mION5z4cbMHaqns9fOi3DttltOfl2tvZ31TCYBhbPRBJgYok
         hQ8/nzj2/7JM3B/olMmUt701Vk95C49qUxgD99fSD6tJh4uHLEPRJ5fBm7yxiNf8Y/nF
         RgBq4lUY1avX/HWwnbzkDiIrO6T7wYrJrfhqgdgYPoiYv0h3Kd5rR2yzi/q1x2vfi8+t
         bUIeMB/wMM82a6FKNcEcZHiSR9HAo4IWjOHODQx+yMO7d0UbWVPDGbFfGT7zTQzn1Nxt
         Fhk2IKTAXG0eVRxyfvMK+48zhBK8m+b9fGwaXbKffRyoDuO6iz34VL/RTAhtJZt8GP41
         xsAA==
X-Gm-Message-State: AOAM530a09shdz3+RIWCCZbIIw8alT4Gddw0u+e8K8ph4IXtV0zRxe/j
        1ncCErFOvIYLHhZIaO9PlmLs/Mc+gpdexTGw0dM=
X-Google-Smtp-Source: ABdhPJx2hSgeK+Yqg7IMRFfwiaPsKVqALRblWQSXFF33Bri5Jv38Yca6XaIqX4fmYVUvCMVExpkjIb4XO50ayw6IDFg=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr9318715ota.311.1614971401734;
 Fri, 05 Mar 2021 11:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20210303132510.66904-1-colin.king@canonical.com>
In-Reply-To: <20210303132510.66904-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Mar 2021 14:09:50 -0500
Message-ID: <CADnq5_Pqd0J_VpSkK_hAd9mUg2YgBLcZCEo3u7pXADPAW0_Zkg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/display: remove redundant continue statement
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks.

Alex

On Wed, Mar 3, 2021 at 8:25 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The continue statement in a for-loop is redudant and can be removed.
> Clean up the code to address this.
>
> Addresses-Coverity: ("Continue as no effect")
> Fixes: b6f91fc183f7 ("drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT interrupt work")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 8ce10d0973c5..d3c687d07ee6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -520,9 +520,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>                 return;
>
>         list_for_each_entry (handler_data, handler_list, list) {
> -               if (!queue_work(system_highpri_wq, &handler_data->work)) {
> -                       continue;
> -               } else {
> +               if (queue_work(system_highpri_wq, &handler_data->work)) {
>                         work_queued = true;
>                         break;
>                 }
> --
> 2.30.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160E3433FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhJSUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:35:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A185C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:33:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so3538615otb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOqRh/1Ua7gaB2YIvupL83cX+ks/UH4oOCeOkubEg+I=;
        b=QSxSD64FavqWcg0SCB8tgXGbDjsJOCFew8H88qS4b6OOiAdL2oRBvoVd+8JMND2d9M
         sQQMburzQHky4ALFU5u/9isSpKrx8H6JSSmP1SFdTWF9NEbvc0G25h1N0vcyuC06YPXl
         k6sO9GgOQpWeWj10j4KXuRbngWbqZkc8dCr1KloSLZAruMZrIOUWV/bmS6mx0drRNTpx
         GglfYIxSk6hQI1aPpc3Sjvq7U5L5QTucwo14yQk4nhl6KH/C1/SP2xl6gWtF2+4Z2bJa
         fLOYu3iv/tnyz23vMmDZ301p6qgolhx3P/4FtK1+MzC1PIyR1L1jTMS+2iVxzPUPwOBD
         AkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOqRh/1Ua7gaB2YIvupL83cX+ks/UH4oOCeOkubEg+I=;
        b=rzUSD2qZuYu5csIgdV+vjYz4zWRFZjcLXsdGEx7vL73PBj1QSox0Mq0l6PKV83U2uM
         XHznOyqdm7rrGE12JEn3YrbNZfs1Oyxf+hkO3zMSXA2nk5Yw9GBEpqxFj8DEbNsbcxo+
         fckRImGAksU84dEn8A1TrD3tF4I3Ath8bYAAXqZj6zyhoVZqzvhNfs6GThc1f+3qGmut
         UbsIPf04J23PwMZD4ilKYgzHp4iHQT8WG1+Fh2vnT3l80RJChXAwgCpQhRf3NYpsenKp
         CcdYvQmnx+5TCPvvZj715GmDGR++O4dhVPf9IA2VpNigeKQGpDdfuQva3sFwg8MAA6sx
         +w/A==
X-Gm-Message-State: AOAM533wkMSl2ulLJkmtwF+nBbSB5aHP0GQfu3qOpY53d46tbhqfB3SE
        nrUHIT4KPkf4qMLUXHa/0IicL/LPJo6HlXDFZJU=
X-Google-Smtp-Source: ABdhPJwbvBP3caz6rJULs5wo0+7q702H1t6nq5mSszwrMHFvV3psA+RHqSmLUNlp8fraE3I5E5R5j0u3z70DoRNKLak=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr7374367otj.299.1634675611573;
 Tue, 19 Oct 2021 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <1634280441-4248-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1634280441-4248-1-git-send-email-wangqing@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Oct 2021 16:33:20 -0400
Message-ID: <CADnq5_PVZ_nFA=adGMXyBsMHMVV6JhDYTDN9sk7rVuKsTZDfYw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: replace snprintf in show functions with sysfs_emit
To:     Qing Wang <wangqing@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

On Fri, Oct 15, 2021 at 2:48 AM Qing Wang <wangqing@vivo.com> wrote:
>
> show() must not use snprintf() when formatting the value to be
> returned to user space.
>
> Fix the following coccicheck warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:427:
> WARNING: use scnprintf or sprintf.
>
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 2834981..faf4011 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -424,7 +424,7 @@ static ssize_t show_##name(struct device *dev,                              \
>         struct drm_device *ddev = dev_get_drvdata(dev);                 \
>         struct amdgpu_device *adev = drm_to_adev(ddev);                 \
>                                                                         \
> -       return snprintf(buf, PAGE_SIZE, "0x%08x\n", adev->field);       \
> +       return sysfs_emit(buf, "0x%08x\n", adev->field);        \
>  }                                                                      \
>  static DEVICE_ATTR(name, mode, show_##name, NULL)
>
> --
> 2.7.4
>

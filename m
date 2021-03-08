Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E913319D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhCHV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCHV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:56:27 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:56:26 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w195so6020410oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyJ0PeO5KwJeqSfUyZWIUqn/iwMU0KWoLqv+BcNnnbs=;
        b=UQ10zTspdmlb5BBImKzv93z4b8rcgHoxxMXyDAGirJ6ZgQdlU3oCoy3/VlIySTVQ9G
         vKjr/FqjR7o+Yu8UECfsO2tAxBqkl1dd9NRaiC7d+XVJKftt981D7j+5kv4r9JGR6wb/
         djLRjS5HT8gaALDGwT9XPp9wVxCKhh+4Pfex+porGxTetWm7f8cRKHM3jCVTrKFKv6sN
         ii2+saA/94KALMXo3L3S2sp749DJ7nxT9UAcXTSxmDiXrORdg20/aDFnjDEmIvsO73m5
         kBEhlJw7H7aZ+W/xTqkG7te3ufg/mLpWyCpOTQ+BogUV6x80+Xosfo9US/SbB0xMwzHK
         BVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyJ0PeO5KwJeqSfUyZWIUqn/iwMU0KWoLqv+BcNnnbs=;
        b=attPaprazjz2TGVr45+jq69VfDDnGARD48QjC0gq9ge1Ll19sCtejfbMSYb3YTvaE5
         C+pBLiFB8tNGL6DEWkFpTkjvuWe3xiendLqDZF0giweUe7Ko7C2nrQ2ouwxBqFiCD5tZ
         mGn94BaTHJyGwkmdKw1XgZSeHSaNzfzB5ImTxZWS0qpgPArenwIrIUw0agXJKRyK1E2l
         Mn2a39R3X56G5DJavztLWNnnbhLSkvWrjnOBqhJTBtIH9wMO6M1lby3WYDaAL18/KkJh
         /90TeRztnsjg2l2l1YW9bm7vzD6w+pZe5DBSq1HZNXyqm2ZOCQ6BaSfrON8Y92zU7hlW
         MS+Q==
X-Gm-Message-State: AOAM532vNwxPdL/RJU+Iv0oBDCu23od5jZziQEpU7Hp2Vm0+69hEisA6
        /kfqepor6bl/DbA3j3KhP8WoiKJWgd8nB4Kc8mw=
X-Google-Smtp-Source: ABdhPJwvMOnqnL13dlmqm4xKkeu24C2hDW1SuZzKmy+7NNx45hQ5X4pEQJAaSTv0pujQzQGXry/q0jZd1nNyYv+sFf8=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr696521oiw.123.1615240586175;
 Mon, 08 Mar 2021 13:56:26 -0800 (PST)
MIME-Version: 1.0
References: <1615172407-4847-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615172407-4847-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Mar 2021 16:56:15 -0500
Message-ID: <CADnq5_NEybY3puwnBs_OUHPWD_16OvbF-sCQ7Mj5gx9PtCd4+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 10:00 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c:561:34-39: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This patch was already applied.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index ae6484a..42a4177 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -558,7 +558,7 @@ bool dal_ddc_service_query_ddc_data(
>                         /* should not set mot (middle of transaction) to 0
>                          * if there are pending read payloads
>                          */
> -                       payload.mot = read_size == 0 ? false : true;
> +                       payload.mot = !(read_size == 0);
>                         payload.length = write_size;
>                         payload.data = write_buf;
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

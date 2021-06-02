Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1482399686
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFBXyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFBXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:54:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F377C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 16:52:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v142so4033746oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=O7sUSvVx4X9Ue3ybXZaq3WZClmga3LyfA3CPoyVQ7pA=;
        b=KaO68w8HrAKn93zPkQaVfAuWyiF8UF7ryWsJU0WXjR5fysUaBY1gUWQGsPthtslf/R
         dBA+coYoduNqCmqyku+m4pfBR+jcwA05SKTnWK++Mwku/2mgyql4oybFlb2UfuVvpqyX
         ii82e17MwzT5sLFPPCsXI9PgffSsDPzKHe8ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=O7sUSvVx4X9Ue3ybXZaq3WZClmga3LyfA3CPoyVQ7pA=;
        b=LQM1LfKN2h6Fetym5S+oskuyeQirmwArBw5d2FZvAp07KCB9GW8TI/5KCHh+CwMVbE
         UWLVX5odspA0zv7nGAvgmhvpsBXjCMU54n6zGz4aikv1md0H8qVx0TmXC91VKFW0Pd7w
         5IM/C6orCArL6tWRVyfKgq7tRYHGNOFeIQJPfvtZySad6JfwVVU7NM9Mhri+31L9RlUj
         XNeCNqUFhoDgLIMv46s+FbduKJGsi9WstK6nnY+HyNW403aN7tqu0ZT8POQttzLcNm6w
         srOUebDcv7RlqPtoShGkY9AJNsgEEwcO9Fq78aQAqKiq/RRddxtjb8ChZTb/ARL0yHlJ
         tD3w==
X-Gm-Message-State: AOAM530kaM/F/p/CG0kHOSIgD2OPvAlzq1PRvRQFw/xIT0s2nk8VnYeE
        d5KQ+cO5glwCgto8qV5o3nhxTANgZQXaIwajyvk63A==
X-Google-Smtp-Source: ABdhPJyEpvV7pUBImKOSlEHTC9uSRojsd37dHEdkjH80CvIPIOyDLk/7FhcUDuDurpeY/zPKdQJPkGeigbtQkdmu7Uw=
X-Received: by 2002:aca:654d:: with SMTP id j13mr5573390oiw.125.1622677932502;
 Wed, 02 Jun 2021 16:52:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jun 2021 16:52:12 -0700
MIME-Version: 1.0
In-Reply-To: <20210602143300.2330146-14-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org> <20210602143300.2330146-14-lee.jones@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 2 Jun 2021 16:52:12 -0700
Message-ID: <CAE-0n53PvVjUzXsZ6etSAOEOjCD3MV5gXd6YmtfrjPaO0kEdkQ@mail.gmail.com>
Subject: Re: [RESEND 13/26] drm/msm/dp/dp_catalog: Correctly document param 'dp_catalog'
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-06-02 07:32:47)
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/msm/dp/dp_catalog.c:206: warning: Function parameter or member 'dp_catalog' not described in 'dp_catalog_aux_reset'
>  drivers/gpu/drm/msm/dp/dp_catalog.c:206: warning: Excess function parameter 'aux' description in 'dp_catalog_aux_reset'
>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

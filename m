Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF3373093
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEDTRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhEDTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:17:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:16:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u16so9826331oiu.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRdBRW+o9Ai+DQFYSW89RtTHfHNn9agjE1x322TlyYU=;
        b=YFh8/z0qssn1bDst6eQniGRWqA1rbFmsUe/5XvGdnPgWEEx0miL0Ow1LmuL8mzhBWy
         D6j1b0mybesUhYhK+V/0BOsRQz0Nja4e+ScRLBvNf/TsHzKbH9gqkvkcqvMcri5oRDUI
         VarX+fs785iqHINhFykZAwK/atw908NM5Ko5uwdWqNht1gyFbDe6z2pBbrl+Ms/uVHO5
         ikBO2hO/FLDzc53OKIupBI3q1NvK7ar4zsNAaESgDWgJWCWxwmugTVz6H3PIPClGSLVY
         WKAqDPVV+8cObeoLx94t3Bin01e7vfGERcwEc8Dzb7KkoluGkaVk9jvx6cVuJ1lC0rna
         9d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRdBRW+o9Ai+DQFYSW89RtTHfHNn9agjE1x322TlyYU=;
        b=AD+On3sPV7PYrR8wUqgNqlbQiTjyh8yX9w2+RrD10tjczQGwNnY8qUEghxUzgnAicF
         AoxMO5bNNESXnHYVaS0p0WRNxoocMJ35dpmdYLmpDFNZyk9oVQuENgXBI5zZ5RwEc4/R
         v9L/k9niwvs7FMxjItJ63hAQQW8s/oXd8eygbqlaZXRmq2ySdmYWwUSxa/Sf9HXEXzaG
         Rqa+C1Pf1up8QbrsHVCrHCo7JHyL1LcZL69AFKNtiB7b//Y6tcDKJudc7j0WxMBkCS86
         vV4NcovxW46guWrhSk1ifLpSVm06vXEvp/0c24dZ20QjJ1WhDdnYC26oqTQqzgYNw0YA
         tLjg==
X-Gm-Message-State: AOAM530umsA3S0dxJ496vtTw3ByKg6zm/FiZa9CB0Kek0JR+zB3xQss0
        t+UaDB8x3k2uWenZLme4F9KctexEG328duHycFM=
X-Google-Smtp-Source: ABdhPJya2bVj9h7KBqRQ3GTlSw15Uqe2pIFXZ6Bx+WDG+eu/A9eQ8xpig33j58f5r+Ek7yQJYrWPW2qQXLC9cX9BkUE=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr3946514oif.5.1620155777060;
 Tue, 04 May 2021 12:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210430171654.3326745-1-trix@redhat.com>
In-Reply-To: <20210430171654.3326745-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 May 2021 15:16:06 -0400
Message-ID: <CADnq5_NN0DRKcZvpsOPjeHn3Nrppc=bNAAAXs_ws8xCmaQfQpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: initialize variable
To:     Tom Rix <trix@redhat.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Quan, Evan" <evan.quan@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Powell, Darren" <darren.powell@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 2:05 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this problem
>
> amdgpu_pm.c:478:16: warning: The right operand of '<' is a garbage value
>   for (i = 0; i < data.nums; i++) {
>                 ^ ~~~~~~~~~
>
> In some cases data is not set.  Initialize to 0 and flag not setting
> data as an error with the existing check.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 4e459ef632ef..9a54066ec0af 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -451,7 +451,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = drm_to_adev(ddev);
>         const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -       struct pp_states_info data;
> +       struct pp_states_info data = {0};
>         enum amd_pm_state_type pm = 0;
>         int i = 0, ret = 0;
>
> --
> 2.26.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

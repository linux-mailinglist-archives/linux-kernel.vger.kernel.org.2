Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90061402D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbhIGRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbhIGRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:10:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED6C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:09:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bi4so13606192oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kK/sEOfN/pZIuqO14/lsd4LIY43xYqn1JYhVweF1vGI=;
        b=Mqfrhoc6dDyOOKYKg8JmzfkKcP7bC2XDcIAejCqjWUuHwRw32QFPLrMh3AFntRPgNY
         sQpyvXh2xR7YXesIdHdWl7wByP72cRua98xOmS/suC6DwFsymUUPDE5Ont6H5yR15CYq
         aXKPiSwBsyc/aLhumurGupVHGy9Hpt0/8U2WsXbB2bUHx2ID3NHDQafzyYL5uEXLP1By
         EcjHQqazagwCMzgdV/pHNhrL9s7wd7Q12U4Kr1cfAYlfSJrXHrpoFQb4J71TsR4UYUqE
         /hsenOoFDa43Qe2TSjEXj0WgAPcTJzAfdwj7Fcm/lZH9seotoMFe0NJM9Z325Hq8RISN
         snrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kK/sEOfN/pZIuqO14/lsd4LIY43xYqn1JYhVweF1vGI=;
        b=fyJCZwJ6DwROlrdbL4kVyHHk0e27+rcVe+ECMnAN/Kh5BB8/0XU+htO0g6eWf74vwX
         hcYk8fmyQsZOVmCefj47YzRa52tA1vC0KE3gwiBXWeAreqEeN5fKnkBNXCG4e9AAtq7c
         LCtEBAoAAKMlgPIPiORNzKtpMqiglpPe6bwfiH406d1v3GAsBFG5q9kAO4YBiypntGuM
         uXs564HV2DaSBEeWh0j9NT0NHyMuJj+hqs+CoBmoWwnsABLBXXHX0qWFWBE6WDBQXYf3
         LQHolrkw55bmHP0QobiVE7A8eu2xF7DkkK51mjBFzI/WwYafUW7a7LagFOrmcTgzvvCa
         sVGQ==
X-Gm-Message-State: AOAM533045zjuuO5XbA5w2nar46ghbAj8Yw4DzfszmttknwQwfhCr9E5
        DrTAV5FdeSfNl81+kwHT6VERG/J/nXA9wlhBVTx+IgMw
X-Google-Smtp-Source: ABdhPJw3/KyAiUHheOHTfy1uxzpNIALadQUdXX4RSLVEVjvJIVCLeww+QUmPCLFJXghPEihFMVQ58zj8hBJHILS7AAg=
X-Received: by 2002:a05:6808:483:: with SMTP id z3mr3634257oid.5.1631034546918;
 Tue, 07 Sep 2021 10:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <1630921347-122646-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1630921347-122646-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 13:08:56 -0400
Message-ID: <CADnq5_PYgN2__PLUB89LR6PNNjOOxeyVcgmBG_N2jsBFXKiQCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: make configure_lttpr_mode_transparent
 and configure_lttpr_mode_non_transparent static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Sep 6, 2021 at 5:42 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>
> This symbols is not used outside of dc_link_dp.c, so marks it static.
>
> Fix the following sparse warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1766:16:
> warning: symbol 'configure_lttpr_mode_non_transparent' was not declared.
> Should it be static?
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1755:16:
> warning: symbol 'configure_lttpr_mode_transparent' was not declared.
> Should it be static?
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index a666401..4e2cf8f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1752,7 +1752,7 @@ uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
>         return 0; // invalid value
>  }
>
> -enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
> +static enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
>  {
>         uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
>
> @@ -1763,7 +1763,7 @@ enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
>                         sizeof(repeater_mode));
>  }
>
> -enum dc_status configure_lttpr_mode_non_transparent(
> +static enum dc_status configure_lttpr_mode_non_transparent(
>                 struct dc_link *link,
>                 const struct link_training_settings *lt_settings)
>  {
> --
> 1.8.3.1
>

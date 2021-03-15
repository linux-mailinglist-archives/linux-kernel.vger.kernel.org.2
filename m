Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9433C570
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCOSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhCOSU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:20:28 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365FC06174A;
        Mon, 15 Mar 2021 11:20:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so5594623otm.7;
        Mon, 15 Mar 2021 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgTmUjpAgS3oY88pdR8n43/ojqKRMNQdI1zf/7d2y7M=;
        b=lsQmoe0RiNR+jpApt3STJZDJUtuFImFAiD9QoNiIYO6y20pPJBBar89/PeF1lajqvL
         PE7PckeqNmolEc+09hLVnPOND3Za2nv2LkTxqd6t3zH06khxIPHswaeCyIczUsgedHsz
         tPVgkgaXNewd5XxYvAXYPUSLy76NwaYlMKXLtiZz9Q+npnXLheUux0fBJ0LojMSSrf+x
         RB1UFaGgSlaKkf2hbUz6Ij6zYbm6cdvJMN6gfbG29PGUAJ0zjJ+XWLG2o6k6jWTg9/x8
         sy1+PSc1bdle27kJf40dpjWGmx3A0CBvObWwJeUS7mER2VPdWKy1M9X+JVISVC39gL9U
         ZZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgTmUjpAgS3oY88pdR8n43/ojqKRMNQdI1zf/7d2y7M=;
        b=gB0ySSvOFWd6lUlurqsAV558ug0YzhGWChAp1J+MbmV+EDiPcCZuOl56A4YS+rgpbx
         KcSJX1qUpLPErxwhfzFiHUsmrHq52WYqs6x2+1/yq7g5nUh5TNVfay+CCWGlQ823bmoh
         JUDeVuxOfk42RwQX3DNQrHQ3WabVz7riOAlfVd3YJlG5wiXhF3FHqV8AJ+5MYgUIXEXz
         h/oyDNaKsWjsCOqeZk67NAbh4+QEOtAbMveM4iarf/paVcB5P8ZB2qEEne9mFvrO7SGj
         8KnUFB1IWZYBRKHBAMXUtnD/1rnGKnHL4o9MLvjFO0mUToByAvlKOfGcqd+x6UKqHAhW
         57IQ==
X-Gm-Message-State: AOAM533ye2y17DrQBYf0fHrOESrIKm3Ex1zooTUANUbdW/VM6oy2tZVK
        p96baNBOYj6bNNtVrK6HPJ8MMQg93HQA5AxAIsU=
X-Google-Smtp-Source: ABdhPJx5cwRZYD3x24+Y5vxu1axyhaBEq/xyonkkb7s5PsBur0DZqElaGFhhHFoWwp6u9qxGfa8lqI29fRn0xWQV1J0=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr309400ota.311.1615832427497;
 Mon, 15 Mar 2021 11:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210311163417.59967-1-colin.king@canonical.com>
In-Reply-To: <20210311163417.59967-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Mar 2021 14:20:16 -0400
Message-ID: <CADnq5_PH0q+mAAjSyL5_067aT0gqVMO1XZHBP_zsG41WY89Reg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant initialization of
 variable result
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Mar 11, 2021 at 11:34 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 099f43709060..47e6c33f73cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4281,7 +4281,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>
>                 if (edp_config_set.bits.PANEL_MODE_EDP
>                         != panel_mode_edp) {
> -                       enum dc_status result = DC_ERROR_UNEXPECTED;
> +                       enum dc_status result;
>
>                         edp_config_set.bits.PANEL_MODE_EDP =
>                         panel_mode_edp;
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

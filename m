Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A708632F2EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCESkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCESjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:39:47 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C759C06175F;
        Fri,  5 Mar 2021 10:38:19 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d20so3523696oiw.10;
        Fri, 05 Mar 2021 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuHbNZ1pCaMD75xKPyicfsteJCNdNgmFyqDm5jntMkg=;
        b=QTriOvFOgzxFv2eZ9ihENSK9Df09qTS/DruECsSFH5Sw4oG5qzZp8dI5XzMGXH15Dh
         y2qwHDqCvJ2QXqvo+txAz2tLQMaxC13wIN2f+9blsjLVvy5glhB7P9IAwwRXnTORChQv
         XU5mE1Veu52ojTGnk0TrGJ5JKXxg36ONwyTwJaZleJFMELIN/qmxyFzjrjtIJ0UVVDpn
         kg2r5yIl+gy/+KaZK0LzlvT+tWx06slMIerNge13J6h2waZLv3CeGi9XMdkYOmwWwvpt
         SUO3wS5V+puwfdol9aeeqsnJmVX4B5GkpmzFzuLxKWW2+8KmzK/wM5moqN4dc+gB7t1k
         S4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuHbNZ1pCaMD75xKPyicfsteJCNdNgmFyqDm5jntMkg=;
        b=gRtQm5hDUCZoJcOSU92fFGrjB8ZpEModTLCEoLGFk/Yb0zPEu8/azDM3cHG2r2mdpQ
         Y+TjYB7Xns5fedckNEt68rThiuSDPXO9IDiuB5QR4iIbUsCcjxS6O9kWRWyTfUMZt7Rd
         w4LOFrqrb3DYrqyGZXU4nOkmYjFLIKgTYolCa6pe5Svfvqc40h98FMPqkBUQTTO/GHwM
         1brmbIb74mKT1JlA4V5kQDniUHymZfeimTLNAKRPvfRS95cOFtzNlz2j3BbsZmXYUSva
         tHu+gXAVtd3x1sYiYJAhVpWUr1i5kQcjFCXTJbvoYDWtEQpssPGo9KssyDVPCpcocOAX
         JyEg==
X-Gm-Message-State: AOAM531HysV+DDaQllR8+CzPRZGelu2hiTt2AKvzZyeWi/vS9SgX+1f6
        hP0ZxuENfeJISIBxaGdQcRG+4UnbWx9+JY1QKpk=
X-Google-Smtp-Source: ABdhPJz0QWrubxnVvKfD+3rMD2OUVXyA1FXnY3QQjHZaZxL2kT/xA2ba7/jwCphvhlofJ9ONnGpq3uvRfWAWoyX3+04=
X-Received: by 2002:aca:af10:: with SMTP id y16mr5168997oie.120.1614969498664;
 Fri, 05 Mar 2021 10:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20210303140654.67950-1-colin.king@canonical.com>
In-Reply-To: <20210303140654.67950-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Mar 2021 13:38:07 -0500
Message-ID: <CADnq5_Nj0_X5E0gqtMEr8FL_UVn+WwjWSycBhWUvcg=zVRHEZA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant initialization of
 variable status
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
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

On Wed, Mar 3, 2021 at 9:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable status is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 03741e170b61..15ed09b7a452 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -81,7 +81,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
>  {
>         struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
>         uint32_t raw_state;
> -       enum dmub_status status = DMUB_STATUS_INVALID;
> +       enum dmub_status status;
>
>         // Send gpint command and wait for ack
>         status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
> --
> 2.30.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

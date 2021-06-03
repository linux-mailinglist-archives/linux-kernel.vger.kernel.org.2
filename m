Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8A39AABF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFCTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:16:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BDBC061756;
        Thu,  3 Jun 2021 12:14:51 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v22so7383698oic.2;
        Thu, 03 Jun 2021 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTcdojc8mwwtA9K2NJaczioq6lgh4tCtax6VLDoB3+8=;
        b=N1b8Xb6JaD/REB3WoovSCN50+jBsEIUw/t0OZgaPSIKlWS16XgazPhYR+e8T3vIIKb
         mGjKhYltbPgSyDrPi2qXpjrpNDsrXi58HUBcgrTnhpOOIT0bWt9DZKcYgHJEDeyHjXV6
         cfq6PqOILEN1tukJd7DKWDW4xcEvAlNI6pyOFEQdx4miovIeAFARR0FpctDoJJZmWVeC
         9R0oE8g3zYmpxmqJSs3xdHwZJ0e6P2Ku+AisTA9Sh9LmPzDAKZS6y7X0Jp+KIvxcnqJw
         kLBfpdS3Gh0utaUCTUhRUkT4Z41XOdep7AYj/Ht00C8YHJ9RgowpWHMZ5vNYrI9aQgKT
         L1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTcdojc8mwwtA9K2NJaczioq6lgh4tCtax6VLDoB3+8=;
        b=XnrKDij4nAyzIMb58e3ZVVI3S2MeqDQMJPAXR9H4safxi14uycQYrIde+BI+CT5IZP
         HqkwFExcOrpz5Bdjv9+/SqUB9wrNfmgUcXPBNDF5DuLnOpdT13txUbqv6pu1jI+aJJTO
         llxENmI9dER7YyePHc49Rui/h6P7Kp2STEWR1KVplAmaqFTZSQ959tDUsVFzBrSzxrPM
         Anj8n8LYeYAGYVfBcjsxGfk/W2rFuNeEAE8uQHYDpM80zuBjtQw9YvXj2+iVArN+Dd+O
         qUufZ9UPofx8ruphZsXJIF+5eQi5uTpGJhxnpDkGiTAwsJMdCcULQtMZozJmBExROjnZ
         LjUQ==
X-Gm-Message-State: AOAM531kkAnGL+WO/HMk4S05heqQR3WgoyHoUzkZVlkwKK/F8zlgaUpj
        AvD9eBrswJJyn50860QVX7QOofx8wcvde5rYR1E=
X-Google-Smtp-Source: ABdhPJy4rqfYmdV0F0ZL0gFISzpsTevYCr4Bh7iAwUynNZmpWVh2h7yvF0xMDmi1+b17doVVsQ57vnkZBY1xBj4z2l0=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr476649oiw.123.1622747691117;
 Thu, 03 Jun 2021 12:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210603124231.84230-1-colin.king@canonical.com>
In-Reply-To: <20210603124231.84230-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 3 Jun 2021 15:14:40 -0400
Message-ID: <CADnq5_P2yPtw1XmXrS8+SxHDMfq_FnVLt-XMDVqz_58YCb3Wog@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove variable active_disp
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
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

On Thu, Jun 3, 2021 at 8:42 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable active_disp is being initialized with a value that
> is never read, it is being re-assigned immediately afterwards.
> Clean up the code by removing the need for variable active_disp.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> index 53d7513b5083..adc710fe4a45 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> @@ -82,9 +82,6 @@ void bios_set_scratch_critical_state(
>  uint32_t bios_get_vga_enabled_displays(
>         struct dc_bios *bios)
>  {
> -       uint32_t active_disp = 1;
> -
> -       active_disp = REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
> -       return active_disp;
> +       return REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
>  }
>
> --
> 2.31.1
>

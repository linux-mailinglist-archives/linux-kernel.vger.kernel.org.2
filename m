Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B33EF270
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhHQTFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhHQTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:05:17 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1BC061764;
        Tue, 17 Aug 2021 12:04:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so18665787otv.11;
        Tue, 17 Aug 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4qQshwhjGofU9gYqtNNSGNhs8pTO6YRe0feCXXBafg=;
        b=RQvXDpXqE5V/Ur6Ae2DKHVTbcnuUm0Dt97KFZlTwrU1PdhC7vhQQe9vvJIE15qB2in
         uRGEQ6IwB++3lJoH05/NllbgsC6MOey2t70WMzlKeYTIfaX92UpuSudKBR12nbL7vF39
         hSgywBWHCxRT/y9ttyJ1rjXDkxNb8pW3PJk+EZVgTNYWMx2kakP7R+LqB4GfLdnkoeXs
         WnsijLY3CPtY1QZxkBO0ui6NNFfYLUV6zPHUkLYZc7+RijCyoWc3ZlAS0KgT5g50OZUq
         euqzIT0ExRE3pgxvE2Hu0XJD0HPW39bVdHM/EYtwYs8OCEDf/sC3W4q4BruJpeV+MuhJ
         Zofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4qQshwhjGofU9gYqtNNSGNhs8pTO6YRe0feCXXBafg=;
        b=bJqG2ynPRoTbfcO9Mpo1ATjkydihM7ucOQEG+Ug47bw4hWElkt4y4HhAZwbmiisV6W
         nKAYDAU2/z9UNZjMtg+3tpS+Uj5f3Y1FIWaL3cC15c1CHSs9R2KCUTGwSPMBsG/hZlWq
         LL9DWhXyud4ATPeF1K7tXKWG3VQmYjRWH9zCu1mEfuUZLroDiVFnlz2i6GIm8hQzZvru
         fgzMf5iUPnQRGrOKK7+PAipLmgLVw7TdQRWHKadLtJhBmJZ+bMCUVEDqTveSFp9lld8J
         Rr8mNRwlpY6Ffb2WTdlPeHMByE/pGNIz6z0M0VKRzOwYpfnfFfnHB2PyYaaU8qPF3xVP
         xzvA==
X-Gm-Message-State: AOAM5319L7okIAKqclldVfQkIyGoSuK6JYKIBvh/c5OJn+F4LhWL21YI
        6A2YKAxPBASUk6PFwRvjUiBdm6cPHETG/K6waEw=
X-Google-Smtp-Source: ABdhPJyF/9SNxCUOO7tAZXfi09hq9gJD0GdsSiKZ6CGVJRU/11gcFjpDwisz8vGeaOkCgfSVSGkxYiTYC/wNsc68QxA=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr3836459otp.23.1629227083396;
 Tue, 17 Aug 2021 12:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210817143514.33609-1-colin.king@canonical.com>
In-Reply-To: <20210817143514.33609-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Aug 2021 15:04:32 -0400
Message-ID: <CADnq5_Nb+2UKPGN5tBqzFuLyBR6KLWtXroxUh24wXVZHB5tHag@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix spelling mistake "firwmare" -> "firmware"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
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

On Tue, Aug 17, 2021 at 10:35 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 5d2605df32e8..a0e50f23b1dd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -311,7 +311,7 @@ static int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu, void **t
>         version_major = le16_to_cpu(hdr->header.header_version_major);
>         version_minor = le16_to_cpu(hdr->header.header_version_minor);
>         if (version_major != 2) {
> -               dev_err(adev->dev, "Unsupported smu firwmare version %d.%d\n",
> +               dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
>                         version_major, version_minor);
>                 return -EINVAL;
>         }
> --
> 2.32.0
>

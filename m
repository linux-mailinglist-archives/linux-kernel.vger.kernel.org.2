Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA35439E539
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFGRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:23:37 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42815 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFGRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:23:35 -0400
Received: by mail-ot1-f50.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so13066357oth.9;
        Mon, 07 Jun 2021 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIsZEzKuedmNrkE8sWmADzsVq5Ce7bsvNlcNsZxTnRY=;
        b=g13yFXluOkzEJmOZQmZQEQXcaP5WqUhlO0+vdTKZ+lHxSMjjYXxAPEbAfNwkDboqTH
         qb1kOYOjC10Rb2yEMyYhFHgRGH5aqUBpJqrCgamlEp/drI181Kw1NC0eP/fbQaUGqgjf
         lhQ8uJNbtt3vMqD3kalgHbYJAztqVaWdAjhcwZHYRliQfsbFSc0aS426zQ9y/5lo9Z1a
         cHbJ/l3t/8ToWpcggpaX0kcdYI3JX8mUD09TUlFI4VsveMbMVQtazwsktniMjcPPIjXy
         mpaTh0FgX2P8TbVNDNi7o4rKHl2X3RFUUSKXmkWi3FtgMaVF018evvpg0idGYoIzmrcn
         nXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIsZEzKuedmNrkE8sWmADzsVq5Ce7bsvNlcNsZxTnRY=;
        b=P1lvlSDAFLh+xRxIcR8BnxLvYV4qQAvSj6Uz+J0IzdBneUQKc94hDExQWW5Ip5HkJt
         LIoXwucTU9QLGsqF4OQ5HF2MeIQOxHqEOK8cKpJdZSiwLHhXydcHvBL2LjIh5ps/c/VY
         XB1+WdXmUNwARkHnMbTJ4FqtjjmXYl7DfrF49LThk1LXKaEPmoN7vCTKEFIy1+qcK5Hh
         lRZIJtB6lncd4j8O/KRUonSS36/aD2slARzvU3fEg3mS4IjU23qorbO5QI8wpM9OupSl
         9M9FsslzQCIj6ryVpNL0S8YN7uT+3MWRi0xqJcBa0ecFYH+VrUsfq3j+a5AED84+7dWi
         /QvA==
X-Gm-Message-State: AOAM5323jiXtHFIioZvRp3RO9xerd5mjXaZvYkCrymCyxQfoDLc1XHGZ
        Ofkx5OxN0mVMcuZfmDgaNLN72ftgKQCx5V6oUuQ=
X-Google-Smtp-Source: ABdhPJyEPIh1daP/HlBQeYnqMwlKB+lCnze26NeJPRgO+gQi876Ow+pkdIucW4umZTuqTIDRv1izuUb+vrRu7TofTFU=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr14588598otl.311.1623086431533;
 Mon, 07 Jun 2021 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210607115615.83162-1-colin.king@canonical.com>
In-Reply-To: <20210607115615.83162-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Jun 2021 13:20:20 -0400
Message-ID: <CADnq5_N=++KR_YjOO2DURYfe4Hp3b5=eDVh4Gp7xpcfPXFF8_w@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix two spelling mistakes, clean
 wide lines
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

On Mon, Jun 7, 2021 at 7:58 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two spelling mistakes in dml_print messages, fix these and
> clear up checkpatch warning on overly wide line length.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index c725160a095b..d655655baaba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -1494,10 +1494,11 @@ static bool CalculatePrefetchSchedule(
>                 dml_print(
>                                 "DML:  Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n",
>                                 (double) LinesToRequestPrefetchPixelData * LineTime);
> -               dml_print("DML: To: %fus - time for propogation from scaler to optc\n", (*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime);
> +               dml_print("DML: To: %fus - time for propagation from scaler to optc\n",
> +                         (*DSTYAfterScaler + ((double) (*DSTXAfterScaler) /
> +                         (double) myPipe->HTotal)) * LineTime);
>                 dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre - To > 0\n");
> -               dml_print(
> -                               "DML: Tslack(pre): %fus - time left over in schedule\n",
> +               dml_print("DML: Tslack(pre): %fus - time left over in schedule\n",
>                                 VStartup * LineTime - TimeForFetchingMetaPTE - 2 * TimeForFetchingRowInVBlank
>                                                 - (*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime - TWait - TCalc - *TSetup);
>                 dml_print("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %d\n", PixelPTEBytesPerRow);
> @@ -3023,7 +3024,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>                         for (k = 0; k < v->NumberOfActivePlanes; ++k) {
>                                 if (v->ImmediateFlipSupportedForPipe[k] == false) {
>  #ifdef __DML_VBA_DEBUG__
> -                                       dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
> +                                       dml_print("DML::%s: Pipe %0d not supporting iflip\n",
> +                                                 __func__, k);
>  #endif
>                                         v->ImmediateFlipSupported = false;
>                                 }
> --
> 2.31.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227CF33C56C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhCOSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhCOSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:19:38 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1EC06174A;
        Mon, 15 Mar 2021 11:19:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so5600487oto.2;
        Mon, 15 Mar 2021 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeDHtCDxywj9r6bA/2S0wPWpH9Q9pfJGq85V9QGOnw8=;
        b=TF7MqunSHLZhiqjjd5eKS6a1ZWsfyx6blhMKMqPybtS5JPw4NzQcK2xItEXkpphYPJ
         8QWlhHoSOyzKbsUYUrrJ8yHht6KEqZrPPGtbwD5vToVHROi8GIgPXOsTOd91WY4e1f1w
         4dj7qN2iBYJ/+ATjMLTpc+Cd0PZSe4yCx+UkRyBpQrdLKcZBlvac67lr3gUbQksGfNZe
         obIT8L8nKImSEVfNCG/qXXqb5HIOC1JKKJyaqEEExdW3l/qu1sO96+BI0qs5nrTte4rF
         MraIQVxq0DmDE4LXZFC+Qfacc+wu3XVpX6PVV5O/9IEdRCE5UULjnCCNRpKeAvJ0PE76
         3c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeDHtCDxywj9r6bA/2S0wPWpH9Q9pfJGq85V9QGOnw8=;
        b=R8K0lSfAv+zjx+RoPAKF0HrX0YyVoZro4uvep+Yb0uKIiOwYdznd7FiGJl5+zAcqm1
         2PY1nXV+WsHCC1ioZiCxSyKsywxTBk8AzjbFsr3CS9bAZquT5PoxeqAPLESeS7AUnl0W
         X89Gza861EJ3TFW33Tb3CtRFkutBYXE+Xbm/fPfCexZomBC4EZJc+TkbIfWE//33BMk0
         tvH39IQI2NCEUIkMkMvn/SP00es0BFc8FDfZiIrh8sB0Qh+NK6O9VHCHV2uEnGoAVVmr
         Z9dhvXh5+d3ZoS/1/SnIBtonHNHtXfkoNROD6S/r6t+oTNYXI9gy+kM1se+F5S/auk8n
         Dg2w==
X-Gm-Message-State: AOAM531bA/9zOohSMAJtmOTcx7w22YmASJJy18CTWfUJL3o5I4NS9Sqs
        oo2861BBE4PmBaV5xBKimRSlMX+f76ksEnsJDRY=
X-Google-Smtp-Source: ABdhPJyAxg+bB/x4V9sYZuqgUOEM6BOJkUKpErYFa5jBJaxeSIB/YQj4BCsKJcWuMzSE93UQTMd/eX9jCImPxzpIB5k=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr333800otl.23.1615832377776;
 Mon, 15 Mar 2021 11:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210312100842.127242-1-colin.king@canonical.com>
In-Reply-To: <20210312100842.127242-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Mar 2021 14:19:26 -0400
Message-ID: <CADnq5_PUo9cLui_B81Kn2LB8jmyZG2HsgWLQ=WqOWP+_wqcfsw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix spelling mistake "disble" -> "disable"
To:     Colin King <colin.king@canonical.com>
Cc:     Evan Quan <evan.quan@amd.com>,
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

On Fri, Mar 12, 2021 at 5:08 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an assert message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0d725b66fb78..7edafef095a3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1300,7 +1300,7 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
>                                 (0 == smum_send_msg_to_smc(hwmgr,
>                                                 PPSMC_MSG_PCIeDPM_Disable,
>                                                 NULL)),
> -                               "Failed to disble pcie DPM during DPM Start Function!",
> +                               "Failed to disable pcie DPM during DPM Start Function!",
>                                 return -EINVAL);
>         }
>
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

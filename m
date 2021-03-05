Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2708632F2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCESgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhCESgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:36:01 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA28C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:36:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v12so2717619ott.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ov2Ty9Jb6QsriK8+bSn7UGp92CXVSd8s3dKNA/YGByM=;
        b=FEIB07sKgIB6pNFXSaohr2gQW8avxTQUntOULApdNkgbd+Ai01qcSjGioPm54JbPRr
         7f058sKm+gcT+ugGsorEJ0zqgPKY6giQ1w0XpfhPwGIV1N+3k5LdzWZZXjj1y1ILiVzV
         NFqBEAnNcurZih0+vhn39JfiQ5ikxV7I+UO6IQNxqe2aZGSxYbaje6BIP036nlwu1uTC
         TEv8ib8TheBO3RB68SaBTV7Ayh4x+EnzJ1Q1fyCt6rzcucE1cJBSl1asmWUcbd0fJvih
         uH6RZePFrj2glSnyVgzyYgmJ5E7Tp5nuprDZqEaPNXwJ7WXY0ZJNy+Ie+TkoqtIpijE7
         hngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ov2Ty9Jb6QsriK8+bSn7UGp92CXVSd8s3dKNA/YGByM=;
        b=LgRrgx6k/QHMb+7wQmcEQQw8QxKWDrz+yFDChaJGe1rnLmPbAsHtS+Y1DNTmjBIy3s
         TE1X0DE5mRrOMMlfmuDGCUBZDBxJtvZb1m2Fja7n37xHF4nfHM3xFsjloAhrcRUwoPVS
         ajKYqXuKvMpL1JPWh8TXx7XQr565xJQsE+jZw7txgJlA96I9qT3FF3OV5qvUytjMZ+hh
         2PEjLJaBnlSX9tTKpnLsrlnEN+J6G+ZWEc9bS70Q2/gvqL2uNQadYYOQ1gg02Ie6645J
         xcKDQCAEnkZV/CAKs2Yf8VteUkYdX8HDB/EpafKsCP6XFwWUg5zhKQqG5pp3r51CWRPa
         4ZfQ==
X-Gm-Message-State: AOAM533mUjp4/bmlIsdh0XtEmpcDpqB/4TAfjPbaUgQ1KHPWB5DSGMkA
        2vpudu2ghRJT7iUkn8kXHRNemHF1CrRsJEW9Z44=
X-Google-Smtp-Source: ABdhPJxFf6nv2FH82CK1HXBYD8T5HDnBWPh/i/e6LCm06m+gPtmqee8/OuGxHYrCcBw8WC0v4zeFycmPwzLSzjgIdpI=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr9528500ott.132.1614969360161;
 Fri, 05 Mar 2021 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <1614844895-85184-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614844895-85184-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Mar 2021 13:35:48 -0500
Message-ID: <CADnq5_MhR+Hhg9C4PvEAushxr_gpNqyQzwa-6R1mcYTpA96wtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: Remove unnecessary conversion to bool
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

Applied.  Thanks!

Alex

On Thu, Mar 4, 2021 at 3:02 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:956:52-57: WARNING:
> conversion to bool not needed here.
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8311:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3e1fd1e..0e6b7415 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -953,7 +953,7 @@ static void event_mall_stutter(struct work_struct *work)
>
>
>         dc_allow_idle_optimizations(
> -               dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
> +               dm->dc, dm->active_vblank_irq_count == 0);
>
>         DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>
> @@ -8307,8 +8307,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         hdcp_update_display(
>                                 adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
>                                 new_con_state->hdcp_content_type,
> -                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED ? true
> -                                                                                                        : false);
> +                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
>         }
>  #endif
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

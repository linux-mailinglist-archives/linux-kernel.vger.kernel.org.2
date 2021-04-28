Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234936E0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhD1VNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhD1VNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:13:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6CC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:12:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so23139502otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6XU5TqBnwnYkFFfBZmHfV+hocGp4E/+zJAvsfnEXySw=;
        b=UEvWG2H4M5sx14vlbmVSleox1eEjQw+3YaiVNov2QtMyh3sO4ZBC3Tx81G+gmURyLk
         KHP6SOlWWq0SCdw4J77Xq7flfHxfIyLEnCMHmzzztaV2hYU1Y6+znQ4o4Wff77E2WPD5
         AHr5jlgQgtVadv43SsbZodxbOhgirC9aFlzrbpDAT+34x2c6rF80Ru8jvZ5ACANyczDp
         IquWTUEvzDhkIFugCSi1kQ7OztvuyEuo2WX2Qj5r26Z213HefdRf5jT1nCQvODq1t/Nk
         EofhvSmGWGkmRjRhgB08kYLYv5AICx3UblqJH4W4ZZfmCywCGeuXThiCwZbSS3piBPMQ
         2eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XU5TqBnwnYkFFfBZmHfV+hocGp4E/+zJAvsfnEXySw=;
        b=lIW3HuQZNByCtCIf1VkY2To1RD6bcQt1vlrEmrPJna+ymAs/LXEbGtxXZTnrcexgBY
         NmOLQrKtOcA7QZTWuKuXVLPPjMHbpmQhXfZCu47qYNrV2HbL4UM2UaJdcwq2qNVd/EAp
         Hhy1KTQULfaUDSxFFVc9r0YpealgDRYeglqZsKPi6C+kgSs2kMVIuSBKvtZhAcl2ndAR
         uL9bpXCLgneDbLIh8NS3QQd4X47Za8uQA+ikF2pSYsAyIyDNyb/qPJPTVtRcd00+I+oT
         54MHefUkUgM4LYuXqj/rVg9iSzXOwrtSpnKIUSDgVnByCdr1hxhiIDDQt8QJhauDwVz2
         4BSw==
X-Gm-Message-State: AOAM5325UIHTXm03JVKx3CkpuU0cCQCNEREKGBOIsxZi78TT4i1/62EC
        4mI3VoJihat0Y20Np1bEdspf+CL5DU0it/SwvKY=
X-Google-Smtp-Source: ABdhPJw8IHCW+SvKtLYTe0mFP+jS7ieH+m64iNY23YQxYGvsJQAmRWkpLpVSvVdKSt71RkLqgs0FMIyq9+ASvUTIzgI=
X-Received: by 2002:a9d:8d1:: with SMTP id 75mr7786542otf.23.1619644351452;
 Wed, 28 Apr 2021 14:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210421161802.175639-1-linux@roeck-us.net>
In-Reply-To: <20210421161802.175639-1-linux@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Apr 2021 17:12:20 -0400
Message-ID: <CADnq5_MQoqjYO8-UPWZeg-F98kRH46a0J+AgN2hEho0Qn=FMMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix build warnings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Fix the following build warnings.
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:
>         In function =E2=80=98dm_update_mst_vcpi_slots_for_dsc=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6242:46:
>         warning: variable =E2=80=98old_con_state=E2=80=99 set but not use=
d
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:
>         In function =E2=80=98amdgpu_dm_commit_cursors=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7709:44:
>         warning: variable =E2=80=98new_plane_state=E2=80=99 set but not u=
sed
>
> The variables were introduced to be used in iterators, but not used.
> Use other iterators which don't require the unused variables.
>
> Fixes: 8ad278062de4e ("drm/amd/display: Disable cursors before disabling =
planes")
> Fixes: 29b9ba74f6384 ("drm/amd/display: Recalculate VCPI slots for new DS=
C connectors")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 573cf17262da..f9b87f1f424b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6239,13 +6239,13 @@ static int dm_update_mst_vcpi_slots_for_dsc(struc=
t drm_atomic_state *state,
>  {
>         struct dc_stream_state *stream =3D NULL;
>         struct drm_connector *connector;
> -       struct drm_connector_state *new_con_state, *old_con_state;
> +       struct drm_connector_state *new_con_state;
>         struct amdgpu_dm_connector *aconnector;
>         struct dm_connector_state *dm_conn_state;
>         int i, j, clock, bpp;
>         int vcpi, pbn_div, pbn =3D 0;
>
> -       for_each_oldnew_connector_in_state(state, connector, old_con_stat=
e, new_con_state, i) {
> +       for_each_new_connector_in_state(state, connector, new_con_state, =
i) {
>
>                 aconnector =3D to_amdgpu_dm_connector(connector);
>
> @@ -7706,15 +7706,14 @@ static void amdgpu_dm_handle_vrr_transition(struc=
t dm_crtc_state *old_state,
>  static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
>  {
>         struct drm_plane *plane;
> -       struct drm_plane_state *old_plane_state, *new_plane_state;
> +       struct drm_plane_state *old_plane_state;
>         int i;
>
>         /*
>          * TODO: Make this per-stream so we don't issue redundant updates=
 for
>          * commits with multiple streams.
>          */
> -       for_each_oldnew_plane_in_state(state, plane, old_plane_state,
> -                                      new_plane_state, i)
> +       for_each_old_plane_in_state(state, plane, old_plane_state, i)
>                 if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
>                         handle_cursor_update(plane, old_plane_state);
>  }
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

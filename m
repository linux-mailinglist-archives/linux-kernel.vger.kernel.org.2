Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF432AC12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448043AbhCBVHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347076AbhCBSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:07:05 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73284C0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:54:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l133so22857271oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et+xU+di4F1x3AQ1+A9WWet/mw3rwpq1euxtEeoI89c=;
        b=R8IMffRwg3aGHh1B5gMoq/i7WEbQ2fL4NUAIAo89ZzlhhjKsNsQWJaZvMijOUazeTZ
         OpMAB7iHFz8rvR0Z+p8U3Vo+0hART0VJlgY7MwY6olkvlLBe4qrhD/px9iljx0b+P+Ju
         bACHt60UzNx+/G4ZsCSc6jqcMFOyFO5HUBcu/v33O4vjiH42sdSgr6VTSQxfCJbj5TpO
         2V0evh8DKHmLHVL2OrjgHShVTa2UUlxacOUHkfwPOg/plPEJ8+1eMBXQMAJEnRjEijg/
         pwYAFgAGiUcAIq4pS5x22sTBb9/ElHmKtRlmhI5e/Y4lpxKM/+rjkaJrw5wlaeh2YApf
         CCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et+xU+di4F1x3AQ1+A9WWet/mw3rwpq1euxtEeoI89c=;
        b=Fd40wYLV6x4bDpEWZwzKKzh8Sbtoa04PZiybhJp+LihaYQtZquHRafsb/OyfGzyqnl
         S09HY8MRSfQldgRyRYArKL63jRYiutY7s7U+tn+VDVSxhgNq7jI312KDypcyDje2SqAN
         Ozdzu5QH6DAp03y9eUeoxWpiqhSkD6D9K4nyVYTf++6ca5EftNpvEMfU1rdAJiXqjfvI
         M3CbkyevnQPsDrAR/KgoeorE160rRkj84V0M9A+MBtaUJbGpMaBxJYf+rBVn7uMV2M3C
         o63mrIDyqZjLg/6xMDzQohHkt1yd5vV0MWpVExoqmFCVfVTOTA2a15TZefzDsc5Kuwlu
         E5mw==
X-Gm-Message-State: AOAM530bXsxrzCBzqhl9DItC2nSUH1uxILLK2CP9xg4P0QVozPbA0K1k
        WiZ4L7BD/Rny3ESgfJI9o33bH6pV51TO/59dQBg=
X-Google-Smtp-Source: ABdhPJxRW4p/vHzKb5c4JRQmf36SLWtagL0pbDRXWsUl6Q0LsZbThftkKX3kYDCpqSStbcgfjUlyvx+pUY4jiy9rzlA=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr4022056oiw.123.1614707672757;
 Tue, 02 Mar 2021 09:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20210225150119.405469-1-arnd@kernel.org>
In-Reply-To: <20210225150119.405469-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Mar 2021 12:54:21 -0500
Message-ID: <CADnq5_NU3DOJShJm4jGLYgPoM2kWT83sL5GZTGp11Be+hsCcmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix an uninitialized index variable
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the new logic uses an always-uninitialized
> array index:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9810:38: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
>                         timing  = &edid->detailed_timings[i];
>                                                           ^
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9720:7: note: initialize the variable 'i' to silence this warning
>
> My best guess is that the index should have been returned by the
> parse_hdmi_amd_vsdb() function that walks an array here, so do that.
>
> Fixes: f9b4f20c4777 ("drm/amd/display: Add Freesync HDMI support to DM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex


> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b19b93c74bae..667c0d52dbfa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9736,7 +9736,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
>         return false;
>  }
>
> -static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> +static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>                 struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
>  {
>         uint8_t *edid_ext = NULL;
> @@ -9746,7 +9746,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>         /*----- drm_find_cea_extension() -----*/
>         /* No EDID or EDID extensions */
>         if (edid == NULL || edid->extensions == 0)
> -               return false;
> +               return -ENODEV;
>
>         /* Find CEA extension */
>         for (i = 0; i < edid->extensions; i++) {
> @@ -9756,14 +9756,15 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>         }
>
>         if (i == edid->extensions)
> -               return false;
> +               return -ENODEV;
>
>         /*----- cea_db_offsets() -----*/
>         if (edid_ext[0] != CEA_EXT)
> -               return false;
> +               return -ENODEV;
>
>         valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
> -       return valid_vsdb_found;
> +
> +       return valid_vsdb_found ? i : -ENODEV;
>  }
>
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> @@ -9781,7 +9782,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>         struct amdgpu_device *adev = drm_to_adev(dev);
>         bool freesync_capable = false;
>         struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> -       bool hdmi_valid_vsdb_found = false;
>
>         if (!connector->state) {
>                 DRM_ERROR("%s - Connector has no state", __func__);
> @@ -9857,8 +9857,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>                         }
>                 }
>         } else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> -               hdmi_valid_vsdb_found = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> -               if (hdmi_valid_vsdb_found && vsdb_info.freesync_supported) {
> +               i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> +               if (i >= 0 && vsdb_info.freesync_supported) {
>                         timing  = &edid->detailed_timings[i];
>                         data    = &timing->data.other_data;
>
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

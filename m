Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718F3258B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhBYVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBYVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:34:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:34:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d24so10762685lfs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z33fwCKGRLdRggSVLa36+oxEo5k56+kIObYh56DIr1o=;
        b=iVOvgwBHTElHBmSyV8PIt+/n4PL5NWhFj7/q6FN4WduvYDrIce/fCRUQYtkupW2DJ2
         WAkqWlxLpGMGuZuQzh5k/1CYCcKI/HswXTLxgiylWtVEldlvWj9jCLVmA8rlGH9/5IDc
         W0KAGWMSe9u1PUJ9XO6r5QuvrlGbRgs6HM3O/HwMXFweNW5RbmKimMXu3HcyA2xiikkY
         3jCvA6OtwNK0/kic08DPa5I6tVW7VIQzCDdLC5oqzC0bfT8Tk8cSjjPgvaM+nWkm2BuW
         +NUABQpD18/jDPEFRuwHFY8SGx35eolwPjMCHURDTydHrY1IK863vZMSZdU63aOONaRg
         TSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z33fwCKGRLdRggSVLa36+oxEo5k56+kIObYh56DIr1o=;
        b=KspxOurOvj9dpD5QByTBv3TYGHHSuIWtfbKBWpeGuitlc9TSmLR/1nN56kxtCzvjEK
         YogDFfkIWUFA8QERKom/KhcvpvgafF9donjCxXi198DSfYWjDrc/F8hc6VIYzNgA6o8C
         tpq7NaD4cXrqBkZTBoPAcHHFwKfrVZvHcC1bbqcHKuz3mcrj57n3nZSTz4x1exgVp9vb
         4FBLw3Y575s/Qr/QRWrLOd2rtL0YkWCY+IuOGtBKXFwzkeBLcXeZIYkVk2+ABUfVSKM3
         7L3nhWzmf6UL/o8qbGB7iU5wpg3rjWchgB4pvTmiH8Oapa0q2wcCui+2/9wrytEs5S4u
         ECiA==
X-Gm-Message-State: AOAM531DQoVrBzo8RECSV2QEx/WY7d+O/8nKMCMy6NCR9ghxS8m1yPbs
        ytbSG5KwsQDMgEH/m2ZBk1djBisUYRewUonLNzdhIQ==
X-Google-Smtp-Source: ABdhPJwidz3VEFA1ImAO0a1g5OYBZZNdfVwrSeMhrhMW+jPSmbGKY9IlX0eQ/dAZ/ZuXoIxIYaDlY8Fz4hPCCRSI9ZA=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr3098656lfg.374.1614288847058;
 Thu, 25 Feb 2021 13:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20210225150119.405469-1-arnd@kernel.org>
In-Reply-To: <20210225150119.405469-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:33:56 -0800
Message-ID: <CAKwvOdkWfQi4vPphJ9X+xQ5MdzGhrHr1mj=oFGh3Yv5TB=76_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix an uninitialized index variable
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 7:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
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

Thanks for the patch!

I don't think we need a local variable to store the return value from
one function call that's immediately returned, ie.

return parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info) ?
i : -ENODEV;

would suffice, but the patch is still fine as is.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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

reusing `i` here is safe, for now, but reuse of variables like this in
separate branches like this might not get noticed if the function is
amended in the future.

>                         timing  = &edid->detailed_timings[i];
>                         data    = &timing->data.other_data;
>
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers

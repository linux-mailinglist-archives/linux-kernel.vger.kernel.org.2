Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9383925B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhE0D7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhE0D7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:59:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:57:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so3181294otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjGMU2eJY7MAduIGnouTTmy3o2skeXkndWNlCEoNBuQ=;
        b=PTTEEebu/8sQ5ioSNf7911tKuN2wGLLQfH2cQNi0CzqN/ETQH+TsFzI1H25ulvzWQg
         6dLO5o51zMJlGzOzwReSjuFhd+6mUsKx1lkVOYOsnCoE0qOAzzget65iz7HXv3RAc/k4
         8PNoyifj2yNi2rMu8fmGSAyMpKeGwmLwcVfGGqApcdge2vt2altFTs51yH8iD03t6SGq
         vB2MVnygFqkZe5qx+6RmjA5NIsPU6g2O8MJmzUfFoLScITDaarOMdOh4RDbTbrPokdH9
         eBnjHb9PElXrztbqidvTP0SHjKhwb2+jjDXJOlcLF7yXz72zGxRF3v9qs5bZ5+kyAHSZ
         pC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjGMU2eJY7MAduIGnouTTmy3o2skeXkndWNlCEoNBuQ=;
        b=YWW4phnJNOX5a7Vm+K2RPxrBg0rxuS8j5eC0htdCRJPdxi3d2OmSOFU0eb6U6qRumt
         oED52HJaov8+O+iyhr0TUxzZkRj0L96Dg2birVobnQTptrsfmIDfc0MxajW37cULi5O8
         fFSGwyH9G+wK67iB3uIrDVsO2xZTzPa+ilUdrg0/WVlDT2JEgI4dsCPYYXsuAjCWZWB3
         SRMMT2cYN4pe51zw9bjxDdsFjmyk+AIQtOarXkMfoH3pDNwC6I3EGn/m3q5iP3G5RxYu
         XRVCOnb6Xy0fzifNHud4bAoH36SnsUqKyUEvmHPIa+khn6+5kYq6e4N6p8XAbcp81QqF
         5P7g==
X-Gm-Message-State: AOAM533xRL9HeYVlilkdGp1NWbYBGTg/NTOW2W3pC9qQ3xuEOcc86akT
        hHUHPEOQSJ3OJcMUVja2ZbPhn7FCgkK4ZvFq2tg=
X-Google-Smtp-Source: ABdhPJxl3eiIdARqk0LBovOakNpsqVIr2PbwJ9p56brQbaisMJonCXUkm68X8Ga/Zma/B50jfTWsbguJeMWeeB9pAZY=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr1255345otl.132.1622087857923;
 Wed, 26 May 2021 20:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-11-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:57:27 -0400
Message-ID: <CADnq5_OteJ0ZZSKqbZ-j3KD7kGajoEyq-F7=VFbruvgxRQC6yQ@mail.gmail.com>
Subject: Re: [PATCH 10/34] drm/amd/display/dc/bios/bios_parser: Fix formatting
 and misnaming issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: expecting prototype for get_ss_info_from_table(). Prototype was for get_s=
s_info_from_tbl() instead
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1562: warnin=
g: expecting prototype for BiosParserObject(). Prototype was for bios_parse=
r_get_ss_entry_number() instead
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1739: warnin=
g: expecting prototype for get_ss_entry_number_from_internal_ss_info_table_=
V3_1(). Prototype was for get_ss_entry_number_from_internal_ss_info_tbl_V3_=
1() instead
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index c67d21a5ee52f..9b8ea6e9a2b96 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -979,7 +979,7 @@ static enum bp_result get_ss_info_from_internal_ss_in=
fo_tbl_V2_1(
>         struct spread_spectrum_info *info);
>
>  /**
> - * get_ss_info_from_table
> + * get_ss_info_from_tbl
>   * Get spread sprectrum information from the ASIC_InternalSS_Info Ver 2.=
1 or
>   * SS_Info table from the VBIOS
>   * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 =
or
> @@ -1548,7 +1548,7 @@ static uint32_t get_ss_entry_number_from_ss_info_tb=
l(
>         uint32_t id);
>
>  /**
> - * BiosParserObject::GetNumberofSpreadSpectrumEntry
> + * bios_parser_get_ss_entry_number
>   * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info tabl=
e from
>   * the VBIOS that match the SSid (to be converted from signal)
>   *
> @@ -1725,7 +1725,7 @@ static uint32_t get_ss_entry_number_from_internal_s=
s_info_tbl_v2_1(
>         return 0;
>  }
>  /**
> - * get_ss_entry_number_from_internal_ss_info_table_V3_1
> + * get_ss_entry_number_from_internal_ss_info_tbl_V3_1
>   * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info tabl=
e of
>   * the VBIOS that matches id
>   *
> --
> 2.31.1
>

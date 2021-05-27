Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FD3925A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhE0Dzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhE0Dzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:55:51 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:54:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so3165147otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uT651Ch6JbByVKpUqSoIkWeIFaGF5wLW7NPyHBjr/q4=;
        b=BgoSlEhFkhdIyEkOpterAYNsrp0jrayCyZw0SQerP0yV49F3y501qTy8MLy7IxcqkT
         Y/skeFxINTA4qTC2dVaMCCUMRYHeTYYc7LtD3vbFjc60J9KbJ4Fit4zFgYLb5PgNhJPn
         /DBrYUxn6FERSZcDLmTTO0oPPiDuZrwM5CD8BMA+TL90MtDKfmojj7sOJYI3JHJbiTl1
         iwtGk//+1PZbcRHnF6KivbfufhP7fRW0x49bFKKyKJsCm9uNutnZTEwQTZg2cm3jvvnz
         O47d7yFttO+MY1s6pwgsGhPGmBm1Iu70nK0+bYuVcj6HUtAKDkHk2z+lNqqPSYRhh2Ok
         c9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uT651Ch6JbByVKpUqSoIkWeIFaGF5wLW7NPyHBjr/q4=;
        b=ryb18eVyPb/POtCDB08CATGKhsPJJfnNaQbgDje8X6OM6NDJNZo4z1ARl5ciG+evRR
         xKEV9E9WG2gZp1MNgbv7CwC2eUmwvfd04CIcguv3WC3Gta5DyMb/ISD6eZQJAZLf1krD
         ONDtL4gFs4xfsBr3gtmhLR+1X6D0acRghWE0bTZbc/SLVKj/2NwhZB6KAGC/aHPkWZBk
         viOcEDj6ho585F3JOjClcFJiuV50lvZ7DmjdLGOJUAVpoL7sFpDp/8h5W9n3Pg+ugWJy
         yBPdpMagemo9xQYpixCKd7U+KsbUUcQhinZSlf/qxeGJxa5w4Xa45h/Cgb8oBRKR58us
         IPgw==
X-Gm-Message-State: AOAM533n+a98ZJyqWoic4ZeNnM6T5Xd5c2pWXEE2cY/O9iph4c9BqQDh
        I9cDsiXLuqapf/pjH6eBvtSRjxsV/f8y+It1FaQ=
X-Google-Smtp-Source: ABdhPJz+Skgjs6oUjSpHjiyoi6e2pn0d+BU5ukYqpVviAOSWNeZeIKuSDjBoPmrsukza/eNRL5hcYXhKE8VqLTtg1Bg=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr1247111otl.132.1622087658314;
 Wed, 26 May 2021 20:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-7-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:54:07 -0400
Message-ID: <CADnq5_M9FNTPUjed0zoTktZbJyKLkJ5LDJrjWqS7pFPL3OBHkw@mail.gmail.com>
Subject: Re: [PATCH 06/34] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Kernel-doc
 headers must contain function names
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:547: war=
ning: This comment starts with '/**', but isn't a kernel-doc comment. Refer=
 Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:603: war=
ning: This comment starts with '/**', but isn't a kernel-doc comment. Refer=
 Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:629: war=
ning: This comment starts with '/**', but isn't a kernel-doc comment. Refer=
 Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1006: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1155: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1608: wa=
rning: expecting prototype for Populates single SMC GFXSCLK structure using=
 the provided engine clock(). Prototype was for vega10_populate_single_gfx_=
level() instead
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1663: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1713: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1862: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2546: wa=
rning: expecting prototype for Initializes the SMC table and uploads it(). =
Prototype was for vega10_init_smc_table() instead
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2922: wa=
rning: This comment starts with '/**', but isn't a kernel-doc comment. Refe=
r Documentation/doc-guide/kernel-doc.rst
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 26 +++++++++++--------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 31c61ac3bd5e1..25979106fd255 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -544,7 +544,7 @@ static int vega10_get_socclk_for_voltage_evv(struct p=
p_hwmgr *hwmgr,
>
>  #define ATOM_VIRTUAL_VOLTAGE_ID0             0xff01
>  /**
> - * Get Leakage VDDC based on leakage ID.
> + * vega10_get_evv_voltages - Get Leakage VDDC based on leakage ID.
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
>   * return:  always 0.
> @@ -600,7 +600,7 @@ static int vega10_get_evv_voltages(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> - * Change virtual leakage voltage to actual value.
> + * vega10_patch_with_vdd_leakage - Change virtual leakage voltage to act=
ual value.
>   *
>   * @hwmgr:         the address of the powerplay hardware manager.
>   * @voltage:       pointer to changing voltage
> @@ -626,7 +626,7 @@ static void vega10_patch_with_vdd_leakage(struct pp_h=
wmgr *hwmgr,
>  }
>
>  /**
> - * Patch voltage lookup table by EVV leakages.
> + * vega10_patch_lookup_table_with_leakage - Patch voltage lookup table b=
y EVV leakages.
>   *
>   * @hwmgr:         the address of the powerplay hardware manager.
>   * @lookup_table:  pointer to voltage lookup table
> @@ -1003,7 +1003,7 @@ static int vega10_setup_asic_task(struct pp_hwmgr *=
hwmgr)
>  }
>
>  /**
> - * Remove repeated voltage values and create table with unique values.
> + * vega10_trim_voltage_table - Remove repeated voltage values and create=
 table with unique values.
>   *
>   * @hwmgr:      the address of the powerplay hardware manager.
>   * @vol_table:  the pointer to changing voltage table
> @@ -1152,7 +1152,7 @@ static void vega10_trim_voltage_table_to_fit_state_=
table(
>  }
>
>  /**
> - * Create Voltage Tables.
> + * vega10_construct_voltage_tables - Create Voltage Tables.
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
>   * return:  always 0
> @@ -1595,7 +1595,8 @@ static int vega10_populate_smc_link_levels(struct p=
p_hwmgr *hwmgr)
>  }
>
>  /**
> - * Populates single SMC GFXSCLK structure using the provided engine cloc=
k
> + * vega10_populate_single_gfx_level - Populates single SMC GFXSCLK struc=
ture
> + *                                    using the provided engine clock
>   *
>   * @hwmgr:      the address of the hardware manager
>   * @gfx_clock:  the GFX clock to use to populate the structure.
> @@ -1660,7 +1661,8 @@ static int vega10_populate_single_gfx_level(struct =
pp_hwmgr *hwmgr,
>  }
>
>  /**
> - * Populates single SMC SOCCLK structure using the provided clock.
> + * vega10_populate_single_soc_level - Populates single SMC SOCCLK struct=
ure
> + *                                    using the provided clock.
>   *
>   * @hwmgr:     the address of the hardware manager.
>   * @soc_clock: the SOC clock to use to populate the structure.
> @@ -1710,7 +1712,8 @@ static int vega10_populate_single_soc_level(struct =
pp_hwmgr *hwmgr,
>  }
>
>  /**
> - * Populates all SMC SCLK levels' structure based on the trimmed allowed=
 dpm engine clock states
> + * vega10_populate_all_graphic_levels - Populates all SMC SCLK levels' s=
tructure
> + *                                      based on the trimmed allowed dpm=
 engine clock states
>   *
>   * @hwmgr:      the address of the hardware manager
>   */
> @@ -1859,7 +1862,8 @@ static int vega10_populate_single_memory_level(stru=
ct pp_hwmgr *hwmgr,
>  }
>
>  /**
> - * Populates all SMC MCLK levels' structure based on the trimmed allowed=
 dpm memory clock states.
> + * vega10_populate_all_memory_levels - Populates all SMC MCLK levels' st=
ructure
> + *                                     based on the trimmed allowed dpm =
memory clock states.
>   *
>   * @hwmgr:  the address of the hardware manager.
>   * return:   PP_Result_OK on success.
> @@ -2537,7 +2541,7 @@ static void vega10_check_dpm_table_updated(struct p=
p_hwmgr *hwmgr)
>  }
>
>  /**
> - * Initializes the SMC table and uploads it
> + * vega10_init_smc_table - Initializes the SMC table and uploads it
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
>   * return:  always 0
> @@ -2919,7 +2923,7 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, =
uint32_t bitmap)
>  }
>
>  /**
> - * Tell SMC to enabled the supported DPMs.
> + * vega10_start_dpm - Tell SMC to enabled the supported DPMs.
>   *
>   * @hwmgr:   the address of the powerplay hardware manager.
>   * @bitmap:  bitmap for the features to enabled.
> --
> 2.31.1
>

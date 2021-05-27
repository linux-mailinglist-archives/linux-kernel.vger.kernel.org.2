Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5343925A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhE0Dyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhE0Dyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:54:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65174C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:53:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso3185135ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xELwdLuZkH4z5J/GT5DZ6nlHBvDe0H+SPpVnI7wy13g=;
        b=TmggnDhozgQCmX0OhYLFCVOpDbjgeA577yM64a6ut7ns1ezHMJRSgO2pnVjdqj5PJD
         O4V95qVJhmr1vXs1A6LxqWlul6BnPt8LUolysdlJHXbYh0lOOrSeqg0P83GT/QIqZNsB
         T6DlymW8whP61Q0eRhn0gQD9BVRst8fjvJB2fTQ5nMgPcepnJj2bWKXGd5wDkK8LysU7
         XcJylSo1O+w4dYl4AJepSZutperkCMRe45jd/KAUraSplb9Kdf5droC299RyZP7Lfg5E
         LuOQ4FCmx13/Ni6iqeX/4bTIm1W0OoKC35L6kXThacH6YH1f2XPd/luWBAqf1hCiI2bF
         NMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xELwdLuZkH4z5J/GT5DZ6nlHBvDe0H+SPpVnI7wy13g=;
        b=E0tyX/M2aQ3kP4ZEP9+c+seTaskHK/GWgz+BpvKY8AwqQk37wLqbn/GMD7I5d7wRAm
         TweZ03r/GES1vdojcrelDL+UgdncUG0wklOpM7n7Ju5IhLvEfgq9onqUowEqcrkE1kxS
         1va+1qE5m8YoTEkQqlrIM9YiLN+THkDXipNQMGrmzU9D6/3rB/WcUyIXxxQ8hNSzIS6h
         QF0viNIQC3wwv3VsH1lhJTDM1ClatK9EWq8NabfuRefMBPMN+50G5h390eCnwkIc98xf
         qWgCOMHR70+YgGPYiQ7vGl9SVg2o56nvJoTlKo7zD6NQ9r1KGY0K+jIoj31zL3GuaVmZ
         J/7Q==
X-Gm-Message-State: AOAM5301Db4YkDxMwriLX8A6b8u/68PslUEYvy7TgViG2C+umHwKsj7y
        mrXHPpOWSnPB9FpYEP+2gXJprYhzQMAeA+TMai0=
X-Google-Smtp-Source: ABdhPJxAXoDdMyn+j4WUJtKIkYpUXXWDoYsi/wMRZ/HPLvpHKA9KsPceqak3zQssVp8/mTHgjvBFuBMORPohagk6UMs=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1204608oti.23.1622087595845;
 Wed, 26 May 2021 20:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-6-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:53:04 -0400
Message-ID: <CADnq5_NQSwdhGQOMDAfHj9dWi-e-EYeH8AsTr+XhRwU6DZDgLA@mail.gmail.com>
Subject: Re: [PATCH 05/34] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Provide
 'vega12_init_smc_table()' function name
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:812: war=
ning: expecting prototype for Initializes the SMC table and uploads it(). P=
rototype was for vega12_init_smc_table() instead
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index 1a097e608808e..29e0d1d4035ad 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -803,7 +803,7 @@ static int vega12_save_default_power_profile(struct p=
p_hwmgr *hwmgr)
>  #endif
>
>  /**
> - * Initializes the SMC table and uploads it
> + * vega12_init_smc_table - Initializes the SMC table and uploads it
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
>   * return:  always 0
> --
> 2.31.1
>

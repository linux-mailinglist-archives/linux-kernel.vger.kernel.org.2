Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8823939259E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhE0DyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhE0DyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:54:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14071C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:52:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so3173292otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GMNN8zidej8CCx7epceEx2ySsZhlFSGB0Zr+V9xhpsE=;
        b=WQ51LN90zU6GGhJNh70xPboiDCxVvC0k64dOhSBqzbuqmTIQkgmACc4VQ5GwW4Se4z
         P/W1tAMTAiQuc/lV0vYTMOuxr+lq6YtLgXeHd1X+bpdb1QmsP0O8aU9u8opmJuxmPZVk
         fCHVDsIylgwUOb+pb+E4Y7RoCtT9c/xQ6aeBGU7DKQDwbZPdWm32zl+aNpEUzfE0YFsu
         R9iAh1YEPhE5lK6T1dqZcPoLHzHK67z/1QJ+hmriu9c4o9kDW5jpOqr9HKlwcQAhjhMb
         PCTQJU6lvh0to4U1UGg5qDu9PS2IoI3ooVD658khTIFNijds2dbBJ3atoa4PMRkhuVV6
         SzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GMNN8zidej8CCx7epceEx2ySsZhlFSGB0Zr+V9xhpsE=;
        b=QYdupOG2jzhRua8EwhUPugqjTHdSnDJWSB1NDtWKp7rmzGGO3oZsA9LBKFxpcWNGKN
         aVwJtAxh1Z00Me8iZdTo230saSrlwAIB2Q21EL2J66Sx9yHEh8DbCrvMcuaPlZ35TUbY
         wC3VakLJuAsK5S454w/UiKnHUnFIiBqoRruCCFNhotzz2bLbjod3IokaakmUF3CDrWdF
         cgj2KX9PxzfGl+jZhfl7OSXcsGM6dYj9jmdzXgHtDuO2KGMzJFfenOIlGq3xaH1+ntaU
         dQ86fPslOA90+92ptIO9L7waQ6leHSl5ic4KcjDlAIIIOoPSjXGaw+S2XC8PuvLahm+2
         cQhg==
X-Gm-Message-State: AOAM531bcGkR6T/f4Jnh8q5PMVhA3nvG19vRblgIiAe88/PooZrBXJKW
        Dk8EiLorXcU+wPdtnb9bAdtOmdxVlUW/8S4pwVU=
X-Google-Smtp-Source: ABdhPJwejt1H97rNvX0CfGW0uyBD5BPQYzbjUvBiuVZWOTUQktXyL/vOFPR6r2TmKVdvNZPBu2gg5fAoui3ceq/p3ek=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1197817otl.311.1622087559482;
 Wed, 26 May 2021 20:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-5-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:52:28 -0400
Message-ID: <CADnq5_Pm3rtKnmjGND7vs5eSNF5xEzT9FmfUsT81JmNW55mmcw@mail.gmail.com>
Subject: Re: [PATCH 04/34] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Provide
 function name
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:171: w=
arning: expecting prototype for Set the requested temperature range for hig=
h and low alert signals(). Prototype was for vega12_thermal_set_temperature=
_range() instead
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> index 0dc16f25a463b..ed3dff0b52d21 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> @@ -159,7 +159,8 @@ int vega12_thermal_get_temperature(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> - * Set the requested temperature range for high and low alert signals
> + * vega12_thermal_set_temperature_range - Set the requested temperature =
range
> + *                                        for high and low alert signals
>   *
>   * @hwmgr: The address of the hardware manager.
>   * @range: Temperature range to be programmed for
> --
> 2.31.1
>
